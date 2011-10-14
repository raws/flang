class User < ActiveRecord::Base
  set_table_name "exp_members"
  
  def password_algorithm
    self.class.password_algorithm(self.password)
  end
  
  class << self
    def password_algorithm(password)
      case password.try(:bytesize)
      when 128
        Digest::SHA512
      when 64
        Digest::SHA256
      when 40
        Digest::SHA1
      when 32
        Digest::MD5
      end
    end
    
    def authenticate(username, password)
      user = select([:member_id, :salt, :password]).find_by_username(username)
      if user && user.password == user.password_algorithm.try(:hexdigest, user.salt + password)
        user.member_id
      else
        nil
      end
    end
  end
end
