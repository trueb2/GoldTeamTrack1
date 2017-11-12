class Chemical < ApplicationRecord
	has_many :releases
	has_many :facilities, through: :releases
end
