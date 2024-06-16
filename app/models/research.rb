class Research < ApplicationRecord
  belongs_to :user
  has_many_attached :photos
  has_one_attached :profile_picture

  validate :acceptable_profile_picture

  def acceptable_profile_picture
    return unless profile_picture.attached?

    if profile_picture.blob.byte_size > 10.megabytes
      errors.add(:profile_picture, "is too big (maximum is 10 MB)")
    end

    acceptable_types = ["image/jpeg", "image/png"]
    unless acceptable_types.include?(profile_picture.blob.content_type)
      errors.add(:profile_picture, "must be a JPEG or PNG")
    end
  end
end
