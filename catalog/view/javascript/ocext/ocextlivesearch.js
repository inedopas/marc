$(function(){
        var ocextSearchAjaxResults = (!!$("#ocextlivesearch").length ? $("#ocextlivesearch") : $("<div onclick='updateStatistic();' id='ocextlivesearch'><ul id='ocextlivesearch_products' ><li></li></ul><ul id='ocextlivesearch_categories' ></ul><ul id='ocextlivesearch_manufacturers' ></ul></div>") );
        var ocextSearchKeywords = $("#search [name=search]");
        function repositionLivesearch() { ocextSearchAjaxResults.css({ top: (ocextSearchKeywords.offset().top+ocextSearchKeywords.outerHeight()), left:ocextSearchKeywords.offset().left, width: ocextSearchKeywords.outerWidth() }); }
	$(window).resize(function(){ repositionLivesearch(); });
	ocextSearchKeywords.keyup(function(e){
		switch (e.keyCode) {
			case 13:
				$(".active", ocextSearchAjaxResults).length && (window.location = $(".active a", ocextSearchAjaxResults).attr("href"));
				return false;
			break;
			case 40:
				($(".active", ocextSearchAjaxResults).length ? $(".active", ocextSearchAjaxResults).removeClass("active").next().addClass("active") : $("li:first", ocextSearchAjaxResults).addClass("active"))
				return false;
			break;
			case 38:
				($(".active", ocextSearchAjaxResults).length ? $(".active", ocextSearchAjaxResults).removeClass("active").prev().addClass("active") : $("li:last", ocextSearchAjaxResults).addClass("active"))
				return false;
			break;
			default:
				var query = ocextSearchKeywords.val();
                                var ocextSearchAjaxResultsProducts = $('#ocextlivesearch_products');
                                var ocextSearchAjaxResultsCategories = $('#ocextlivesearch_categories');
                                var ocextSearchAjaxResultsManufacturers = $('#ocextlivesearch_manufacturers');
                                
				if (query.length > 2) {
                                        
					$.getJSON(
                                                "index.php?route=module/ocext_smart_search&query=" + query,
						function(data) {
                                                    ocextSearchAjaxResultsProducts.empty();
                                                    ocextSearchAjaxResultsCategories.empty();
                                                    ocextSearchAjaxResultsManufacturers.empty();
                                                    $("#ocextlivesearch .title-box").remove();
                                                    if(data.no_results.no_results_status > 0){
                                                        $.each(data.products, function( k, v ) {
                                                            ocextSearchAjaxResultsProducts.append("<li><a href='"+v.href+"' "+v.class+"><img src='"+v.img+"' alt='"+v.name+"'><span>"+v.name+(v.category_path ? "<small>"+v.category_path+"</small>" : '')+"</span><em>"+(v.price ? v.price : '')+"</em></a></li>")
                                                        });
                                                    }else{
                                                        if(data.total_products>0){
                                                            $.each(data.products, function( k, v ) {
                                                                ocextSearchAjaxResultsProducts.append("<li><a href='"+v.href+"' "+v.class+"><img src='"+v.img+"' alt='"+v.name+"'><span>"+v.name+(v.category_path ? "<small>"+v.category_path+"</small>" : '')+"</span><em>"+(v.price ? v.price : '')+"</em></a></li>")
                                                            });
                                                            ocextSearchAjaxResultsProducts.before(data.products_title);
                                                        }
                                                        if(data.total_manufacturers>0){
                                                            $.each(data.manufacturers, function( k, v ) {
                                                                ocextSearchAjaxResultsManufacturers.append("<li><a href='"+v.href+"' "+v.class+"><span>"+v.name+((v.products!='') ? " ("+v.products+")" : '')+"</span></li>");
                                                            });
                                                            ocextSearchAjaxResultsManufacturers.before(data.manufacturers_title);
                                                        }
                                                        if(data.total_categories>0){
                                                            $.each(data.categories, function( k, v ) {
                                                                ocextSearchAjaxResultsCategories.append("<li><a href='"+v.href+"' "+v.class+"><span>"+v.name+((v.products!='') ? " ("+v.products+")" : '')+"</span></li>");
                                                            });
                                                            ocextSearchAjaxResultsCategories.before(data.categories_title);
                                                        }
                                                    }
                                                    
                                                    $("body").prepend(ocextSearchAjaxResults);
                                                    
                                                    repositionLivesearch();
						}
					);
				} else {
					ocextSearchAjaxResultsProducts.empty();
                                        ocextSearchAjaxResultsCategories.empty();
                                        ocextSearchAjaxResultsManufacturers.empty();
                                        $("#ocextlivesearch .title-box").remove();
				}
		}
	}).blur(function(){ setTimeout(function(){ ocextSearchAjaxResults.hide(); },500); }).focus(function(){ repositionLivesearch(); ocextSearchAjaxResults.show(); });   
});

function updateStatistic(){
    var ocextSearchKeywords = $("#search [name=search]");
    var query = ocextSearchKeywords.val();
    $.ajax({
            url: "index.php?route=module/ocext_smart_search&us=1&query=" + query,
            type: 'get',
            beforeSend: function() {
                    
            },
            complete: function() {
                    
            },
            success: function(response) {
                
            }
    });
}