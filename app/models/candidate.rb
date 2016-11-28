class Candidate < ActiveRecord::Base
  attr_accessible :email_, :mobile, :name, :resume, :role, :team_id
  
  validates :name, :presence => true
  validates :email_, :presence => true
  validates :role, :presence => true
  validates :team_id, :presence => true
  validates :mobile, :presence => true, :length => { :minimum => 10, :maximum => 10}

  belongs_to :team
  has_many :interviews

  before_save do |user| 
  	user.email_ = email_.downcase 
  	user.name = name.capitalize
  end

  def self.to_csv
        desired_columns = ["name", "email_", "mobile", "role", "team"]
        CSV.generate do |csv|
                csv << desired_columns
                all.each do |todo|
                        csv << todo.attributes.values_at(*desired_columns)
                end
     end
  end
end
