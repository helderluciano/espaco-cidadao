class Help < ActiveRecord::Base

	 default_scope :order => 'helps.created_at ASC'
end
