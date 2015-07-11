class Request < ActiveRecord::Base

	#validation
	validates :type,       :presence => TRUE
	validates :created,    :presence => TRUE
	validates :expires,	   :presence => TRUE
	validates :longtitude, :presence => TRUE
	validates :latitude,   :presence => TRUE

end
