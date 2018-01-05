class Listing < ApplicationRecord


validates :name, presence: true


enum verification: [:unverified, :verified]
# same as enum verification: { unverified: 0, verified: 1 }

belongs_to :user

end
