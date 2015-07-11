class User < ActiveRecord::Base
	require 'digest'

	has_many :requests

  	before_save :encrypt

	#validation
	validates :username, :presence => TRUE
	validates :password, :presence => TRUE, :length => { :minimum => 6 }, :confirmation => TRUE
	validates :number, 	 :presence => TRUE

	def encrypt
		self.password = Digest::SHA256.hexdigest(password);
	end

	def self.validate_login(username, password)
		user = User.find_by_mail(mail);

		if user && user.password == Digest::SHA256.hexdigest(password)
			return user
		else
			return nil
		end
	end

end
