class BusinessSerializer
  include FastJsonapi::ObjectSerializer
  set_id :object_id
  attribute :revenue do |obj|
    obj
  end
end
