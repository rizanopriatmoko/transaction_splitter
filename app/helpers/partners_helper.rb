module PartnersHelper
    def to_currency(number, unit="")
        number_to_currency(number, :unit => unit, :negative_format => "(%u%n)",  :separator => ",", :delimiter => ".")
    end 
end
