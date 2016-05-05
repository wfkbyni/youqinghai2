$(function (){

	//$.ajax({
	//				url:"192.168.3.19:8080/swimQinghai/app/travelsDynamic/getTravelsList",
	  //     			type:"post",
	   //    			dataType: "json",
	    //   			data: {},
	     //  			success:function(data){
	      // 				alert("");
	       	//		},
	       	//		error:function(a,b){
	       	//			alert("网络错误,请稍后再试....");
	       	//		}
			//	});

	
	
	
	  $.getJSON("http://192.168.3.19:8080/swimQinghai/app/travelsDynamic/getTravelsList?callback=?",
				function(data){
               console.log(data);
        });
	
	
	
});




$.getJSON("http://192.168.3.19:8080/swimQinghai/app/travelsDynamic/getTravelsList?callback=?",
				function(data){
              		
					 var result = '';
                    for(var i = 0; i < data.lists.length; i++){
                        result +=   '<a class="item opacity" href="'+data.lists[i].link+'">'
                                        +'<img src="'+data.lists[i].pic+'" alt="">'
                                        +'<h3>'+data.lists[i].title+'</h3>'
                                        +'<span class="date">'+data.lists[i].date+'</span>'
                                    +'</a>';
                    }
                    // 为了测试，延迟1秒加载
                    setTimeout(function(){
                        $('.zx-travels').append(result);
                        // 每次数据加载完，必须重置
                        dropload.resetload();
                    },1000);
					
					
        		});	