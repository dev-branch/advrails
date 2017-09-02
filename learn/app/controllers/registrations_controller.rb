class RegistrationsController < ApplicationController
  before_action :auth_teacher

  def index
    @registrations = Registration.all.order(id: 'asc')
  end

  def new
    @klasses = Klass.all
    @teachers = User.where(role: 'teacher')
    @semesters = ['Spring', 'Fall']
    @registration = Registration.new
  end

  def create
    @registration = Registration.new(params[:registration].permit(:klass_id, :teacher_id, :semester, :year, :capacity))
    if @registration.save
      redirect_to registrations_path
    else
      @klasses = Klass.all
      @teachers = User.where(role: 'teacher')
      @semesters = ['Spring', 'Fall']
      render 'new'
    end
  end

  def toggle_open
    r = Registration.find(params[:id])
    r.update(is_open: !r.is_open)
    redirect_to registrations_path
  end
end
