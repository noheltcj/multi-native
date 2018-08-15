package com.noheltcj.multinative.channel

sealed class Transformation<E, U>(protected val upChannel: Channel<U>) : Channel<E> {
  protected val activeSubscriptions = mutableListOf<Subscription<E>>()
  protected var upstreamDisposable: Disposable? = null

  override fun subscribe(operation: (E) -> Unit): Subscription<E> {
    return Subscription(this, operation)
        .also { activeSubscriptions.add(it) }
  }

  override fun unsubscribe(subscription: Subscription<E>) {
    upstreamDisposable?.dispose()
    activeSubscriptions.remove(subscription)
  }

  override fun <T> map(transformation: (E) -> T): Channel<T> {
    return Map(this, transformation)
  }

  override fun <T, O> aggregate(otherSource: Channel<O>, aggregationMode: Channel.AggregationMode, transform: (E, O) -> T): Channel<T> {
    return Aggregate(this, otherSource, aggregationMode, transform)
  }

  class Map<E, R>(upChannel: Channel<E>, private val mapTransform: (E) -> R): Transformation<R, E>(upChannel) {
    override fun subscribe(operation: (R) -> Unit): Subscription<R> {
      upstreamDisposable = upChannel.subscribe {
        operation(mapTransform(it))
      }
      return super.subscribe(operation)
    }
  }

  class Aggregate<S1, S2, R>(
      private val sourceOne: Channel<S1>,
      private val sourceTwo: Channel<S2>,
      private val aggregationMode: Channel.AggregationMode,
      private inline val transform: (S1, S2) -> R
  ) : Transformation<R, S1>(sourceOne) {

    private val compositeDisposeBag = CompositeDisposeBag()
    private var sourceOneLastElement: S1? = null
    private var sourceTwoLastElement: S2? = null

    override fun subscribe(operation: (R) -> Unit): Subscription<R> {
      when (aggregationMode) {
        Channel.AggregationMode.CombineLatest -> {
          compositeDisposeBag.add(sourceOne.subscribe {
            sourceOneLastElement = it
            sourceTwoLastElement?.run { operation(transform(it, this)) }
          })
          compositeDisposeBag.add(sourceTwo.subscribe {
            sourceTwoLastElement = it
            sourceOneLastElement?.run { operation(transform(this, it)) }
          })
        }
      }

      return super.subscribe(operation)
    }

    override fun unsubscribe(subscription: Subscription<R>) {
      compositeDisposeBag.dispose()
      activeSubscriptions.remove(subscription)
    }
  }
}