var residentApp = angular.module('resident-app', ['ngResource']).config(
    ['$httpProvider', function($httpProvider) {
    var authToken = angular.element("meta[name=\"csrf-token\"]").attr("content");
    var defaults = $httpProvider.defaults.headers;

    defaults.common["X-CSRF-TOKEN"] = authToken;
    defaults.patch = defaults.patch || {};
    defaults.patch['Content-Type'] = 'application/json';
    defaults.common['Accept'] = 'application/json';
}]);

residentApp.factory('Resident', ['$resource', function($resource) {
  return $resource('/residents/:id',
     {id: '@id'},
     {update: { method: 'PATCH'}});
}]);

residentApp.controller('ResidentCtrl', ['$scope', 'Resident', function($scope, Resident) {
    $scope.residents= [];


    Resident.query(function(residents) {
      $scope.residents = residents;
    });



   }])
