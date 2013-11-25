angular.module('deckBuilder')
  .directive('insetFilter', ($parse) ->
    template: '<div class="input"></div>'
    restrict: 'E'
    require: 'ngModel'
    link: (scope, element, attrs, modelCtrl) ->
      inputElement = element.find('.input')

      # Attach an ID for the label
      inputElement.attr('id', attrs.id)

      # Initializes select2 with the provided data
      initSelect = (data) ->
        inputElement.select2(
          placeholder: attrs.placeholder
          data: data)

      # Grab the data
      data = $parse(attrs.insetFilterSource)(scope) ? []

      # Select2-ify the input element
      initSelect(data)

      # Watch for data source changes
      scope.$watch(attrs.insetFilterSource, dataChanged = (newVal, oldVal) ->
        if newVal == oldVal
          return
        initSelect(data).select2('val', '').val('').change())

      inputElement.on('change', (e) ->

      )

      # Clear the select's value on escape press
      element.keydown(jwerty.event('esc', (e) ->
        inputElement.select2('val', ''))
      )
  )
