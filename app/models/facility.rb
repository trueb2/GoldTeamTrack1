class Facility < ApplicationRecord
	has_many :releases
	has_many :chemicals, through: :releases
end
