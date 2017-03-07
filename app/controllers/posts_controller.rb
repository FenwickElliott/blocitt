class PostsController < ApplicationController

before_action :require_sign_in, except: :show
before_action :require_sign_in, except: [:show, :new, :create]
# after_create :create_vote

    def show
        @post = Post.find(params[:id])
    end

    def new
        @topic = Topic.find(params[:topic_id])
        @post = Post.new
    end

    def create
        @topic = Topic.find(params[:topic_id])
        @post = @topic.posts.build(post_params)
        @post.user = current_user
        if @post.save
            flash[:notice] = "Post was saved."
            @post.votes.create(value: 1, user: @post.user)
            redirect_to [@topic, @post]
        else
            flash.now[:alert] = "There was an error saving the post. Please try again."
            render :new
        end
    end

    def edit
        @post = Post.find(params[:id])
    end

    def update
        @post = Post.find(params[:id])
        # @post.assign_attributes(post_params)
        @post.title = params[:post][:title]
        @post.body = params[:post][:body]
        if @post.save
            flash[:notice] = "Post was updated."
            redirect_to [@post.topic, @post]
        else
            flash.now[:alert] = "No Luck"
            render :edit
        end
    end

    def destroy
        @post = Post.find(params[:id])

        if @post.destroy
            flash[:notice] = "\"#{@post.title}\" was deleted successfully."
            redirect_to @post.topic
        else
            flash.now[:alert] = "There was an error deleting the post."
            render :show
        end
    end

    private

    def post_params
        params.require(:post).permit(:title, :body)
    end

    def authorise_user
        post = Post.find(params[:id])
        unless current_user == post.user || current_user.admin?
            flash[:alert] = "Permission denied"
            redirect_to [post.topic, post]
        end
    end

    # def create_vote
    #     user.votes.create(value: 1, post:self)
    # end
end
