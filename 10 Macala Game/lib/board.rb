class Board
  attr_accessor :cups

  def initialize(name1, name2)
    @name1, @name2 = name1, name2
    @cups = Array.new(14) { Array.new([:stone, :stone, :stone, :stone]) }
    place_stones
  end

  def place_stones
    @cups.each_index do |i|
      @cups[i] = [] if i == 6 || i == 13
    end  
  end

  def valid_move?(start_pos)
    raise "Invalid starting cup" if start_pos < 0 || start_pos > 12
    raise "Starting cup is empty" if @cups[start_pos].empty?
  end

  def make_move(start_pos, current_player_name)
    current_pos = start_pos
    while !@cups[start_pos].empty?
      current_pos = (current_pos + 1) % 14
      next if current_player_name == @name1 && current_pos == 13
      next if current_player_name == @name2 && current_pos == 6
      @cups[current_pos] << @cups[start_pos].pop
    end
    render
    next_turn(current_pos)
  end

  def next_turn(ending_cup_idx)
    # helper method to determine whether #make_move returns :switch, :prompt, or ending_cup_idx
    if ending_cup_idx == 6 || ending_cup_idx == 13
      :prompt
    elsif @cups[ending_cup_idx].length == 1
      :switch
    else
      ending_cup_idx
    end
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
    @cups.take(6).all? { |cup| cup.empty? } ||
    @cups[7..12].all? { |cup| cup.empty? }

  end

  def winner
    if @cups[6] == @cups[13]
      :draw
    else
      @cups[6].length > @cups[13].length ? @name1 : @name2
    end
  end
end
