json.product do
  json.partial! 'product', product: @product
end

json.message 'The product has been updated.'
