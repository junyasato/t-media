# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
console.log("sdf");
$ ->
  $(document).on 'click', '#add-text', () ->
    id = $(this).attr("article_id")
    $.ajax
      url: "/articles/add_text",
      type: "GET",
      data: id: id

  $(document).on 'click', '#add-header', () ->
    id = $(this).attr("article_id")
    $.ajax
      url: "/articles/add_header",
      type: "GET",
      data: id: id

  $(document).on 'click', '#add-quote', () ->
    id = $(this).attr("article_id")
    $.ajax
      url: "/articles/add_quote",
      type: "GET",
      data: id: id

  $(document).on 'click', '#add-button', () ->
    id = $(this).attr("article_id")
    $.ajax
      url: "/articles/add_button",
      type: "GET",
      data: id: id

  $(document).on 'click', '#add-image', () ->
    id = $(this).attr("article_id")
    $.ajax
      url: "/articles/add_image",
      type: "GET",
      data: id: id

  # item_orderを保存する
  # ajaxを使う必要性はないかも。
  $(document).on 'click', 'input.btn-basic', () ->
    item_order = ""
    id = $(this).attr("article_id")
    $(".items").each (i) ->
      if item_order == ""
        item_order = $(this).attr("item_id")
      else
        item_order = item_order + "," + $(this).attr("item_id")
    $.ajax
      url: "/articles/save",
      type: "GET",
      data: id: id, item_order: item_order,
      success: (data) ->
        alert("保存しました")
      error: (data) ->
        alert("保存に失敗しました")

  ### 以下、order関係 ###
  # 選択フィールドの表示
  $(document).on {
    'mouseenter': ->
      $(this).append $('<ul class="choice-field"><li class="up-order">上へ</li><li class="down-order">下へ</li><li class="top-order">一番上へ</li><li class="bottom-order">一番下へ</li><li class="edit-order">編集</li><li class="remove-order">削除</li></ul>')
      return
    'mouseleave': ->
      $(this).find('ul:last').remove()
      return
  }, '.items'

  # 一番上へ要素を移動する
  $(document).on 'click', '.top-order', () ->
    $(this).closest(".items").prependTo('#item-field')

  # 一番上へ要素を移動する
  $(document).on 'click', '.bottom-order', () ->
    $(this).closest(".items").appendTo('#item-field')

  # 上へ要素を移動する
  $(document).on 'click', '.up-order', () ->
    beforeObject = $(this).closest(".items").prev()
    $(this).closest(".items").insertBefore(beforeObject)

  # 下へ要素を移動する
  $(document).on 'click', '.down-order', () ->
    afterObject = $(this).closest(".items").next()
    $(this).closest(".items").insertAfter(afterObject)

  # 要素を編集する
  $(document).on 'click', '.edit-order', () ->
    object = $(this).closest(".items")
    id = object.attr("item_id")
    $.ajax
      url: "/items/" + id + "/edit",
      type: "GET",
      data: id: id

  # 要素を削除する
  $(document).on 'click', '.remove-order', () ->
    if !confirm('本当に削除しますか？')
      return false
    else
      object = $(this).closest(".items")
      id = object.attr("item_id")
      object.hide()
      $.ajax
        url: "/items/destroy",
        type: "GET",
        data: id: id