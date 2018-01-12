class Listing < ApplicationRecord

# require 'carrierwave/orm/activerecord'

validates :name, presence: true


enum verification: [:unverified, :verified]
# same as enum verification: { unverified: 0, verified: 1 }

belongs_to :user
has_many :reservations, dependent: :destroy

mount_uploaders :image, ImageUploader


end
