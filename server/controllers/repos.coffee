module.exports =
  list: (req, res) -> res.render 'repos/list'
  next: (req, res) -> res.send
    # TODO: use real code
    "owner": "hedgewars",
    "name": "hw",
    "matched": "apple",
    "status": "queued",
    "file": "https: //github.com/hedgewars/hw/blob/1a66e765df311b0eaa4a37e30ff532676f895dde/share/hedgewars/Data/Names/apple.txt"
