class AttendancesController < ApplicationController
    before_action :authenticate_user!

    def create
      @event = Event.find(params[:event_id])
      current_user.attended_events << @event
      redirect_to @event, notice: 'You are now attending this event.'
    end
  
    def destroy
      @attendance = Attendance.find(params[:id])
      @event = @attendance.attended_event
      @attendance.destroy
      redirect_to @event, notice: 'You are no longer attending this event.'
    end

    def remove_attendance
      @attendance = Attendance.find(params[:id])
      @event = @attendance.attended_event
      if @attendance.user == current_user
        @attendance.destroy
        redirect_to @event, notice: 'You are no longer attending this event.'
      else
        redirect_to @event, alert: 'You cannot remove someone else\'s attendance.'
      end
    end

end
