class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  #skip_before_action :authenticate_user!, only: [:index]

  #before_save :ensure_authentication_token

  #Relations
  has_many :tasks, dependent: :destroy
  #Relations end

  #attr_accessor :current_user

  FIELDS_RENDERED = [:id, :name, :email]
  METHODS_RENDERED = []

  def ensure_authentication_token
    if authentication_token.blank?
      self.authentication_token = generate_authentication_token
    end
  end

  def reset_authentication_token
    self.authentication_token = generate_authentication_token
    self.save(:validate =>false)
  end

  # def as_json(options={})
  #   super(
  #     :methods => User::METHODS_RENDERED,
  #     :only => User::FIELDS_RENDERED
  #   )
  # end

  private
  # Generate auth token
  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(authentication_token: token).first
    end
  end

end
