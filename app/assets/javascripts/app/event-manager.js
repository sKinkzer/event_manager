angular.module('eventManager', ['angucomplete-alt', 'templates', 'ngResource'])
	.factory('Location', ['$resource', function ($resource) {
		return new $resource('/locations/:id');
	}])
	.directive('emLocationSearch', ['Location', function (Location) {
		return {
			restrict: 'E',
			bindToController: {
				
			},
			controller: function () {
				this.location = new Location();
				var self = this;
				this.onInputChanged = function (val) {
					self.location.name = val;	
				}
				this.onLocationSelected = function (location) {
					if(location) {
						self.location = location.originalObject;
					}
				}	
			},
			controllerAs: 'locationSearch',
			scope: true,
			templateUrl: 'location-search.html'
		}
	}])