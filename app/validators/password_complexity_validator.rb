module PasswordComplexityValidator
  extend ActiveSupport::Concern

  included do
    validate :password_complexity
  end

  private

  def password_complexity
    return if password.blank? || password =~ /(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}/

    errors.add :password, 'Password must be at least 8 characters long and include at least one uppercase letter, one lowercase letter, one digit, and one special character'
  end
end