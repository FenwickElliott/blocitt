module UsersHelper
    def has_posts?
        if @user.posts.count > 0
            return true
        else
            return false
        end
    end

    def has_comments?
        if @user.comments.count > 0
            return true
        else
            return false
        end
    end
end
