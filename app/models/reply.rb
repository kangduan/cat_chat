class Reply < ApplicationRecord
  belongs_to :post
  validates :content, presence: { message: "내용이 비었습니다."}
end
