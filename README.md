# JSONDecoder

[![language][code-shield]][code-url]
[![language-top][code-top]][code-url]
![code-size][code-size]
[![release][release-shield]][release-url]
[![license][license-shield]][license-url]

Utility class to decode objects or collections into classes

## Creating the decoder

```4d
$decoder:=JSONDecoder()
```

## Decoding a simple object

### Getting object from JSON

Here our is JSON definition

```
	{
		"line": 2,
		"method": {
			"type": 1,
			"methodName": "folder_unboxing"
		}
	}
```

We could parse this JSON to `C_OBJECT`

```4d
$json:=JSON Parse($jsonString)
```

Then decode it passing the destination class

```4d
C_OBJECT(breakpointInstance)
$breakpointInstance:=$decoder.decode($json;cs.Breakpoint)
```

We have a new instance of `cs.Breakpoint`

### Getting a collection of objects from JSON Array

```javascript
[
	{
		"line": 2,
		"method": {
			"type": 1,
			"methodName": "folder_unboxing"
		}
	},
	{
		"line": 21,
		"method": {
			"type": 1,
			"methodName": "test_breakpoint"
		}
	}
]
```

We could parse this JSON to `C_COLLECTION`

```4d
$json:=JSON Parse($jsonString)
```
 and decode to a collection of passed class
```4d
C_COLLECTION(breapoints)
$breapoints:=$decoder.decode($json;cs.Breakpoint)
```

### Decoding a subclass

First we need to defined the class mapping.

Here we want to decode key `method` as `cs.Method` instance.

```4d
Use (cs.Breakpoint)
	cs.Breakpoint.coding:=New shared object("method";cs.Method.name)
End use
```
Then as usual we decode

```4d
$breakpointInstance:=$decoder.decode($json;cs.Breakpoint)
```

`breakpointInstance.method` will be a `cs.Method` instance

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[code-shield]: https://img.shields.io/static/v1?label=language&message=4d&color=blue
[code-top]: https://img.shields.io/github/languages/top/mesopelagique/JSONDecoder.svg
[code-size]: https://img.shields.io/github/languages/code-size/mesopelagique/JSONDecoder.svg
[code-url]: https://developer.4d.com/
[release-shield]: https://img.shields.io/github/v/release/mesopelagique/JSONDecoder
[release-url]: https://github.com/mesopelagique/JSONDecodere/releases/latest
[license-shield]: https://img.shields.io/github/license/mesopelagique/JSONDecoder
[license-url]: LICENSE
