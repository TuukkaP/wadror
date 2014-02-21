/**
 * Created by tuukka on 21.2.2014.
 */
function BeersController($scope, $http) {
    $http.get('beers.json').success( function(data, status, headers, config) {
        $scope.beers = data;
    });

    $scope.order = 'name';

    $scope.click = function (order, reverse){
        $scope.order = order;
        $scope.reverse = reverse;
        console.log(order + ' ' + reverse);
    }

    $scope.searchText = '';
}