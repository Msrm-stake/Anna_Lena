class User < ApplicationRecord
  has_many :designs, dependent: :destroy
  has_many :researches, dependent: :destroy
  has_many :publications, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  validate :allowed_email, on: :create

  private

  def allowed_email
    unless ['mahmoud.salah.rabee@gmail.com', 'anna@atelier-zaatar.com'].include?(email)
      errors.add(:email, "Sign-ups are only allowed from authorized email addresses.")
    end
  end
end
