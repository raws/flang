class Command
  include MongoMapper::Document
  
  key :name, String
  key :user_id, Integer
  timestamps!
  
  validates_presence_of :name
  
  attr_accessible :name
  
  def user
    @user ||= User.find_by_member_id(user_id)
  end
end
