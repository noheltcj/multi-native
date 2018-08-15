package com.noheltcj.multinative.channel

interface Channel<Element> {
  fun subscribe(operation : (Element) -> Unit) : Subscription<Element>
  fun unsubscribe(subscription: Subscription<Element>)

  fun <Transformed> map(transformation: (Element) -> Transformed) : Channel<Transformed>
  fun <Transformed, OtherElement> aggregate(otherSource: Channel<OtherElement>,
                                            aggregationMode: AggregationMode,
                                            transform: (Element, OtherElement) -> Transformed): Channel<Transformed>

  enum class AggregationMode {
    CombineLatest /** http://reactivex.io/documentation/operators/combinelatest.html */
  }
}