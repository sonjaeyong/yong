function commonAjax(url, resultVarName, data){
    return $.ajax({
        url: url,
        type: 'post',
        dataType: 'json',
        data : data? data: {},
        success: function(result){
            resultMap.set(resultVarName,result);
        },error:function(request,status,error){
            console.log("code:"+request.status+", "+"message:"+request.responseText+", "+"error:"+error);
        }
    });
}