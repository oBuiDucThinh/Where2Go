class CommentsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy, :show]
  def index
    @comments = Comment.all
  end

  def show
    @comment = Comment.find_by id: params[:id]
  end

  def new
    @comment = Comment.new
  end

  def create
    @event = Event.find(params[:event_id])
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
      flash[:info] = "Your comment couldn't be created"
      render 'static_pages/home'
    end
  end

  def destroy
    @event = Event.find(params[:event_id])
    @comment = Comment.find(params[:id])
    @comment.destroy
    respond_to do |format|
      format.html do
        flash[:success] = "Comment has been deleted"
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
    @event = Event.find_by id: params[:id]
  end
end
