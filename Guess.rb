# CLASS: Guess
#
# Author: Mitul patel, 7851781
#
# REMARKS: Simulates guesses made by the players
#
#-----------------------------------------

require_relative "Card"

class Guess

  def initialize(person,place,weapon,guess)

    #------------------------------------------------------
    # initialize
    #
    # PURPOSE:  Constructor
    # PARAMETERS:
    #    person- the person who was guessed
    #    place- the place which was guessed
    #    weapon- the weapon which was guessed
    #    guess- a boolean if it was a guess. If its an accusation its false
    #-----------------------------------------------------

    @person=person
    @place=place
    @weapon=weapon
    @guess=guess

  end

  def to_s()
    #the to string of the guess
    return "#{@person.value} in the #{@place.value} course with the #{@weapon.value}"
  end

  def isAccusation()  # returns if guess is an accusation

    return !@guess

  end

  attr_reader :person,:place,:weapon,:guess    #getters

end