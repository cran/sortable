#' Add a rank list inside bucket list.
#'
#' Since a [bucket_list] can contain more than one [rank_list], you need
#' an easy way to define the contents of each individual rank list.  This
#' function serves as a specification of a rank list.
#'
#' @inheritParams rank_list
#' @param ... Other arguments passed to `rank_list`
#'
#' @return A list of class `add_rank_list`
#' @export
add_rank_list <- function(text, labels = NULL, input_id = NULL, ...) {
  if (is.null(input_id)) {
    input_id <- increment_rank_list_input_id()
  }
  z <- list(
    text = text,
    labels = labels,
    input_id = input_id,
    ...
  )
  # assert_that(is_input_id(input_id))
  class(z) <- c("add_rank_list", "list")
  z
}

is_add_rank_list <- function(x) {
  inherits(x, "add_rank_list")
}


#' Create a bucket list.
#'
#' A bucket list can contain more than one [rank_list] and allows drag-and-drop
#' of items between the different lists.
#'
#' @template options
#'
#' @param header Text that appears at the top of the bucket list.  (This is
#'   encoded as an HTML `<p>` tag, so not strictly speaking a header.)
#'
#' @param ... One or more specifications for a rank list, and must be defined by
#'   [add_rank_list].
#'
#' @param class A css class applied to the bucket list and rank lists.  This can
#'   be used to define custom styling.
#'
#' @param group_name Passed to `SortableJS` as the group name. Also the input
#'   value set in Shiny. (`input[[group_name]]`)
#'
#' @param group_put_max Not yet implemented
#'
#' @param orientation Either `horizontal` or `vertical`, and specifies the
#'   layout of the components on the page.
#'
#' @return A list with class `bucket_list`
#' @seealso rank_list
#' @export
#' @example inst/examples/example_bucket_list.R
#' @examples
#' ## Example of a shiny app
#' if (interactive()) {
#'   app <- system.file("shiny-examples/bucket_list/app.R", package = "sortable")
#'   shiny::runApp(app)
#' }
bucket_list <- function(
  header = NULL,
  ...,
  group_name,
  group_put_max = rep(Inf, length(labels)),
  options = sortable_options(),
  class = "default-sortable",
  orientation = c("horizontal", "vertical")
) {

  # assert_that(is_header(header))

  assert_that(is_sortable_options(options))
  if (missing(group_name) || is.null(group_name)) {
    group_name <- increment_bucket_group()
  }

  orientation <- match.arg(orientation)

  class <- paste(class, collapse = " ")

  # capture the dots
  ellipsis::check_dots_unnamed()
  dot_vals <- list(...)
  # modify the dots by adding the group_name to the sortable options
  dots <- lapply(seq_along(dot_vals), function(i) {
    dot <- dot_vals[[i]]
    assert_that(is_add_rank_list(dot))

    if (is.null(dot$css_id)) {
      dot$css_id <- increment_rank_list()
    }
    modifyList(
      dot,
      val = list(
        options = sortable_options(group = group_name),
        class = paste(class, paste0("column_", i))
      )
    )
  })

  css_ids <- vapply(dots, function(dot) dot$css_id, character(1))
  input_ids <- vapply(dots, function(dot) dot$input_id, character(1))

  set_bucket <- sortable_js_capture_bucket_input(group_name, input_ids, css_ids)
  display_empty_class <- sortable_js_set_empty_class(css_ids)

  dots <- lapply(dots, function(dot) {
    dot$options$onLoad <- chain_js_events(set_bucket, dot$options$onLoad) # nolint
    dot$options$onSort <- chain_js_events(set_bucket, dot$options$onSort) # nolint
    dot$options$onMove <- chain_js_events(dot$options$onMove, display_empty_class) # nolint
    dot
  })

  # construct list rank_list objects
  sortables <- lapply(dots, function(dot) do.call(rank_list, dot) )

  title_tag <-
    if (!is.null(header)) {
      tags$p(header)
    } else {
      NULL
    }

  z <- tagList(
    tags$div(
      class = paste("bucket-list-container", class),
      title_tag,
      tags$div(
        class = paste(class, "bucket-list", paste0("bucket-list-", orientation)),
        sortables
      )
    ),
    bucket_list_dependencies()
  )

  as_bucket_list(z)
}
