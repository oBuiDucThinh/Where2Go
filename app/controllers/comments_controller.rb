class CommentsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy, :show]
  before_action :set_event
  before_action :correct_user, only: :destroy

  def index
    @comments = Comment.order_by_date_created
  end

  def show
    @comment = Comment.find_by id: params[:id]
  end

  def new
    @comment = Comment.new
  end

  def create
    @comment = @event.comments.build comment_params
    @comment.user_id = current_user.id

    if @comment.save
      respond_to do |format|
        format.html do
          flash[:info] = t :success
          redirect_to @event
        end
        format.js
      end
    else
      flash[:info] = t :comment_false
      render "static_pages/home"
    end
  end

  def destroy
    @comment = Comment.find_by id: params[:id]
    @comment.destroy
    respond_to do |format|
      format.html do
        flash[:success] = t :comment_delete
        redirect_to @event
      end
      format.js
    end
  end

  private

  def comment_params
    params.require(:comment).permit :content, :event_id, :date_created
  end

  def correct_user
    @comment = current_user.comments.find_by id: params[:id]
    redirect_to root_url if @comment.nil?
  end

  def set_event
    @event = Event.find_by id: params[:event_id]
    return if @event
    redirect_to root_url
  end
end
