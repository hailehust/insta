class Post < ApplicationRecord
  belongs_to :user
  has_many :photos, dependent: :destroy
  has_many :likes, -> {order(:created_at => :desc)}

  #check xem post nay co thuoc ve user nay khong
  # is_belongs_to: method name
  # user: param
  def is_belongs_to? user
    Post.find_by(user_id: user.id, id: id)
  end

  #check xem 1 user da like post nay chua
  def is_liked user
    Like.find_by(user_id: user.id, id: id)
  end
end
