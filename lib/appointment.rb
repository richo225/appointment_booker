class Appointment
  attr_reader :slot_data, :requested_time
  attr_writer :slot_data

  def initialize(slot_data)
    @slot_data = slot_data
  end

  def check_availability(requested_time)
    @requested_time = requested_time
    raise "Please pick a time between 08:00:00 and 15:00:00" if !valid?
    raise "No later appointments available. Please pick an earlier time" if !available?
    book_appointment
  end

  def book_appointment
    available_slots = slot_data.select {|slot| slot["time"] >= requested_time}
    earliest_slot = available_slots[0]
    remove_appointment(earliest_slot)
  end

  def remove_appointment(earliest_slot)
    slot_data.delete(earliest_slot)
    "Appointment confirmed at #{earliest_slot["time"]}"
  end

  private

  def valid?
    requested_time.between?("08:00:00","15:00:00")
  end

  def available?
    slot_data.any? {|slot| slot["time"] >= requested_time}
  end

  # Check if exact time is available ie. "booked" => false or deleted
  # If it is, run booking method and either delete that appointment or add a key "booked" => true
    # Write this to the JSON file
  # If it isn't, find nearest value and repeat

end
