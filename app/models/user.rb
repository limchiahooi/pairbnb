class User < ApplicationRecord
  include Clearance::User



enum role: [:customer, :moderator, :superadmin]
# same as enum verification: { customer: 0, moderator: 1, superadmin: 2 }


 has_many :authentications, dependent: :destroy
 has_many :listings, dependent: :destroy
 has_many :reservations, dependent: :destroy


  mount_uploader :avatar, AvatarUploader



    def self.create_with_auth_and_hash(authentication, auth_hash)
      user = self.create!(
       password: SecureRandom.hex(10),
       email: auth_hash["extra"]["raw_info"]["email"]
      )
      user.authentications << authentication
      return user
    end

    # grab fb_token to access Facebook for user data
      def fb_token
       x = self.authentications.where(:provider => :facebook).first
      return x.token unless x.nil?
      end
 end