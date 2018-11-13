require_relative "room"

class Hotel
  attr_reader :rooms

  def initialize(name, rooms)
    @name = name
    @rooms = {}

    rooms.each do |room_name, cap|
      @rooms[room_name] = Room.new(cap)
    end
  end

  def name
    new_name = []

    @name.split.each do |word|
      new_name << word[0].upcase + word[1..-1].downcase
    end

    new_name.join(" ")
  end

  def room_exists?(room_name)
    return true if @rooms.key?(room_name)
    false
  end

  def check_in(person, room_name)
    if room_exists?(room_name)
      if @rooms[room_name].add_occupant(person)
        puts "check in successful"
      else
        puts "sorry, room is full"
      end
    else
      puts "sorry, room does not exist"
    end
  end

  def has_vacancy?
    return false if @rooms.each_value.all? { |room| room.full? }
    true
  end

  def list_rooms
    @rooms.each do |room_name, room|
      puts "#{room_name}.*#{room.available_space}"
    end
  end
end
