conversation test6 {
  type aThing {
    val contract contract
  }
  type bThing {
    val contract contract
  }
  type contract {
    String aId
    String bId
    String id
  }
  infinite agent a concerning aThing {
    privately receives start: contract
    privately receives accept: contract
    privately receives stop: contract
    sends stopped: contract
    sends starting: contract
    sends accepted: contract

    initially becomes stopped {
      stopped {
        receives start becomes starting sends starting
      }
      started {
        receives contract.stopped [contract.aId] becomes stopped
        receives stop becomes stopped sends stopped
      }
      while in starting {
        receives contract.started [contract.aId] becomes started
        receives contract.stopped [contract.aId] becomes stopped
        receives accept becomes starting sends accepted
        receives stop becomes stopped sends stopped
      }
    }
  }
  agent contract concerning contract {
    sends started: contract
    sends stopped: contract
    sends starting: contract
    privately receives start: contract
    privately receives stop: contract
    initially receives a.starting [ contract.id ] becomes starting sends starting {
      while in custom starting waits for a.accepted and b.accepted {
        receives a.accepted [ contract.id ] becomes starting
        receives b.accepted [ contract.id ] becomes starting
        receives a.stopped [ contract.id ] becomes stopped sends stopped
        receives start becomes staged
      }
      custom staged {
        receives start becomes started sends started
        receives stop becomes stopped sends stopped
        //these must be here to catch out of sync stops
        receives a.stopped [ contract.id ] becomes stopped sends stopped
        receives b.stopped [ contract.id ] becomes stopped sends stopped
      }
      started {
        receives a.stopped [ contract.id ] becomes stopped sends stopped
        receives b.stopped [ contract.id ] becomes stopped sends stopped
      }
      stopped {
      }
    }
  }
  infinite agent b concerning bThing {
    privately receives accept: contract
    privately receives stop: contract
    sends stopped: contract
    sends accepted: contract
    initially becomes stopped {
      stopped {
        receives contract.starting [contract.bId] becomes starting
      }
      started {
        receives contract.stopped [contract.bId] becomes stopped
        receives stop becomes stopped sends stopped
      }
      starting {
        receives contract.started [contract.bId] becomes started
        receives contract.stopped [contract.bId] becomes stopped
        receives accept becomes starting sends accepted
        receives stop becomes stopped sends stopped
      }
    }
  }
}