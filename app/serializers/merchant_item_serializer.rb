class MerchantItemSerializer
  include JSONAPI::Serializer
  attributes :merchant_id, :item_id, :created_at, :updated_at
end
