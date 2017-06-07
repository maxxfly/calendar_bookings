class BookingsController < ApplicationController
  def create
    @room = Room.find(params[:room_id])

    availability_room_service = AvailabilityRoomService.new
    if availability_room_service.check(@room, params[:start], params[:end])
      render json: { message: 'Booking created.' }, status: :ok
    else
      render json: { message: 'Booking conflicts with an existing booking' }, status: :unprocessable_entity
    end
  end

  private

  def booking_params
    params.permit(:start, :end, :room_id)
  end
end
