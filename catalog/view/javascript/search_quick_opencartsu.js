$(document).ready(function() {

if ($.ui.version != '1.11.4') {
$('head').append( $('<script></script>').attr('src', 'catalog/view/javascript/jquery/ui/jquery-ui-1.11.4.min.js') );
}

    		var baseurl = $('base').attr('href');


    $("#search input, #input-search").autocomplete({


		//Определяем обратный вызов к результатам форматирования
			source: function(req, add){

            if ($('select[name=category_id]').length > 0) { var category_id =  $('select[name=category_id]').val(); }
            else if ($('#selected_category').length > 0) {  var category_id =  $("#selected_category").val(); }
            else { var category_id = 0; }


            if(typeof req == "object") { var searchstring = req.term; }
            else { var searchstring = req; }

            				//Передаём запрос на сервер
				$.getJSON(baseurl+"index.php?route=module/search_quick_opencartsu&category_id="+category_id+"&search_query="+searchstring, function(data) {

					//Создаем массив для объектов ответа
					var suggestions = [];

					//Обрабатываем ответ
                    if(data) {
					$.each(data, function(i, val){
						suggestions.push({label:val.name,href:baseurl+val.href,img:val.img,price:val.price,quantity:val.quantity});
					});
                    }

					//Передаем массив обратному вызову
					add(suggestions);
				});
			},
        select: function(e, ui) {
         if(typeof ui == "object") {  location.replace(ui.item.href); }
         else if(typeof e == "object") { location.replace(e.href); }
         else { return false; }
        }
    }).focus(function(){
          $(this).autocomplete("search");
    }).each(function() {
          $(this).data('ui-autocomplete')._renderItem = function (ul, item) {
            return $( "<li>" )
            .append( "<a href='"+item.href+"'>" + item.img + " " + item.label + "</a>"+ item.price + item.quantity)
            .appendTo( ul );
            }
    });



});