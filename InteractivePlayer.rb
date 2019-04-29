# CLASS: Player
#
# Author: Mitul patel, 7851781
#
# REMARKS: Class that simulates the human player
#
#----------------------------------------

require_relative "Card"
require_relative "Guess"
require_relative "Players"




class InteractivePlayer<Players

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
      puts("You received the card "+card.value)

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
    temp_arr=Array.new


    for value in @hand #loop through the hand

      if value==guess.person|| value==guess.place|| value==guess.weapon  #check to see.

        temp_arr.push(value) #add the value to a temp array
      end
    end

    if temp_arr.length==0  #if there was no one found

      puts("Player #{player_index} asked you about #{guess.to_s}, but you couldn't answer.")

    elsif temp_arr.length==1 #if only one card was found

      ret_value=temp_arr[0]
      puts("Player #{player_index} asked you about #{guess.to_s}, you only have one card, #{temp_arr[0].value}, showed it to them.")

    else  #if more than one card was found


      puts( "Player #{player_index} asked you about #{guess.to_s}. Which do you show?" )
      ret_value=ioHelper(temp_arr)
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

    ret_value=nil
    person=nil
    place=nil
    weapon=nil
    guess=true


    puts("Which person do you want to suggest?")  #players turn
    person=ioHelper(@list_suspects)

    puts("Which place do you want to suggest?")  #players turn
    place=ioHelper(@list_locations)

    puts("Which weapon do you want to suggest?")  #players turn
    weapon=ioHelper(@list_weapons)

    puts("Is this an accusation (Y/[N])?")  #players turn

    while true
      char=gets.chomp  #get input from the user

      if char=="Y"|| char=="y"
        guess=false
        break
      elsif char=="N"|| char=="n"
        guess=true
        break
      else
        puts("Invalid Input!")
      end

    end

    if person!=nil &&place!=nil &&weapon!=nil
      ret_value=Guess.new(person,place,weapon,guess)
    end

    return ret_value

  end



  def ioHelper(arr)
    #------------------------------------------------------
    # printHelper
    #
    # PURPOSE: Helps to print the array contents
    # Parameters:
    #   arr- the array to be printed
    #-----------------------------------------------------

    index=0
    ret_value=nil

    for value in arr  #for each element in the array

      puts(index.to_s+". "+value.value)
      index+=1
    end

    while true

      index=gets  #get input from the user
      index=index.to_i  #changing it to an int


      if index<arr.length&&index>=0

        ret_value=arr[index]
        break

      else
        puts("Invalid Input!")
      end

    end


    return ret_value
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

          @info_person.push(card)

        elsif card.type==:place #if the card is a place

          @info_places.push(card)

        else  #if the card is a weapon

          @info_weapon.push(card)

        end

      end
    end
  end

end