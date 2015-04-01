class Game < ActiveRecord::Base
	belongs_to :park
  belongs_to :host, :class_name => "User"
  has_many :reservations
  has_many :players, :class_name => "User", through: :reservations
end
