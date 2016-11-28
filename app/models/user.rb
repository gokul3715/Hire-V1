class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :team_id, :role
  # attr_accessible :title, :body

  validates :email, :presence => true
  validates :username, :presence => true

  has_many :has_scheduled, class_name: 'Interview', :foreign_key => "recruiter_id"
  has_many :scheduled_to, class_name: 'Interview', :foreign_key => "interviewer_id"
  belongs_to :team

  before_save do |user| 
    user.username = username.capitalize
  	user.email = email.downcase 
  	user.role = role.downcase
  end
end
