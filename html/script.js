var isFirstButtonPress = true;
var isDialing = false;
var lcdDisplay = document.getElementById("lcd-display");
var lcdText = document.getElementById("lcd-text");
var number = "";
var outOfOrder = false;

var audioContextClass =
  window.AudioContext ||
  window.webkitAudioContext ||
  window.mozAudioContext ||
  window.oAudioContext ||
  window.msAudioContext;

function resetDisplay() {
  lcdText.classList.remove("blink");
  lcdText.textContent = "";
}

function hangUp() {
  // Reset the blink class after the animation ends
  lcdText.classList.remove("blink");
  lcdText.textContent = "";
  isDialing = false;
  $.post(
    "https://tofu-payphone/exit",
    JSON.stringify({
      number: lcdText.textContent,
    })
  );
}

function dial() {
  isDialing = true;
  lcdText.classList.add("blink");
  $.post(
    "https://tofu-payphone/dial",
    JSON.stringify({
      number: lcdText.textContent,
    })
  );
}

function updateDisplay(value) {
  if (isFirstButtonPress) {
    lcdText.textContent = "";
    isFirstButtonPress = false;
  }

  if (lcdText.textContent.length === 3 || lcdText.textContent.length === 7) {
    lcdText.textContent += "-";
  }
  if (lcdText.textContent.length === 12) {
    return;
  }

  lcdText.textContent += value;
}

$(function () {
  $("#payphone").hide();

  window.addEventListener("message", function (event) {
    var eventData = event.data;

    if (eventData.action == "ui") {
      if (eventData.toggle) {
        $("#branding").text(eventData.brand + " Telephony");
        var phNumber = eventData.phNumber;
        $("#this-phone-number").text(
          "# " +
            [
              phNumber.slice(0, 3),
              "-",
              phNumber.slice(3, 6),
              "-",
              phNumber.slice(6),
            ].join("")
        );

        if (eventData.outOfOrder === true) {
          outOfOrder = true;
          lcdText.textContent = "OUT OF ORDER";
          lcdText.classList.add("blink");
          $("#this-phone-number").text("");
        }
        $("#payphone").fadeIn(250);
      } else {
        $("#payphone").fadeOut(50);
        $("#this-phone-number").text("");
        lcdText.textContent = "";
        lcdText.classList.remove("blink");
        outOfOrder = false;
      }
    }
  });
});
