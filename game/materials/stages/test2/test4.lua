return {
  version = "1.1",
  luaversion = "5.1",
  tiledversion = "0.14.2",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 30,
  height = 30,
  tilewidth = 16,
  tileheight = 16,
  nextobjectid = 54,
  properties = {},
  tilesets = {
    {
      name = "Sprite-0001",
      firstgid = 1,
      tilewidth = 16,
      tileheight = 16,
      spacing = 0,
      margin = 0,
      image = "Sprite-0001.png",
      imagewidth = 128,
      imageheight = 256,
      tileoffset = {
        x = 0,
        y = 0
      },
      properties = {},
      terrains = {
        {
          name = "block",
          tile = -1,
          properties = {}
        }
      },
      tilecount = 128,
      tiles = {
        {
          id = 19,
          terrain = { 0, 0, 0, 0 }
        },
        {
          id = 20,
          terrain = { 0, 0, 0, 0 }
        },
        {
          id = 21,
          terrain = { 0, 0, 0, 0 }
        },
        {
          id = 27,
          terrain = { 0, 0, 0, 0 }
        },
        {
          id = 28,
          terrain = { 0, 0, 0, 0 }
        },
        {
          id = 29,
          terrain = { 0, 0, 0, 0 }
        }
      }
    }
  },
  layers = {
    {
      type = "tilelayer",
      name = "bg",
      x = 0,
      y = 0,
      width = 30,
      height = 30,
      visible = false,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "base64",
      data = "GwAAACMAAAAiAAAAGQAAABkAAAAbAAAAGQAAACMAAAARAAAAIQAAABkAAAAaAAAAGgAAACIAAAASAAAAIQAAACEAAAAiAAAAEgAAABIAAAASAAAAGQAAACMAAAAiAAAAGgAAACIAAAATAAAAIQAAABMAAAAbAAAAEwAAACMAAAAbAAAAGwAAABkAAAASAAAAIwAAABkAAAAjAAAAEwAAABMAAAAiAAAAEQAAABkAAAAZAAAAIQAAABoAAAAjAAAAIQAAACEAAAAhAAAAIwAAABoAAAAjAAAAGgAAABMAAAAaAAAAIwAAABMAAAAhAAAAEwAAABMAAAAaAAAAIgAAACIAAAAbAAAAGwAAABIAAAAbAAAAIgAAABsAAAAiAAAAGQAAABkAAAAbAAAAGgAAABoAAAATAAAAGQAAABIAAAAjAAAAIQAAABEAAAATAAAAGgAAABEAAAAhAAAAGQAAACEAAAAjAAAAGQAAABMAAAARAAAAIwAAABIAAAAaAAAAIwAAABsAAAATAAAAGQAAABIAAAARAAAAEwAAABIAAAAbAAAAEwAAABIAAAAZAAAAGQAAABsAAAAZAAAAGQAAABsAAAAiAAAAIQAAABkAAAAZAAAAGQAAABsAAAAZAAAAIwAAABkAAAAiAAAAIQAAABkAAAAZAAAAGQAAABMAAAAaAAAAGgAAACEAAAARAAAAEQAAACEAAAAaAAAAEwAAACIAAAASAAAAEgAAABIAAAAZAAAAEwAAACIAAAAbAAAAEwAAABEAAAAiAAAAEwAAACEAAAAZAAAAEwAAABIAAAAiAAAAIQAAABsAAAAjAAAAIwAAABoAAAAjAAAAGQAAABEAAAAaAAAAGQAAABoAAAATAAAAIwAAACIAAAASAAAAGgAAABMAAAARAAAAEQAAABMAAAASAAAAEQAAABkAAAAhAAAAEwAAABEAAAAhAAAAGgAAABoAAAASAAAAIgAAACIAAAARAAAAIgAAABsAAAAhAAAAGQAAABoAAAASAAAAIgAAABoAAAARAAAAGwAAABIAAAASAAAAGwAAABIAAAAhAAAAGQAAACEAAAASAAAAIwAAABoAAAAhAAAAEgAAACIAAAAZAAAAIwAAACIAAAAZAAAAIgAAABIAAAASAAAAGQAAABIAAAARAAAAEwAAABIAAAAbAAAAEwAAABsAAAARAAAAGQAAABkAAAATAAAAEwAAACEAAAAaAAAAIwAAABMAAAATAAAAGQAAACMAAAATAAAAIwAAACMAAAATAAAAIQAAABEAAAAhAAAAEQAAABkAAAARAAAAEgAAACMAAAASAAAAGQAAABkAAAAbAAAAIwAAACEAAAAjAAAAIwAAABIAAAAbAAAAIQAAABsAAAAhAAAAGwAAABMAAAAZAAAAGQAAACIAAAAhAAAAGwAAACMAAAAbAAAAIQAAABIAAAATAAAAGwAAACMAAAAaAAAAIwAAACEAAAAhAAAAGwAAACMAAAAaAAAAGgAAABoAAAAiAAAAGgAAABEAAAAZAAAAEgAAACMAAAATAAAAEgAAABMAAAAZAAAAEwAAACIAAAAaAAAAIwAAABkAAAAZAAAAGgAAABsAAAAbAAAAEgAAACEAAAASAAAAIwAAABEAAAAhAAAAIwAAACEAAAAaAAAAIQAAABEAAAAaAAAAEgAAACMAAAAZAAAAGwAAACIAAAAZAAAAEwAAABoAAAAbAAAAIgAAABMAAAASAAAAGQAAACIAAAAhAAAAEQAAABsAAAAZAAAAGwAAABsAAAAiAAAAEwAAACIAAAATAAAAEgAAABMAAAAZAAAAGgAAABoAAAAjAAAAGgAAABkAAAAaAAAAEgAAABIAAAAbAAAAIwAAABoAAAAjAAAAIwAAABsAAAARAAAAIQAAABkAAAAaAAAAGwAAABMAAAAjAAAAIwAAABoAAAARAAAAIQAAABEAAAAbAAAAIgAAABEAAAAiAAAAIgAAABEAAAATAAAAGgAAABsAAAAhAAAAIQAAABEAAAAaAAAAIgAAABMAAAAjAAAAEgAAACIAAAASAAAAEQAAABIAAAAhAAAAEgAAABMAAAAjAAAAEQAAACEAAAAhAAAAEQAAACIAAAAiAAAAGgAAABoAAAAaAAAAGgAAACIAAAAaAAAAGgAAABkAAAAjAAAAGQAAABsAAAAaAAAAIQAAABMAAAAiAAAAIgAAABoAAAARAAAAGgAAACIAAAAiAAAAIQAAACEAAAAbAAAAGgAAACEAAAAbAAAAIwAAACMAAAASAAAAIwAAACIAAAAjAAAAEQAAACMAAAAiAAAAEQAAACIAAAAjAAAAEQAAABsAAAATAAAAGgAAABMAAAASAAAAIgAAABoAAAAaAAAAIQAAACMAAAAZAAAAIwAAABEAAAAhAAAAGgAAABEAAAAhAAAAEwAAABEAAAAaAAAAIwAAACMAAAAbAAAAIQAAABEAAAATAAAAEwAAACEAAAAbAAAAIQAAABIAAAARAAAAEQAAACEAAAASAAAAGQAAABsAAAAbAAAAGwAAACMAAAAbAAAAEQAAABIAAAAjAAAAIQAAABMAAAAhAAAAIQAAABIAAAAiAAAAIwAAABoAAAAaAAAAEgAAABsAAAAbAAAAIQAAACEAAAAbAAAAIwAAABMAAAAbAAAAIQAAABkAAAAaAAAAEQAAACMAAAAbAAAAEgAAABkAAAAiAAAAGgAAACIAAAAhAAAAGgAAABkAAAAiAAAAIQAAACEAAAATAAAAIgAAACIAAAAZAAAAGwAAABEAAAAZAAAAGwAAABsAAAAhAAAAIQAAABoAAAAaAAAAEQAAACMAAAAbAAAAGQAAABsAAAAaAAAAGQAAABEAAAAiAAAAEQAAABoAAAAaAAAAEwAAABsAAAASAAAAEgAAACEAAAASAAAAEwAAACIAAAAZAAAAEgAAABsAAAAZAAAAIQAAABMAAAASAAAAGQAAACIAAAAaAAAAGwAAACEAAAASAAAAEQAAACMAAAASAAAAEQAAABMAAAAhAAAAIgAAABMAAAAaAAAAEwAAABoAAAAZAAAAIwAAABMAAAAbAAAAEgAAACIAAAATAAAAGgAAACEAAAASAAAAEQAAABoAAAAjAAAAEQAAACEAAAAZAAAAEwAAACMAAAATAAAAEwAAACMAAAAbAAAAGQAAABoAAAARAAAAGQAAABsAAAAjAAAAIwAAACEAAAAZAAAAEQAAABsAAAAbAAAAGQAAACMAAAASAAAAIwAAABsAAAASAAAAIgAAABsAAAATAAAAGwAAABsAAAASAAAAGQAAABMAAAAaAAAAGwAAACIAAAAZAAAAEQAAABoAAAATAAAAEwAAACMAAAASAAAAEwAAABsAAAAiAAAAGgAAACIAAAAhAAAAIwAAABIAAAATAAAAEwAAABoAAAAjAAAAIwAAABIAAAAhAAAAIQAAABoAAAASAAAAIgAAABIAAAAaAAAAGwAAABsAAAARAAAAGQAAABkAAAASAAAAIgAAABoAAAAZAAAAGQAAACIAAAAjAAAAIgAAACIAAAAaAAAAIwAAACEAAAAaAAAAIQAAABEAAAAhAAAAEQAAABkAAAARAAAAIgAAABkAAAAiAAAAGQAAACEAAAAaAAAAIgAAABoAAAATAAAAGgAAACIAAAAZAAAAGwAAABoAAAAaAAAAGQAAABIAAAASAAAAEQAAABoAAAAaAAAAIgAAACIAAAAjAAAAGQAAABkAAAASAAAAGwAAABsAAAAhAAAAIQAAABkAAAAbAAAAEwAAACEAAAATAAAAEQAAABsAAAAiAAAAEwAAACMAAAASAAAAGgAAABsAAAAhAAAAIQAAACMAAAAjAAAAIQAAACMAAAASAAAAGQAAACMAAAARAAAAEwAAACMAAAATAAAAEgAAACEAAAAZAAAAGQAAABIAAAAaAAAAGQAAABkAAAASAAAAIgAAACEAAAAhAAAAEwAAABsAAAARAAAAIQAAACMAAAAjAAAAEQAAABsAAAAjAAAAIgAAABoAAAAZAAAAEQAAABEAAAAZAAAAIgAAABMAAAAhAAAAEwAAABsAAAAiAAAAEwAAACIAAAARAAAAIwAAABIAAAAiAAAAIwAAABkAAAAjAAAAEgAAABEAAAARAAAAEwAAABIAAAAaAAAAGQAAABIAAAAhAAAAIwAAABMAAAAjAAAAEgAAACMAAAARAAAAIgAAABMAAAAaAAAAEwAAACMAAAATAAAAGgAAABsAAAAaAAAAEwAAABsAAAAaAAAAIwAAABsAAAASAAAAEgAAABIAAAASAAAAIQAAACIAAAAiAAAAEgAAABkAAAASAAAAGQAAACIAAAAaAAAAGQAAABIAAAARAAAAEwAAACIAAAAaAAAAGwAAABEAAAAZAAAAIQAAACEAAAASAAAAIwAAACEAAAAiAAAAEwAAACEAAAAZAAAAGQAAACIAAAATAAAAGQAAACEAAAAiAAAAIwAAACEAAAATAAAAEQAAACMAAAASAAAAGwAAABoAAAAbAAAAIwAAABsAAAAaAAAAIgAAABIAAAAiAAAAGwAAABoAAAAhAAAAEQAAABEAAAAbAAAAIQAAABsAAAAbAAAAGgAAABoAAAAiAAAAIwAAABoAAAASAAAAEwAAABIAAAAaAAAAEwAAABMAAAAjAAAAGQAAABoAAAAaAAAAGQAAABIAAAARAAAAIgAAACEAAAAaAAAAGQAAABMAAAARAAAAEQAAACEAAAAaAAAAGwAAABkAAAAiAAAAIgAAACEAAAAbAAAA"
    },
    {
      type = "tilelayer",
      name = "b1",
      x = 0,
      y = 0,
      width = 30,
      height = 30,
      visible = false,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "base64",
      data = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAJAAAICwAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAkAAAgLAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAJQAAIC0AACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAlAAAgLQAAICQAACAsAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACQAACAsAAAgJgAAIC4AACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAmAAAgLgAAICUAACAtAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACUAACAtAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACYAACAuAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACYAACAuAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACQAACAsAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAkAAAAJQAAACYAAAAAAAAAAAAAAAAAAAAAAAAAJAAAICwAACAAAAAAAAAAACUAACAtAAAgJAAAICwAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAsAAAALQAAAC4AAAAAAAAAAAAAAAAAAAAAAAAAJQAAIC0AACAkAAAgLAAAICYAACAuAAAgJQAAIC0AACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACQAAAAlAAAAJgAAACQAAAAlAAAAJgAAAAAAAAAAAAAAJgAAIC4AACAlAAAgLQAAICQAACAsAAAgJgAAIC4AACAkAAAgLAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACwAAAAtAAAALgAAACwAAAAtAAAALgAAAAAAAAAAAAAAJAAAICwAACAmAAAgLgAAICUAACAtAAAgJAAAICwAACAlAAAgLQAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAJAAAACUAAAAmAAAAJAAAACUAAAAmAAAAJAAAACUAAAAmAAAAJQAAIC0AACAkAAAgLAAAICYAACAuAAAgJQAAIC0AACAmAAAgLgAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAALAAAAC0AAAAuAAAALAAAAC0AAAAuAAAALAAAAC0AAAAuAAAAJgAAIC4AACAlAAAgLQAAIAAAAAAAAAAAJgAAIC4AACAlAAAgLQAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAmAAAgLgAAIAAAAAAAAAAAAAAAAAAAAAAmAAAgLgAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
    },
    {
      type = "tilelayer",
      name = "col",
      x = 0,
      y = 0,
      width = 30,
      height = 30,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "base64",
      data = "AgAAAAMAAAACAAAAAwAAAAIAAAADAAAAAgAAAAMAAAACAAAAAwAAAAIAAAADAAAAAgAAAAMAAAACAAAAAwAAAAIAAAADAAAAAgAAAAMAAAACAAAAAwAAAAIAAAADAAAAAgAAAAMAAAACAAAAAwAAAAIAAAADAAAACgAAAAsAAAAKAAAACwAAAAoAAAALAAAACgAAAAsAAAAKAAAACwAAAAoAAAALAAAACgAAAAsAAAAKAAAACwAAAAoAAAALAAAACgAAAAsAAAAKAAAACwAAAAoAAAALAAAACgAAAAsAAAAKAAAACwAAAAoAAAALAAAAAgAAAAMAAAACAAAAAwAAAAIAAAADAAAAAgAAAAMAAAACAAAAAwAAAAIAAAADAAAAAgAAAAMAAAACAAAAAwAAAAIAAAADAAAAAgAAAAMAAAACAAAAAwAAAAIAAAADAAAAAgAAAAMAAAACAAAAAwAAAAIAAAADAAAACgAAAAsAAAAKAAAACwAAAAoAAAALAAAACgAAAAsAAAAKAAAACwAAAAoAAAALAAAACgAAAAsAAAAKAAAACwAAAAoAAAALAAAACgAAAAsAAAAKAAAACwAAAAoAAAALAAAACgAAAAsAAAAKAAAACwAAAAoAAAALAAAAAgAAAAMAAAACAAAAAwAAAAIAAAADAAAAAgAAAAMAAAACAAAAAwAAAAIAAAADAAAAAgAAAAMAAAACAAAAAwAAAAIAAAADAAAAAgAAAAMAAAACAAAAAwAAAAIAAAADAAAAAgAAAAMAAAACAAAAAwAAAAIAAAADAAAACgAAAAsAAAAKAAAACwAAAAoAAAALAAAACgAAAAsAAAAKAAAACwAAAAoAAAALAAAACgAAAAsAAAAKAAAACwAAAAoAAAALAAAACgAAAAsAAAAKAAAACwAAAAoAAAALAAAACgAAAAsAAAAKAAAACwAAAAoAAAALAAAAAgAAAAMAAAACAAAAAwAAAAIAAAADAAAAAgAAAAMAAAACAAAAAwAAAAIAAAADAAAAAgAAAAMAAAACAAAAAwAAAAIAAAADAAAAAgAAAAMAAAACAAAAAwAAAAIAAAADAAAAAgAAAAMAAAACAAAAAwAAAAIAAAADAAAACgAAAAEAAAAEAAAABQAAAAQAAAAFAAAABAAAAAUAAAAEAAAABQAAAAIAAAADAAAAAgAAAAMAAAACAAAAAwAAAAIAAAADAAAAAgAAAAMAAAABAAAABAAAAAUAAAAEAAAABQAAAAQAAAAFAAAABAAAAAUAAAAEAAAgAQAAAAEAAAABAAAAAQAAAAIAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAoAAAALAAAACgAAAAsAAAAKAAAACwAAAAoAAAALAAAACgAAAAsAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAMAAAABAAAAAQAAAAEAAAABAAAABAAAIAUAACAEAAAgBQAAIAoAAAALAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACgAAAAsAAAAEAAAgBQAAIAQAACAEAAAgBQAAIAQAACAFAAAgBAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAFAAAgBAAAIAUAACAFAAAgBAAAIAUAACAEAAAgBQAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAkAAAABAAAACQAAAAAAAAAAAAAAAAAAAAAAAAAJAAAAAQAAAAkAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAgBQAAIAQAACAEAAAgBQAAIAQAACAFAAAgBAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAFAAAgBAAAIAUAACAFAAAgBAAAIAUAACAEAAAgBQAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAgBQAAIAQAACAEAAAgBQAAIAQAACAFAAAgBAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAkAAAABAAAACQAAAAAAAAAAAAAAAAAAAAAAAAAJAAAAAQAAAAkAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAFAAAgBAAAIAUAACAFAAAgBAAAIAUAACAEAAAgBQAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAgBQAAIAQAACAEAAAgBQAAIAQAACAFAAAgBAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAFAAAgBAAAIAUAACAFAAAgBAAAIAUAACAEAAAgBQAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAMAAAADQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAgBQAAIAQAACAEAAAgAQAAAAEAAAAJAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAFAAAABUAAAAFAAAgBAAAIAUAACAFAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAFAAAABUAAAAWAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAHAAAAB0AAAAEAAAgBQAAIAEAAAABAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAHAAAAB0AAAAeAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAIAAAAAAAAAAAAAAAAAAAAAAUAAAAFQAAABYAAAAFAAAgAQAAAAEAAAABAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAUAAAAFQAAABYAAAAUAAAAFQAAABYAAAAAAAAAAAAAAAAAAAAMAAAgDQAAIAwAACAAAAAAAAAAAAAAAAAcAAAAHQAAAB4AAAABAAAAAQAAAAEAAAABAAAACQAAAAkAAAABAAAAAQAAAAwAAAANAAAADAAAAA0AAAAcAAAAHQAAAB4AAAAcAAAAHQAAAB4AAAABAAAAAQAAAAEAAAANAAAgAQAAAA0AACACAAAAAwAAAAIAAAADAAAABAAAAAUAAAACAAAAAwAAAAIAAAADAAAAAQAAAAkAAAABAAAACQAAAAIAAAADAAAAAgAAAAMAAAACAAAAAwAAAAIAAAADAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAAKAAAACwAAAAoAAAALAAAAAgAAAAMAAAAKAAAACwAAAAoAAAALAAAACgAAAAsAAAAKAAAACwAAAAoAAAALAAAACgAAAAsAAAAKAAAACwAAAAoAAAALAAAAAgAAAAMAAAACAAAAAwAAAAIAAAADAAAAAgAAAAMAAAACAAAAAwAAAAIAAAADAAAACgAAAAsAAAACAAAAAwAAAAIAAAADAAAAAgAAAAMAAAACAAAAAwAAAAIAAAADAAAAAgAAAAMAAAACAAAAAwAAAAIAAAADAAAACgAAAAsAAAAKAAAACwAAAAoAAAALAAAACgAAAAsAAAAKAAAACwAAAAoAAAALAAAAAgAAAAMAAAAKAAAACwAAAAoAAAALAAAACgAAAAsAAAAKAAAACwAAAAoAAAALAAAACgAAAAsAAAAKAAAACwAAAAoAAAALAAAACgAAAAsAAAAKAAAACwAAAAoAAAALAAAACgAAAAsAAAAKAAAACwAAAAoAAAALAAAACgAAAAsAAAACAAAAAwAAAAIAAAADAAAAAgAAAAMAAAACAAAAAwAAAAIAAAADAAAAAgAAAAMAAAACAAAAAwAAAAIAAAADAAAAAgAAAAMAAAACAAAAAwAAAAIAAAADAAAAAgAAAAMAAAACAAAAAwAAAAIAAAADAAAAAgAAAAMAAAAKAAAACwAAAAoAAAALAAAACgAAAAsAAAAKAAAACwAAAAoAAAALAAAACgAAAAsAAAAKAAAACwAAAAoAAAALAAAACgAAAAsAAAAKAAAACwAAAAoAAAALAAAACgAAAAsAAAAKAAAACwAAAAoAAAALAAAACgAAAAsAAAACAAAAAwAAAAIAAAADAAAAAgAAAAMAAAACAAAAAwAAAAIAAAADAAAAAgAAAAMAAAACAAAAAwAAAAIAAAADAAAAAgAAAAMAAAACAAAAAwAAAAIAAAADAAAAAgAAAAMAAAACAAAAAwAAAAIAAAADAAAAAgAAAAMAAAAKAAAACwAAAAoAAAALAAAA"
    },
    {
      type = "tilelayer",
      name = "other",
      x = 0,
      y = 0,
      width = 30,
      height = 30,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "base64",
      data = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYAAAAAAAAABgAAAAAAAAAAAAAAAAAAAAAAAAAGAAAAAAAAAAYAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA4AAAAAAAAADgAAAAAAAAAAAAAAAAAAAAAAAAAOAAAAAAAAAA4AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAApAAAAKgAAACsAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAYAAAAAAAAABgAAAAAAAAAxAAAAMgAAADMAAAAGAAAAAAAAAAYAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA4AAAAAAAAADgAAAAAAAAA5AAAAOgAAADsAAAAOAAAAAAAAAA4AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
    },
    {
      type = "objectgroup",
      name = "door",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      objects = {
        {
          id = 53,
          name = "1",
          type = "",
          shape = "rectangle",
          x = 48,
          y = 336,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    }
  }
}
