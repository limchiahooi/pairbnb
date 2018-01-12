class UsersController < ApplicationController



	def index
		@user = User.all
	end

	def new
		@user = User.new
		render 'users/new'
	end

	def create
		@user = User.new(user_from_params)

		if @user.save
			sign_in @user
			flash[:success] = "Welcome to Pairbnb"
			redirect_to root_url
		else 
			flash[:alert] = @user.errors.full_messages.first
			
			redirect_to sign_up_path
			
		end
	end

	


	def show
		@user = User.find(params[:id])
		@listings = Listing.where(user_id: @user).order(id: :desc).paginate(:page => params[:page], :per_page => 4) 
		@reservations = @user.reservations
		render 'users/show'
	end


	def edit
		@user = User.find(params[:id])
	end


	def update
		@user = User.find(params[:id])
		@user.update_attributes(user_from_params)
		redirect_to @user
	end 



    def user_from_params
		params.require(:user).permit(:email, :password, :avatar, :remove_avatar)
	end








end
