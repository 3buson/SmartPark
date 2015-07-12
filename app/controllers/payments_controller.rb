class PaymentsController < ApplicationController
  def client_token
  	render json: {client_token: Braintree::ClientToken.generate}

  end

  def pay
  	result = Braintree::Transaction.sale(
  		:amount => params[:ammount],
  		:payment_method_nonce => params[:payment_method_nonce]
	)

	@user = User.find_by_username('Matic')
	@user.credits = @user.credits + 1
	@user.save
  end
end
