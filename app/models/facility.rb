class Facility < ApplicationRecord
  has_many :releases, dependent: :delete_all
  has_many :chemicals, through: :releases
  belongs_to :company, optional: true
end
