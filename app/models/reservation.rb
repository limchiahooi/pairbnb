class Reservation < ApplicationRecord

  belongs_to :user
  belongs_to :listing
  
# validates (with s) = normal validations e.g. presence, length, etc
# validate (without s) = custom validation methods e.g. validate_name_starts_with_a
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :num_guests, presence: true
  validate :check_overlapping_dates
  validate :check_start_date  
  validate :check_max_guests
  validate :check_num_guests
  


  


  def check_overlapping_dates
  	if start_date.present? && end_date.present?


  	#compare this new booking to existing bookings
  	listing.reservations.each do |prev_reserv|
  	  if overlap?(self, prev_reserv)
  		return errors.add(:overlapping_dates, "The booking dates conflict with existing bookings")
  	  end 
     end 

 else
return errors.add(:start_date, "Please enter both Start date and End date")
end
  end

  def overlap?(x,y)
  	(x.start_date - y.end_date) * (y.start_date - x.end_date) > 0
  end

  def check_max_guests
  	max_guests = listing.guest_number
  	if num_guests.present? && num_guests > max_guests
  	  return errors.add(:max_guests, "Maximum number of guests exceeded")
  	end 
  end

  def check_num_guests
    if num_guests.present? && num_guests <= 0
      return errors.add(:num_guests, "The number of guests must be at least 1")
    end 
  end 

  def check_start_date
  	if start_date.present? && start_date == Date.today
  	  return errors.add(:start_date, "cannot be today")
  	elsif start_date.present? && start_date < Date.today 
  	  return errors.add(:start_date, "cannot be in the past")
	elsif start_date.present? && start_date > end_date 
  	  return errors.add(:start_date, "cannot be later than End date")
	elsif start_date.present? && start_date == end_date 
  	  return errors.add(:start_date, "cannot be the same as End date")
  	end 
  end 

  def total_price
    price = listing.price
    num_dates = (start_date..end_date).to_a.length - 1
    return price * num_dates
  end 






end
