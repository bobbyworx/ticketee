class Ticket < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  attr_accessible :description, :title
  validates :title, :presence => :true
  validates :description, :presence => :true,
  											 	:length => { :minimum => 10 }
	has_attached_file :asset
	attr_accessible :asset											 
  #accepts_nested_attributes_for :user
  
end
