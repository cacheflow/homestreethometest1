var residentApp = angular.module('resident-app', ['ngResource', 'mgcrea.ngStrap']).config(
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
    $scope.numdisplay = 8;
    $scope.counter = 0;
    $scope.ressyID = 0;
    $scope.randomnum = 4;
    $scope.newDonation = 0;
    Resident.query(function(residents) {
      $scope.residents = residents;
    });

    console.log('logging')
    $scope.loadMore = function() {
        $scope.numdisplay +=4;
        console.log($scope.numdisplay)    
    };
    $scope.returnRes = function(){
        currentUrl = location.href;
        $scope.ressyID = parseInt(currentUrl.split("/").pop())
        console.log($scope.ressyID)
    }
    $scope.returnRes();
    $scope.numdonations = function(resident){
      return resident.donations.length
    }
    $scope.numstatuses = function(resident){
      return -resident.statuses.length
    }

    $scope.calcrevTotal = function(r){
      var totaldonation = 0;
      for( i=0; i<r.donations.length; i++){
        totaldonation = totaldonation + r.donations[i].amount;
      };
      return -totaldonation;
    }
 
    $scope.calcTotal = function(r){
      var totaldonation = 0;
      for( i=0; i<r.donations.length; i++){
        totaldonation = totaldonation + r.donations[i].amount;
      };
      return totaldonation;
    }
    $scope.calcPercent = function(r){
      var totaldonation = 0;
      for( i=0; i<r.donations.length; i++){
        totaldonation = totaldonation + r.donations[i].amount;
      };
      var mongoal = parseInt(r.goal_monetary)
      var percentofgoal = (totaldonation/mongoal)*100
      return percentofgoal
    }
    $scope.calcAmtLeft = function(r){
      var totaldonation = 0;
      for( i=0; i<r.donations.length; i++){
        totaldonation = totaldonation + r.donations[i].amount;
      };
      var mongoal = parseInt(r.goal_monetary);
      var amtleft = mongoal - totaldonation;
      return amtleft 

    }
$scope.showRes = function(resident){
      resident.details = true;
    }
$scope.hideRes = function(resident){
      resident.details = false;
    }
$scope.avgdonation = function(r){
    var totaldonation = 0;
    for (j=0; j<r.length; j++){
      for( i=0; i<r[j].donations.length; i++){
        totaldonation = totaldonation + r[j].donations[i].amount;
      }
    };
      avgdonation = totaldonation/r.length
      return avgdonation;
}
$scope.avgstatuses = function(r){
      var numstatuses = 0;
      var avgstatus = 0;
      for (j=0; j<r.length; j++){
        numstatuses = numstatuses + r[j].statuses.length;
    };
      avgstatus = numstatuses/r.length;
      return avgstatus;
}


   }])

residentApp.directive('whenScrolled', function() {
    return function(scope, elm, attr) {
        var raw = elm[0];
        
        elm.bind('scroll', function() {
            if (raw.scrollTop + raw.offsetHeight >= raw.scrollHeight) {
                scope.$apply(attr.whenScrolled);
            }
        });
    };
});


