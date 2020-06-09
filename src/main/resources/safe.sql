/*
 Navicat Premium Data Transfer

 Source Server         : aaa
 Source Server Type    : MySQL
 Source Server Version : 80019
 Source Host           : localhost:3306
 Source Schema         : safe

 Target Server Type    : MySQL
 Target Server Version : 80019
 File Encoding         : 65001

 Date: 04/05/2020 15:27:16
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for t_answer
-- ----------------------------
DROP TABLE IF EXISTS `t_answer`;
CREATE TABLE `t_answer`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `answeruser` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `pubtime2` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `topicId` int(0) NOT NULL,
  `state2` int(0) NULL DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FKC06B980D29D8874D`(`topicId`) USING BTREE,
  CONSTRAINT `FKC06B980D29D8874D` FOREIGN KEY (`topicId`) REFERENCES `t_topic` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_answer
-- ----------------------------
INSERT INTO `t_answer` VALUES (4, '<p>先看黑马，尚硅谷的全套java视频来学习，这样可以更好地入门</p>\r\n', 'qianqi', '2019-06-28', 14, 2);

-- ----------------------------
-- Table structure for t_news
-- ----------------------------
DROP TABLE IF EXISTS `t_news`;
CREATE TABLE `t_news`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `article` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `time` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 65 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_news
-- ----------------------------
INSERT INTO `t_news` VALUES (60, '进程与线程', '<h3><strong>1 多进程的组织形式包括下面3个关键部分：</strong></h3>\r\n\r\n<p>1）<a href=\"https://www.liaoxuefeng.com/\" target=\"_blank\">PCB</a>（Process Control Block）:用来记录进程信息的数据结构（管理进程的核心，包含了PID等进程的所有关键信息）https://blog.csdn.net/rongwenbin/article/details/9860253</p>\r\n\r\n<p>2）进程的状态：1：就绪状态，2：执行状态，3：阻塞状态（多线程时也是这些状态）</p>\r\n\r\n<p>3）队列：就绪队列、等待（阻塞）队列。</p>\r\n\r\n<p>&nbsp;<img alt=\"\" src=\"https://images2018.cnblogs.com/blog/1169376/201807/1169376-20180710220802379-2085911867.png\" /></p>\r\n\r\n<p>处于就绪状态的进程，在调度程序为之分配了处理机之后便开始执行， 就绪 -&gt; 执行</p>\r\n\r\n<p>正在执行的进程如果因为分配他的时间片已经用完，而被剥夺处理剂， 执行 -&gt; 就绪</p>\r\n\r\n<p>如果因为某种原因致使当前的进程执行受阻，使之不能执行。 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 执行 -&gt; 阻塞</p>\r\n\r\n<h3>2 CPU调度算法&nbsp; （在就绪序列中怎么挑选进程让CPU执行）</h3>\r\n\r\n<p>先了解两个概念：</p>\r\n\r\n<ul>\r\n	<li>周转时间： 从开始申请执行任务，到执行任务完成</li>\r\n	<li>响应时间： 从开始申请执行任务到开始执行任务</li>\r\n</ul>\r\n\r\n<p><strong>先来先服务调度算法FCFS：</strong>按作业或者进程到达的先后顺序依次调度；（平均周转时间可能会很长&nbsp;）</p>\r\n\r\n<p><strong>短作业优先调度算法SJF：</strong>算法从就绪队列中选择估计时间最短的作业进行处理，直到得出结果或者无法继续执行（周转时间短，但是响应时间长&nbsp;）</p>\r\n\r\n<p><strong>高相应比算法HRN：</strong>响应比=(等待时间+要求服务时间)/要求服务时间；</p>\r\n\r\n<p><strong>时间片轮转调度RR：</strong>按到达的先后对进程放入队列中，然后给队首进程分配CPU时间片，时间片用完之后计时器发出中断，暂停当前进程并将其放到队列尾部，循环 ;（响应时间可以得到保证）</p>\r\n\r\n<p><strong>多级反馈队列调度算法：</strong>目前公认较好的调度算法；设置多个就绪队列并为每个队列设置不同的优先级，第一个队列优先级最高，其余依次递减。优先级越高的队列分配的时间片越短，进程到达之后按FCFS放入第一个队列，如果调度执行后没有完成，那么放到第二个队列尾部等待调度，如果第二次调度仍然没有完成，放入第三队列尾部&hellip;。只有当前一个队列为空的时候才会去调度下一个队列的进程。</p>\r\n\r\n<h3>3 进程的分类</h3>\r\n\r\n<p><strong>https://www.cnblogs.com/xdyixia/p/9257160.html</strong></p>\r\n\r\n<h3><strong>4 线程</strong></h3>\r\n\r\n<p>线程有自己的TCB（thread control block线程控制块）, 只负责这条流程的信息，包括PC程序计数器，SP栈，State状态，和寄存器，线程id。</p>\r\n\r\n<p>线程有内核级线程和用户级线程，我们一般说的都是用户级线程，内核级线程由内核管理。</p>\r\n\r\n<p>补充小知识：</p>\r\n\r\n<p>1）只有内核级线程才能发挥多核性能，因为内核级线程共用一套MMU（即内存映射表），统一分配核1核2（即有多个CPU，可以一个CPU执行一个内核级线程）。进程 无法发挥多核性能，因为进程切换都得切MMU</p>\r\n\r\n<p>2）为什么需要内核级线程？？如果只有用户级线程，在内核中只能看到进程，所以当用户级线程中一个线程进行IO读写阻塞时，内核会将该线程所在的进程直接切换。例如当用浏览器打开网页，这个进程中有下载数据线程，有显示数据线程，当数据下载读写阻塞时，内核直接切到qq（这些切换是指在CPU上运行的程序的切换）</p>\r\n\r\n<p><strong><img alt=\"\" src=\"https://images2018.cnblogs.com/blog/1169376/201807/1169376-20180710225112142-685579294.png\" /></strong></p>\r\n\r\n<h3><strong>5 进程和线程的对比</strong></h3>\r\n\r\n<p><strong>进程是系统进行资源调度和分配的基本单位；线程是CPU调度的基本单位。</strong></p>\r\n\r\n<p>进程 = 资源 （包括寄存器值，PCB，内存映射表）+ TCB（栈结构）<br />\r\n线程 =&nbsp;TCB（栈结构）</p>\r\n\r\n<p>线程 的资源是共享的<br />\r\n进程 间的资源是分隔独立的，内存映射表不同，占用物理内存地址是分隔的</p>\r\n\r\n<p>线程 的切换只是切换PC，切换了TCB（栈结构）<br />\r\n进程 的切换不仅要切换PC，还包括切换资源，即切换内存映射表</p>\r\n\r\n<h3>6 进程间通信方式</h3>\r\n\r\n<p><strong>https://www.cnblogs.com/xdyixia/p/9257668.html</strong></p>\r\n\r\n<h3>7 进程间同步</h3>\r\n\r\n<p>经典的进程同步问题：生产者-消费者问题；哲学家进餐问题；读者-写者问题</p>\r\n\r\n<p>同步的解决方案：管程，信号量。</p>\r\n\r\n<p><strong>死锁定义：</strong></p>\r\n\r\n<p>　　在两个或多个并发进程中，如果每个进程持有某种资源而又都等待别的进程释放它或它们现在保持着的资源，在未改变这种状态之前都不能向前推进，称这一组进程产生了死锁。通俗地讲，就是两个或多个进程被无限期地阻塞、相互等待的一种状态。</p>\r\n\r\n<p><strong>产生条件：</strong></p>\r\n\r\n<p>　　1：互斥条件 &nbsp; &nbsp; &nbsp; &nbsp;-- 一个资源一次只能被一个进程使用</p>\r\n\r\n<p>&nbsp; &nbsp; 　2：请求保持条件 -- 一个进程因请求资源而阻塞时，对已经获得资源保持不放&nbsp;</p>\r\n\r\n<p>　　3：不可抢占条件 --&nbsp;进程已获得的资源在未使用完之前不能强行剥夺</p>\r\n\r\n<p>　　4：循环等待条件 -- 若干进程之间形成一种头尾相接的循环等待资源的关系&nbsp;</p>\r\n\r\n<p><strong>&nbsp;死锁处理：</strong></p>\r\n\r\n<ol>\r\n	<li>\r\n	<p>预防死锁：破坏产生死锁的4个必要条件中的一个或者多个；实现起来比较简单，但是如果限制过于严格会降低系统资源利用率以及吞吐量</p>\r\n	</li>\r\n	<li>\r\n	<p>避免死锁：在资源的动态分配中，防止系统进入不安全状态(可能产生死锁的状态)-如银行家算法</p>\r\n	</li>\r\n	<li>\r\n	<p>检测死锁：允许系统运行过程中产生死锁，在死锁发生之后，采用一定的算法进行检测，并确定与死锁相关的资源和进程，采取相关方法清除检测到的死锁。实现难度大</p>\r\n	</li>\r\n	<li>\r\n	<p>解除死锁：与死锁检测配合，将系统从死锁中解脱出来（撤销进程或者剥夺资源）。对检测到的和死锁相关的进程以及资源，通过撤销或者挂起的方式，释放一些资源并将其分配给处于阻塞状态的进程，使其转变为就绪态。实现难度大</p>\r\n	</li>\r\n</ol>\r\n\r\n<p>死锁忽略：&nbsp;windows，Linux个人版都不做死锁处理，直接忽略，大不了重启就好了，小概率事件，代价可以接受</p>\r\n\r\n<p>&nbsp;</p>\r\n', '2020-05-04 11:12:20');
INSERT INTO `t_news` VALUES (61, '内存管理', '<p><strong>要解决的两个问题</strong></p>\r\n\r\n<p><strong>1）每个进程代码中使用的地址可能相同。解决思路：对代码中的地址重定向（加个基地址）。</strong></p>\r\n\r\n<p><strong><strong>2）物理内存可能比较小，不能同时放很多进程进来。解决思路：把要运行的代码移到内存，暂时不用的代码移入磁盘，即交换（swap），内存置换</strong></strong></p>\r\n\r\n<h3>1 分段</h3>\r\n\r\n<p>一个程序分成多个段（每个段特性不同为了方便管理，例如代码段只读、数据段等等），当然这都是逻辑上的。</p>\r\n\r\n<p>管理段的结构叫段表，段表保存中进程的PCB中。</p>\r\n\r\n<p><img alt=\"\" src=\"https://images2018.cnblogs.com/blog/1169376/201807/1169376-20180711102655465-1407008790.png\" /></p>\r\n\r\n<h3>2 页表</h3>\r\n\r\n<p>　　把程序按段分对程序员是友好的，但是如果物理存储也按段存，则会导致大块的内存碎片，例如现在需要分个10M的段但是连续的存储空间只有8M/9M/5M三个。<strong>解决办法：</strong>&nbsp;（将段打散存到页中）不要对内存进行连续的分配，将内存划分成1页1页，按页分配，1页4kb大小，最多浪费的也就4KB。这样不会有内存碎片，也不会出现没有符合要求大小的内存可以申请的情况，因为可以打散了分散到一页一页中。&nbsp;</p>\r\n\r\n<p>　　整个系统的页表就是https://www.cnblogs.com/xdyixia/p/9253138.html中说的多级页表（这个整个系统的多级页表简单来说就是把<strong>物理地址</strong>都进行了按页划分，保存了每页的基地址（对应下图中的页框号））。程序向系统申请时内存时，系统就会把哪几个页框号分给程序的某个段，程序再把它段0中的第3页数据放到页框6中。</p>\r\n\r\n<p>&nbsp;<img alt=\"\" src=\"https://images2018.cnblogs.com/blog/1169376/201807/1169376-20180711105527646-2028519348.png\" /><img alt=\"\" src=\"https://images2018.cnblogs.com/blog/1169376/201807/1169376-20180711110342342-1764262432.png\" /></p>\r\n\r\n<p><strong>说明：进程需要有自己的&ldquo;页表&rdquo;，里面映射双方是程序的逻辑地址中的页号和系统分给这給程序的页框号。</strong></p>\r\n\r\n<h3><strong>3 段页结合的内存管理</strong></h3>\r\n\r\n<p><strong>实际在内存管理中的段页结合如下图，页号加偏移称为虚拟地址，MMU负载从虚拟地址到物理地址的转换，同时也负责权限检查。</strong></p>\r\n\r\n<p><img alt=\"\" src=\"https://images2018.cnblogs.com/blog/1169376/201807/1169376-20180711110934367-1037972366.png\" /></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>上面解决了<strong>每个进程代码中使用的地址可能相同，系统给每个进程分配基地址，进程保存在PCB中。</strong></p>\r\n\r\n<p><strong>但是进程可操作的虚拟地址为4G（32位系统），可物理地址为1G怎么办。</strong></p>\r\n\r\n<h3><strong>4 请求调页内存换入</strong></h3>\r\n\r\n<p><strong>CPU对数据进行请求时，才会进行映射（虚拟内存到物理内存）。</strong></p>\r\n\r\n<p><strong><img alt=\"\" src=\"https://images2018.cnblogs.com/blog/1169376/201807/1169376-20180711112105366-513531844.png\" /></strong></p>\r\n\r\n<p><strong>例如进程1正在运行，进行映射拿数据，查页表发现页框号中没有数据或有进程2的数据，则需要页表调入内存。</strong></p>\r\n\r\n<p><img alt=\"\" src=\"https://images2018.cnblogs.com/blog/1169376/201807/1169376-20180711112539371-1506123921.png\" /></p>\r\n\r\n<h3><strong>5 内存换出</strong></h3>\r\n\r\n<p>有页表需要调入，那么谁调出。</p>\r\n\r\n<p><strong><strong><strong><strong><strong><strong><strong><strong><strong><strong><strong><strong><strong><strong><strong>页面置换算法</strong></strong></strong></strong></strong></strong></strong></strong></strong></strong></strong></strong></strong></strong></strong></p>\r\n\r\n<p><strong>1：最佳置换算法</strong>（Optimal）：一种理论的算法，选着淘汰的页面是以后一定不再使用的页面（理想化的），该算法无法实现，只能作为其他算法好坏的一个评价对比。</p>\r\n\r\n<p><strong>2：先进先出（FIFO）算法：</strong>总是最先淘汰最先进去的页面，该算法容易实现。缺点：通常程序调入内存的先后顺序和程序执行的先后顺序不一致，导致缺页率高。</p>\r\n\r\n<p><strong>3：最近最久未使用算法LRU：</strong>算法赋予每个页面一个访问字段，用来记录上次页面被访问到现在所经历的时间t，每次置换的时候把t值最大的页面置换出去(实现方面可以采用寄存器或者栈的方式实现)。</p>\r\n\r\n<p><strong>4：时钟算法clock(也被称为是最近未使用算法NRU)</strong>：页面设置一个访问位R，并将页面链接为一个环形队列，页面被访问的时候访问位设置R为1。页面置换的时候，如果当前指针所指页面访问R为0，那么置换，否则将其置为0，循环直到遇到一个访问为位0的页面。</p>\r\n\r\n<p>但是这个方法有缺点：缺页比较少的时候（最近没有使用淘汰中的&ldquo;最近&rdquo;太长了），所有的R都为1（很少变成0）,每次都要转一圈才能找到换出去的页，退化成FIFO，效率不高。</p>\r\n\r\n<p><strong>改进：</strong>&nbsp;双指针，一个快，一个慢，像时钟一样 （定时清除R位）（更像clock）<br />\r\n快时钟做R的清0定时清0,等到慢指针转到这里的时候R=0,说明在定时时间片内没有备访问，该页可以被替换了。</p>\r\n', '2020-05-04 11:13:03');
INSERT INTO `t_news` VALUES (65, '操作系统的四个特性', '<p>并发：同一段时间内多个程序执行(注意区别并行和并发，前者是同一时刻的多个事件，后者是同一时间段内的多个事件)<br />\r\n共享：系统中的资源可以被内存中多个并发执行的进线程共同使用<br />\r\n虚拟：通过时分复用（如分时系统）以及空分复用（如虚拟内存）技术实现把一个物理实体虚拟为多个<br />\r\n异步：系统中的进程是以走走停停的方式执行的，且以一种不可预知的速度推进</p>\r\n', '2020-05-04 11:11:30');

-- ----------------------------
-- Table structure for t_permission
-- ----------------------------
DROP TABLE IF EXISTS `t_permission`;
CREATE TABLE `t_permission`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `permissionName` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `roleId` int(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `roleId`(`roleId`) USING BTREE,
  CONSTRAINT `t_permission_ibfk_1` FOREIGN KEY (`roleId`) REFERENCES `t_role` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_permission
-- ----------------------------
INSERT INTO `t_permission` VALUES (1, 'admin:*', 1);
INSERT INTO `t_permission` VALUES (2, 'user:*', 2);

-- ----------------------------
-- Table structure for t_role
-- ----------------------------
DROP TABLE IF EXISTS `t_role`;
CREATE TABLE `t_role`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `roleName` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_role
-- ----------------------------
INSERT INTO `t_role` VALUES (1, 'admin');
INSERT INTO `t_role` VALUES (2, 'user');

-- ----------------------------
-- Table structure for t_source
-- ----------------------------
DROP TABLE IF EXISTS `t_source`;
CREATE TABLE `t_source`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `filename` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `filepath` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `pubtime` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 31 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_source
-- ----------------------------
INSERT INTO `t_source` VALUES (31, '新建文本文档.txt', 'D:/upload/source/新建文本文档.txt', '2019-09-04');

-- ----------------------------
-- Table structure for t_topic
-- ----------------------------
DROP TABLE IF EXISTS `t_topic`;
CREATE TABLE `t_topic`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `pubtime` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `detail` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `edituser` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `state` int(0) NULL DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 39 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_topic
-- ----------------------------
INSERT INTO `t_topic` VALUES (14, 'java基础？', '2019-05-09', '<p>大佬们好，我是一位大一的萌新，请问java基础该怎么学呢？</p>\r\n', 'zhangsan', 1);

-- ----------------------------
-- Table structure for t_user
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `username` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `email` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `state` int(0) NULL DEFAULT 1,
  `roleId` int(0) NULL DEFAULT 2,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `roleId`(`roleId`) USING BTREE,
  CONSTRAINT `t_user_ibfk_1` FOREIGN KEY (`roleId`) REFERENCES `t_role` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 43 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_user
-- ----------------------------
INSERT INTO `t_user` VALUES (34, 'lisi', '4a7d1ed414474e4033ac29ccb8653d9b', '123@qq.com', 2, 2);
INSERT INTO `t_user` VALUES (38, 'haha', '4a7d1ed414474e4033ac29ccb8653d9b', 'bb@163.comaaa', 1, 2);
INSERT INTO `t_user` VALUES (40, 'lili', '4a7d1ed414474e4033ac29ccb8653d9b', 'lili@qq.com', 1, 2);
INSERT INTO `t_user` VALUES (42, 'yy', '202cb962ac59075b964b07152d234b70', '475668579@qq.com', 1, 2);
INSERT INTO `t_user` VALUES (44, 'admin', '202cb962ac59075b964b07152d234b70', '123@qq.com', 1, 1);

-- ----------------------------
-- Table structure for t_video
-- ----------------------------
DROP TABLE IF EXISTS `t_video`;
CREATE TABLE `t_video`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `size` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `path` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `uploadTime` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_video
-- ----------------------------
INSERT INTO `t_video` VALUES (1, '经典影片1', '899.83KB', '.mp4', 'video/1.mp4', '2019-09-04 07:23:55');
INSERT INTO `t_video` VALUES (2, '经典影片二', '1.58MB', '.mp4', 'video/2.mp4', '2019-09-04 07:24:12');
INSERT INTO `t_video` VALUES (3, '经典影片3', '1.54MB', '.mp4', 'video/3.mp4', '2019-09-04 07:24:31');
INSERT INTO `t_video` VALUES (4, '经典影片四', '2.47MB', '.mp4', 'video/4.mp4', '2019-09-04 07:24:47');

SET FOREIGN_KEY_CHECKS = 1;
