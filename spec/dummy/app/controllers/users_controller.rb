class UsersController < ApplicationController
  include ReTrack::Sweeper
  re_track :user

  respond_to :html
  before_filter :get_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
    respond_with(@users)
  end

  def show
    respond_with(@user)
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(params[:user])
    flash[:notice] = 'User was successfully created.' if @user.save
    respond_with(@user)
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:notice] = 'User was successfully updated.'
    end
    respond_with(@user)
  end

  def destroy
    @user.destroy
    respond_with(@user)
  end

  private

  def get_user
    @user = User.find(params[:id])
  end
end
