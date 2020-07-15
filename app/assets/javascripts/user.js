$(function(){
  let password = '#password';
  let passcheck = '#js-passcheck';
  $(passcheck).change(function(){
    const passwordLabel = document.querySelector('.js-password-label');
    if ($(this).prop('checked')){
      $(password).attr('type','text');
      passwordLabel.innerHTML = '<i class="fas fa-eye" style="font-size:20px;color:#808080"></i>';
    } else {
      $(password).attr('type','password');
      passwordLabel.innerHTML = '<i class="fas fa-eye-slash" style="font-size:20px;color:#808080"></i>';
    }
  })
})

$(function(){
  let password = '#password2';
  let passcheck = '#js-passcheck2';
  $(passcheck).change(function(){
    const passwordLabel = document.querySelector('.js-password-label2');
    if ($(this).prop('checked')){
      $(password).attr('type','text');
      passwordLabel.innerHTML = '<i class="fas fa-eye" style="font-size:20px;color:#808080"></i>';
    } else {
      $(password).attr('type','password');
      passwordLabel.innerHTML = '<i class="fas fa-eye-slash" style="font-size:20px;color:#808080"></i>';
    }
  })
})