# CLASS: Players
#
# Author: Mitul patel, 7851781
#
# REMARKS: Abstract class that is the father of player and interactive player
#
#-----------------------------------------


class Players


  def Players.new(*args)
    #------------------------------------------------------
    # Players.new()
    #
    # PURPOSE:  Method that doesnt let us create an object
    #-----------------------------------------------------
    if self==Players

      raise("Cannot create an object for an abstract class")

    else

      super

    end
  end

  def initialize()
    #------------------------------------------------------
    # constructor
    #
    # PURPOSE:  initializes the Object
    #-----------------------------------------------------
    super
  end


  def setup(num_players,index,list_suspects,list_locations,list_weapons)
    #------------------------------------------------------
    # setup
    #
    # PURPOSE:  method that sets up the player ready to play
    # PARAMETERS:
    #    num_players- the number of players in the game
    #    index-the index of this player
    #    list_suspects- the array of suspects in the game
    #    list_locations- the array of the locations of the game
    #    list_weapons- the array of the weapons in the game
    #-----------------------------------------------------

    if (num_players.is_a?(Integer))&&(index.is_a?(Integer))
      @num_players=num_players
      @index=index
    end

    if (list_weapons.is_a?(Array))&&(list_locations.is_a?(Array))&&(list_suspects.is_a?(Array))
      @list_suspects=list_suspects.clone
      @list_locations=list_locations.clone
      @list_weapons=list_weapons.clone
    end

    @hand=Array.new()  # the hand of the player

    # THIS ARRAY STRICTLY CONTAINS THE INFORMATION ABOUT THE CARDS THE PLAYER HAS RECEIVED INFORMATION ABOUT.
    @info_person=Array.new()
    @info_places=Array.new()
    @info_weapon=Array.new()

  end




  # getters
  attr_reader :num_players,:list_suspects,:list_locations,:list_weapons,:index,:hand,:info_aware
end
