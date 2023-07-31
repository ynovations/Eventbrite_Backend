class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :created_events, class_name: 'Event', foreign_key: 'creator_id'
  has_many :attendances
  has_many :attended_events, through: :attendances, source: :event

  def attending?(event)
    attended_events.include?(event)
  end

  def attendance_for(event)
    attendances.find_by(event: event)
  end
  
end
