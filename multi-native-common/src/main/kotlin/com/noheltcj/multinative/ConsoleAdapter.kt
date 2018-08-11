package com.noheltcj.multinative

class ConsoleAdapter : OutputAdapter {
  override fun output(value: String) {
    println(value)
  }
}