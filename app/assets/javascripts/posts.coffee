# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

`document.addEventListener('turbolinks:load', () => {
  document.querySelectorAll('.suggestion-form-display').forEach((el) => {
      el.addEventListener('click',(ev) => {
          ev.preventDefault();
          el.nextElementSibling.style = 'display: block; margin-top:20px'
      })
    })
})
  
document.addEventListener('turbolinks:load', () => {
    document.querySelectorAll('.suggestions-display').forEach((el) => {
      el.addEventListener('click',(ev) => {
          ev.preventDefault();
          el.nextElementSibling.style = 'display: block; margin-top:20px'
      })
    })
})

document.addEventListener('turbolinks:load', () => {  
    document.querySelectorAll('.reported-display').forEach((el) => {
      el.addEventListener('click',(ev) => {
          ev.preventDefault();
          el.nextElementSibling.style = 'display: block; margin-top:20px'
      })
    })
})`
