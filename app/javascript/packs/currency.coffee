class CurrencyHistory
  @GRAPHQL_QUERY: 'query currencies($publishedAtFrom: ISO8601DateTime,
                           $publishedAtTo: ISO8601DateTime) {
                             currencies(publishedAtFrom: $publishedAtFrom,
                                        publishedAtTo: $publishedAtTo) {
                                          base
                                          publishedAt
                                          foreignRates { currency rate }
                             }
                            }'

  @render: (data) =>
    $('#history_body').empty()
    currencies = data['currencies']
    highchart_data = @normalized_highchart_data(currencies)
    @build_highcharts(highchart_data)

  @normalized_highchart_data: (currencies) =>
    highchart_data = {}
    for currency in currencies
      highchart_item = @upsert_higchart_item(highchart_data, currency.base)
      highchart_item['categories'].push(currency.publishedAt)

      for foreign_rate in currency.foreignRates
        series = @upsert_highchart_series(highchart_item, foreign_rate.currency)
        series.push(foreign_rate.rate)

    highchart_data

  @upsert_higchart_item: (highchart_data, base) =>
      if not highchart_data["#{base}"]?
        highchart_data["#{base}"] = { 'categories': [], 'series': {} }
      highchart_data["#{base}"]

  @upsert_highchart_series: (highchart_item, currency) =>
      series = highchart_item['series']
      if not series["#{currency}"]?
        series["#{currency}"] = []
      series["#{currency}"]

  @build_highcharts: (highchart_data) ->
    for base, highchart_item of highchart_data
      chart_id = "currency_history_#{base}"
      $('#history_body').append("<div id=\"#{chart_id}\">")
      Highcharts.chart(chart_id,
        title: { text: 'Currency History' },
        xAxis: { categories: highchart_item['categories'] },
        yAxis: { title: { text: base } },
        series: do ->
            for currency, series of highchart_item.series
              { name: currency, data: series }
      )

$(document).ready ->
  $('#currency_history').find('#query').val(CurrencyHistory.GRAPHQL_QUERY)

  $('#currency_publishedAtFrom').change ->
    new_date = event.target.value
    $('#variables_publishedAtFrom').val(new_date)

  $('#currency_publishedAtTo').change ->
    new_date = event.target.value
    $('#variables_publishedAtTo').val(new_date)

  $('#currency_history').on 'ajax:success', (event) ->
    [data, status, xhr] = event.detail
    CurrencyHistory.render(data['data'])
