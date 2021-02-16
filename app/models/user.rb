class User < ApplicationRecord
    has_secure_password
    has_many :plants 
    has_many :types, through: :plants 
    has_many :plant_comments, through: :plants, source: :comments
    has_many :comments  
    validates :email, uniqueness: true 
    validates :username, :email, presence: true 

    def self.create_from_omniauth(auth)
        User.find_or_create_by(uid: auth['uid'], provider: auth['provider']) do |u|
            u.username = auth['info']['first_name']
            u.email = auth['info']['email']
            u.password = SecureRandom.hex(18)
        end
    end 

end
