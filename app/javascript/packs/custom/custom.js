document.addEventListener("turbolinks:load", function() {
  const button = document.getElementById("toggle__button")
  const sidemenu = document.getElementById("sidemenu")
  button.addEventListener('click', e => {
    sidemenu.classList.toggle("open")
  })
})
