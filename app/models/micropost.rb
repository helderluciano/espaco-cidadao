class Micropost < ActiveRecord::Base

	attr_accessible :content
	attr_accessible :titulo, :governante , :tipo

  	belongs_to :user
	has_many :comentarios, :dependent => :destroy


	validates_presence_of :content, :length => { :maximum => 5000 }, :message => "- Campo Obrigatório."
  	validates_presence_of :user_id
	validates_presence_of :titulo, :length => { :maximum => 40}, :message => "- Campo Obrigatório."
	validates_presence_of :governante, :length => { :maximum => 50}, :message => "- Campo Obrigatório."

	default_scope :order => 'microposts.created_at DESC'

  # Retorno dos usuários a ser seguido
  scope :from_users_followed_by, lambda { |user| followed_by(user) }

  private

    # Retornar uma condição SQL para usuários seguido pelo usuário.
    # Nós incluímos ID do próprio usuário também.
    def self.followed_by(user)
      following_ids = %(SELECT followed_id FROM relationships
                        WHERE follower_id = :user_id)
      where("user_id IN (#{following_ids}) OR user_id = :user_id",
            { :user_id => user })
    end
end
