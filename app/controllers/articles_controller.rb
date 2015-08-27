class ArticlesController < ApplicationController

    http_basic_authenticate_with name: "sasa", password: "sss", except: [:index, :show]

    before_action :find_article, only: [:show, :edit, :update, :destroy]

    def index
        @articles = Article.all
    end

    def show
    end

    def new
        @article = Article.new
    end

    def edit
    end

    def create
        @article = Article.new(article_params)

        if @article.save
            redirect_to @article, notice: '新增成功'
        else
            render :new
        end 
    end

    def update
        if @article.update(article_params)
            redirect_to @article, notice: '更新成功'
        else
            render :edit
        end 
    end

    def destroy
        @article.destroy
        redirect_to articles_path, notice: '已刪除'
    end

    private
        def find_article
            @article = Article.find_by(id: params[:id])
            redirect_to articles_path, notice: '無此篇文章' if not @article
        end

        def article_params
            params.require(:article).permit(:title, :text)
        end
end
