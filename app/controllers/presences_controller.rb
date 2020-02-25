class PresencesController < ApplicationController
    before_action :authenticate_student!, only: [:new]
    before_action :authenticate_student!, except: [:show]
    before_action :set_checkout, only: [:show, :checkout, :update]
    before_action :set_student, only: [:index, :new]

    def index
      @presences = current_student.presences.order(created_at: :desc).page params[:page]
    end

    # def new
    #   @presence = current_student.presences.new
    # end

    def edit; end

    def checkout; end

    def update
      respond_to do |format|
        if @presence_to_update.update(presence_params)
          format.html { redirect_to "/", notice: 'Goodbye, be careful.' }
          format.json { render :show, status: :ok, location: @presence }
        else
          format.html { render :edit }
          format.json { render json: @presence.errors, status: :unprocessable_entity }
        end
      end
    end

    def create
      @presence = current_student.presences.new(presence_params)

      respond_to do |format|
        if @presence.save
          format.html { redirect_to "/", notice: 'Welcome to 41studio, have a good work.' }
          format.json { render :show, status: :created, location: @presence }
        else
          format.html { render :new }
          format.json { render json: @presence.errors, status: :unprocessable_entity }
        end
      end
    end

    private

      def set_student
        @student = current_student
      end

      def set_presence
        @presence = Presence.find(params[:id])
      end

      def presence_params
        params.require(:presence).permit(:checkin, :checkout)
      end

      def set_checkout
        @presence_to_update = current_student.presences.last
      end

      def presence_checkout
        params.require(:presence).permit(:checkout)
      end

end

