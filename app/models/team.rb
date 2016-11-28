class Team < ActiveRecord::Base
  attr_accessible :name, :company_id

  belongs_to :company
  has_many :candidates
  has_many :users
end
