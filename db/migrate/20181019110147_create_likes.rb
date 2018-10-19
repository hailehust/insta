# migrate: lam viec voi database thay nhu cach hoi truoc
# create Like table gom: id userID (khoa ngoai tham chieu tu user table) postID (khoa ngoai)
class CreateLikes < ActiveRecord::Migration[5.1]
  def change
    create_table :likes do |t|
      t.references :post, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
