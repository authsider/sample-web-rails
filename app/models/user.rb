# frozen_string_literal: true

# Devise managed user
class User < ApplicationRecord

  devise :omniauthable, omniauth_providers: %i[authsider]

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name
      user.image = auth.info.image
      user.extra = auth.extra.raw_info.to_h
    end
  end
end
