class Listing < ApplicationRecord

enum verification: [:unverified, :verified]
# same as enum verification: { unverified: 0, verified: 1 }

belongs_to :user

end
