class Post < ActiveRecord::Base
	belongs_to :user
	has_many :likes


	def liked_by?(user)
		likes.where(user_id: user.try(:id)).exists?
	end
end