//%attributes = {}
C_VARIANT:C1683($result;$json;$jsonArray;$jsonObjectWithArray)
C_TEXT:C284($jsonString;$jsonArrayString;$jsonObjectWithArrayString)

$jsonString:="{\"line\":2,\"method\":{\"type\":1,\"methodName\":\"folder_unboxing\"}}"
$json:=JSON Parse:C1218($jsonString)

$jsonArrayString:="[{\"line\":2,\"method\":{\"type\":1,\"methodName\":\"folder_unboxing\"}},{\"line\":21,\"method\":{\"type\":1,\"methodName\":\"test_breakpoint\"}}]"
$jsonArray:=JSON Parse:C1218($jsonArrayString)

$jsonObjectWithArrayString:="{\"line\":2,\"method\":[{\"type\":1,\"methodName\":\"folder_unboxing\"}]}"
$jsonObjectWithArray:=JSON Parse:C1218($jsonObjectWithArrayString)

  // create a mapper
C_OBJECT:C1216($mapper)
  // $mapper:=cs.ObjectClassMapper.new()
$mapper:=ObjectClassMapper ()

  // // // // // // //
  // Without classMapping
  // // // // // // //

Use (cs:C1710.Breakpoint)
	cs:C1710.Breakpoint.classMapping:=Null:C1517
End use 

  // Simple obj
$result:=$mapper.map($json;cs:C1710.Breakpoint)

ASSERT:C1129(Value type:C1509($result)=Is object:K8:27)
ASSERT:C1129(OB Class:C1730($result).name="Breakpoint")

ASSERT:C1129(OB Class:C1730($result.method).name="Object")

  // array
$result:=$mapper.map($jsonArray;cs:C1710.Breakpoint)

ASSERT:C1129(Value type:C1509($result)=Is collection:K8:32)
ASSERT:C1129($result.length=2)
ASSERT:C1129(OB Class:C1730($result[0]).name="Breakpoint")

  // object with one array
$result:=$mapper.map($jsonObjectWithArray;cs:C1710.Breakpoint)

ASSERT:C1129(Value type:C1509($result)=Is object:K8:27)
ASSERT:C1129(OB Class:C1730($result).name="Breakpoint")

ASSERT:C1129(Value type:C1509($result.method)=Is collection:K8:32)

ASSERT:C1129(OB Class:C1730($result.method[0]).name="Object")

  // // // // // // //
  // With class mapping
  // // // // // // //

Use (cs:C1710.Breakpoint)
	cs:C1710.Breakpoint.classMapping:=New shared object:C1526("method";cs:C1710.Method.name)  // cs.Method could not be stored
End use 

  // Simple obj
$result:=$mapper.map($json;cs:C1710.Breakpoint)

ASSERT:C1129(Value type:C1509($result)=Is object:K8:27)
ASSERT:C1129(OB Class:C1730($result).name="Breakpoint")

ASSERT:C1129(OB Class:C1730($result.method).name="Method")

  // array
$result:=$mapper.map($jsonArray;cs:C1710.Breakpoint)

ASSERT:C1129(Value type:C1509($result)=Is collection:K8:32)
ASSERT:C1129($result.length=2)
ASSERT:C1129(OB Class:C1730($result[0]).name="Breakpoint")

  // object with one array
$result:=$mapper.map($jsonObjectWithArray;cs:C1710.Breakpoint)

ASSERT:C1129(Value type:C1509($result)=Is object:K8:27)
ASSERT:C1129(OB Class:C1730($result).name="Breakpoint")

ASSERT:C1129(Value type:C1509($result.method)=Is collection:K8:32)

ASSERT:C1129(OB Class:C1730($result.method[0]).name="Method")

