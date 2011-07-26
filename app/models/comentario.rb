class Comentario < ActiveRecord::Base
  belongs_to :microposts
  belongs_to :users
end
