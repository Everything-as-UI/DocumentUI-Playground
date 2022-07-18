//
//  Created by Denis Koryttsev on 24.06.2022.
//

import Foundation

enum HTML {}

extension HTML {
    enum Tag: String {
        case a
        case abbr
        case address
        case article
        case aside
        case audio
        case b
        case bb
        case bdo
        case blockquote
        case body
        case button
        case canvas
        case caption
        case cite
        case code
        case colgroup
        case datagrid
        case datalist
        case dd
        case del
        case detail
        case dfn
        case dialog
        case div
        case dl
        case em
        case fieldset
        case figure
        case footer
        case form
        case h1
        case h2
        case h3
        case h4
        case h5
        case h6
        case head
        case header
        case html
        case i
        case iframe
        case ins
        case kbd
        case label
        case legend
        case li
        case map
        case mark
        case menu
        case meter
        case nav
        case noscript
        case object
        case ol
        case optgroup
        case option
        case output
        case p
        case pre
        case progress
        case q
        case rp
        case rt
        case ruby
        case samp
        case script
        case section
        case select
        case small
        case span
        case strong
        case style
        case sub
        case sup
        case table
        case tbody
        case td
        case textarea
        case tfoot
        case th
        case thead
        case time
        case title
        case tr
        case ul
        case `var`
        case video

        case area
        case base
        case br
        case col
        case command
        case dt
        case embed
        case hr
        case img
        case input
        case link
        case meta
        case param
        case source
    }
}

extension HTML {
    enum Attribute: String {
        case accept  //  <input>    Specifies the types of files that the server accepts (only for type="file")
        case accept_c = "accept_c"//harset    <form>    Specifies the character encodings that are to be used for the form submission
        case accesskey  //  Global Attributes    Specifies a shortcut key to activate/focus an element
        case action  //  <form>    Specifies where to send the form-data when a form is submitted
        case align  //  Not supported in HTML 5.    Specifies the alignment according to surrounding elements. Use CSS instead
        case alt  //  <area>, <img>, <input>    Specifies an alternate text when the original element fails to display
        case async  //  <script>    Specifies that the script is executed asynchronously (only for external scripts)
        case autocomplete  //  <form>, <input>    Specifies whether the <form> or the <input> element should have autocomplete enabled
        case autofocus  //  <button>, <input>, <select>, <textarea>    Specifies that the element should automatically get focus when the page loads
        case autoplay  //  <audio>, <video>    Specifies that the audio/video will start playing as soon as it is ready
        case bgcolor  //  Not supported in HTML 5.    Specifies the background color of an element. Use CSS instead
        case border  //  Not supported in HTML 5.    Specifies the width of the border of an element. Use CSS instead
        case charset  //  <meta>, <script>    Specifies the character encoding
        case checked  //  <input>    Specifies that an <input> element should be pre-selected when the page loads (for type="checkbox" or type="radio")
        case cite  //  <blockquote>, <del>, <ins>, <q>    Specifies a URL which explains the quote/deleted/inserted text
        case `class`  //  Global Attributes    Specifies one or more classnames for an element (refers to a class in a style sheet)
        case color  //  Not supported in HTML 5.    Specifies the text color of an element. Use CSS instead
        case cols  //  <textarea>    Specifies the visible width of a text area
        case colspan  //  <td>, <th>    Specifies the number of columns a table cell should span
        case content  //  <meta>    Gives the value associated with the http-equiv or name attribute
        case contenteditable  //  Global Attributes    Specifies whether the content of an element is editable or not
        case controls  //  <audio>, <video>    Specifies that audio/video controls should be displayed (such as a play/pause button etc)
        case coords  //  <area>    Specifies the coordinates of the area
        case data  //  <object>    Specifies the URL of the resource to be used by the object
        case data_star = "data-*"//    Global Attributes    Used to store custom data private to the page or application
        case datetime  //  <del>, <ins>, <time>    Specifies the date and time
        case `default`  //  <track>    Specifies that the track is to be enabled if the user's preferences do not indicate that another track would be more appropriate
        case `defer`  //  <script>    Specifies that the script is executed when the page has finished parsing (only for external scripts)
        case dir  //  Global Attributes    Specifies the text direction for the content in an element
        case dirname  //  <input>, <textarea>    Specifies that the text direction will be submitted
        case disabled  //  <button>, <fieldset>, <input>, <optgroup>, <option>, <select>, <textarea>    Specifies that the specified element/group of elements should be disabled
        case download  //  <a>, <area>    Specifies that the target will be downloaded when a user clicks on the hyperlink
        case draggable  //  Global Attributes    Specifies whether an element is draggable or not
        case enctype  //  <form>    Specifies how the form-data should be encoded when submitting it to the server (only for method="post")
        case `for`  //  <label>, <output>    Specifies which form element(s) a label/calculation is bound to
        case form  //  <button>, <fieldset>, <input>, <label>, <meter>, <object>, <output>, <select>, <textarea>    Specifies the name of the form the element belongs to
        case formaction  //  <button>, <input>    Specifies where to send the form-data when a form is submitted. Only for type="submit"
        case headers  //  <td>, <th>    Specifies one or more headers cells a cell is related to
        case height  //  <canvas>, <embed>, <iframe>, <img>, <input>, <object>, <video>    Specifies the height of the element
        case hidden  //  Global Attributes    Specifies that an element is not yet, or is no longer, relevant
        case high  //  <meter>    Specifies the range that is considered to be a high value
        case href  //  <a>, <area>, <base>, <link>    Specifies the URL of the page the link goes to
        case hreflang  //  <a>, <area>, <link>    Specifies the language of the linked document
        case http_e = "http-e" //quiv    <meta>    Provides an HTTP header for the information/value of the content attribute
        case id  //  Global Attributes    Specifies a unique id for an element
        case ismap  //  <img>    Specifies an image as a server-side image map
        case kind  //  <track>    Specifies the kind of text track
        case label  //  <track>, <option>, <optgroup>    Specifies the title of the text track
        case lang  //  Global Attributes    Specifies the language of the element's content
        case list  //  <input>    Refers to a <datalist> element that contains pre-defined options for an <input> element
        case loop  //  <audio>, <video>    Specifies that the audio/video will start over again, every time it is finished
        case low  //  <meter>    Specifies the range that is considered to be a low value
        case max  //  <input>, <meter>, <progress>    Specifies the maximum value
        case maxlength  //  <input>, <textarea>    Specifies the maximum number of characters allowed in an element
        case media  //  <a>, <area>, <link>, <source>, <style>    Specifies what media/device the linked document is optimized for
        case method  //  <form>    Specifies the HTTP method to use when sending form-data
        case min  //  <input>, <meter>    Specifies a minimum value
        case multiple  //  <input>, <select>    Specifies that a user can enter more than one value
        case muted  //  <video>, <audio>    Specifies that the audio output of the video should be muted
        case name  //  <button>, <fieldset>, <form>, <iframe>, <input>, <map>, <meta>, <object>, <output>, <param>, <select>, <textarea>    Specifies the name of the element
        case novalidate  //  <form>    Specifies that the form should not be validated when submitted
        case onabort  //  <audio>, <embed>, <img>, <object>, <video>    Script to be run on abort
        case onafterprint  //  <body>    Script to be run after the document is printed
        case onbeforeprint  //  <body>    Script to be run before the document is printed
        case onbeforeunload  //  <body>    Script to be run when the document is about to be unloaded
        case onblur  //  All visible elements.    Script to be run when the element loses focus
        case oncanplay  //  <audio>, <embed>, <object>, <video>    Script to be run when a file is ready to start playing (when it has buffered enough to begin)
        case oncanplaythrough  //  <audio>, <video>    Script to be run when a file can be played all the way to the end without pausing for buffering
        case onchange  //  All visible elements.    Script to be run when the value of the element is changed
        case onclick  //  All visible elements.    Script to be run when the element is being clicked
        case oncontextmenu  //  All visible elements.    Script to be run when a context menu is triggered
        case oncopy  //  All visible elements.    Script to be run when the content of the element is being copied
        case oncuechange  //  <track>    Script to be run when the cue changes in a <track> element
        case oncut  //  All visible elements.    Script to be run when the content of the element is being cut
        case ondblclick  //  All visible elements.    Script to be run when the element is being double-clicked
        case ondrag  //  All visible elements.    Script to be run when the element is being dragged
        case ondragend  //  All visible elements.    Script to be run at the end of a drag operation
        case ondragenter  //  All visible elements.    Script to be run when an element has been dragged to a valid drop target
        case ondragleave  //  All visible elements.    Script to be run when an element leaves a valid drop target
        case ondragover  //  All visible elements.    Script to be run when an element is being dragged over a valid drop target
        case ondragstart  //  All visible elements.    Script to be run at the start of a drag operation
        case ondrop  //  All visible elements.    Script to be run when dragged element is being dropped
        case ondurationchange  //  <audio>, <video>    Script to be run when the length of the media changes
        case onemptied  //  <audio>, <video>    Script to be run when something bad happens and the file is suddenly unavailable (like unexpectedly disconnects)
        case onended  //  <audio>, <video>    Script to be run when the media has reach the end (a useful event for messages like "thanks for listening")
        case onerror  //  <audio>, <body>, <embed>, <img>, <object>, <script>, <style>, <video>    Script to be run when an error occurs
        case onfocus  //  All visible elements.    Script to be run when the element gets focus
        case onhashchange  //  <body>    Script to be run when there has been changes to the anchor part of the a URL
        case oninput  //  All visible elements.    Script to be run when the element gets user input
        case oninvalid  //  All visible elements.    Script to be run when the element is invalid
        case onkeydown  //  All visible elements.    Script to be run when a user is pressing a key
        case onkeypress  //  All visible elements.    Script to be run when a user presses a key
        case onkeyup  //  All visible elements.    Script to be run when a user releases a key
        case onload  //  <body>, <iframe>, <img>, <input>, <link>, <script>, <style>    Script to be run when the element is finished loading
        case onloadeddata  //  <audio>, <video>    Script to be run when media data is loaded
        case onloadedmetadata  //  <audio>, <video>    Script to be run when meta data (like dimensions and duration) are loaded
        case onloadstart  //  <audio>, <video>    Script to be run just as the file begins to load before anything is actually loaded
        case onmousedown  //  All visible elements.    Script to be run when a mouse button is pressed down on an element
        case onmousemove  //  All visible elements.    Script to be run as long as the  mouse pointer is moving over an element
        case onmouseout  //  All visible elements.    Script to be run when a mouse pointer moves out of an element
        case onmouseover  //  All visible elements.    Script to be run when a mouse pointer moves over an element
        case onmouseup  //  All visible elements.    Script to be run when a mouse button is released over an element
        case onmousewheel  //  All visible elements.    Script to be run when a mouse wheel is being scrolled over an element
        case onoffline  //  <body>    Script to be run when the browser starts to work offline
        case ononline  //  <body>    Script to be run when the browser starts to work online
        case onpagehide  //  <body>    Script to be run when a user navigates away from a page
        case onpageshow  //  <body>    Script to be run when a user navigates to a page
        case onpaste  //  All visible elements.    Script to be run when the user pastes some content in an element
        case onpause  //  <audio>, <video>    Script to be run when the media is paused either by the user or programmatically
        case onplay  //  <audio>, <video>    Script to be run when the media has started playing
        case onplaying  //  <audio>, <video>    Script to be run when the media has started playing
        case onpopstate  //  <body>    Script to be run when the window's history changes.
        case onprogress  //  <audio>, <video>    Script to be run when the browser is in the process of getting the media data
        case onratechange  //  <audio>, <video>    Script to be run each time the playback rate changes (like when a user switches to a slow motion or fast forward mode).
        case onreset  //  <form>    Script to be run when a reset button in a form is clicked.
        case onresize  //  <body>    Script to be run when the browser window is being resized.
        case onscroll  //  All visible elements.    Script to be run when an element's scrollbar is being scrolled
        case onsearch  //  <input>    Script to be run when the user writes something in a search field (for <input="search">)
        case onseeked  //  <audio>, <video>    Script to be run when the seeking attribute is set to false indicating that seeking has ended
        case onseeking  //  <audio>, <video>    Script to be run when the seeking attribute is set to true indicating that seeking is active
        case onselect  //  All visible elements.    Script to be run when the element gets selected
        case onstalled  //  <audio>, <video>    Script to be run when the browser is unable to fetch the media data for whatever reason
        case onstorage  //  <body>    Script to be run when a Web Storage area is updated
        case onsubmit  //  <form>    Script to be run when a form is submitted
        case onsuspend  //  <audio>, <video>    Script to be run when fetching the media data is stopped before it is completely loaded for whatever reason
        case ontimeupdate  //  <audio>, <video>    Script to be run when the playing position has changed (like when the user fast forwards to a different point in the media)
        case ontoggle  //  <details>    Script to be run when the user opens or closes the <details> element
        case onunload  //  <body>    Script to be run when a page has unloaded (or the browser window has been closed)
        case onvolumechange  //  <audio>, <video>    Script to be run each time the volume of a video/audio has been changed
        case onwaiting  //  <audio>, <video>    Script to be run when the media has paused but is expected to resume (like when the media pauses to buffer more data)
        case onwheel  //  All visible elements.    Script to be run when the mouse wheel rolls up or down over an element
        case open  //  <details>    Specifies that the details should be visible (open) to the user
        case optimum  //  <meter>    Specifies what value is the optimal value for the gauge
        case pattern  //  <input>    Specifies a regular expression that an <input> element's value is checked against
        case placeholder  //  <input>, <textarea>    Specifies a short hint that describes the expected value of the element
        case poster  //  <video>    Specifies an image to be shown while the video is downloading, or until the user hits the play button
        case preload  //  <audio>, <video>    Specifies if and how the author thinks the audio/video should be loaded when the page loads
        case readonly  //  <input>, <textarea>    Specifies that the element is read-only
        case rel  //  <a>, <area>, <form>, <link>    Specifies the relationship between the current document and the linked document
        case required  //  <input>, <select>, <textarea>    Specifies that the element must be filled out before submitting the form
        case reversed  //  <ol>    Specifies that the list order should be descending (9,8,7...)
        case rows  //  <textarea>    Specifies the visible number of lines in a text area
        case rowspan  //  <td>, <th>    Specifies the number of rows a table cell should span
        case sandbox  //  <iframe>    Enables an extra set of restrictions for the content in an <iframe>
        case scope  //  <th>    Specifies whether a header cell is a header for a column, row, or group of columns or rows
        case selected  //  <option>    Specifies that an option should be pre-selected when the page loads
        case shape  //  <area>    Specifies the shape of the area
        case size  //  <input>, <select>    Specifies the width, in characters (for <input>) or specifies the number of visible options (for <select>)
        case sizes  //  <img>, <link>, <source>    Specifies the size of the linked resource
        case span  //  <col>, <colgroup>    Specifies the number of columns to span
        case spellcheck  //  Global Attributes    Specifies whether the element is to have its spelling and grammar checked or not
        case src  //  <audio>, <embed>, <iframe>, <img>, <input>, <script>, <source>, <track>, <video>    Specifies the URL of the media file
        case srcdoc  //  <iframe>    Specifies the HTML content of the page to show in the <iframe>
        case srclang  //  <track>    Specifies the language of the track text data (required if kind="subtitles")
        case srcset  //  <img>, <source>    Specifies the URL of the image to use in different situations
        case start  //  <ol>    Specifies the start value of an ordered list
        case step  //  <input>    Specifies the legal number intervals for an input field
        case style  //  Global Attributes    Specifies an inline CSS style for an element
        case tabindex  //  Global Attributes    Specifies the tabbing order of an element
        case target  //  <a>, <area>, <base>, <form>    Specifies the target for where to open the linked document or where to submit the form
        case title  //  Global Attributes    Specifies extra information about an element
        case translate  //  Global Attributes    Specifies whether the content of an element should be translated or not
        case type  //  <a>, <button>, <embed>, <input>, <link>, <menu>, <object>, <script>, <source>, <style>    Specifies the type of element
        case usemap  //  <img>, <object>    Specifies an image as a client-side image map
        case value  //  <button>, <input>, <li>, <option>, <meter>, <progress>, <param>    Specifies the value of the element
        case width  //  <canvas>, <embed>, <iframe>, <img>, <input>, <object>, <video>    Specifies the width of the element
        case wrap  //  <textarea>    Specifies how the text in a text area is to be wrapped when submitted in a form
    }
}

extension HTML {
    enum CSSProperty: String {
        case align_content = "align-content"  //   Specifies the alignment of flexible container's items within the flex container.
        case align_items = "align-items"  //   Specifies the default alignment for items within the flex container.
        case align_self = "align-self"  //   Specifies the alignment for selected items within the flex container.
        case animation  //  Specifies the keyframe-based animations.
        case animation_delay = "animation-delay"  //   Specifies when the animation will start.
        case animation_direction = "animation-direction"  //   Specifies whether the animation should play in reverse on alternate cycles or not.
        case animation_duration = "animation-duration"  //   Specifies the number of seconds or milliseconds an animation should take to complete one cycle.
        case animation_fill_mode = "animation-fill-mode" //  Specifies how a CSS animation should apply styles to its target before and after it is executing.
        case animation_iteration_count = "animation-iteration-count"  //   Specifies the number of times an animation cycle should be played before stopping.
        case animation_name = "animation-name"  //  Specifies the name of @keyframes defined animations that should be applied to the selected element.
        case animation_play_state = "animation-play-state"  //   Specifies whether the animation is running or paused.
        case animation_timing_function = "animation-timing-function"  //   Specifies how a CSS animation should progress over the duration of each cycle.
        case backface_visibility = "backface-visibility"  //  Specifies whether or not the "back" side of a transformed element is visible when facing the user.
        case background  //  Defines a variety of background properties within one declaration.
        case background_attachment = "background-attachment"  // Specify whether the background image is fixed in the viewport or scrolls.
        case background_clip = "background-clip"  //  Specifies the painting area of the background.
        case background_color = "background-color"  // Defines an element's background color.
        case background_image = "background-image"  // Defines an element's background image.
        case background_origin = "background-origin"  //  Specifies the positioning area of the background images.
        case background_position = "background-position"  // Defines the origin of a background image.
        case background_repeat = "background-repeat"  // Specify whether/how the background image is tiled.
        case background_size = "background-size"  //  Specifies the size of the background images.
        case border  //  Sets the width, style, and color for all four sides of an element's border.
        case border_bottom = "border-bottom" //  Sets the width, style, and color of the bottom border of an element.
        case border_bottom_color = "border-bottom-color" //  Sets the color of the bottom border of an element.
        case border_bottom_left_radius = "border-bottom-left-radius"  //   Defines the shape of the bottom-left border corner of an element.
        case border_bottom_right_radius = "border-bottom-right-radius"  //   Defines the shape of the bottom-right border corner of an element.
        case border_bottom_style = "border-bottom-style" //  Sets the style of the bottom border of an element.
        case border_bottom_width = "border-bottom-width" //  Sets the width of the bottom border of an element.
        case border_collapse = "border-collapse" //  Specifies whether table cell borders are connected or separated.
        case border_color = "border-color" //  Sets the color of the border on all the four sides of an element.
        case border_image = "border-image" //   Specifies how an image is to be used in place of the border styles.
        case border_image_outset = "border-image-outset"  //  Specifies the amount by which the border image area extends beyond the border box.
        case border_image_repeat = "border-image-repeat"  //  Specifies whether the image-border should be repeated, rounded or stretched.
        case border_image_slice = "border-image-slice"  //  Specifies the inward offsets of the image-border.
        case border_image_source = "border-image-source"  //  Specifies the location of the image to be used as a border.
        case border_image_width = "border-image-width"  //  Specifies the width of the image-border.
        case border_left = "border-left" //  Sets the width, style, and color of the left border of an element.
        case border_left_color = "border-left-color"  //  Sets the color of the left border of an element.
        case border_left_style = "border-left-style"  //  Sets the style of the left border of an element.
        case border_left_width = "border-left-width"  //  Sets the width of the left border of an element.
        case border_radius = "border-radius" //   Defines the shape of the border corners of an element.
        case border_right = "border-right" //  Sets the width, style, and color of the right border of an element.
        case border_right_color = "border-right-color"  //  Sets the color of the right border of an element.
        case border_right_style = "border-right-style"  //  Sets the style of the right border of an element.
        case border_right_width = "border-right-width"  //  Sets the width of the right border of an element.
        case border_spacing = "border-spacing" //  Sets the spacing between the borders of adjacent table cells.
        case border_style = "border-style" //  Sets the style of the border on all the four sides of an element.
        case border_top = "border-top" //  Sets the width, style, and color of the top border of an element.
        case border_top_color = "border-top-color"  //  Sets the color of the top border of an element.
        case border_top_left_radius = "border-top-left-radius"  //   Defines the shape of the top-left border corner of an element.
        case border_top_right_radius = "border-top-right-radius"  //   Defines the shape of the top-right border corner of an element.
        case border_top_style = "border-top-style"  //  Sets the style of the top border of an element.
        case border_top_width = "border-top-width"  //  Sets the width of the top border of an element.
        case border_width = "border-width" //  Sets the width of the border on all the four sides of an element.
        case bottom  //  Specify the location of the bottom edge of the positioned element.
        case box_shadow = "box-shadow" //   Applies one or more drop-shadows to the element's box.
        case box_sizing = "box-sizing" //   Alter the default CSS box model.
        case caption_side = "caption-side"  //  Specify the position of table's caption.
        case clear  //  Specifies the placement of an element in relation to floating elements.
        case clip  //  Defines the clipping region.
        case color  //  Specify the color of the text of an element.
        case column_count = "column-count" //   Specifies the number of columns in a multi-column element.
        case column_fill = "column-fill" //   Specifies how columns will be filled.
        case column_gap = "column-gap" //   Specifies the gap between the columns in a multi-column element.
        case column_rule = "column-rule" //   Specifies a straight line, or "rule", to be drawn between each column in a multi-column element.
        case column_rule_color = "column-rule-color"  //   Specifies the color of the rules drawn between columns in a multi-column layout.
        case column_rule_style = "column-rule-style"  //   Specifies the style of the rule drawn between the columns in a multi-column layout.
        case column_rule_width = "column-rule-width"  //   Specifies the width of the rule drawn between the columns in a multi-column layout.
        case column_span = "column-span" //   Specifies how many columns an element spans across in a multi-column layout.
        case column_width = "column-width" //   Specifies the optimal width of the columns in a multi-column element.
        case columns  //   A shorthand property for setting column-width and column-count properties.
        case content  //  Inserts generated content.
        case counter_increment = "counter-increment" //  Increments one or more counter values.
        case counter_reset = "counter-reset" //  Creates or resets one or more counters.
        case cursor  //  Specify the type of cursor.
        case direction  //  Define the text direction/writing direction.
        case display  //  Specifies how an element is displayed onscreen.
        case empty_cells = "empty-cells" //  Show or hide borders and backgrounds of empty table cells.
        case flex  //   Specifies the components of a flexible length.
        case flex_basis = "flex-basis" //   Specifies the initial main size of the flex item.
        case flex_direction = "flex-direction" //   Specifies the direction of the flexible items.
        case flex_flow = "flex-flow" //   A shorthand property for the flex-direction and the flex-wrap properties.
        case flex_grow = "flex-grow" //   Specifies how the flex item will grow relative to the other items inside the flex container.
        case flex_shrink = "flex-shrink" //   Specifies how the flex item will shrink relative to the other items inside the flex container.
        case flex_wrap = "flex-wrap" //   Specifies whether the flexible items should wrap or not.
        case float  //  Specifies whether or not a box should float.
        case font  //  Defines a variety of font properties within one declaration.
        case font_family = "font-family" //  Defines a list of fonts for element.
        case font_size = "font-size" //  Defines the font size for the text.
        case font_size_adjust = "font-size-adjust"  //   Preserves the readability of text when font fallback occurs.
        case font_stretch = "font-stretch" //   Selects a normal, condensed, or expanded face from a font.
        case font_style = "font-style" //  Defines the font style for the text.
        case font_variant = "font-variant" //  Specify the font variant.
        case font_weight = "font-weight" //  Specify the font weight of the text.
        case height  //  Specify the height of an element.
        case justify_content = "justify-content" //   Specifies how flex items are aligned along the main axis of the flex container after any flexible lengths and auto margins have been resolved.
        case left  //  Specify the location of the left edge of the positioned element.
        case letter_spacing = "letter-spacing" //  Sets the extra spacing between letters.
        case line_height = "line-height" //  Sets the height between lines of text.
        case list_style = "list-style" //  Defines the display style for a list and list elements.
        case list_style_image = "list-style-image"  //  Specifies the image to be used as a list-item marker.
        case list_style_position = "list-style-position"  //  Specifies the position of the list-item marker.
        case list_style_type = "list-style-type"  //  Specifies the marker style for a list-item.
        case margin  //  Sets the margin on all four sides of the element.
        case margin_bottom = "margin-bottom" //  Sets the bottom margin of the element.
        case margin_left = "margin-left" //  Sets the left margin of the element.
        case margin_right = "margin-right" //  Sets the right margin of the element.
        case margin_top = "margin-top" //  Sets the top margin of the element.
        case max_height = "max-height" //  Specify the maximum height of an element.
        case max_width = "max-width" //  Specify the maximum width of an element.
        case min_height = "min-height" //  Specify the minimum height of an element.
        case min_width = "min-width" //  Specify the minimum width of an element.
        case opacity  //   Specifies the transparency of an element.
        case order  //   Specifies the order in which a flex items are displayed and laid out within a flex container.
        case outline  //  Sets the width, style, and color for all four sides of an element's outline.
        case outline_color = "outline-color" //  Sets the color of the outline.
        case outline_offset = "outline-offset" //   Set the space between an outline and the border edge of an element.
        case outline_style = "outline-style" //  Sets a style for an outline.
        case outline_width = "outline-width" //  Sets the width of the outline.
        case overflow  //  Specifies the treatment of content that overflows the element's box.
        case overflow_x = "overflow-x" //   Specifies the treatment of content that overflows the element's box horizontally.
        case overflow_y = "overflow-y" //   Specifies the treatment of content that overflows the element's box vertically.
        case padding  //  Sets the padding on all four sides of the element.
        case padding_bottom = "padding-bottom" //  Sets the padding to the bottom side of an element.
        case padding_left = "padding-left" //  Sets the padding to the left side of an element.
        case padding_right = "padding-right" //  Sets the padding to the right side of an element.
        case padding_top = "padding-top" //  Sets the padding to the top side of an element.
        case page_break_after = "page-break-after"  //  Insert a page breaks after an element.
        case page_break_before = "page-break-before"  //  Insert a page breaks before an element.
        case page_break_inside = "page-break-inside"  //  Insert a page breaks inside an element.
        case perspective  //   Defines the perspective from which all child elements of the object are viewed.
        case perspective_origin = "perspective-origin" //   Defines the origin (the vanishing point for the 3D space) for the perspective property.
        case position  //  Specifies how an element is positioned.
        case quotes  //  Specifies quotation marks for embedded quotations.
        case resize  //   Specifies whether or not an element is resizable by the user.
        case right  //  Specify the location of the right edge of the positioned element.
        case tab_size = "tab-size" //   Specifies the length of the tab character.
        case table_layout = "table-layout" //  Specifies a table layout algorithm.
        case text_align = "text-align" //  Sets the horizontal alignment of inline content.
        case text_align_last = "text-align-last"  //   Specifies how the last line of a block or a line right before a forced line break is aligned when text-align is justify.
        case text_decoration = "text-decoration" //  Specifies the decoration added to text.
        case text_decoration_color = "text-decoration-color"  //   Specifies the color of the text-decoration-line.
        case text_decoration_line = "text-decoration-line"  //   Specifies what kind of line decorations are added to the element.
        case text_decoration_style = "text-decoration-style"  //   Specifies the style of the lines specified by the text-decoration-line property
        case text_indent = "text-indent" //  Indent the first line of text.
        case text_justify = "text-justify" //   Specifies the justification method to use when the text-align property is set to justify.
        case text_overflow = "text-overflow" //   Specifies how the text content will be displayed, when it overflows the block containers.
        case text_shadow = "text-shadow" //   Applies one or more shadows to the text content of an element.
        case text_transform = "text-transform" //  Transforms the case of the text.
        case top  //  Specify the location of the top edge of the positioned element.
        case transform  //   Applies a 2D or 3D transformation to an element.
        case transform_origin = "transform-origin" //   Defines the origin of transformation for an element.
        case transform_style = "transform-style" //   Specifies how nested elements are rendered in 3D space.
        case transition  //   Defines the transition between two states of an element.
        case transition_delay = "transition-delay" //   Specifies when the transition effect will start.
        case transition_duration = "transition-duration" //   Specifies the number of seconds or milliseconds a transition effect should take to complete.
        case transition_property = "transition-property" //   Specifies the names of the CSS properties to which a transition effect should be applied.
        case transition_timing_function = "transition-timing-function"  //   Specifies the speed curve of the transition effect.
        case vertical_align = "vertical-align" //  Sets the vertical positioning of an element relative to the current text baseline.
        case visibility  //  Specifies whether or not an element is visible.
        case white_space = "white-space" //  Specifies how white space inside the element is handled.
        case width  //  Specify the width of an element.
        case word_break = "word-break" //   Specifies how to break lines within words.
        case word_spacing = "word-spacing" //  Sets the spacing between words.
        case word_wrap = "word-wrap" //   Specifies whether to break words when the content overflows the boundaries of its container.
        case z_index = "z-index" //  Specifies a layering or stacking order for positioned elements.
    }
}
