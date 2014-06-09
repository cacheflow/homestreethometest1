var partnerApp = angular.module('partner-app', ['ngResource', 'mgcrea.ngStrap']).config(
    ['$httpProvider', function($httpProvider) {
    var authToken = angular.element("meta[name=\"csrf-token\"]").attr("content");
    var defaults = $httpProvider.defaults.headers;

    defaults.common["X-CSRF-TOKEN"] = authToken;
    defaults.patch = defaults.patch || {};
    defaults.patch['Content-Type'] = 'application/json';
    defaults.common['Accept'] = 'application/json';
}]);

partnerApp.factory('Partner', ['$resource', function($resource) {
  return $resource('/partners/:id',
     {id: '@id'},
     {update: { method: 'PATCH'}});
}]);

partnerApp.controller('PartnerCtrl', ['$scope', 'Partner', function($scope, Partner) {
    $scope.partners= [];


    Partner.query(function(partners) {
      $scope.partners = partners;
    });

$scope.aside = {
  "title": "Admin Dashboard",
  "content": "Hello Aside<br />This is a multiline message!"
};
// $scope.aside = { template: '/tpl.html'};

$scope.showPartner = function(partner){
      partner.details = true;
    }
$scope.hidePartner = function(partner){
      partner.details = false;
    }
$scope.avgdonation = function(partners){
    var totaldonation = 0;
    var avgdonation = 0;
      for( i=0; i<partners.length; i++){
        totaldonation = totaldonation + partners[i].sum;
      };
      avgdonation = totaldonation/partners.length
      return avgdonation;
}
$scope.avgresidents = function(partners){
      var numresidents = 0;
      for( i=0; i<partners.length; i++){
        numresidents = numresidents + partners[i].residents.length;
      };
      avgresident = numresidents/partners.length
      return avgresident;
}



   }]);
