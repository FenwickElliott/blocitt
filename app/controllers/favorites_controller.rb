class FavoritesController < ApplicationController

    before_action :require_sign_in

    def create
        post = Post.find(params[:post_id])
        favorite = current_user.favorites.build(post: post)

        if favorite.save
            flash[:notice] = "Favorited."
        else
            flash[:alert] = "Failed."
        end

        redirect_to [post.topic, post]
    end
end
