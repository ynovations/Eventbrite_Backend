class Event < ApplicationRecord
    belongs_to :creator, class_name: 'User', foreign_key: "creator_id"
    has_many :attendances, dependent: :destroy
    has_many :attendees, through: :attendances, source: :user
    has_many :invitations, dependent: :destroy
    has_many :invitees, through: :invitations, source: :user



    scope :past, -> { where('date < ?', Date.today) }
    scope :upcoming, -> { where('date >= ?', Date.today) }
    
end
