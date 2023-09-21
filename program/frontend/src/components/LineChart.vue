
 <template>
  <div ref="chartDom" style="width: 100%; height: 400px;"></div>
</template>

<script lang="ts">
import { ref, onMounted, watch } from 'vue'
import * as echarts from 'echarts/core'
import { LineChart } from 'echarts/charts'
import {
  GridComponent,
  TooltipComponent,
  ToolboxComponent,
  MarkLineComponent // 导入 MarkLineComponent
} from 'echarts/components'
import { CanvasRenderer } from 'echarts/renderers'

import { groupBy } from 'lodash-es' // 导入 groupBy 函数

echarts.use([LineChart, GridComponent, TooltipComponent, ToolboxComponent, CanvasRenderer, MarkLineComponent]) // 加入 MarkLineComponent

export default {
  props: {
    data: {
      type: Array,
      required: true
    }
  },
  setup(props) {
    const chartDom = ref(null)
    const chartInstance = ref<echarts.ECharts | null>(null)

    // 创建 groupDataByDate 函数，对相同日期的数据进行聚合，并计算平均价格
    const groupDataByDate = () => {
      const groupedData: { com_pc_time: string; avgPrice: number }[] = []

      const groupedByDate = groupBy(props.data, 'com_pc_time')

      for (const date in groupedByDate) {
        const prices = groupedByDate[date].map(item => item.com_pc_price)
        const avgPrice = prices.reduce((sum, price) => sum + price, 0) / prices.length
        groupedData.push({
          com_pc_time: date,
          avgPrice
        })
      }

      return groupedData
    }

    const option = {
      title: {
        text: '价格曲线折线图'
      },
      tooltip: {
        trigger: 'axis'
      },
      grid: {
        left: '3%',
        right: '4%',
        bottom: '3%',
        containLabel: true
      },
      toolbox: {
        feature: {
          saveAsImage: {}
        }
      },
      xAxis: {
        type: 'category',
        data: groupDataByDate().map(item => item.com_pc_time) // 使用 groupDataByDate 函数的结果
      },
      yAxis: {
        type: 'value'
      },
      series: [
        {
          name: '价格',
          type: 'line',
          step: 'middle', // 这里设置为 'middle'，表示在数据点之间绘制水平横线的折线图
          data: groupDataByDate().map(item => item.avgPrice) // 使用 groupDataByDate 函数的结果
        }
      ],
      markLine: {
        symbol: 'none', // 去掉标记点
        label: {
          position: 'middle', // 标签的位置
          fontSize: 14
        },
        lineStyle: {
          color: '#999',
          type: 'dashed'
        },
        data: groupDataByDate()
          .filter((item, index, array) => {
            // 根据相邻数据是否相等，筛选出需要添加水平线的日期
            if (index === 0) {
              return item.avgPrice === array[index + 1].avgPrice
            } else if (index === array.length - 1) {
              return item.avgPrice === array[index - 1].avgPrice
            } else {
              return item.avgPrice === array[index - 1].avgPrice || item.avgPrice === array[index + 1].avgPrice
            }
          })
          .map(item => {
            return {
              name: item.com_pc_time,
              yAxis: item.avgPrice
            }
          })
      }
    }

    onMounted(() => {
      if (chartDom.value) {
        chartInstance.value = echarts.init(chartDom.value)
        chartInstance.value.setOption(option)
      }
    })

    watch(props.data, (newData) => {
      if (chartInstance.value) {
        const newOption = {
          xAxis: {
            data: groupDataByDate().map(item => item.com_pc_time) // 使用 groupDataByDate 函数的结果
          },
          series: [
            {
              step: 'middle', // 这里设置为 'middle'，表示在数据点之间绘制水平横线的折线图
              data: groupDataByDate().map(item => item.avgPrice) // 使用 groupDataByDate 函数的结果
            }
          ],
          markLine: {
            data: groupDataByDate()
              .filter((item, index, array) => {
                if (index === 0) {
                  return item.avgPrice === array[index + 1].avgPrice
                } else if (index === array.length - 1) {
                  return item.avgPrice === array[index - 1].avgPrice
                } else {
                  return item.avgPrice === array[index - 1].avgPrice || item.avgPrice === array[index + 1].avgPrice
                }
              })
              .map(item => {
                return {
                  name: item.com_pc_time,
                  yAxis: item.avgPrice
                }
              })
          }
        }
        chartInstance.value.setOption(newOption)
      }
    })

    return {
      chartDom
    }
  }
}
</script>

