class EventsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

    def index
        @events = Event.all
    end

    def show
        @event = Event.find(params[:id])
        @attendees = @event.attendees
    end

    def create
        @event = current_user.created_events.build(event_params)
    
        if @event.save
          redirect_to @event, notice: 'Event was successfully created.'
        else
          render :new
        end
    end
    
    
      # ... other actions ...
      
      private
    
      def event_params
        params.require(:event).permit(:title, :location, :date)
      end

end
