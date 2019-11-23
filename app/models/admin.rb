class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_attached_file :photo, style: { medium: "300x500>",thumb: "100x100>" }
  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\z/

  attr_writer :login

  has_many :categories
  has_many :products
  has_many :users
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, authentication_keys: [:login]

  enum role: [:user, :vip, :admin]
  after_initialize :set_default_role, :if => :new_record?

  # has_and_belongs_to_many :permissions

  validates :username, presence: :true, uniqueness: { case_sensitive: false }

  validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true

  def login
    @login || self.username || self.email
  end

  def set_default_role
    self.role ||= :user
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end

end
