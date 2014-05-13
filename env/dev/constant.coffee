libr = angular.module 'libr.constant', []

Constant = {}
#Constant.baseUrl = "http://libr.herokuapp.com/api/v1"
Constant.baseUrl = "http://192.168.3.73:3000/api/v1"


libr.constant 'Constant', Constant
