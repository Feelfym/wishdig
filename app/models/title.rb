class Title < ActiveHash::Base
  self.data = [
    { id:1, name: 'メモのテーマを選択してください' },
    { id:2, name: '欲しいと思う理由は？' },
    { id:3, name: '他の製品との違いは？' },
    { id:4, name: 'ワンランク下げてみるのはどう？' },
    { id:5, name: 'ワンランク上げてみるのはどう？' },
    { id:6, name: '来年ではなく、今欲しい理由は？' },
    { id:7, name: '購入の結果、自分に起きる変化は？' },
    { id:8, name: '買わない方が良いと思うなら、その理由は？' },
    { id:9, name: 'これを達成したら買う！' },
    { id:10, name: '買わなくても目的を達成する方法は？' },
  ]

  include ActiveHash::Associations
  has_many :memos
end