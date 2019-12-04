class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  attr_writer :login

  has_attached_file :photo, style: { medium: "300x500>",thumb: "100x100>" }
  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\z/

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, authentication_keys: [:login]

  has_many :orders
  belongs_to :admin, optional: true
  has_many :deliveries
  has_many :cash_drawers
  has_many :customers
  validates :username, presence: :true, uniqueness: { case_sensitive: false }

  validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true


  def active_for_authentication?
    super and self.is_active?
  end

  def login
    @login || self.username || self.email
  end

  enum role: [:user, :seller, :employee]
  after_initialize :set_default_role, :if => :new_record?

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
