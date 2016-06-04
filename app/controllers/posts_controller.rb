class PostsController < ApplicationController
    before_action :authenticate_user!


    
	def step1
		@title = "タイトルです"
	end

    def index
    	@posts = Post.all.order(created_at: :desc)
        @post = Post.new
    end

    def show
        @post = Post.find(params[:id])
    end

    def new
        @post = Post.new
    end

    def edit
        @post = Post.find(params[:id])

    end

    def create
        @post = Post.new(post_params)
        @post.user_id = current_user.try(:id)

        if @post.save
            redirect_to '/posts', notice:"投稿できました"
        else
            render :new, alert: "投稿に失敗しました"
        end
    end

    def update
        @post = Post.find(params[:id])
        if @post.update(post_params)
            redirect_to post_path(@post),notice: "編集に成功しました"
        else
            render :edit, alert: "編集に失敗しました"
        end

    end

    def destroy
         @post = Post.find(params[:id])
         @post.destroy
         redirect_to '/posts', notice: "投稿を削除しました"
    end
    
    private
    def post_params
        params.require(:post).permit(:title, :body)
    end
    



end
