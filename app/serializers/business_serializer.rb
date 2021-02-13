class BusinessSerializer
  include FastJsonapi::ObjectSerializer
  set_id :object_id

  attributes :revenue do |object|
    object
  end
end
