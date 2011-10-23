class Command
  include MongoMapper::Document
  
  key :name, String
  key :body, String
  key :creator_id, Integer
  key :updater_id, Integer
  timestamps!
  
  validates_presence_of :name
  validates_presence_of :body
  
  attr_accessible :name, :body
  
  def creator
    @creator ||= User.find_by_member_id(creator_id)
  end
  
  def updater
    @updater ||= User.find_by_member_id(updater_id)
  end
  
  def updated?
    updated_at != created_at
  end
end
