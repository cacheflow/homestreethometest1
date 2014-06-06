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
    $scope.saveDonation = function(resident){
      $scope.newDonation = resident.donations.build;
        $scope.newDonation.$save(function(resident) {
        $scope.newDonation = resident.donations.build
      });
   
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


