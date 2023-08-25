class UsersController < ApplicationController
  def show
    user = User.find(params[:id])
    @name = user.name
    @profile = user.profile
    @occupation = user.occupation
    @position = user.position
    # @prototypes = User.find(params[:prototype_id])
    @prototypes = user.prototypes
  end
end