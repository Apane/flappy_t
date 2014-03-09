Selfstarter =
  firstTime: true
  validateEmail: ->
    # The regex we use for validating email
    # It probably should be a parser, but there isn't enough time for that (Maybe in the future though!)
    if /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/.test($("#email").val())
      $("#email").removeClass("highlight")
      $("#amazon_button").removeClass("disabled")
    else
      $("#email").addClass("highlight") unless Selfstarter.firstTime
      $("#amazon_button").addClass("disabled") unless $("#amazon_button").hasClass("disabled")

  bindPricingChange: ->
    $("#quantity, #shippingoptions").change ->
      units = $("#quantity").val()
      shippingKey = $("#shippingoptions").val()
      shipping = {
        "United States": 4.95,
        "Canada": 7.95,
        "International": 12.95
        }[shippingKey]
      price = (15.00 * parseInt(units)) + shipping
      $("#totalprice").text("$" + price);

  bindFBShare: ->
    $(".facebook-btn").click ->
      FB.ui({
        method: "feed",
        display: "popup",
        redirect_uri: "http://www.flappytoy.com",
        link: "http://www.flappytoy.com",
        caption: "Play Flappy Bird with the wireless toy",
        description: "Flappy is no ordinary plush toy.  He's wireless and controls the game when you lift him up!",
        picture: "http://flappytoycom.s3.amazonaws.com/assets/video_placeholder.png"
      })

  bindGiftCheckbox: ->
    $("#gift").change ->
      val = $(this).is(":checked")
      if val
        $("#gift-form-section").removeClass("hidden")
      else
        $("#gift-form-section").addClass("hidden")

  init: ->
    checkoutOffset = $('body').height() - $('.footer').outerHeight() #needs to be done upon init

    $("#email").bind "textchange", ->
      Selfstarter.validateEmail()
    $("#email").bind "hastext", ->
      Selfstarter.validateEmail()
    # The first time they type in their email, we don't want it to throw a validation error
    $("#email").change ->
      Selfstarter.firstTime = false

    # Bind gift checkbox, pricing
    Selfstarter.bindGiftCheckbox()
    Selfstarter.bindPricingChange()
    Selfstarter.bindFBShare()

    # init placeholder image for video
    $("#video_image").on "click", ->
      $("#player").removeClass("hidden")
      $("#player").css('display', 'block')
      $(this).hide()

    # if they are using the optional payment options section on the checkout page, need to conditional fix the email
    # field and button to the bottom of the page so it's displayed after selecting a radio button
    if $('.payment_options').length > 0

      onScroll = () ->
        wrapper = $('.checkout_controls_wrapper')
        if $(window).scrollTop() + $(window).height() < checkoutOffset
          wrapper.addClass('fix_to_bottom')
        else if wrapper.hasClass("fix_to_bottom")
          wrapper.removeClass('fix_to_bottom')

      $(window).on "scroll", ->
        onScroll()

      # the radio button selection should bring up the email field and button
      $('.payment_options ol li').on "click", ->
        return false if $(this).children(".payment_radio").attr("disabled") == "disabled"
        $(".payment_radio").parents("ol>li").removeClass("checkout_option_selected")
        $(this).addClass("checkout_option_selected")
        $(this).children(".payment_radio").attr "checked", "checked"
        onScroll()
        $('.checkout_controls_wrapper').addClass "checkout_ready"
$ ->
  Selfstarter.init()
  $("#email").focus() if $('.payment_options').length == 0
