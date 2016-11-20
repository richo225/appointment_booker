class Appointment
  attr_reader :requested_time
  attr_accessor :slot_data

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
    puts "Appointment confirmed at #{earliest_slot["time"]} with Doctor #{earliest_slot["doctor_id"]}"
    print_menu
  end

  def print_menu
    puts "Please enter another time:"
    input = STDIN.gets.chomp
    check_availability(input) if !input.empty?
  end

  private

  def valid?
    requested_time.between?("08:00:00","15:00:00")
  end

  def available?
    slot_data.any? {|slot| slot["time"] >= requested_time}
  end

end
