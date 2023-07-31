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
end
