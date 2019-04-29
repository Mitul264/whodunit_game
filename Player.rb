# CLASS: Player
#
# Author: Mitul patel, 7851781
#
# REMARKS: Class that simulates the computer player
#
#-----------------------------------------

require_relative "Players"
require_relative "Card"
require_relative "Guess"


class Player < Players

  def initialize()
    super
  end

  def setCard(card)
    #------------------------------------------------------
    # setCard
    #
    # PURPOSE:  adds the card to the players hand
    # PARAMETERS:
    #    card- adds the card to the players hand
    #-----------------------------------------------------

    if card.instance_of?(Card)

      @hand.push(card)  #add the card to the players hand

      if card.type==:person

        @info_person.push(card)       # the cards we know about
        @list_suspects.delete(card)   # the cards we dont know about

      elsif card.type==:place

        @info_places.push(card)
        @list_locations.delete(card)

      else

        @info_weapon.push(card)
        @list_weapons.delete(card)

      end

    end
  end

  def canAnswer(player_index,guess)
    #------------------------------------------------------
    # canAnswer
    #
    # PURPOSE:  This method receives information regarding the guess and returns a nil if it can answer
    # PARAMETERS:
    #    player_index-the index of the player who is guessing the card
    #    guess- the guess that is shown to player
    #
    #-----------------------------------------------------

    ret_value=nil

    if player_index.is_a?(Integer) && guess.is_a?(Guess)#if the index is an int and card is a Card

      if index!=-1 && guess!=nil #if the index is not -1

        for card in @hand  #loop through the hand

          if card.value==guess.person.value || card.value==guess.place.value || card.value==guess.weapon.value #check to see.

            ret_value=card #found a card in the hand
            break

          end
        end
      end
    end

    return ret_value
  end


  def getGuess()
    #------------------------------------------------------
    # getGuess
    #
    # PURPOSE: Makes a guess for the player
    # RETURN- returns a guess made
    #-----------------------------------------------------

    # PLEASE NOTE: ONE CARD IS NEVER CHOSEN MORE THAN ONCE
    # IF THE AI IS AWARE OF A CARD IT WILL REMOVE IT FROM THE ARRAY IN THE RECEIVE INFO METHOD


    retValue=nil

    if !(@list_weapons.length==1&&@list_locations.length==1&&@list_suspects.length==1)

      # PLEASE NOTE: ONE CARD IS NEVER CHOSEN MORE THAN ONCE
      # IF THE AI IS AWARE OF A CARD IT WILL REMOVE IT FROM THE ARRAY IN THE RECEIVE INFO METHOD

      # always chooses a random value from the list
      person_index=rand(@list_suspects.length)
      place_index=rand(@list_locations.length)
      weapon_index=rand(@list_weapons.length)

      retValue=Guess.new(@list_suspects[person_index],@list_locations[place_index],@list_weapons[weapon_index],true)

    else  #if the array is, then its an accusation

      retValue=Guess.new(@list_suspects[0],@list_locations[0],@list_weapons[0],false)

    end

    return retValue
  end


  def receiveInfo(index,card)
    #------------------------------------------------------
    # receiveInfo
    #
    # PURPOSE:  This method receives information regarding the guess they made
    # PARAMETERS:
    #    card- the card that is shown to player
    #    index-the index of the player who is showing the card
    #
    #-----------------------------------------------------

    if index.is_a?(Integer) && card.is_a?(Card)#if the index is an int and card is a Card


      if index!=-1 && card!=nil #if the index is not -1


        if card.type==:person #if the card is of

          @info_person.delete(card) # incase there are duplicates due to human player returning wrong cards, then deletes them all
          @info_person.push(card)
          @list_suspects.delete(card)


        elsif card.type==:place #if the card is a place

          @info_places.delete(card)
          @info_places.push(card)
          @list_locations.delete(card)

        else  #if the card is a weapon

          @info_weapon.delete(card)
          @info_weapon.push(card)
          @list_weapons.delete(card)

        end

      end
    end
  end

end