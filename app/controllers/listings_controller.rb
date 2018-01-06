class ListingsController < ApplicationController


	def index
		@listings = Listing.all.order(id: :desc).paginate(:page => params[:page], :per_page => 12)
		#use plural @listings coz index shows all listings
	end


	def new
		@listing = Listing.new
		#initialize an empty object for the form, so that we can fill in with details using the form.
		#use singular @listing coz only create one listing
		render 'listings/new'
	end


	def create
		#use singular @listing coz only create one listing
		@listing = Listing.new(params.require(:listing).permit(:name, :place_type, :property_type, :room_number, :bed_number, :guest_number, :country, :state, :city, :zipcode, :address, :price, :description, {image: []}, :remove_image))
	   @listing.user_id = current_user.id if current_user
	     if @listing.save
	       redirect_to @listing
	     else
	        render 'new'
	     end
	end



	  def show
	  	#use singular @listing coz only create one listing
	    @listing = Listing.find(params[:id])
	     # @reservation = @listing.reservations.new
	    
	end


	def edit
	    @listing = Listing.find(params[:id])
	  end 

	def update
	    @listing = Listing.find(params[:id])
	    @listing.update(params.require(:listing).permit(:name, :place_type, :property_type, :room_number, :bed_number, :guest_number, :country, :state, :city, :zipcode, :address, :price, :description, {image: []}, :remove_image))
	    redirect_to @listing
	end 


	  # def listing_from_params
	  #   params.require(:listing).permit(:name, :place_type, :property_type, :room_number, :bed_number, :guest_number, :country, :state, :city, :zipcode, :address, :price, :description, amenity_list:[], facility_list:[], rule_list:[], images:[])
	  # end


	def destroy
			@listing = Listing.find_by(id: params[:id])
			@listing.destroy
			redirect_to root_url
		end


	def verify
		@listing = Listing.find_by(id: params[:id])
		@listing.verified!
		redirect_to @listing
	end


	def unverify
		@listing = Listing.find_by(id: params[:id])
		@listing.unverified!
		redirect_to @listing
	end

end
