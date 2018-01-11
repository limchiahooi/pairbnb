class BraintreeController < ApplicationController
    def new
  	@client_token = Braintree::ClientToken.generate
  	@reservation = Reservation.find(params[:id])
  end



  def checkout
  nonce_from_the_client = params[:checkout_form][:payment_method_nonce]
  @reservation = Reservation.find(params[:id])
  result = Braintree::Transaction.sale(
   :amount => @reservation.total_price, #this is currently hardcoded
   :payment_method_nonce => nonce_from_the_client,
   :options => {
      :submit_for_settlement => true
    }
   )

  if result.success?
  	

    flash[:success] = "Transaction successful!"
    redirect_to :root
    @reservation.update_attribute(:status, 1) #status 1 = paid

  else
  	flash[:danger] = "Transaction failed. Please try again."
    redirect_to :root
  end
end
end
