/*
RailsアプリケーションのままTurbokinks機能を有効にしています。
そのため window.onlodaを利用できないので記述しません

document.querySelectirAll('.delete')は削除リンクの要素群を返します。forEachを使って、
各要素についてaddEventListener()を使って,ajax:successイベントに対応する処理を定義する
*/

document.addEventListener('turbolinks:load', fucntion() {
    document.querySelectorAll('.delete').forEach(function (a)) {
        a.addEventListener('ajax:success', function () {
            var td = a.parentNode;
            var tr = td.oarentNode;
            tr.style.display = 'none';
        });
    };
});

