class User < ActiveRecord::Base

  has_secure_password
  # make sure to include this with the bcrypt gem to hash passwords.

  # make my db connection between User and City
  has_and_belongs_to_many :cities
  has_many :loc_edits # rich join table
  has_many :locs, through: :loc_edits # needed to traverse rich join as well as line above.
  EMAIL_REGEX = /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}\Z/i

  # validates_presence_of :first_name
  # validates_length_of :first_name, maximum: 25   ---- see below!
  validates_presence_of :last_name
  validates_length_of :last_name, maximum: 50
  validates_presence_of :username
  validates_length_of :username, within: 6..25
  validates_uniqueness_of :username
  validates_presence_of :email
  validates_length_of :email, maximum: 100
  validates_format_of :email, with: EMAIL_REGEX
  validates_confirmation_of :email
  # will add a virtual attribute called email_confirmation (not a column in db), if that attribute is there, then it can be confirmed.

  # shortcut validations:
  validates :first_name, presence: true,
   length: { maximum: 25 }

  scope :sorted, lambda { order("last_name ASC, first_name ASC") }
  # custom query for accounts active in the last week
  scope :recent, lambda { where(updated_at: 1.week.ago..Time.now) }
  # a scope to check if user is an admin
  scope :admin, lambda { where(admin: 1)}

  def name
    "#{first_name} #{last_name}" # using a string
    # OR: first_name + '' + last_name
    # OR: [first_name, last_name].join(' ')
  end
end