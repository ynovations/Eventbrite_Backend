class EventsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

    def index
        @events = Event.all
        @past_events = Event.past
        @upcoming_events = Event.upcoming
    end

    def show
        @event = Event.find(params[:id])
        @attendees = @event.attendees
    end

    def new
      @event = Event.new
    end

    def create
      @event = current_user.created_events.build(event_params)
  
      if @event.save
        redirect_to @event, notice: 'Event was successfully created.'
      else
        render :new
      end
    end


    def edit
      @event = Event.find(params[:id])
    end

  
    def update
      @event = Event.find(params[:id])
      if @event.update(event_params)
        redirect_to @event, notice: 'Event was successfully updated.'
      else
        render :edit
      end
    end
  
    def destroy
      puts "Destroy action is being called"
      @event = Event.find(params[:id])
      @event.destroy
      redirect_to events_path, notice: 'Event was successfully deleted.'
    end

    def invite
      @event = Event.find(params[:id])
      @invitees = User.all
    end
  
    def send_invitations
      @event = Event.find(params[:id])
      invitee_ids = params[:event][:invitee_ids]
      if @event.update(invitee_ids: invitee_ids)
        redirect_to @event, notice: 'Invitations sent successfully.'
      else
        @invitees = User.all
        render :invite
      end
    end
    
    
      # ... other actions ...
      
      private
    
      def event_params
        params.require(:event).permit(:title, :location, :date)
      end

end
