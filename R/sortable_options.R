#' Check if object is sortable options.
#'
#' @param x Object to test
#' @return Logical vector.  TRUE if the object inherits from `sortable_options`
#' @export
#' @examples
#' is_sortable_options("foo") # returns FALSE
is_sortable_options <- function(x) {
  inherits(x, "sortable_options")
}


#' Define options to pass to a sortable object.
#'
#' Use this function to define the options for [sortable_js] and [rank_list],
#' which will pass these in turn to the `SortableJS` JavaScript library.
#'
#' Many of the `SortableJS` options will accept a JavaScript function. You can
#' do this using the `htmlwidgets::JS` function.
#'
#' @param ... other arguments passed onto `SortableJS`
#'
#' @param swap If `TRUE`, modifies the behaviour of `sortable` to allow for items to
#'   be swapped with each other rather than sorted. Once dragging starts, the
#'   user can drag over other items and there will be no change in the elements.
#'   However, the item that the user drops on will be swapped with the
#'   originally dragged item.
#'   See also https://github.com/SortableJS/Sortable/tree/master/plugins/Swap
#'
#' @param multiDrag If `TRUE`, allows the selection of multiple items within a
#'   `sortable` at once, and drag them as one item. Once placed, the items will
#'   unfold into their original order, but all beside each other at the new
#'   position.
#'   See also https://github.com/SortableJS/Sortable/wiki/Dragging-Multiple-Items-in-Sortable
#'
#'
#' @param group To drag elements from one list into another, both lists must
#'   have the same group value. See
#'   [Sortable#group-option](https://github.com/sortablejs/Sortable/#group-option)
#'   for more details. \[`"name"`\]
#'
#' @param sort Boolean that allows sorting inside a list. \[`TRUE`\]
#'
#' @param delay Time in milliseconds to define when the sorting should start.
#'   \[`0`\]
#
#' @param disabled Boolean that disables the `sortable` if set to true. \[`FALSE`\]
#
#' @param animation Millisecond duration of the animation of items when sorting
#'   \[`0` (no animation)\]
#'
#' @param handle CSS selector used for the drag handle selector within list
#'   items. \[`".my-handle"`\]
#'
#' @param filter CSS selector or JS function used for elements that cannot be
#'   dragged. \[`".ignore-elements"`\]
#'
#' @param draggable CSS selector of which items inside the element should be
#'   draggable. \[`".item"`\]
#'
#' @param swapThreshold Percentage of the target that the swap zone will take
#'   up, as a number between `0` and `1`. \[`1`\]
#'
#' @param invertSwap Set to \code{TRUE} to set the swap zone to the sides of the
#'   target, for the effect of sorting "in between" items. \[`FALSE`\]
#'
#' @param direction Direction of `sortable` \[`"horizontal"`\]
#'
#' @param scrollSensitivity Number of pixels the mouse needs to be to an edge to
#'   start scrolling. \[`30`\]
#'
#' @param scrollSpeed Number of pixels for the speed of scrolling. \[`10`\]
#
#' @param onStart,onEnd JS function called when an element dragging starts or ends
#'
#' @param onAdd JS function called when an element is dropped into the list from
#'   another list
#'
#' @param onUpdate JS function called when the sorting is changed within a list
#'
#' @param onSort JS function called by any change to the list (add / update /
#'   remove)
#'
#' @param onRemove JS function called when an element is removed from the list
#'   into another list
#'
#' @param onFilter JS function called when an attempt is made to drag a filtered
#'   element
#'
#' @param onMove JS function called when an item is moved in a list or between
#'   lists
#'
#' @param onLoad JS function dispatched on the "next tick" after SortableJS has
#'   initialized
#
# @param delayOnTouchOnly Boolean that will only delay if user is using touch
#   (mobile display). \[`FALSE`\]
#
# @param touchStartThreshold Number of pixels a point should move before
#   cancelling a delayed drag event. \[`0`\]
#
# @param store Saving and restoring of the sort. See
#   [Sortable#store](https://github.com/sortablejs/Sortable/#store)
#
# @param easing Easing for animation. \[`NULL`\] See
#   [https://easings.net/](https://easings.net/) for examples.
#
# @param preventOnFilter Boolean that determines if `event.preventDefault()` is
#   called when `filter` is triggered. \[`TRUE`\]
#
# @param dataIdAttr no documentation
#
# @param ghostClass CSS class name for the drop placeholder.
#   \[`"sortable-ghost"`\]
#
# @param chosenClass CSS class name for the chosen item \[`"sortable-chosen"`\]
#
# @param dragClass CSS class name for the dragging item \[`"sortable-drag"`\]
#
# @param invertedSwapThreshold Percentage of the target that the inverted swap
#   zone will take up, as a number between `0` and `1`. \[`swapThreshold`\]
#
# @param forceFallback : false,  // ignore the HTML5 DnD behaviour and force the
#   fallback to kick in
#
# @param fallbackClass : "sortable-fallback",  // Class name for the cloned DOM
#   Element when using forceFallback
#
# @param fallbackOnBody : false,  // Appends the cloned DOM Element into the
#   Document's Body
#
# @param fallbackTolerance : 0, // Specify in pixels how far the mouse should
#   move before it's considered as a drag.
#
# @param dragoverBubble If set to true, the dragover event will bubble to parent
#   sortables. \[`false`\]
#
# @param removeCloneOnHide: true, // Remove the clone element when it is not
#   showing, rather than just hiding it
#
# @param emptyInsertThreshold: Number of pixels a mouse must be from empty
#   `sortable` to insert drag element into it. \[`5`\]
#
# @param setData undocumented on website
#   https://github.com/SortableJS/Sortable/tree/master/plugins/AutoScroll
#
# @param onChoose,onUnchoose JS function called when an element is chosen or
#   unchosen
#
# @param onClone JS function that is called when creating a clone of an element
#
# @param onChange JS function that is called when a dragging element changes
#   position
#'
#'
#' @references  [https://github.com/sortablejs/Sortable/](https://github.com/sortablejs/Sortable/)
#'
#' @seealso [sortable_js]
#'
#' @return A list with class `sortable_options`
#' @examples
#' sortable_options(sort = FALSE)
#' @export
sortable_options <- function(
  ...,
  # nolint start
  swap = NULL,
  multiDrag = NULL,
  group = NULL,
  sort = NULL,
  delay = NULL,
  disabled = NULL,
  animation = NULL,
  handle = NULL,
  filter = NULL,
  draggable = NULL,
  swapThreshold = NULL,
  invertSwap = NULL,
  direction = NULL,
  scrollSensitivity = NULL,
  scrollSpeed = NULL,
  onStart = NULL,
  onEnd = NULL,
  onAdd = NULL,
  onUpdate = NULL,
  onSort = NULL,
  onRemove = NULL,
  onFilter = NULL,
  onMove = NULL,
  onLoad = NULL
  # nolint end
) {
  extra_args <- rlang::list2(...)

  # get all names and values
  args <- names(formals(sortable_options))
  arg_vals <- mget(args[-1], environment()) # remove first element (...)

  # remove null values
  is_null <- vapply(arg_vals, is.null, logical(1))
  arg_vals <- arg_vals[!is_null]

  # merge all args
  ret <- append(arg_vals, extra_args)

  class(ret) <- "sortable_options"
  ret
}


default_sortable_options <- function() {
  sortable_options(
    animation = 150,
    emptyInsertThreshold = 50 / 4
  )
}
