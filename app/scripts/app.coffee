'use strict'

angular.module('frontendWissenSystemApp', [
  'ngCookies'
  'ngSanitize'
  'ngAnimate'
  'pascalprecht.translate'
  'ui.bootstrap'
  'ui.router'
  'ui.select2'
  'chieffancypants.loadingBar'
  'ngCkeditor'
  'restangular'
  'uiBreadcrumbs'
])

.constant('App', {
	#Origin: 'http://olimpiadas.herokuapp.com/' # Pruebas en Heroku
	Origin: 'http://127.0.0.1:8000/' # Pruebas en mi localhost
	API: 'api/'
	#Server: "#{App.Origin}#{App.API}" # No puedo hacer esto
	#Server: 'http://olimpiadas.herokuapp.com/api/'
	Server: 'http://127.0.0.1:8000/api/'
	views: 'views/'
})

.config(['$stateProvider', '$urlRouterProvider', '$translateProvider', '$translatePartialLoaderProvider', '$httpProvider', 'App', 'RestangularProvider', ($state, $urlRouter, $translate, $translatePartialLoader, $httpProvider, App, Restangular)->
	
	$httpProvider.defaults.withCredentials = true;
	
	###
	$httpProvider.defaults.headers.post['X-CSRFToken'] = $cookies.csrftoken;
	$httpProvider.defaults.headers.put['X-CSRFToken'] = $cookies.csrftoken;
	$httpProvider.defaults.headers['delete']['X-CSRFToken'] = $cookies.csrftoken;
	###

	$httpProvider.defaults.xsrfCookieName = 'csrftoken';
	$httpProvider.defaults.xsrfHeaderName = 'X-CSRFToken';



	Restangular.setBaseUrl App.Server

	$urlRouter
		.otherwise('/')

	$state
	.state('main', {
		url: '/'
		views: 
			'principal':
				templateUrl: App.views+'main.tpl.html'
				controller: 'MainCtrl'
		data: 
			displayName: 'principal'
			icon_fa: ''
	})
	.state('login', {
		url: '/login'
		views:
			'principal':
				templateUrl: "#{App.views}login/login.tpl.html"
				controller: 'LoginCtrl'
		data: 
			displayName: 'Login'
			icon_fa: 'fa fa-user'

	})
	.state('panel', {
		url: '/panel'
		views:
			'principal':
				templateUrl: "#{App.views}panel/panel.tpl.html"
				controller: 'PanelCtrl'
		data: 
			displayName: 'Inicio'
			icon_fa: 'fa fa-home'
	})

	@
	])
.run ['$rootScope', '$state', '$stateParams', '$translate', ($rootScope, $state, $stateParams, $translate) ->
	


	$rootScope.$state = $state
	$rootScope.$stateParams = $stateParams;


	$rootScope.$on '$stateChangeStart', (event, toState, toParams, fromState, fromParams)->
		#console.log toState
		#console.log event


	$rootScope.$on '$stateChangeSuccess', (event, toState, toParams, fromState, fromParams)->
		#console.log toState
		#console.log $state



	$rootScope.$on '$translatePartialLoaderStructureChanged', () ->
	  $translate.refresh()
	  console.log('Translate refrescado supuestamente.')

]

