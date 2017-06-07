require 'mailgun'
require 'nokogiri'
require 'open-uri'
class ChatroomsController < ApplicationController
  before_action :set_chatroom, only: [:show, :edit, :update, :destroy]

  # GET /chatrooms
  # GET /chatrooms.json
  def index
    @chatrooms = Chatroom.all
    @posts = Post.all.order("id desc")
    #@rank_movie = Nokogiri::HTML(open("https://www.naver.com/"))

  end
  def email_write
     @name = params[:name]
     @email = params[:email]
     @message = params[:message]

     #mailgun 보내는 폼
    # First, instantiate the Mailgun Client with your API key
    mg_client = Mailgun::Client.new 'key-ac89645311d8534bb27750e824ad715a'

    # Define your message parameters
    message_params =  { from: @email,
                        to:   'duanea0606@gmail.com',
                        subject: @name,
                        text:    @message
                      }

    # Send your message through the client
    mg_client.send_message 'sandbox165c26fd72294c21b95418c845d11557.mailgun.org', message_params

     redirect_to '/index'
  end
  #새로운 글쓰는 액션
  def write
      post = Post.new
      post.title = params[:post_title]
      post.content = params[:post_content]
      if post.save
        redirect_to '/index'
      else
        render :text => post.errors.messages
      end
  end
  #답글쓰는 액션
  def reply_write
      reply = Reply.new
      reply.post_id = params[:id_of_post]
      reply.content = params[:reply_content]
      if reply.save
        #redirect_to '/index'
      else
        render :text => reply.errors.messages
      end
  end

  # GET /chatrooms/1
  # GET /chatrooms/1.json
  def show
    @messages = @chatroom.messages.order(created_at: :asc)
    @chatroom_user = current_user.chatroom_users.find_by(chatroom_id: @chatroom.id)
  end


  # GET /chatrooms/new
  def new
    @chatroom = Chatroom.new
  end

  # GET /chatrooms/1/edit
  def edit
  end

  # POST /chatrooms
  # POST /chatrooms.json
  def create
    @chatroom = Chatroom.new(chatroom_params)

    respond_to do |format|
      if @chatroom.save
        format.html { redirect_to @chatroom, notice: 'Chatroom was successfully created.' }
        format.json { render :show, status: :created, location: @chatroom }
      else
        format.html { render :new }
        format.json { render json: @chatroom.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /chatrooms/1
  # PATCH/PUT /chatrooms/1.json
  def update
    respond_to do |format|
      if @chatroom.update(chatroom_params)
        format.html { redirect_to @chatroom, notice: 'Chatroom was successfully updated.' }
        format.json { render :show, status: :ok, location: @chatroom }
      else
        format.html { render :edit }
        format.json { render json: @chatroom.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /chatrooms/1
  # DELETE /chatrooms/1.json
  def destroy
    @chatroom.destroy
    respond_to do |format|
      format.html { redirect_to chatrooms_url, notice: 'Chatroom was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chatroom
      @chatroom = Chatroom.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def chatroom_params
      params.require(:chatroom).permit(:name)
    end

end
