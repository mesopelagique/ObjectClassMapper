//%attributes = {}

Use (cs:C1710.Breakpoint)
	cs:C1710.Breakpoint.coding:=New shared object:C1526("method";cs:C1710.Method.name)  // cs.Method could not be stored
End use 

C_VARIANT:C1683($result;$json)
C_TEXT:C284($jsonString)


C_OBJECT:C1216($decoder)
$decoder:=cs:C1710.JSONDecoder.new()

  // Simple obj
$jsonString:="{\"line\":2,\"method\":{\"type\":1,\"methodName\":\"folder_unboxing\"}}"
$json:=JSON Parse:C1218($jsonString)

$result:=$decoder.decode($json;cs:C1710.Breakpoint)

ASSERT:C1129(Value type:C1509($result)=Is object:K8:27)
ASSERT:C1129(OB Class:C1730($result).name="Breakpoint")

  // array
$jsonString:="[{\"line\":2,\"method\":{\"type\":1,\"methodName\":\"folder_unboxing\"}},{\"line\":21,\"method\":{\"type\":1,\"methodName\":\"test_breakpoint\"}}]"
$json:=JSON Parse:C1218($jsonString)

$result:=$decoder.decode($json;cs:C1710.Breakpoint)

ASSERT:C1129(Value type:C1509($result)=Is collection:K8:32)
ASSERT:C1129($result.length=2)
ASSERT:C1129(OB Class:C1730($result[0]).name="Breakpoint")