

Class constructor
	
	
	
Function decode
	C_VARIANT:C1683($0)
	C_VARIANT:C1683($1)
	C_OBJECT:C1216($2)
	Case of 
		: (Value type:C1509($1)=Is object:K8:27)
			$0:=This:C1470.decodeObject($1;$2)
		: (Value type:C1509($1)=Is collection:K8:32)
			$0:=This:C1470.decodeCollection($1;$2)
		Else 
			$0:=$1
	End case 
	
Function decodeObject
	C_OBJECT:C1216($0)
	C_OBJECT:C1216($1;$value)
	C_OBJECT:C1216($2;$class)
	$value:=$1
	$class:=$2
	
	$0:=$class.new()
	C_TEXT:C284($key)
	
	$coding:=$class.coding
	If ($coding=Null:C1517)
		For each ($key;$value)
			$subValue:=$value[$key]
			$0[$key]:=$subValue
		End for each 
	Else 
		For each ($key;$value)
			$subValue:=$value[$key]
			
			If ($coding[$key]=Null:C1517)
				$0[$key]:=$subValue
			Else 
				$0[$key]:=This:C1470.decode($subValue;cs:C1710[$coding[$key]])
			End if 
			
		End for each 
	End if 
	
Function decodeCollection
	C_COLLECTION:C1488($0)
	C_COLLECTION:C1488($1;$value)
	C_OBJECT:C1216($2;$class)
	$value:=$1
	$class:=$2
	
	$0:=New collection:C1472()
	C_VARIANT:C1683($var)
	For each ($var;$value)
		$result:=This:C1470.decode($var;$class)
		$0.push($result)
	End for each 
	