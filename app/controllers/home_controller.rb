class HomeController < ApplicationController
  before_action :authenticate_user!, :only => [:inside, :stamp] 
  
  def outside
    redirect_to :inside if current_user
  end
  
  def inside
    if current_user.stampable?
      @stampable = true
    else
      @last_tx = current_user.transactions.last
    end
  end
  
  def stamp
    if current_user.stampable?
      from_address = '1Bj5UVzWQ84iBCUiy5eQ1NEfWfJ4a3yKG1'
      private_key = ENV['PRIVATE_KEY']
      to_address = '1JJynffTaq3bWcWTXnC4P68VMeNNHdVmMy'
      metadata = '@' + current_user.username + ',' + (sprintf "%.6f", @lat_lng[0]) + ',' + (sprintf "%.6f", @lat_lng[1])
    
      hex = Chain.build_metadata_transaction(from_address, private_key, to_address, metadata)
    
      tx = Transaction.new
      tx.user = current_user
      tx.metadata = metadata
      tx.response = Chain.send_transaction(hex) if Rails.env.production?
      tx.response = "Test" if Rails.env.development?
      tx.save
    end
    
    redirect_to :inside
  end
end