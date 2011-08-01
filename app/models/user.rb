class User < ActiveRecord::Base

     attr_accessor :password
     attr_accessible :name, :email, :password, :password_confirmation
     attr_accessible :cpf, :rg, :sexo, :data_nascimento, :telefone
     attr_accessible :estado, :cidade, :logradouro, :tipo

#RELACIONAMENTO
     
     has_many :comments , :dependent => :destroy

     has_many :microposts, :dependent => :destroy
     has_many :relationships, :foreign_key => "follower_id",
                           :dependent => :destroy
     has_many :following, :through => :relationships, :source => :followed
     
     has_many :reverse_relationships, :foreign_key => "followed_id",
                                   :class_name => "Relationship",
                                   :dependent => :destroy
     has_many :followers, :through => :reverse_relationships, :source => :follower

#VALIDAÇÕES

	email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  	validates :email, :format     => { :with => email_regex },
                    :uniqueness => { :case_sensitive => false }

	validates :password, :presence     => true,
                       :confirmation => true,
                       :length       => { :within => 6..40 }
	validates_length_of :cpf, :minimum => 11, :message =>"- No minimo 11 caracteres."
	validates_length_of :cpf, :maximum => 11, :message =>"- No máximo 11 caracteres."
	validates_presence_of :email, :message => "- Campo Obrigatório."
	validates_length_of :name , :minimum => 10, :message=>"- No minimo 10 caracteres."
	validates_presence_of :name, :message => "- Campo Obrigatório." 
	validates_presence_of :cpf, :message => "- Campo Obrigatório." 
	validates_uniqueness_of :cpf, :message => "- CPF já cadastrado."
	validates_length_of :rg, :minimum=> 7, :message=>"- No minimo 7 caracteres." 
	validates_length_of :rg, :maximum=> 20, :message=> "- No máximo 20 caracteres."
	validates_presence_of :rg , :message => "- Campo Obrigatório."
	validates_length_of :logradouro, :minimum=> 6 , :message =>"- No minimo 6 caracteres."
	validates_presence_of :logradouro, :message => "- Campo Obrigatório."
	validates_length_of :estado, :minimum=> 6 , :message =>"- No minimo 6 caracteres."
	validates_presence_of :estado, :message => "- Campo Obrigatório."
	validates_length_of :cidade, :minimum=> 6 , :message =>"- No minimo 6 caracteres."
	validates_presence_of :cidade, :message => "- Campo Obrigatório."


#Métodos

  before_save :encrypt_password

  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end

  def self.authenticate(email, submitted_password)
    user = find_by_email(email)
    return nil  if user.nil?
    return user if user.has_password?(submitted_password)
  end

  def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    (user && user.salt == cookie_salt) ? user : nil
  end

  def following?(followed)
    relationships.find_by_followed_id(followed)
  end

  def follow!(followed)
    relationships.create!(:followed_id => followed.id)
  end

  def unfollow!(followed)
    relationships.find_by_followed_id(followed).destroy
  end

   def feed
    Micropost.from_users_followed_by(self)
   end

  private

    def encrypt_password
      self.salt = make_salt if new_record?
      self.encrypted_password = encrypt(password)
    end

    def encrypt(string)
      secure_hash("#{salt}--#{string}")
    end

    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end

    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end
end
