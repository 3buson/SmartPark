class PaymentsController < ApplicationController
  def client_token
  	render json: {client_token: Braintree::ClientToken.generate}
  end

  def pay
  	result = Braintree::Transaction.sale(
  		:amount => params[:ammount],
  		:payment_method_nonce => params[:payment_method_nonce]
	)
  end
end
