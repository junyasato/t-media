class Item < ApplicationRecord
  belongs_to :article
  enum item_type: { "text": 0 ,"header": 1, "quote": 2, "link": 3, "image": 4, "button": 5}
end
