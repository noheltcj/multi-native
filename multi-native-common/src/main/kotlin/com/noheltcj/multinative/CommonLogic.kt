package com.noheltcj.multinative

class CommonLogic(private val outputAdapter: OutputAdapter) {
  fun helloNative() {
    outputAdapter.output("Hello Native")
  }
}