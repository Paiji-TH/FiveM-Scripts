/*
  __  __           _            _                 _  __                         _____  
 |  \/  |         | |          | |               | |/ /                        |  __ \ 
 | \  / | __ _  __| | ___      | |__  _   _      | ' / __ _ ___ _ __   ___ _ __| |__) |
 | |\/| |/ _` |/ _` |/ _ \     | '_ \| | | |     |  < / _` / __| '_ \ / _ \ '__|  _  / 
 | |  | | (_| | (_| |  __/     | |_) | |_| |     | . \ (_| \__ \ |_) |  __/ |  | | \ \ 
 |_|  |_|\__,_|\__,_|\___|     |_.__/ \__, |     |_|\_\__,_|___/ .__/ \___|_|  |_|  \_\
                                       __/ |                   | |                     
                                      |___/                    |_|                     

  Author: Kasper Rasmussen
  Steam: https://steamcommunity.com/id/kasperrasmussen
*/

$(document).ready(function () {
  // openHome();
  window.addEventListener('message', function (event) {
    var item = event.data;
    if (item.open) {
      $(".container").fadeIn();
      openHome();
    }
    if (item.close) {
      $(".container").fadeOut();
      closeNUI();
    }
    if (item.openBalance) {
      $(".balance-input").val("Balance: " + item.balance);
      setTimeout(function () {
        $(".back").css("display", "block");
        $(".home").css("display", "none");
        $(".deposit").css("display", "none");
        $(".withdraw").css("display", "none");
        $(".transfer").css("display", "none");
        $(".balance").fadeIn();
        $("#loadingscreen").css("display", "none");
      }, 1000);
    }
    if (item.notification) {
      Swal.fire(
        item.notification_title,
        item.notification_desc,
        item.notification_type
      )
    }
    if (item.showName) {
      $(".showName").html(`Welcome, ${item.firstname} ${item.lastname}`);
    }
  });
  document.onkeyup = function (data) {
    if (data.which == 27) {
      $.post('http://kasperr_bank/close', JSON.stringify({}));
    }
  };
});

function closeNUI() {
  $(".back").css("display", "none");
  $(".home").css("display", "none");
  $(".deposit").css("display", "none");
  $(".withdraw").css("display", "none");
  $(".balance").css("display", "none");
  $(".transfer").css("display", "none");
  $("#loadingscreen").css("display", "none");
  $.post('http://kasperr_bank/close', JSON.stringify({}));
}

function openHome() {
  $(".back").css("display", "none");
  $(".deposit").css("display", "none");
  $(".withdraw").css("display", "none");
  $(".balance").css("display", "none");
  $(".transfer").css("display", "none");
  $(".home").fadeIn();
  $("#loadingscreen").css("display", "none");
  $.post('http://kasperr_bank/showName', JSON.stringify({}));
}

function openDeposit() {
  $(".back").css("display", "block");
  $(".home").css("display", "none");
  $(".withdraw").css("display", "none");
  $(".balance").css("display", "none");
  $(".transfer").css("display", "none");
  $(".deposit").fadeIn();
  $("input").val("");
  $("#loadingscreen").css("display", "none");
}

function openWithdraw() {
  $(".back").css("display", "block");
  $(".home").css("display", "none");
  $(".deposit").css("display", "none");
  $(".balance").css("display", "none");
  $(".transfer").css("display", "none");
  $(".withdraw").fadeIn();
  $("input").val("");
  $("#loadingscreen").css("display", "none");
}

function openTransfer() {
  $(".back").css("display", "block");
  $(".home").css("display", "none");
  $(".deposit").css("display", "none");
  $(".balance").css("display", "none");
  $(".withdraw").css("display", "none");
  $(".transfer").fadeIn();
  $("input").val("");
  $("#loadingscreen").css("display", "none");
}

function openLoadingscreen() {
  $(".back").css("display", "none");
  $(".home").css("display", "none");
  $(".deposit").css("display", "none");
  $(".withdraw").css("display", "none");
  $(".balance").css("display", "none");
  $(".transfer").css("display", "none");
  $("#loadingscreen").css("display", "block");
}

function openBalance() {
  openLoadingscreen();
  $.post('http://kasperr_bank/openBalance', JSON.stringify({}));
}

function depositMoney(amount) {
  if (amount && amount > 0 && amount[0] != 0) {
    openLoadingscreen();
    $.post('http://kasperr_bank/depositMoney', JSON.stringify({
      amount: amount
    }));
  } else {
    Swal.fire(
      "invalid amount",
      "",
      "warning"
    )
  }
}

function withdrawMoney(amount) {
  if (amount && amount > 0 && amount[0] != 0) {
    openLoadingscreen();
    $.post('http://kasperr_bank/withdrawMoney', JSON.stringify({
      amount: amount
    }));
  } else {
    Swal.fire(
      "invalid amount",
      "",
      "warning"
    )
  }
}

function transferMoney(userid, amount) {
  if (userid && userid > 0 && userid[0] != 0 && amount && amount > 0 && amount[0] != 0) {
    openLoadingscreen();
    $.post('http://kasperr_bank/transferMoney', JSON.stringify({
      userid: userid,
      amount: amount
    }));
  } else {
    Swal.fire(
      "invalid amount",
      "",
      "warning"
    )
  }
}