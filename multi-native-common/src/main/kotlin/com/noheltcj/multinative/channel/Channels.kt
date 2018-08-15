package com.noheltcj.multinative.channel

fun <S1, S2, R> Channel<S1>.combineLatest(otherSource: Channel<S2>, transform: (S1, S2) -> R): Channel<R> {
  return Transformation.Aggregate(this, otherSource, Channel.AggregationMode.CombineLatest, transform)
}