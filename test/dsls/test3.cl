conversation test3 {
  type obj {
  }
  type control {
  }
  type sync {
    String control
  }
  type stop {
    String obj
  }
  agent obj concerning obj {
    privately receives signal: sync
    receives stop: stop
    sends sync: sync

    initially receives signal -> running > sync {
      terminated {
      }
      running {
        stop [ stop.obj ] -> terminated
        signal -> terminated
      }
    }
  }
  agent control concerning control {
    privately receives stop: stop

    initially receives obj.sync [ sync.control ] -> controlling {
      controlling {
        stop -> ^end > obj.stop
      }
      ^end {
      }
    }
  }
}
