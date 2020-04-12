Class constructor
	C_OBJECT:C1216($1)
	If ($1=Null:C1517)
		This:C1470.cs:=cs:C1710
	Else 
		This:C1470.cs:=$1  // XXX check is class store?
	End if 
	
Function map // (/*object, class*/)
	C_VARIANT:C1683($0)
	C_VARIANT:C1683($1)
	C_OBJECT:C1216($2)
	Case of 
		: ($2=Null:C1517)
			$0:=$1
		: (Value type:C1509($1)=Is object:K8:27)
			$0:=This:C1470.mapObject($1;$2)
		: (Value type:C1509($1)=Is collection:K8:32)
			$0:=This:C1470.mapCollection($1;$2)
		Else 
			$0:=$1
	End case 
	
Function mapObject
	C_OBJECT:C1216($0)
	C_OBJECT:C1216($1;$value)
	C_OBJECT:C1216($2;$class)
	$value:=$1
	$class:=$2
	
	$0:=$class.new()
	C_TEXT:C284($key)
	
	If ($class.classMapping=Null:C1517)
		For each ($key;$value)
			$0[$key]:=$value[$key]
		End for each 
	Else 
		For each ($key;$value)
			
			If ($class.classMapping[$key]=Null:C1517)
				$0[$key]:=$value[$key]
			Else 
				$0[$key]:=This:C1470.map($value[$key];This:C1470.cs[$class.classMapping[$key]])  // Decode class from name, because Class could not be added to another
			End if 
			
		End for each 
	End if 
	
Function mapCollection
	C_COLLECTION:C1488($0)
	C_COLLECTION:C1488($1;$value)
	C_OBJECT:C1216($2;$class)
	$value:=$1
	$class:=$2
	
	$0:=New collection:C1472()
	C_VARIANT:C1683($var)
	For each ($var;$value)
		$0.push(This:C1470.map($var;$class))
	End for each 
	
Function mapFile
	C_VARIANT:C1683($0)
	C_OBJECT:C1216($1)
	$0:=This:C1470.mapJSONString($1.getText())
	
Function mapJSONString
	C_VARIANT:C1683($0)
	C_TEXT:C284($1)
	$0:=This:C1470.map(JSON Parse:C1218($1))
	
