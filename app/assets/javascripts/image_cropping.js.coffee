jQuery ->
  new AvatarCropper()

class AvatarCropper
  constructor: ->
    @minWidth = $('#cropbox').data("min-width")
    @minHeight = $('#cropbox').data("min-height")
    $('#cropbox').Jcrop
      aspectRatio: @minWidth/@minHeight
      minSize:[@minWidth,@minHeight]
      setSelect: [0,0,@minWidth,@minHeight]
      onSelect: @update
      onChange: @update

  update: (coords) =>
    $("input[id*=crop_x]").val(coords.x)
    $("input[id*=crop_y]").val(coords.y)
    $("input[id*=crop_w]").val(coords.w)
    $("input[id*=crop_h]").val(coords.h)
    @updatePreview(coords)

  updatePreview: (coords) =>
    console.log(coords)
#    console.log("width:" + )

    rx = (@minWidth/2)/coords.w
    ry = (@minHeight/2)/coords.h

    $('#preview').css
      width: Math.round(rx * $('#cropbox').width()) + 'px'
      height: Math.round(ry * $('#cropbox').height()) + 'px'
      marginLeft: '-' + Math.round(rx * coords.x) + 'px'
      marginTop: '-' + Math.round(ry * coords.y) + 'px'