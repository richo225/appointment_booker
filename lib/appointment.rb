require "json"

class Appointment
  attr_reader :slots, :requested_time

  def initialize(time)
    @requested_time = time
    get_slots
  end

  def get_slots
    json = File.read("lib/availability_slots.json")
    @slots = JSON.parse(json)["availability_slots"]
  end    

  def check_availability
    if available?
      "Appointment confirmed at #{@requested_time}"
    else
      "Please pick another time"
    end
  end

  private

  def available?
    slots.any? {|slot| slot["time"] == requested_time}
  end

  # Check if exact time is available ie. "booked" => false or deleted
  # If it is, run booking method and either delete that appointment or add a key "booked" => true
  # If it isn't, find nearest value and repeat

end
