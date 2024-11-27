package main

import (
	"log"
	"net/http"
	"time"

	"github.com/prometheus/client_golang/prometheus"
	"github.com/prometheus/client_golang/prometheus/promhttp"
)

// 定义监控指标变量
var (
	// HttpRequestCountWithPath 用于记录每个路径的HTTP请求总数
	HttpRequestCountWithPath = prometheus.NewCounterVec(
		prometheus.CounterOpts{
			Name: "http_requests_total_with_path",
			Help: "Number of HTTP requests by path.",
		},
		[]string{"url"},
	)

	// HttpRequestDuration 用于记录HTTP请求的响应时间
	HttpRequestDuration = prometheus.NewHistogramVec(
		prometheus.HistogramOpts{
			Name: "http_request_duration_seconds",
			Help: "Response time of HTTP request.",
		},
		[]string{"path"},
	)

	// orderBooksCounter 用于记录产品订单总数
	orderBooksCounter = prometheus.NewCounter(
		prometheus.CounterOpts{
			Name: "product_order_total",
			Help: "Total number of product",
		},
	)
)

// init 函数在程序初始化时注册监控指标
func init() {
	prometheus.MustRegister(orderBooksCounter)
	prometheus.MustRegister(HttpRequestCountWithPath)
	prometheus.MustRegister(HttpRequestDuration)
}

// main 程序的入口点
func main() {
	// 为 /product 路径设置处理函数
	http.HandleFunc("/product", orderHandler)
	// 为 /metrics 路径设置Prometheus的处理程序
	http.Handle("/metrics", promhttp.Handler())

	// 启动服务器并监听指定端口
	log.Println("Starting server on :8181")
	if err := http.ListenAndServe(":8181", nil); err != nil {
		log.Fatalf("Failed to start server: %v", err)
	}
}

// orderHandler 处理 /product 路径的请求
// 它记录请求路径的计数和响应时间，并增加订单计数器
func orderHandler(w http.ResponseWriter, r *http.Request) {
	// 记录请求开始时间
	start := time.Now()
	defer func() {
		// 计算请求持续时间并记录到监控指标中
		duration := time.Since(start)
		HttpRequestDuration.WithLabelValues(r.URL.Path).Observe(duration.Seconds())
	}()

	// 检查请求路径是否为空，如果为空则返回错误
	if r.URL.Path == "" {
		http.Error(w, "Invalid path", http.StatusBadRequest)
		return
	}

	// 增加订单计数器和请求路径计数器
	orderBooksCounter.Inc()
	HttpRequestCountWithPath.WithLabelValues(r.URL.Path).Inc()

	// 写入响应
	if _, err := w.Write([]byte("Order placed!")); err != nil {
		log.Printf("Failed to write response: %v", err)
	}
}
