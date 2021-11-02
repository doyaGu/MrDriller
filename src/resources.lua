local resources = cargo.init('res')()

function initPlayerAnimation()
  local g = anim8.newGrid(CHARACTER_WIDTH, CHARACTER_HEIGHT, resources.images['player']:getWidth(), resources.images['player']:getHeight(), 0, 0, 4)
  return {
    ['idle'] = anim8.newAnimation(g(1,7), 1),
    ['angel'] = anim8.newAnimation(g('1-4',1), 0.2),
    ['falling'] = anim8.newAnimation(g('1-2',2), 0.2),
    ['climb'] = {
      ['left'] = anim8.newAnimation(g('1-8',3), 0.1),
      ['right'] = anim8.newAnimation(g('1-8',4), 0.1)
    },
    ['air'] = {
      ['left'] = anim8.newAnimation(g('1-8',5), 0.2),
      ['right'] = anim8.newAnimation(g('1-8',6), 0.2)
    },
    ['drill'] = {
      ['down'] = anim8.newAnimation(g('1-8',7), 0.1),
      ['left'] = anim8.newAnimation(g('1-8',8), 0.1),
      ['right'] = anim8.newAnimation(g('1-8',9), 0.1),
      ['up'] = anim8.newAnimation(g('1-8',10), 0.1)
    },
    ['revive'] = anim8.newAnimation(g('1-3',11), 0.4),
    ['crushed'] = {
      ['left'] = anim8.newAnimation(g('1-3',12), 0.6),
      ['right'] = anim8.newAnimation(g('1-3',13), 0.6)
    },
    ['dodge_back_left'] = anim8.newAnimation(g('1-3',14), 0.3),
    ['dodge_back_right'] = anim8.newAnimation(g('1-3',15), 0.3),
    ['dodge_front_left'] = anim8.newAnimation(g('1-3',16), 0.3),
    ['dodge_front_right'] = anim8.newAnimation(g('1-3',17), 0.3),
    ['drill_while_walking'] = {
      ['left'] = anim8.newAnimation(g('1-8',18), 0.1),
      ['right'] = anim8.newAnimation(g('1-8',19), 0.1)
    },
    ['walking'] = {
      ['left'] = anim8.newAnimation(g('1-8',20), 0.1),
      ['right'] = anim8.newAnimation(g('1-8',21), 0.1)
    },
    ['goal'] = anim8.newAnimation(g('1-8',22), 0.1)
  }
end

function initBlockAnimation()
  local g = anim8.newGrid(BLOCK_SIZE, BLOCK_SIZE, resources.images['block']:getWidth(), resources.images['block']:getHeight())
  return {
    [BLOCK_ID.BLUE] = {
      {
        anim8.newAnimation(g(1,1), 1),
        anim8.newAnimation(g('20-22',1), 0.1)
      },
      {
        anim8.newAnimation(g(1,2), 1),
        anim8.newAnimation(g('20-22',2), 0.1)
      },
      {
        anim8.newAnimation(g(1,3), 1),
        anim8.newAnimation(g('20-22',3), 0.1)
      },
      {
        anim8.newAnimation(g(1,4), 1),
        anim8.newAnimation(g('20-22',4), 0.1)
      },
      {
        anim8.newAnimation(g(1,5), 1),
        anim8.newAnimation(g('20-22',5), 0.1)
      }
    },
    [BLOCK_ID.GREEN] = {
      {
        anim8.newAnimation(g(1,6), 1),
        anim8.newAnimation(g('20-22',6), 0.1)
      },
      {
        anim8.newAnimation(g(1,7), 1),
        anim8.newAnimation(g('20-22',7), 0.1)
      },
      {
        anim8.newAnimation(g(1,8), 1),
        anim8.newAnimation(g('20-22',8), 0.1)
      },
      {
        anim8.newAnimation(g(1,9), 1),
        anim8.newAnimation(g('20-22',9), 0.1)
      },
      {
        anim8.newAnimation(g(1,10), 1),
        anim8.newAnimation(g('20-22',10), 0.1)
      }
    },
    [BLOCK_ID.RED] = {
      {
        anim8.newAnimation(g(1,11), 1),
        anim8.newAnimation(g('20-22',11), 0.1)
      },
      {
        anim8.newAnimation(g(1,12), 1),
        anim8.newAnimation(g('20-22',12), 0.1)
      },
      {
        anim8.newAnimation(g(1,13), 1),
        anim8.newAnimation(g('20-22',13), 0.1)
      },
      {
        anim8.newAnimation(g(1,14), 1),
        anim8.newAnimation(g('20-22',14), 0.1)
      },
      {
        anim8.newAnimation(g(1,15), 1),
        anim8.newAnimation(g('20-22',15), 0.1)
      }
    },
    [BLOCK_ID.YELLOW] = {
      {
        anim8.newAnimation(g(1,16), 1),
        anim8.newAnimation(g('20-22',16), 0.1)
      },
      {
        anim8.newAnimation(g(1,17), 1),
        anim8.newAnimation(g('20-22',17), 0.1)
      },
      {
        anim8.newAnimation(g(1,18), 1),
        anim8.newAnimation(g('20-22',18), 0.1)
      },
      {
        anim8.newAnimation(g(1,19), 1),
        anim8.newAnimation(g('20-22',19), 0.1)
      },
      {
        anim8.newAnimation(g(1,20), 1),
        anim8.newAnimation(g('20-22',20), 0.1)
      }
    },
    [BLOCK_ID.BROWN] = {
      {
        anim8.newAnimation(g(12,21), 1),
        anim8.newAnimation(g(13,21), 1),
        anim8.newAnimation(g(14,21), 1),
        anim8.newAnimation(g(15,21), 1),
        anim8.newAnimation(g(16,21), 1),
        anim8.newAnimation(g('17-19',21), 0.1)
      }
    },
    [BLOCK_ID.WHITH] = {
      {
        anim8.newAnimation(g(1,22), 1),
        anim8.newAnimation(g(2,22), 1),
        anim8.newAnimation(g(3,22), 1),
        anim8.newAnimation(g(4,22), 1),
        anim8.newAnimation(g(5,22), 1),
        anim8.newAnimation(g('17-19',21), 0.1)
      }
    },
    [BLOCK_ID.CRYSTAL] = {
      {
        anim8.newAnimation(g(5,21), 1),
        anim8.newAnimation(g('6-10',21), 0.1)
      }
    },
    [BLOCK_ID.AIR] = {
      {
        anim8.newAnimation(g('1-4',21), 1)
      }
    },
    [BLOCK_ID.FLOOR] = {
      {
        -- anim8.newAnimation(g(6,22), 1),
        -- anim8.newAnimation(g(7,22), 1),
        -- anim8.newAnimation(g(8,22), 1),
        -- anim8.newAnimation(g(10,22), 1),
        -- anim8.newAnimation(g(11,22), 1),
        -- anim8.newAnimation(g(12,22), 1),
        -- anim8.newAnimation(g(14,22), 1),
        -- anim8.newAnimation(g(15,22), 1),
        anim8.newAnimation(g(16,22), 1),
        anim8.newAnimation(g('17-19',21), 0.1)
      }
    }
  }
end

resources.animations = {
  ['player'] = initPlayerAnimation(),
  ['block'] = initBlockAnimation()
}

return resources
