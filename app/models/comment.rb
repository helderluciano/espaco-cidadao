class Comment < ActiveRecord::Base

	attr_accessible :content, :micropost_id

	belongs_to :microposts
	belongs_to :users

	default_scope :order => 'comments.created_at DESC'
end
