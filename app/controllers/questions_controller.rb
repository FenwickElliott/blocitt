class QuestionsController < ApplicationController
  def index
      @questions = Question.all
  end

  def show
      @question = Question.find(params[:id])
  end

  def new
      @question = Question.new
  end

  def create
      @question = Question.new
      @question.title = params[:question][:title]
      @question.body = params[:question][:body]
      @question.resolved = false

      if @question.save
          flash[:notie] = 'Question saved'
          redirect_to @question
      else
          flash.now[:alert] = 'error'
          render :new
      end
  end

  def edit
     @question = Question.find(params[:id])
  end

  def update
      @question = Question.find(params[:id])
      @question.title = params[:question][:title]
      @question.body = params[:question][:body]
      @question.resolved = false

      if @question.save
          flash[:notice] = 'Question saved'
          redirect_to @question
      else
          flash.now[:alert] = 'error'
          render :new
      end
  end

  def destroy
      @question = Question.find(params[:id])
      if @question.destroy
          flash[:notice] = "\"#{@question.title}\" deleted"
          redirect_to questions_path
      else
          flash[:error] = "error"
          render :show
      end
  end
end
