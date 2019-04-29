# CLASS: Card
#
# Author: Mitul patel, 7851781
#
# REMARKS: Holds the card object
#
#-----------------------------------------
class Card

  def initialize(type,value)
    #------------------------------------------------------
    # initialize
    #
    # PURPOSE:  Constructor
    # PARAMETERS:
    #    type- its the type of the card
    #    Value- the value of the card
    #-----------------------------------------------------
    @type=type
    @value=value
  end

  def ==(other)
    #overloading the == operator and compares the data fields to check if they are the same
    # other- this is the other object of card
    retValue=false

    if other.instance_of?(Card)
      if @type==other.type && @value==other.value
        retValue=true
      end
    end

    return retValue
  end

  def to_s()
    return @value.to_s
  end
  attr_reader :type,:value    #getters for the type and value

end