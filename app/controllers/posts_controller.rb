class PostsController < ApplicationController


  def show
    # @post = Post.find(params[:id])
    # @topic = Topic.find(params[:topic_id])
    # @comment = Comment.find(params[:post_id])

    # POST SHOW
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.where(id: params[:id]).first

    # COMMENTS INDEX (array)
    @comments = @post.comments

    #puts "POSTS SHOW COMMENTS = #{@comments.inspect}"

    # COMMENT NEW
    @comment = Comment.new

  end

  def new
    @topic = Topic.find(params[:topic_id])
    @post =  Post.new
    authorize! :create, Post, message: "You need to be a member to create a new post."
  end

  def create
    @topic = Topic.find(params[:topic_id])
    @post = current_user.posts.build(params[:post])
    @post.topic = @topic
#    @post = Post.new(params[:post])
    #puts "POSTS CREATE = #{params.inspect}"
    #puts "CURRENT USER = #{current_user.email}"
    #puts "CURRENT USER = #{current_user.role}"
    #authorize! :create, @post, message: "You need to be signed in to do that."
    authorize! :create, @post, message: "You need to be signed up to do that."
    #puts "POST CREATE, WE SHOULD NEVER SEE THIS."
    #raise # this will short-circuit the method
    if @post.save
      redirect_to [@topic,@post], notice: "Post was saved successfully"
      #flash[:notice] =  "Post was saved."
      #redirect_to @post
    else
      flash[:error] = "There was an error saving the post. Please try again."
      render :new
    end
  end

  def edit
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])
    authorize! :edit, @post, message: "You need to own the post to edit it."
  end

  def update
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])
    authorize! :update, @post, message: "You need to own the post to edit it."
    if @post.update_attributes(params[:post])
      redirect_to [@topic,@post], notice: "Post was saved successfully"
      #flash[:notice] = "Post was updated."
      #redirect_to @post
    else
      flash[:error] = "There was an error saving the post. Please try again."
      render :edit
    end
  end

  def destroy
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])

    title = @post.title
    authorize! :destroy, @post, message: "You need to own the post to delete it."
    if @post.destroy
      flash[:notice] = "\"#{title}\" was deleted successfully."
      redirect_to @topic
    else
      flash[:error] = "There was an error deleting the post."
      render :show
    end
  end  
  
end
