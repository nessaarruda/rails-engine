class BusinessSerializer
  include FastJsonapi::ObjectSerializer

  def self.merchants
    merchants.map do |merchant|
      {
        id: merchant.id,
        type: merchant.type,
        attributes: merchant.attributes,
        name: merchant.name
      }
    end 
  end
end
