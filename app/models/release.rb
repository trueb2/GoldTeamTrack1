class Release < ApplicationRecord
	belongs_to :facility
	belongs_to :chemical
end
