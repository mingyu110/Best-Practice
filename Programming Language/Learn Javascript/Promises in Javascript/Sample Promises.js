// 1. 定义常量`cart`为一个数组,其中包含商品名称"shores","shirt","pant"
const cart = ["shoes","shirt","pant"];

//调用`createOrder`函数，传入`cart`作为参数，并对返回的Promise进行链式处理：
// - 使用`.then()`方法指定当Promise成功解决时的回调函数，该函数接收一个参数`orderId`，将其打印到控制台；
// - 使用`.catch()`方法指定当Promise被拒绝时的回调函数，该函数接收一个参数`err`，打印其`message`属性（即错误信息）到控制台。
createOrder(cart)
    .then(orderId=>{
        console.log(orderId);
    })
    .catch(err=>console.log(err.message));
// 定义名为`validateCart`的函数，接受一个参数`cart`（表示购物车中的商品列表）
// 返回一个布尔值，表示购物车是否有效
function validateCart(cart) {
    // 示例验证规则：购物车中至少包含一件商品
    return cart.length > 0;
}

function createOrder(cart) {
    return new Promise((resolve, reject) => {
        // 验证购物车有效性
        if (validateCart(cart)) {
            setTimeout(() => {
                // 订单ID生成逻辑，确保其唯一性，例如使用时间戳与随机数结合
                const orderId = `${Date.now()}-${Math.floor(Math.random() * 100000)}`;
                resolve(orderId);
            }, 1000);
        } else {
            // 如果购物车无效，则拒绝Promise并传递错误信息
            reject(new Error("Invalid cart: No items in the cart"));
        }
    });
}
