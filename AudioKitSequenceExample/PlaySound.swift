//
//  PlaySound.swift
//  AudioKitSequenceExample
//
//  Created by Daisaku Ejiri on 2022/12/03.
//

import Foundation
import AudioKit

class PlaySound {
  
  public static let shared = PlaySound()
  
  private init() {
    setup()
  }
  
  var guitarSampler = MIDISampler(name: "guitar")
  var mainSequencer = AppleSequencer()
  var mixer = Mixer()
  var engine = AudioEngine()
  var callbackInstrument = MIDICallbackInstrument()
  
  private func setup() {
    loadSF2(name: soundFonts[1], bank: 17, preset: 27, sampler: guitarSampler)
    
    if mainSequencer.trackCount < 1 {
      let _ = mainSequencer.newTrack("guitarTrack")
    }

    mixer.addInput(guitarSampler)
    engine.output = mixer
    do {
      try engine.start()
    } catch {
      print("error starting the engine: \(error)")
    }
  }
  
  func loadSF2(name: String, bank: Int, preset: Int, sampler: MIDISampler) {
    do {
      try sampler.loadSoundFont(name, preset: preset, bank: bank)
    } catch {
      print("can not load soundfont \(name) with error: \(error)")
    }
  }
  
  public func loadSequence() {
    var time = 0.0
    mainSequencer.setTime(0.0)
    let guitarTrackManager = mainSequencer.tracks[0]
    guitarTrackManager.clearRange(start: Duration(beats: time), duration: Duration(beats: 200))
    guitarTrackManager.add(noteNumber: 50, velocity: 127, position: Duration(beats: time), duration: Duration(beats: 0.5))
    time += 0.5
    guitarTrackManager.add(noteNumber: 52, velocity: 127, position: Duration(beats: time), duration: Duration(beats: 1))
    guitarTrackManager.setMIDIOutput(guitarSampler.midiIn)
    
  }
  
  public func play() {
    loadSequence()
    mainSequencer.stop()
    mainSequencer.setTempo(60)
    mainSequencer.play()
  }
  
  public func toggleLoop() {
    if mainSequencer.loopEnabled {
      mainSequencer.disableLooping()
    } else {
      mainSequencer.enableLooping()
    }
  }
  
  private let soundFonts: [String] = [
    "Nice-Steinway-Lite-v3.0",
    "FS-Telecaster-I5-HedSound",
  ]
}
