class HomeController < ApplicationController
  before_action :authenticate_user!, :only => [:inside, :stamp] 
  
  def outside
    redirect_to :inside if current_user
  end
  
  def inside
      @stampable = current_user.stampable?
      @last_tx = current_user.transactions.last
      
      if @last_tx && @last_tx.response.nil? && @stampable == false
        redirect_to '/500'
      end
  end
  
  def stamp
    if current_user.stampable?
      metadata = '@' + current_user.username + ',' + (sprintf "%.6f", @lat_lng[0]) + ',' + (sprintf "%.6f", @lat_lng[1])
    
      tx = Transaction.new
      tx.user = current_user
      tx.metadata = metadata
      tx.save
      p tx.inspect
    end
    
    redirect_to :inside
  end
  
end