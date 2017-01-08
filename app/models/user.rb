# authentication tutorial: http://railscasts.com/episodes/250-authentication-from-scratch
class User < ApplicationRecord
	attr_accessor(:password)
	before_save(:encrypt_password)

	validates_confirmation_of(:password)
	validates_presence_of(:password, :on => :create)
	validates_presence_of(:username)
	validates_uniqueness_of(:username)

	def self.authenticate(name_of_user, password)
		user = User.find_by(username: name_of_user)
		if (user != nil) && (user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt))
			return user
		else
			return nil
		end
	end

	def encrypt_password()
		if password.present?() == true
			self.password_salt = BCrypt::Engine.generate_salt()
			self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
		end
	end
end
