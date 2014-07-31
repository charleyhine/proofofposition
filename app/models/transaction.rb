class Transaction < ActiveRecord::Base
  belongs_to :user
  
  validates :user, presence: true
  validates :metadata, presence: true
  
  before_create :bitcoin_transaction
  
  def bitcoin_transaction
    from_address = '18Qi4yEQtVvSzDrapG6EWPFSumwdLWvZbJ'
    private_key = ENV['PRIVATE_KEY'] # Wallet import format (starts with a 5)
    to_address = '18Qi4yEQtVvSzDrapG6EWPFSumwdLWvZbJ'
    
    p from_address
    p private_key
    p to_address
    p self.metadata

    hex = Chain.build_metadata_transaction(from_address, private_key, to_address, self.metadata)
    
    #self.response = Chain.send_transaction(hex) if Rails.env.production?
    #self.response = "Testing" if Rails.env.development?  
  end
end