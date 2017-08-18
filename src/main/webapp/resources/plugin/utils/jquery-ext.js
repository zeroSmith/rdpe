var jQueryExt={};
/**
 * JQUERY的序列化方法扩展，保留空格
 * */
jQueryExt.serialize = function(_form){
	return jQueryExt.param(_form.serializeArray());
};
jQueryExt.param = function( a, traditional ) {
	var s = [];
	
	// Set traditional to true for jQuery <= 1.3.2 behavior.
	if ( traditional === undefined ) {
		traditional = jQuery.ajaxSettings.traditional;
	}
	
	// If an array was passed in, assume that it is an array of form elements.
	if ( jQuery.isArray(a) || a.jquery ) {
		// Serialize the form elements
		jQuery.each( a, function() {			
			add( this.name, this.value );
		});
		
	} else {
		// If traditional, encode the "old" way (the way 1.3.2 or older
		// did it), otherwise encode params recursively.
		for ( var prefix in a ) {
			buildParams( prefix, a[prefix] );
		}
	}

	// Return the resulting serialization
	//return s.join("&");
	//@2016@ 代表  &    update by jxw
   
	return s.join("@2016@");
	function buildParams( prefix, obj ) {
		if ( jQuery.isArray(obj) ) {
			// Serialize array item.
			jQuery.each( obj, function( i, v ) {
				if ( traditional || /\[\]$/.test( prefix ) ) {
					// Treat each array item as a scalar.
					add( prefix, v );
				} else {
					// If array item is non-scalar (array or object), encode its
					// numeric index to resolve deserialization ambiguity issues.
					// Note that rack (as of 1.0.0) can't currently deserialize
					// nested arrays properly, and attempting to do so may cause
					// a server error. Possible fixes are to modify rack's
					// deserialization algorithm or to provide an option or flag
					// to force array serialization to be shallow.
					buildParams( prefix + "[" + ( typeof v === "object" || jQuery.isArray(v) ? i : "" ) + "]", v );
				}
			});
				
		} else if ( !traditional && obj != null && typeof obj === "object" ) {
			// Serialize object item.
			jQuery.each( obj, function( k, v ) {
				buildParams( prefix + "[" + k + "]", v );
			});
				
		} else {
			// Serialize scalar item.
			add( prefix, obj );
		}
	}

	function add( key, value ) {
		// If value is a function, invoke it and return its value
		value = jQuery.isFunction(value) ? value() : value;		
		//s[ s.length ] = encodeURIComponent(key) + "=" + encodeURIComponent(value); 
		//   @2017@  代表     =     update by jxw
		s[ s.length ] = encodeURIComponent(key) + "@2017@" + encodeURIComponent(value);
	}
};
jQueryExt.par2Json = function(string){
	var newString = string.replace(/\n/g,"\\n");
	var obj = "{", 
	//pairs = newString.split('&');
	pairs = newString.split('@2016@');
	$jQuery.each(pairs, function(i,pair) { 
		//pair = pair.split('='); 
		pair = pair.split('@2017@'); 
		obj += "\""+pair[0]+"\":";
		obj += "\""+pair[1]+"\",";
	}); 
	obj = obj.substring(0,obj.length -1);
	obj += "}";
	return obj; 
};

jQueryExt.formSpecialCharValidate = function(formId)  
{    
var form = document.getElementById(formId);
    //记录不含引号的文本框数量    
var resultTag = 0;    
    //记录所有text文本框数量    
    var flag = 0;    
 for(var i = 0; i < form.elements.length; i ++)    
 {   	 
  if(form.elements[i].type=="text"||form.elements[i].type=="textarea")    
  {    
            flag = flag + 1;       
   //if(/^[^####]*$/.test(form.elements[i].value))     
  //要过滤的特殊符号  
   //var tt = /^[^\|"'<>^+-_\$?\{\}\#\&\:]*$/;
   var tt =/^(?!.*?[\'\^\#\$%\&\|\:\[\]\{\}\=\"\>\<?\\]).*$/;
   if(tt.test(form.elements[i].value))   
                resultTag = resultTag+1;   
   else   
    form.elements[i].select();   
  }  
 }   
  
    /**   
     * 如果含引号的文本框等于全部文本框的值，则校验通过   
     */   
 if(resultTag == flag)   
  return true;   
 else   
 {   	 
  return false;    
 }    
};
jQueryExt.SpecialCharWarning = function(){
	var msg = "文本框中不能含有以下符号\n" +
		"' \n" +
		"^ \n" +
  		"\" \n" +
  		"| \n" +
  		"< > \n" +
  		"{ } \n" +
  		"[ ] \n" +
  		"? \n" +
  		"$ \n" +  		
  		"# \n"+
  		"= \n"+
  		"% \n"+
  		": \n"+
  		"& \n"+  
  		"\\ \n"+  
  		"请检查输入！";
	return msg;
};