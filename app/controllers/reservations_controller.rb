class ReservationsController < ApplicationController

  def create
  	@listing = Listing.find(params[:listing_id])
    @reservation = Reservation.new(reservation_params)
    @reservation.user_id = current_user.id if current_user
    @reservation.listing = @listing
    # @reservation.start_date = convert_to_y_m_d(params[:reservation][:start_date])
    # @reservation.end_date = convert_to_y_m_d(params[:reservation][:end_date])

if signed_in?

    if @reservation.save

      if  !current_user.fb_token.nil?

      RestClient.post('https://graph.facebook.com/v2.11/me/feed', { message: "I made a reservation here", link: listing_url(@listing.id), access_token: current_user.fb_token })
    end

      ReservationJob.perform_later(@reservation)

      redirect_to current_user






    else 
      @error = @reservation.errors.full_messages.first
      render 'listings/show'
    end

else
	@error = "Please sign in to make a booking!"
	render 'listings/show'

end

  end





  def destroy
    @reservation = Reservation.find(params[:id])
    @reservation.destroy
    redirect_to @reservation.user 
  end

  def reservation_params
    params.require(:reservation).permit(:num_guests, :start_date, :end_date)
  end

  # def convert_to_y_m_d(date)  
  #   new_date = date.split("/")[2] + "-" + date.split("/")[0] + "-" + date.split("/")[1]  
  #   new_date
# end 


end
