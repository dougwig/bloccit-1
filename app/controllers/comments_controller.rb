class CommentsController < ApplicationController
  def index
  end

  def show
  end

  def new
  end

  def create
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:post_id])
    #@comment = @post.comments.build(params[:comment])
    
    #from solution
    @comment = current_user.comments.build(params[:comment])
    @comment.post = @post

    authorize! :create, @comment, message: "You need to be signed up to do that."
    if @comment.save
      redirect_to [@topic, @post], notice: "Comment was saved successfully"
    else
      flash[:error] = "There was an error saving the comment. Please try again."
      render :new
    end
  end

  def edit
  end
end
