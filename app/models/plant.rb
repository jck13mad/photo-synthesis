class Plant < ApplicationRecord
    validates :name, :description, presence: true 
    validates :description, length: {maximum: 500, 
        too_long: "Description can only be 500 characters."} 

    belongs_to :user
    has_many :comments
    has_many :users_commented, through: :comments, source: :user
    belongs_to :type

    def self.search(q)
        Plant.where("name LIKE ?", "%#{q}%").alpha
    end

    def type_attributes=(attr) 
        if !attr[:name].blank?
            self.type = Type.find_or_create_by(name: attr[:name])
        end
    end 

    scope :order_by_name, -> {order(name: :asc)}
    scope :alpha, -> { order('LOWER(name)') }

    def plant_and_type
        "#{self.name} - #{self.type.name}"
    end 

end
