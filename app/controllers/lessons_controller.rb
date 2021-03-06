class LessonsController < ApplicationController
  before_action :set_lesson, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_filter :check_user, only: [:edit, :update, :destroy]
  respond_to :html

  def new
    @lesson = Lesson.new
    respond_with(@lesson)
  end

  def edit
  end

  def create
    @lesson = Lesson.new(lesson_params)
    @lesson.tutor = current_user.profile

    if @lesson.save
      redirect_to @lesson.tutor
    else
      render :new
    end
  end

  def update
    @lesson.update(lesson_params)
    redirect_to @lesson.tutor
  end

  def destroy
    @lesson.destroy
    redirect_to @lesson.tutor
  end

  private
    def set_lesson
      @lesson = Lesson.find(params[:id])
    end

    def lesson_params
      params.require(:lesson).permit(:day, :start_time, :duration, :status, :tutor_id, :student_id)
    end

    def check_user
      if current_user != @lesson.tutor.user
        redirect_to root_url, alert: "Sorry, you cannot make changes to someone else's lesson."
      end
    end
end
