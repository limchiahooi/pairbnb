class User < ApplicationRecord
  include Clearance::User



enum role: [:customer, :moderator, :superadmin]
# same as enum verification: { customer: 0, moderator: 1, superadmin: 2 }


 has_many :authentications, dependent: :destroy
 has_many :listings, dependent: :destroy
 has_many :reservations, dependent: :destroy


  mount_uploader :avatar, AvatarUploader



    def self.create_with_auth_and_hash(authentication,auth_hash)
      user = self.create! do |u|
        u.password = SecureRandom.hex(10)
        u.email = auth_hash["extra"]["raw_info"]["email"] || "#{SecureRandom.hex(8)}@facebnb.com"
      end
      user.authentications << authentication
      return user
    end

    # grab fb_token to access Facebook for user data
      def fb_token
       x = self.authentications.where(:provider => :facebook).first
       return x.token unless x.nil?
      end

      def google_token
        x = self.authentications.find_by(:provider => 'google')
        return x.token unless x.nil?
      end
 end