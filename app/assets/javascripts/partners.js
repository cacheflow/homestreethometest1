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
$scope.donationTotal = function(partner){
    var totaldonation = 0;
      for( i=0; i<partner.donations.length; i++){
        totaldonation = totaldonation + partner.donations[i].amount;
      };
      return totaldonation;
}



   }]);
