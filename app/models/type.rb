class Type < ApplicationRecord
    validates :name, uniqueness: { case_sensitive: false }
    has_many :plants 
    has_many :users, through: :plants

    
end
