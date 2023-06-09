module ApplicationHelper
  def to_currency(number)
    number_to_currency(number, :unit => "", :negative_format => "(%u%n)",  :separator => ",", :delimiter => ".")
  end 
end
