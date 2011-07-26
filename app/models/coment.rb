class Coment < ActiveRecord::Base

	attr_accessible :content

	default_scope :order => 'coments.created_at DESC'
end
