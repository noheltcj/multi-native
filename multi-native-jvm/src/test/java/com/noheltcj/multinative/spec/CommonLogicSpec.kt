package com.noheltcj.multinative.spec

import com.noheltcj.multinative.CommonLogic
import com.greghaskins.spectrum.Spectrum
import com.greghaskins.spectrum.Spectrum.*
import com.nhaarman.mockito_kotlin.then
import com.noheltcj.multinative.OutputAdapter
import org.junit.runner.RunWith
import org.mockito.Mock
import org.mockito.MockitoAnnotations

@RunWith(Spectrum::class)
class CommonLogicSpec {
  @Mock private lateinit var mockOutputAdapter: OutputAdapter

  lateinit var logic: CommonLogic

  init {
    describe("CommonLogic") {
      beforeEach {
        MockitoAnnotations.initMocks(this)

        logic = CommonLogic(outputAdapter = mockOutputAdapter)
      }

      describe("#helloNative") {
        it("outputs the correct value") {
          logic.helloNative()

          then(mockOutputAdapter).should().output("Hello Native")
        }
      }
    }
  }
}