class Project < ActiveRecord::Base
  attr_accessible :name
  validates :name, :presence => true, :uniqueness => true
  has_many :tickets, :dependent => :delete_all
  has_many :permissions, :as => :thing
  scope :readable_by, lambda {|user| joins(:permissions).where(:permissions => {:action => "view",
  																				 :user_id => :user.id})}

def self.for(current_user)
	if current_user.admin?
    Project
  else
    Project.readable_by(current_user)
  end
end

end
