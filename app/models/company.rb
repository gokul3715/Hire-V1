class Company < ActiveRecord::Base
  attr_accessible :name

  has_many :teams
  has_many :users, through: :teams
  has_many :candidates, through: :teams
end
