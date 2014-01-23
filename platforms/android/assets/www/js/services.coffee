libr = angular.module 'starter.services', []
libr.factory 'PetService', ()->
  pets = [
    { id: 0, title: 'Cats', description: 'Furry little creatures.' },
    { id: 1, title: 'Dogs', description: 'Lovable. Loyal almost to a fault. Smarter than they let on.' },
    { id: 2, title: 'Turtles', description: 'Everyone likes turtles.' },
    { id: 3, title: 'Sharks', description: 'An advanced pet. Needs millions of gallons of salt water. Will happily eat you.' }
  ]

  return  {
  all: ()->
    pets
  get: (petId)->
    pets[petId]
  }
libr.factory 'BookService', ['$http', ($http)->
  baseUrl = 'http://libr.herokuapp.com/api'
  bookFactory = {}
  bookFactory.getBooks = () ->
    $http.get(baseUrl + '/books?user_email=wahyd4@qq.com&user_token=5w1snRq8QgxBfxayzTa2')
  bookFactory.getBook = (isbn) ->
    $http.get baseUrl + '/bookinfo/' + isbn
  bookFactory
]