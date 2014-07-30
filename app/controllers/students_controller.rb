class StudentsController < ApplicationController

  def index
    if params[:search]
      name_matches = Student.where("name LIKE '%#{params[:search]}%'")
      email_matches = Student.where("email LIKE '%#{params[:search]}%'")
      @students = (name_matches + email_matches).uniq
    else
      @students = Student.all
    end

  end

  def show
    @student = Student.find_by(id: params[:id])
  end

  def new
  end

  def create
    @student = Student.new
    @student.name = params[:name]
    @student.email = params[:email]

    if @student.save
      redirect_to "/students/#{ @student.id }"
    else
      render 'new'
    end
  end

  def edit
    @student = Student.find_by(id: params[:id])
  end

  def update
    @student = Student.find_by(id: params[:id])
    @student.name = params[:name]
    @student.email = params[:email]

    if @student.save
      redirect_to "/students/#{ @student.id }"
    else
      render 'edit'
    end
  end

  def destroy
    @student = Student.find_by(id: params[:id])
    @student.destroy


    redirect_to "/students"
  end
end
