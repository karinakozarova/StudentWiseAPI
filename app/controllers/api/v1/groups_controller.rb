class Api::V1::GroupsController < ApplicationController
  before_action :authenticate_user!, except: %i(index show)
  before_action :require_admin!, only: %i(create update destroy)
  before_action :set_group, except: %i(index create)
  before_action :set_user, only: %i(move_member remove_member)
  before_action :check_group, only: %i(update destroy)

  def index
    @groups = Group.all
  end

  def show
  end

  def create
    @group = Group.new(group_params)

    @group.save!
    render :show, status: :created
  end

  def update
    @group.update!(group_params)
    render :show, status: :ok
  end

  def destroy
    @group.destroy
  end

  def move_member
    @user.update!(group_id: @group.id)
    render :member, status: :ok
  end

  def remove_member
    @user.update!(group_id: nil)
    render :member, status: :ok
  end

  private

  def set_group
    @group = Group.find(params[:id] || params[:group_id])
  end

  def set_user
    @user = User.find(group_member_params[:member_id])
  end

  def group_params
    params.require(:group).permit(:name, :description, :rules)
  end

  def group_member_params
    params.require(:group_member).permit(:member_id)
  end

  def check_group
    return unless @group.is_default?

    case params[:action].to_sym
    when :update
      group_params.keys.each do |param|
        @group.errors.add(:base, "Parameter '#{param}' is not allowed for default group") unless whitelisted_param?(param)
      end
    when :destroy
      @group.errors.add(:base, 'Cannot remove default group')
    end

    raise ActiveRecord::RecordInvalid.new(@group) if @group.errors.any?
  end
end

def whitelisted_param?(param)
  whitelist = %i(description rules)

  whitelist.each do |prop|
    return true if param.to_sym == prop
  end
  return false
end
