class Customer < ApplicationRecord
  enum gender:
  {
    man: 0,
    woman: 1
  }

  
end
