class User < ApplicationRecord
    has_secure_password
    has_many :plants 
    has_many :types, through: :plants 
    has_many :plant_comments, through: :plants, source: :comments
    has_many :comments  
    validates :email, uniqueness: true 
    validates :username, :email, presence: true 

    def self.create_from_omniauth(response)
        User.find_or_create_by(uid: response['uid'], provider: response['provider']) do |u|
            u.username = response['info']['first_name']
            u.email = response['info']['email']
            u.password = SecureRandom.hex(15)
        end
    end 

end
