class AvailabilityRoomService
  def initialize
  end

  def check(room, start_check, end_check)
    room.bookings.where("(start <= ? AND end >= ?) OR
                         (start <= ? AND end >= ?) OR
                         (start >= ? AND end <= ?)",
                         start_check, start_check,
                         end_check, end_check,
                         start_check, end_check).empty?
  end
end
