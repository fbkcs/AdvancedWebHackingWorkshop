class UserController < ApplicationController
	def show
		render params[:id]
	end
end