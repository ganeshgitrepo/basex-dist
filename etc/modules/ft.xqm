(:~
 : This <a href="http://docs.basex.org/wiki/Module_Library">XQuery Module</a> extends the <a href="http://www.w3.org/TR/xpath-full-text-10">W3C Full Text Recommendation</a> with some useful functions: The index can be directly accessed, full-text results can be marked with additional elements, or the relevant parts can be extracted. Moreover, the score value, which is generated by the <code>contains text</code> expression, can be explicitly requested from items.
 : 
 : @author BaseX Team
 : @see http://docs.basex.org/wiki/Module_Library
 :)
module namespace ft = "http://basex.org/modules/ft";
declare namespace bxerr = "http://basex.org/errors";

(:~
 : Returns all text nodes from the full-text index of the database <code>$db</code> that contain the specified <code>$terms</code> .
 : The options used for building the full-text will also be applied to the search terms. As an example, if the index terms have been stemmed, the search string will be stemmed as well. <p>The <code>$options</code> argument can be used to overwrite the default full-text options, which can be either specified
 : </p>  <ul> <li> as children of an <code>&lt;options/&gt;</code> element, e.g.: </li> </ul>  <pre class="brush:xml"> &lt;options&gt; &lt;key1 value='value1'/&gt; ... &lt;/options&gt; </pre>  <ul> <li> as map, which contains all key/value pairs: </li> </ul>  <pre class="brush:xml"> map { "key1" := "value1", ... } </pre>  <p>The following keys are supported: </p>  <ul> <li> <code>mode</code>: determines the search mode (also called <a href="http://www.w3.org/TR/xpath-full-text-10/#ftwords">AnyAllOption</a>). Allowed values are <code>any</code>, <code>any word</code>, <code>all</code>, <code>all words</code>, and <code>phrase</code>. <code>any</code> is the default search mode. </li> <li> <code>fuzzy</code>: turns fuzzy querying on or off. Allowed values are an empty string or <code>true</code>, or <code>false</code>. By default, fuzzy querying is turned off. </li> <li> <code>wildcards</code>: turns wildcard querying on or off. Allowed values are an empty string or <code>true</code>, or <code>false</code>. By default, wildcard querying is turned off. </li> </ul> 
 :
 : @error bxerr:BXDB0002 The addressed database does not exist or could not be opened.
 : @error bxerr:BXDB0004 the full-text index is not available.
 : @error bxerr:BXFT0001 both fuzzy and wildcard querying was selected.
 :)
declare function ft:search($db as xs:string, $terms as item()*) as text()* external;

(:~
 : Returns all text nodes from the full-text index of the database <code>$db</code> that contain the specified <code>$terms</code> .
 : The options used for building the full-text will also be applied to the search terms. As an example, if the index terms have been stemmed, the search string will be stemmed as well. <p>The <code>$options</code> argument can be used to overwrite the default full-text options, which can be either specified
 : </p>  <ul> <li> as children of an <code>&lt;options/&gt;</code> element, e.g.: </li> </ul>  <pre class="brush:xml"> &lt;options&gt; &lt;key1 value='value1'/&gt; ... &lt;/options&gt; </pre>  <ul> <li> as map, which contains all key/value pairs: </li> </ul>  <pre class="brush:xml"> map { "key1" := "value1", ... } </pre>  <p>The following keys are supported: </p>  <ul> <li> <code>mode</code>: determines the search mode (also called <a href="http://www.w3.org/TR/xpath-full-text-10/#ftwords">AnyAllOption</a>). Allowed values are <code>any</code>, <code>any word</code>, <code>all</code>, <code>all words</code>, and <code>phrase</code>. <code>any</code> is the default search mode. </li> <li> <code>fuzzy</code>: turns fuzzy querying on or off. Allowed values are an empty string or <code>true</code>, or <code>false</code>. By default, fuzzy querying is turned off. </li> <li> <code>wildcards</code>: turns wildcard querying on or off. Allowed values are an empty string or <code>true</code>, or <code>false</code>. By default, wildcard querying is turned off. </li> </ul> 
 :
 : @error bxerr:BXDB0002 The addressed database does not exist or could not be opened.
 : @error bxerr:BXDB0004 the full-text index is not available.
 : @error bxerr:BXFT0001 both fuzzy and wildcard querying was selected.
 :)
declare function ft:search($db as xs:string, $terms as item()*, $options as item()) as text()* external;

(:~
 : Puts a marker element around the resulting <code>$nodes</code> of a full-text index request.
 : The default tag name of the marker element is <code>mark</code> . An alternative tag name can be chosen via the optional <code>$tag</code> argument.
 : Please note that: <ul> <li> the XML node to be transformed must be an internal "database" node. The <code>transform</code> expression can be used to apply the method to a main-memory fragment, as shown in Example 2. </li> <li> the full-text expression, which computes the token positions, must be specified within <code>ft:mark()</code> function, as all position information is lost in subsequent processing steps. You may need to specify more than one full-text expression if you want to use the function in a FLWOR expression, as shown in Example 3. </li> </ul> 
 :)
declare function ft:mark($nodes as node()*) as node()* external;

(:~
 : Puts a marker element around the resulting <code>$nodes</code> of a full-text index request.
 : The default tag name of the marker element is <code>mark</code> . An alternative tag name can be chosen via the optional <code>$tag</code> argument.
 : Please note that: <ul> <li> the XML node to be transformed must be an internal "database" node. The <code>transform</code> expression can be used to apply the method to a main-memory fragment, as shown in Example 2. </li> <li> the full-text expression, which computes the token positions, must be specified within <code>ft:mark()</code> function, as all position information is lost in subsequent processing steps. You may need to specify more than one full-text expression if you want to use the function in a FLWOR expression, as shown in Example 3. </li> </ul> 
 :)
declare function ft:mark($nodes as node()*, $tag as xs:string) as node()* external;

(:~
 : Extracts and returns relevant parts of full-text results. It puts a marker element around the resulting <code>$nodes</code> of a full-text index request and chops irrelevant sections of the result.
 : The default tag name of the marker element is <code>mark</code> . An alternative tag name can be chosen via the optional <code>$tag</code> argument.
 : The default length of the returned text is <code>150</code> characters. An alternative length can be specified via the optional <code>$length</code> argument. Note that the effective text length may differ from the specified text due to formatting and readibility issues.
 : For more details on this function, please have a look at <a href="#ft:mark">ft:mark</a> .
 :)
declare function ft:extract($nodes as node()*) as node()* external;

(:~
 : Extracts and returns relevant parts of full-text results. It puts a marker element around the resulting <code>$nodes</code> of a full-text index request and chops irrelevant sections of the result.
 : The default tag name of the marker element is <code>mark</code> . An alternative tag name can be chosen via the optional <code>$tag</code> argument.
 : The default length of the returned text is <code>150</code> characters. An alternative length can be specified via the optional <code>$length</code> argument. Note that the effective text length may differ from the specified text due to formatting and readibility issues.
 : For more details on this function, please have a look at <a href="#ft:mark">ft:mark</a> .
 :)
declare function ft:extract($nodes as node()*, $tag as xs:string) as node()* external;

(:~
 : Extracts and returns relevant parts of full-text results. It puts a marker element around the resulting <code>$nodes</code> of a full-text index request and chops irrelevant sections of the result.
 : The default tag name of the marker element is <code>mark</code> . An alternative tag name can be chosen via the optional <code>$tag</code> argument.
 : The default length of the returned text is <code>150</code> characters. An alternative length can be specified via the optional <code>$length</code> argument. Note that the effective text length may differ from the specified text due to formatting and readibility issues.
 : For more details on this function, please have a look at <a href="#ft:mark">ft:mark</a> .
 :)
declare function ft:extract($nodes as node()*, $tag as xs:string, $length as xs:integer) as node()* external;

(:~
 : Returns the number of occurrences of the search terms specified in a full-text expression.
 :)
declare function ft:count($nodes as node()*) as xs:integer external;

(:~
 : Returns the score values (0.0 - 1.0) that have been attached to the specified items. <code>0</code> is returned a value if no score was attached.
 :)
declare function ft:score($item as item()*) as xs:double* external;

(:~
 : Returns all full-text tokens stored in the index of the database <code>$db</code> , along with their numbers of occurrences.
 : If <code>$prefix</code> is specified, the returned nodes will be refined to the strings starting with that prefix. The prefix will be tokenized according to the full-text used for creating the index.
 :
 : @error bxerr:BXDB0002 The addressed database does not exist or could not be opened.
 : @error bxerr:BXDB0004 the full-text index is not available.
 :)
declare function ft:tokens($db as xs:string) as element(value)* external;

(:~
 : Returns all full-text tokens stored in the index of the database <code>$db</code> , along with their numbers of occurrences.
 : If <code>$prefix</code> is specified, the returned nodes will be refined to the strings starting with that prefix. The prefix will be tokenized according to the full-text used for creating the index.
 :
 : @error bxerr:BXDB0002 The addressed database does not exist or could not be opened.
 : @error bxerr:BXDB0004 the full-text index is not available.
 :)
declare function ft:tokens($db as xs:string, $prefix as xs:string) as element(value)* external;

(:~
 : Tokenizes the given <code>$input</code> string, using the current default full-text options.
 :)
declare function ft:tokenize($input as xs:string) as xs:string* external;



