class Like < ApplicationRecord
  belongs_to :post
  belongs_to :user

  #make sure user can only like a post once
  validates :user_id, uniqueness: {scope: :post_id}
end
