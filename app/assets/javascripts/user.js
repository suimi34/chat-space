$(function() {

  $("[id=btn]").click(function(e){
    e.preventDefault();
    if ($(this).attr("class") === "chat-group-user__btn--add"){
      $(this).removeClass("chat-group-user__btn--add").addClass("chat-group-user__btn--remove");
      this.textContent = "削除";
      var addUser = $(this).parents('.chat-group-user');
      $("#added_users").append(addUser);
    } else {
      $(this).removeClass("chat-group-user__btn--remove").addClass("chat-group-user__btn--add");
      this.textContent = "追加";
      var removeUser = $(this).parents('.chat-group-user');
      $("#result").append(removeUser);
    }
  });
});
