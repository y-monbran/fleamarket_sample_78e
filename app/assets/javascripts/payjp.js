// console.log("aaa");

// document.addEventListener( // addEventListener() メソッドは、特定のイベントが対象に配信されるたびに呼び出される関数を設定します。
//   // console.log("aaa");

//   "DOMContentLoaded", (e) => {
//     Payjp.setPublicKey("pk_test_f9c4bb64158e5b8e9834ca5c"); // Payjpに特定の公開鍵をあるウェブサーバーに関連付けさせる
//     const btn = document.getElementById('token_submit'); //IDがtoken_submitの場合に取得されます
//     btn.addEventListener("click", (e) => { //ボタンが押されたときに作動します
//       e.preventDefault(); //ボタンを一旦無効化します
//       // console.log("aaa");

//       //カード情報生成
//       const card = {
//         number: document.getElementById("card_number").value,
//         cvc: document.getElementById("cvc").value,
//         exp_month: document.getElementById("exp_month").value,
//         exp_year: document.getElementById("exp_year").value
//       }; //入力されたデータを取得します。
//       // console.log(card);

//       //トークン生成
//       Payjp.createToken(card, (status, response) => {
//         if (status === 200) { //成功した場合
//           $("#card_number").removeAttr("name");
//           $("#cvc").removeAttr("name");
//           $("#exp_month").removeAttr("name");
//           $("#exp_year").removeAttr("name"); //カード情報を自分のサーバにpostせず削除します
//           $("#card_token").append(
//             $('<input hidden name="payjp-token">').val(response.id)
//           ); //トークンを送信できるように隠しタグを生成
//           document.inputForm.submit();
//           alert("登録が完了しました"); 
//         } else {
//           alert("カード情報が正しくありません。");
//         }
//       });
//     });
//   },false);

// document.addEventListener(
//   "DOMContentLoaded", e => {//DOM読み込みが完了したら実行
//     if (document.getElementById("token_submit") != null) { //token_submitというidがnullの場合、下記コードを実行しない
//       Payjp.setPublicKey("pk_test_31f3ec18c086406c969b76cb"); //ここに公開鍵を直書き
//       let btn = document.getElementById("token_submit"); //IDがtoken_submitの場合に取得
//       btn.addEventListener("click", e => { //ボタンが押されたときに作動
//         e.preventDefault(); //ボタンを一旦無効
//         let card = {//カード情報生成
//           number: document.getElementById("card_number").value,
//           cvc: document.getElementById("cvc").value,
//           exp_month: document.getElementById("exp_month").value,
//           exp_year: document.getElementById("exp_year").value
//         }; //入力されたデータを取得
//         Payjp.createToken(card, (status, response) => {//トークン生成
//           if (status === 200) { //成功した場合
//             $("#card_number").removeAttr("name");
//             $("#cvc").removeAttr("name");
//             $("#exp_month").removeAttr("name");
//             $("#exp_year").removeAttr("name"); //データを自サーバにpostしないように削除
//             $("#card_token").append(
//               $('<input type="hidden" name="payjp-token">').val(response.id)
//             ); //取得したトークンを送信できる状態
//             document.inputForm.submit();
//             alert("登録が完了しました"); 
//           } else {
//             alert("カード情報が正しくありません。"); 
//           }
//         });
//       });
//     }
//   },
//   false
// );

// console.log("aaa");
// // DOM読み込みが完了したら実行
// document.addEventListener('DOMContentLoaded', (e) => {
//   // payjp.jsの初期化
//   Payjp.setPublicKey('pk_test_f9c4bb64158e5b8e9834ca5c');
  
//   // ボタンのイベントハンドリング
//   const btn = document.getElementById('token');
//   btn.addEventListener('click', (e) => {
//     e.preventDefault();
//     console.log("bbb");
   
//     // カード情報生成
//     const card = {
//       number: document.getElementById('card_number').value,
//       cvc: document.getElementById('cvv').value,
//       exp_month: document.getElementById('exp_month').value,
//       exp_year: document.getElementById('exp_year').value
//     };
    
//     // トークン生成
//     Payjp.createToken(card, (status, response) => {
//       if (status === 200) {
//         // 出力（本来はサーバへ送信）
//         document.getElementById('card_token').innerHTML = response.card.id;
//         console.log("ccc");
//       }
//     });
//   });
// }, false);

// $(document).on('turbolinks:load', function() {
//   var form = $("#charge-form");
//   Payjp.setPublicKey('pk_test_f9c4bb64158e5b8e9834ca5c');
//   $(document).on("click", "#submit-button", function(e) {

//     e.preventDefault();
//     form.find("input[type=submit]").prop("disabled", true);

//     var card = {
//         number: $("#payment_card_no").val(),
//         cvc: $("#payment_card_cvc").val(),
//         exp_month: $("#payment_expiration_date_1i").val(),
//         exp_year: $("#payment_expiration_date_2i").val(),
//     };
//     Payjp.createToken(card, function(s, response) {
//       if (response.error) {
//         alert('トークン作成エラー発生');
//       }
//       else {
//         $(".number").removeAttr("name");
//         $(".cvc").removeAttr("name");
//         $(".exp_month").removeAttr("name");
//         $(".exp_year").removeAttr("name");
//         var token = response.id;

//         form.append($('<input type="hidden" name="payjpToken" />').val(token));
//         form.get(0).submit();
//       }
//     });
//   });
// });

// document.addEventListener(
//   "DOMContentLoaded", e => {//DOM読み込みが完了したら実行
//     if (document.getElementById("token_submit") != null) { //token_submitというidがnullの場合、下記コードを実行しない
//       Payjp.setPublicKey("pk_test_f9c4bb64158e5b8e9834ca5c"); //ここに公開鍵を直書き
//       let btn = document.getElementById("token_submit"); //IDがtoken_submitの場合に取得
//       btn.addEventListener("click", e => { //ボタンが押されたときに作動
//         e.preventDefault(); //ボタンを一旦無効
//         let card = {//カード情報生成
//           number: document.getElementById("card_number").value,
//           cvc: document.getElementById("cvc").value,
//           exp_month: document.getElementById("exp_month").value,
//           exp_year: document.getElementById("exp_year").value
//         }; //入力されたデータを取得
//         Payjp.createToken(card, (status, response) => {//トークン生成
//           if (status === 200) { //成功した場合
//             $("#card_number").removeAttr("name");
//             $("#cvc").removeAttr("name");
//             $("#exp_month").removeAttr("name");
//             $("#exp_year").removeAttr("name"); //データを自サーバにpostしないように削除
//             $("#card_token").append(
//               $('<input type="hidden" name="payjp-token">').val(response.id)
//             ); //取得したトークンを送信できる状態
//             document.inputForm.submit();
//             alert("登録が完了しました"); 
//           } else {
//             alert("カード情報が正しくありません。"); 
//           }
//         });
//       });
//     }
//   },
//   false
// );

window.addEventListener('DOMContentLoaded', function(){

  //id名が"payment_card_submit-button"というボタンが押されたら取得
  let submit = document.getElementById("payment_card_submit-button");
  // console.log('aaa');

  Payjp.setPublicKey('pk_test_f9c4bb64158e5b8e9834ca5c'); //公開鍵の記述(ご自身の公開鍵コードを記述しよう！)
    // console.log('bbb');

    submit.addEventListener('click', function(e){ //ボタンが押されたらトークン作成開始。
      // console.log('ccc');

    e.preventDefault(); //ボタンを1度無効化

    let card = { //入力されたカード情報を取得(id名の記載ミスに注意！)
        number: document.getElementById("payment_card_no").value,
        cvc: document.getElementById("payment_card_cvc").value,
        exp_month: document.getElementById("payment_card_month").value,
        exp_year: document.getElementById("payment_card_year").value
    };

    Payjp.createToken(card, function(status, response) {  // トークンを生成
      if (status === 200) { //成功した場合(status === 200はリクエストが成功している状況です。)
        //データを自サーバにpostしないようにremoveAttr("name")で削除
        $(".number").removeAttr("name");
        $(".cvc").removeAttr("name");
        $(".exp_month").removeAttr("name");
        $(".exp_year").removeAttr("name"); 
        $("#charge-form").append(
          $('<input type="hidden" name="payjp_token">').val(response.id)
          // console.log('ddd');
        ); //取得したトークンを送信できる状態にします
        document.inputForm.submit();
        alert("登録が完了しました"); //正常処理完了確認用。createビューがあればつけなくてもOKかな
      } else {
        alert("カード情報が正しくありません。"); //エラー確認用
      }
    });
  });
});