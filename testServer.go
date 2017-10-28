package main
 
import (
	    "net/http"
		"fmt"
		"time"
	   )
 
func main() {
	http.Handle("/", new(testHandler))
    fmt.Println("start")					 
	http.ListenAndServe(":5000", nil)
}
 
type testHandler struct {
		    http.Handler
}
 
func (h *testHandler) ServeHTTP(w http.ResponseWriter, req *http.Request) {
	str := "Server Running"
	time.Sleep(3 * time.Second)
	w.Write([]byte(str))
}
