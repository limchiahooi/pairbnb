class ReservationJob < ApplicationJob
  queue_as :default

  def perform(reservation)
    # Do something later
    host = User.find(reservation.listing.user_id)
    customer = User.find(reservation.user_id)
    ReservationMailer.booking_email(customer, host, reservation.id).deliver_later
  end
end
