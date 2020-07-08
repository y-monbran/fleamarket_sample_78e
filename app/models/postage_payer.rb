class PostagePayer < ActiveHash::Base
  self.data = [
      {id: 1, name: '出品者負担'}, {id: 2, name: '購入者負担'}
  ]
end