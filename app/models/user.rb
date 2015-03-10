class User < ActiveRecord::Base

  include RoleModel

  attr_accessor :password, :salt
  EMAIL_REGEX = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i
  validates :email, :presence => true, :uniqueness => true, :format => EMAIL_REGEX
  validates :password, :confirmation => true #password_confirmation attr
  validates_length_of :password, :in => 6..20, :on => :create

  before_save :encrypt_password
  after_save :clear_password_attr

  roles_attibute :roles_mask
  #roles
  roles :admin, :client

  private

  def encrypt_password
    if self.password.present?
      self.salt = BCrypt::Engine.generate_salt
      self.encrypted_password= BCrypt::Engine.hash_secret(self.password, self.salt)
    end
  end

  def clear_password
    self.salt = nil
    self.password = nil
  end
end
