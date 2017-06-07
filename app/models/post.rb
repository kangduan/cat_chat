class Post < ApplicationRecord
  has_many :replies
  validates :title, presence: { message: "제목이 비었습니다."}
end
