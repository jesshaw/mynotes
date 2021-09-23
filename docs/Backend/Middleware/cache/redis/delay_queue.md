# 延时队列redis方式实现

[Redisson与继承自Java队列的实现](https://redisson.org/glossary/java-queue.html)

[Redisson延时队列单元测试源码](https://github.com/redisson/redisson/blob/redisson-3.16.2/redisson/src/test/java/org/redisson/RedissonDelayedQueueTest.java)

[Redisson延时队列中文文档](https://github.com/redisson/redisson/wiki/7.-%E5%88%86%E5%B8%83%E5%BC%8F%E9%9B%86%E5%90%88#715-%E5%BB%B6%E8%BF%9F%E9%98%9F%E5%88%97delayed-queue)

[有赞延迟队列设计英文版](https://developpaper.com/an-introduction-to-the-implementation-of-delay-queue-in-redis/)

[有赞延迟队列设计中文版](https://tech.youzan.com/queuing_delay/)

[阿里一种低延迟的超时中心实现方式](https://mp.weixin.qq.com/s/RqErpEqwyT6T15ONtkmQVA)

[基于redisson实现延迟队列中文版](https://blog.csdn.net/qq_38721537/article/details/116976009)

[基于redisson实现延迟队列英文版](https://www.fatalerrors.org/a/delayed-queue-implementation-based-on-redisson.html)

[基于redisson的延迟队列](https://www.cnblogs.com/markytsai/p/13800743.html)

[基于Redis实现DelayQueue延迟队列设计方案](https://blog.csdn.net/u010634066/article/details/98864764)


`package cc.mynatapp.detroitdentist.current; import com.google.common.util.concurrent.ThreadFactoryBuilder; import java.util.concurrent.*; /** * @author Xu hao * @Description ThreadFactory的使用 * @Version 1.0 * Email 15229357319@sina.cn * create on 2019/4/15 */ public class UseThreadFactory { private static ThreadFactory namedFactory = new ThreadFactoryBuilder().setNameFormat("线程-demo-%d").build(); private static ThreadPoolExecutor pool = new ThreadPoolExecutor(2, 4, 60, TimeUnit.SECONDS, new ArrayBlockingQueue<>(10), namedFactory, new ThreadPoolExecutor.AbortPolicy()); public static void main(String[] args) { for (int i = 1; i <= 14; i++) { Callable<Boolean> task = createTask(i); pool.submit(task); System.out.println("after task:" + i + " submitted, current active count: " + pool.getActiveCount() + ", size of queue: " + pool.getQueue().size()); } pool.shutdown(); } /** * @Author Xu hao * @Description 创建任务 * @Date 2019/3/19 0:08 * @param i * @return java.util.concurrent.Callable<java.lang.Boolean> **/ private static Callable<Boolean> createTask(int i){ Callable<Boolean> callable = () -> { TimeUnit.SECONDS.sleep(10); System.out.println("thread: " + Thread.currentThread().getName() + " execute task: " + i); return true; }; return callable; } }`