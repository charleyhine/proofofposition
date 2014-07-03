class User < ActiveRecord::Base
  has_many :transactions

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :omniauthable, :omniauth_providers => [:twitter]

         
  def stampable?
    last_tx = self.transactions.last 
    
    # If no txs or last tx occured over 2 hrs ago
    if last_tx.nil? || last_tx.created_at < Time.now - 2.hours 
      return true
    else
      return false
    end
  end
             
  def self.from_omniauth(auth)
   where(auth.slice(:provider, :uid)).first_or_create do |user|
     user.username = auth.info.nickname
     user.password = Devise.friendly_token[0,20]
     user.image = auth.info.image
   end
  end
end
