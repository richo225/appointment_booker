require "appointment"
require "json"

json = File.read("lib/availability_slots.json")
slot_data = JSON.parse(json)["availability_slots"]

describe Appointment do
  let(:appointment) { described_class.new(slot_data) }

  it "correctly parses JSON to a slot_data array" do
    slot_hash = {"time"=>"08:00:00","slot_size"=>10,"doctor_id"=>1}
    expect(appointment.slot_data).to be_an Array
    expect(appointment.slot_data).to include(slot_hash)
  end

  context "requested time is invalid" do
    invalid = "Please pick a time between 08:00:00 and 15:00:00"

    it "raises an error if time is before 08:00:00" do
      expect{appointment.check_availability("07:30:00")}.to raise_error invalid
    end

    it "raises an error if time is after 15:00:00" do
      expect{appointment.check_availability("15:30:00")}.to raise_error invalid
    end
  end

  context "requested time is not available" do

    it "books the next available slot" do
      appointment.check_availability("08:15:00")
      expect(appointment.check_availability("08:15:00")).to eq "Appointment confirmed at 08:20:00 with Doctor 1"
    end

    it "asks for an earlier time if all later slots unavailable" do
      unavailable = "No later appointments available. Please pick an earlier time"
      appointment.check_availability("15:00:00")
      expect{appointment.check_availability("15:00:00")}.to raise_error unavailable
    end
  end

  context "requested time is available" do

    it "returns a confirmation message if time is available" do
      message = "Appointment confirmed at 08:00:00 with Doctor 1"
      expect(appointment.check_availability("08:00:00")).to eq message
    end

    it "user can book same time with both doctors" do
      message = "Appointment confirmed at 11:00:00 with Doctor 2"
      appointment.check_availability("11:00:00")
      expect(appointment.check_availability("11:00:00")).to eq message
    end
  end

end
