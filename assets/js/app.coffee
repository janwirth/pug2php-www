window.fs =
  readFileSync: ->

Vue      = require 'vue'
jade2php = require '/Users/jan/jade2php/'


Vue.filter 'jade2php', (string) ->

demoVue = new Vue

  el: '.Demo'

  data:
    input: '- var foo = "hello world"\na(href=foo)\n\t| Say Hey'
    output: ''
    error: undefined

  methods:
    render: ->
      opts =
        omitPhpRuntime: yes
        omitPhpExtractor: yes
      try
        @output = jade2php @input, opts
        @error = undefined
      catch err
        @error = err

    # tab support
    catchTab: (event) ->
      if event.code == 'Tab'

        event.preventDefault()

        start = event.path[0].selectionStart
        end = event.path[0].selectionEnd

        @input = @input.substring(0, start) + "\t" + @input.substring end

        targetPosition = start + 1
        process.nextTick =>
          event.path[0].selectionStart = event.path[0].selectionEnd = targetPosition

# Initial render
demoVue.render()
