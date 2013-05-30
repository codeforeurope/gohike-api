jQuery ->
  new AvatarCropper()

class AvatarCropper
  constructor: ->
    $('#cropbox').Jcrop
      aspectRatio: 1.5
      minSize:[570,380]
      setSelect: [0,0,570,380]
      onSelect: @update
      onChange: @update

  update: (coords) =>
    $('#location_crop_x').val(coords.x)
    $('#location_crop_y').val(coords.y)
    $('#location_crop_w').val(coords.w)
    $('#location_crop_h').val(coords.h)
    @updatePreview(coords)

  updatePreview: (coords) =>
    console.log(coords)
#    console.log("width:" + )

    rx = 285/coords.w
    ry = 190/coords.h

    $('#preview').css
      width: Math.round(rx * $('#cropbox').width()) + 'px'
      height: Math.round(ry * $('#cropbox').height()) + 'px'
      marginLeft: '-' + Math.round(rx * coords.x) + 'px'
      marginTop: '-' + Math.round(ry * coords.y) + 'px'