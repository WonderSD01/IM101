document.addEventListener("DOMContentLoaded", function () {
    const form = document.querySelector("form");
    const usernameInput = form.querySelector("input[name='username']");
    const passwordInput = form.querySelector("input[name='password']");

    form.addEventListener("submit", function (e) {
        if (usernameInput.value.trim() === "" || passwordInput.value.trim() === "") {
            alert("Please fill in both username and password.");
            e.preventDefault(); // stops form from submitting
        }
    });
});
