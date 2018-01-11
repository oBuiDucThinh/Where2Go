class CommentsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy, :show]
  before_action :correct_user, only: :destroy
  before_action :authenticate_user!, except: :show
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
      flash[:info] = t :success
      redirect_to @event
    else
      render "static_pages/home"
    end
  end

  def destroy
    @comment.destroy
    flash[:success] = "Comment has been deleted"
    redirect_to @event
  end

  private

  def comment_params
    params.require(:comment).permit :content, :event_id, :date_created
  end

  def correct_user
    @comment = current_user.comments.find_by id: params[:id]
    redirect_to root_url if @comment.nil?
  end
end
