function initToggleBtn() {
  let toggleBtn = document.getElementById("toggle-btn");
  let form = document.getElementById("recipe-form");

  toggleBtn.addEventListener("change", function () {
    form.submit();
  });
}

initToggleBtn();
