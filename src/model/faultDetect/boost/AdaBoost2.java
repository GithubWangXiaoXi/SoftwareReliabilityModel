//package model.faultDetect.boost;
//
//import util.ArraySort;
//
//import java.math.BigDecimal;
//import java.text.DecimalFormat;
//import java.util.HashSet;
//import java.util.LinkedList;
//import java.util.Queue;
//import java.util.Set;
//
///**
// * AdaBoost分析二维特征，得到学习模型（多层的提升树）
// */
//public class AdaBoost2 implements BasicBoost {
//
//    private int dimensions;
//    private double [][] x_train;
//    private int [] y_train;
//    private double [][] x_test;
//    private int [] y_test;
//    private double []w;  //样本数据的权值
//    private double []e;  //每个弱分类器的误差率em（需要遍历整棵树得到最终的em）
//    private double []a;  //每个弱分类器对应的系数
//
//    private String[] featureNames;   //特征名称
//    private String label;  //标签名称
//    public double threshold = 0.01;  //设置迭代过程中误分类率的阈值
//    public int TIMES = 100;  //算法迭代次数
//    private String f_x;  //输出每一步的基本分类器的线性组合
//    private String G_x;  //输出最终的强分类器
//    private int[] outdata;  //测试集的预测值
//    public int level = 3; //树的高度，默认是dimensions + 1;
//
//    private LinkedList<BTNode> root_m; //保存每一步弱分类树的根节点
//    private double []score;  //记录每个测试样本点的得分
//    private LinkedList<Integer> positiveList = new LinkedList<>();
//
//    public void calculate(){
//
//        /**
//         * 1、初始化权值w：一开始所有点都未通过函数预测分类，所以各样本数据权值相同，均为1/N
//         */
//        w = new double[x_train.length];
//
//        DecimalFormat dF = new DecimalFormat("0.00000000");
//        for (int i = 0; i < x_train.length; i++) {
//            w[i] = Double.parseDouble(dF.format((float)1/x_train.length));
//        }
//
//
//        int m = 0;  //第m步
//        e[0] = x_train.length;  //初始化第一个弱分类器,第一个特征下的误分类率e[0]
//
//        //分类误差率 = 0, 则跳出循环
//        BigDecimal e_m = new BigDecimal(e[0]);
//        BigDecimal thres = new BigDecimal(threshold);
//        //误差率小于阈值，结束训练
//        while(e_m.compareTo(thres) > 0) {
//
//            if (m >= TIMES) break;   //限制迭代次数
//
//            /**
//             * 2、计算在该弱分类器上最小的分类误差率e_m（e_m不是通过之前累加的弱分类器来计算的）
//             */
//            double [][]eTemp = new double[TIMES][dimensions];  //用来保存不同特征k下的最小误分类率
//            BTNode root = new BTNode();  //每一步的根节点
//            root.floor = 1;
//
//            LinkedList<Integer> list = new LinkedList<>();
//            for (int i = 0; i < x_train.length; i++) {
//                list.add(i);
//            }
//            root_m.add(root);
//
//            /**
//             * step3：构建弱分类树,并得到误分类率e[m]
//             */
//            Set<Integer> featureSelected = new HashSet<>();  //用来存取已经用过的特征，避免下次再使用
//            e[m] = createDecisionTree(root,list,eTemp,m,featureSelected,false,false);
//
//            a[m] = 0.5 * Math.log((double)(1 - e[m])/e[m]);
//
//            BTNode head = levelOrder(root);
//
//            /**
//             * 4、更新权值w，对样本数据进行权重的重排：
//             */
//            double Z_m = getZ_m(head,m);  //规范化因子
//
//            updateW_m(head, Z_m, m);  //更新权值w
//
//            //判断w和是否为1
////            double d = 0.0;
////            for (int i = 0; i < x_train.length; i++) {
////                d += w[i];
////            }
////            System.out.println("w和为：" + d);
//
//            /**
//             * 5、基本分类器的线性组合构造f_x：这里主要是更新x_borderList，y_borderList这两个列表
//             */
////            func_LinearCombination(fs, a[m], borderIndex_m[m][fs], borderleft_m[m][fs], (-1) * borderleft_m[m][fs]);
////
////            f_x = getF_x();
////            G_x = getG_x();
//
//            System.out.print("m = " + m + "  ");
//            System.out.print("误差率e_m = " + e[m] + "   ");
//            System.out.print("基函数系数a_m = " + a[m] + "   ");
//            System.out.print("f(x) = {" + f_x + ")" + "   ");
//
//            //通过G_x判断训练数据，如果不存在误分类点，即G_x为最终的强分类器
//            int count = getMissPointCount(head,m);
//            if(count == 0){
//                System.out.print("G_x误分类样本点为" + count + "个  ");
//                System.out.println("训练误差为:" + Double.parseDouble(dF.format((float)count/x_train.length)));
//                break;
//            }
//            System.out.print("G_x误分类样本点为" + count + "个  ");
//            System.out.println("训练误差为:" + Double.parseDouble(dF.format((float)count/x_train.length)));
//
//            printDecisionTree(root,m);  //绘制决策树
//
//            printClassification(head);  //绘制分类结果
//
//            //删除以head为头节点的、串联叶子节点的链表中的训练数据集索引，避免占用空间。
//            deleteLeafTrainList(head);
//
//            e_m = new BigDecimal(e[m]);
//
//            m++;
//        }
//    }
//
//
//    @Override
//    public void inputdata(double[][] x_trainP, int[] y_trainP, double[][] x_testP, int[] y_testP, String[] featureSel, String label) {
//        this.dimensions = x_trainP[0].length;
//
//        if(this.level > dimensions + 1 || this.level <= 1){
//            this.level = dimensions + 1;
//        }
//        this.x_train = x_trainP;
//        this.y_train = y_trainP;
//        this.x_test = x_testP;
//        this.y_test = y_testP;
//        this.root_m = new LinkedList<>();
//        this.e = new double[TIMES];
//        this.a = new double[TIMES];
//        this.featureNames = featureSel;
//        this.label = label;
//        this.score = new double[x_testP.length];
//    }
//
//    @Override
//    public int[] getoutdata() {
//
//        /**
//         * 对每一个测试数据集样本，都需要跑一遍所有的树模型，按特征分类，将每一个测试样本归位到叶子节点中。
//         * 加权表决得到最终的评分，再用sign函数将评分映射到+1，-1中。
//         */
//        int results[] = new int[x_test.length];
//        for (int i = 0; i < x_test.length; i++) {
//            int result = predict(root_m, a, x_test[i],i);
//            results[i] = result;
//        }
//
//        outdata = results;
//        return results;
//    }
//
//    public double getCorrectRate() {
//
//        int num = 0;
//        for (int i = 0; i < x_test.length; i++) {
//            if (y_test[i] == outdata[i]){
//                num++;
//            }
//        }
//
//        System.out.println(num + "/" + x_test.length);
//
//        DecimalFormat dF = new DecimalFormat("0.0000");
//
//        return Double.parseDouble(dF.format((float) num / x_test.length));
//    }
//
//    public double createDecisionTree(BTNode root, LinkedList<Integer> list, double [][]eTemp, int m, Set<Integer> featureSelected, boolean leftT,boolean rightT){
//
//        //如果到达树的高度，或者是到了叶子节点，则返回这棵树的误分类率em
//        if(root.floor == level || root.isLeaf == true){
//
//            if(root.floor == level){
//                root.isLeaf = true;
//                root.train_list = list;
//                if(leftT){
//                    root.isLeftChild = true;
//                }else{
//                    root.isRightChild = true;
//                }
//            }
//
//            double em = 0.0;
//            BTNode parent = root.parent;
//
//            //计算该叶子节点的em
//            for (int i = 0; i < list.size(); i++) {
//                if(x_train[list.get(i)][parent.featureIndex] < parent.borderIndex){
//                    if(y_train[list.get(i)] != parent.borderLeft){
//                        em += w[list.get(i)] * 1;
//                    }
//                }else{
//                    if(y_train[list.get(i)] != parent.borderLeft * (-1)){
//                        em += w[list.get(i)] * 1;
//                    }
//                }
//            }
//
//            return em;
//        }
//
//        /**
//         * step1：先将数据集合分别划分成正负类,方便计算最优切分量和切分点
//         */
//
//        //将训练数据集按类别（二类问题）划分到两个数组中
//        int pos = 0;  //训练集中正类数目
//        int neg = 0;  //训练集中负类数目
//
//        //判断正类负类数目
//        for (int i = 0; i < list.size(); i++) {
//            if(y_train[list.get(i)] == 1){
//                pos++;
//            }else{
//                neg++;
//            }
//        }
//
//        double[][] x_trainPos = new double[pos][dimensions];
//        double[][] x_trainNeg = new double[neg][dimensions];
//        int p = 0;
//        int q = 0;
//        boolean flag = false;  //判断划分的集合是否全为正类或负类
//        for (int i = 0; i < list.size(); i++) {
//            if(y_train[list.get(i)] == 1 && x_trainPos != null){
//                for (int j = 0; j < dimensions; j++) {
//                    x_trainPos[p][j] = x_train[list.get(i)][j];
//                }
//                p++;
//            }else if(x_trainNeg != null){
//                for (int j = 0; j < dimensions; j++) {
//                    x_trainNeg[q][j] = x_train[list.get(i)][j];
//                }
//                q++;
//            }
//        }
//
//        /**
//         * step2: 计算该子树桩下最优的切分量和切分点
//         */
//        double []borderIndex_k = new double[dimensions];  //用来记录每一步弱分类器,在特征k下的边界索引
//        double []borderleft_k = new double[dimensions];  //用来记录每一步弱分类器，在特征k下的左边边界类
//
//
//        //计算每个特征下最小的em（局部）
//        for (int k = 0; k < dimensions; k++) {
//
//            //如果该特征之前用过，继续遍历
//            if (featureSelected.contains(k)){
//                continue;
//            }
//
//            int h = 0;
//            double borderIndex[] = new double[x_train.length];  //可能存在的边界
//            int borderleft[] = new int[x_train.length];  //左边界
//
//            //对特征k进行训练数据重排
//            ArraySort.sort(x_trainPos,new int[]{k});
//            ArraySort.sort(x_trainNeg,new int[]{k});
//
//            //通过正类，负类集合，把两数组看做链表，设置两指针判断边界
//            int j = 0;  //正类指针
//            int l = 0;  //负类指针
//
//            //如果分类的集合中全是正类或负类，则无分界点
//            if(x_trainPos.length == 0 || x_trainNeg.length == 0) {
//                flag = true;
//                break;
//            }
//
//            while(j < x_trainPos.length - 1 || l < x_trainNeg.length - 1) {
//
//                //[j] <= [l], j++
//                if(x_trainPos[j][k] <= x_trainNeg[l][k]){
//
//                    //提前预判这个位置是不是边界
//                    if(j + 1 < x_trainPos.length && x_trainPos[j + 1][k] > x_trainNeg[l][k]){
//                        borderleft[h] = 1;  //j在追l，左边界为1
//                        borderIndex[h++] = x_trainPos[j][k] + 0.5;  //选第k个特征进行计算
//                    }
//                    //如果到了正类列表末尾，则不加
//                    if(j < x_trainPos.length - 1){
//                        j++;
//                    }
//                    //如果正类末尾小于当前负类，则记录分界点，并跳出循环
//                    else if(j == x_trainPos.length - 1 && x_trainPos[j][k] < x_trainNeg[l][k]){
//                        borderleft[h] = 1;  //l在追j，左边界为-1
//                        borderIndex[h++] = x_trainPos[j][k] + 0.5;  //选第k个特征进行计算
//                        break;
//                    }
//                }
//                //[j] > [l], l++
//                else{
//                    //提前预判这个位置是不是边界
//                    if(l + 1 < x_trainNeg.length && x_trainNeg[l + 1][k] >= x_trainPos[j][k]){
//                        borderleft[h] = -1;  //l在追j，左边界为-1
//                        borderIndex[h++] = x_trainNeg[l][k] + 0.5;  //选第k个特征进行计算
//                    }
//                    //如果到了负类列表末尾，则不加
//                    if(l < x_trainNeg.length - 1){
//                        l++;
//                    }
//                    //如果负类末尾小于当前正类，则记录分界点，并跳出循环
//                    else if(l == x_trainNeg.length - 1 && x_trainNeg[l][k] < x_trainPos[j][k]){
//                        borderleft[h] = -1;  //l在追j，左边界为-1
//                        borderIndex[h++] = x_trainNeg[l][k] + 0.5;  //选第k个特征进行计算
//                        break;
//                    }
//                }
//            }
//
//            //如果pos,neg都到了末尾
//            if(j == x_trainPos.length - 1 && l == x_trainNeg.length - 1){
//                //如果pos末尾元素小于neg末尾元素，则borderleft = 1
//                if (x_trainPos[j][k] < x_trainNeg[l][k]){
//                    borderleft[h] = 1;
//                    borderIndex[h++] = x_trainPos[j][k] + 0.5;  //选第k个特征进行计算
//                }
//                //如果neg末尾元素小于pos末尾元素，则borderleft = -1
//                else if(x_trainNeg[l][k] < x_trainPos[j][k]){
//                    borderleft[h] = -1;
//                    borderIndex[h++] = x_trainNeg[l][k] + 0.5;  //选第k个特征进行计算
//                }
//            }
//
//            double e_temp[] = new double[h]; //所有边界可能取到的分类误差率
//            for (int i = 0; i < h; i++) {
//
//                double temp = 0.0;
//
//                //注意判断误分类点是对子集而言的
//                for (int n = 0; n < list.size(); n++) {
//                    //累加左边w·误分类点
//                    if(x_train[list.get(n)][k] < borderIndex[i]){
//                        if(y_train[list.get(n)] != borderleft[i]){
//                            temp += w[list.get(n)] * 1;
//                        }
//                    }
//                    //累加右边w·误分类点
//                    else{
//                        if(y_train[list.get(n)] != borderleft[i] * (-1)){
//                            temp += w[list.get(n)] * 1;
//                        }
//                    }
//                }
//
//                //注意所有的权值*{1，-1}相加有可能等于double的0，如果double的0在分母上，会出现NaN，-Infinity,Infinity
//                e_temp[i] = temp;
//            }
//
//            if(!flag){
//                //计算得到该特征下该弱分类器最小e_m,以及边界索引，边界左边的值
//                double min_temp  = e_temp[0];
//                borderIndex_k[k] = borderIndex[0];
//                borderleft_k[k] = borderleft[0];
//                for (int i = 1; i < h; i++) {
//                    //去掉e_temp[i] = 0
//                    BigDecimal bigDecimal1 = new BigDecimal(e_temp[i]);
//                    BigDecimal bigDecimal2 = new BigDecimal(0.0);
//                    if(e_temp[i] < min_temp && bigDecimal1.compareTo(bigDecimal2) != 0){
//                        min_temp = e_temp[i];
//                        borderIndex_k[k] = borderIndex[i];
//                        borderleft_k[k] =  borderleft[i];
//                    }
//                }
//
//                eTemp[m][k] = min_temp;
//            }
//        }
//
//        if(!flag){
//            //计算所有特征下最小的em（全局）,并将对应的borderIndex，borderLeft保存在根节点上
//            double min = eTemp[m][0];
//            root.featureIndex = 0;  //记录要划分的特征
//            root.borderIndex = borderIndex_k[0];  //记录要划分的特征边界索引
//            root.borderLeft = borderleft_k[0];  //记录要划分的特征的左边界
//            for (int i = 0; i < dimensions; i++) {
//                if(eTemp[m][i] < min && !featureSelected.contains(i)){
//                    e[m] = eTemp[m][i];
//                    root.featureIndex = i;  //记录要划分的特征
//                    root.borderIndex = borderIndex_k[i];  //记录要划分的特征边界索引
//                    root.borderLeft = borderleft_k[i];  //记录要划分的特征的左边界
//                }
//            }
//            featureSelected.add(root.featureIndex);
//        }
//
//        if(!flag){
//            /**
//             * step3: 根据最优切分量和切分点划分数据集合
//             */
//            //将划分的集合保存在节点中(只保存索引下标）
//            LinkedList<Integer> x_list1 = new LinkedList<>();
//            LinkedList<Integer> x_list2 = new LinkedList<>();
//            for (int i = 0; i < list.size(); i++) {
//                if(x_train[list.get(i)][root.featureIndex] < root.borderIndex){
//                    x_list1.add(list.get(i));
//                }else{
//                    x_list2.add(list.get(i));
//                }
//            }
//
//            /**
//             * step4：迭代构造子树
//             */
//            BTNode leftChild = new BTNode();
//            BTNode rightChild = new BTNode();
//            leftChild.parent = root;
//            rightChild.parent = root;
//            root.leftChild = leftChild;
//            root.rightChild = rightChild;
//
//            root.leftChild.floor = root.floor + 1;
//            root.rightChild.floor = root.floor + 1;
//
//            if(root.floor == dimensions){
//                root.leftChild.isLeaf = true;
//                root.leftChild.isLeftChild = true;
//                root.rightChild.isLeaf = true;
//                root.rightChild.isRightChild = true;
//                root.leftChild.train_list = x_list1;
//                root.rightChild.train_list = x_list2;
//            }
//
//            //全拷贝featureSelected
//            Set<Integer> featureSelected1 = new HashSet<>();
//            for (Integer i: featureSelected) {
//                featureSelected1.add(i);
//            }
//
//            boolean left = true;
//            double em1 = createDecisionTree(root.leftChild, x_list1, eTemp, m,featureSelected,left,false);  //left,right标识用来提示是左子树递归还是右子树递归
//            boolean right = true;
//            double em2 = createDecisionTree(root.rightChild, x_list2, eTemp, m,featureSelected1,false,right);
//            return em1 + em2;
//        }
//        //该root节点本来就是叶子节点
//        else{
//            root.isLeaf = true;
//            if(leftT){
//                root.isLeftChild = true;
//            }else{
//                root.isRightChild = true;
//            }
//            root.train_list = list;
//            return createDecisionTree(root,list,eTemp,m,featureSelected,false,false);
//        }
//    }
//
//    /**
//     * 通过二叉树的层次遍历，将二叉树的叶子节点串联起来，并返回头结点
//     * 方便计算Z[m]
//     */
//    public BTNode levelOrder(BTNode root){
//
//        Queue<BTNode> queue = new LinkedList<>();
//        queue.offer(root);
//
//        BTNode head = new BTNode();
//        BTNode p = head;
//        while(!queue.isEmpty()){
//            BTNode btNode = queue.poll();
//
//            if(btNode.isLeaf == true){
//                p.next = btNode;
//                p = btNode;
//            }
//
//            if(btNode.leftChild != null){
//                queue.offer(btNode.leftChild);
//            }
//            if(btNode.rightChild != null){
//                queue.offer(btNode.rightChild);
//            }
//        }
//
//        return head;
//    }
//
//    public double getZ_m(BTNode head,int m) {
//        double Z_m = 0.0;
//
//        BTNode p = head;
//        while (p.next != null){
//
//            p = p.next;
//            for (int i = 0; i < p.train_list.size(); i++) {
//                if(x_train[p.train_list.get(i)][p.parent.featureIndex] < p.parent.borderIndex){
//                    Z_m += w[p.train_list.get(i)] * Math.exp(-a[m] * y_train[p.train_list.get(i)] * p.parent.borderLeft);
//                }else{
//                    Z_m += w[p.train_list.get(i)] * Math.exp(-a[m] * y_train[p.train_list.get(i)] * p.parent.borderLeft * (-1));
//                }
//            }
//        }
//
//        return Z_m;
//    }
//
//    private void updateW_m(BTNode head,double Z_m, int m) {
//
//        BTNode p = head;
//        while (p.next != null){
//
//            p = p.next;
//            for (int i = 0; i < p.train_list.size(); i++) {
//                if(x_train[p.train_list.get(i)][p.parent.featureIndex] < p.parent.borderIndex){
//                    w[p.train_list.get(i)] = (double)(w[p.train_list.get(i)] * Math.exp(-a[m] * y_train[p.train_list.get(i)] * p.parent.borderLeft))/Z_m;
//                }else{
//                    w[p.train_list.get(i)] = (double)(w[p.train_list.get(i)] * Math.exp(-a[m] * y_train[p.train_list.get(i)] * p.parent.borderLeft * (-1)))/Z_m;
//                }
//            }
//        }
//    }
//
//    public Integer getMissPointCount(BTNode head, int m){
//
//        BTNode p = head;
//        Integer missPointCount = 0;
//        while (p.next != null){
//
//            p = p.next;
//            for (int i = 0; i < p.train_list.size(); i++) {
//                if(x_train[p.train_list.get(i)][p.parent.featureIndex] < p.parent.borderIndex){
//                    if(y_train[p.train_list.get(i)] != p.parent.borderLeft){
//                        missPointCount++;
//                    }
//                }else{
//                    if(y_train[p.train_list.get(i)] != p.parent.borderLeft * (-1)){
//                        missPointCount++;
//                    }
//                }
//            }
//        }
//        return missPointCount;
//    }
//
//    private void deleteLeafTrainList(BTNode head) {
//
//        BTNode p = head;
//        while (p.next != null){
//            p = p.next;
//            p.train_list.clear();
//        }
//    }
//
//    //预测测试样本
//    private int predict(LinkedList<BTNode> root_m, double[] a, double[] sample,int index) {
//
//        double result = 0.0;
//        for (int i = 0; i < root_m.size(); i++) {
//
//            BTNode root = root_m.get(i);
//
//            BTNode p = root;
//            boolean isLeftChild = false;
//            while(p.isLeaf != true){
//                if (sample[root.featureIndex] < p.borderIndex){
//                    p = p.leftChild;
//                    isLeftChild = true;
//                }else{
//                    p = p.rightChild;
//                    isLeftChild = false;
//                }
//            }
//
//            if(isLeftChild){
//                result += a[i] * p.parent.borderLeft;
//            }else{
//                result += a[i] * p.parent.borderLeft * (-1);
//            }
//        }
//
//        if(result > 0){
//            positiveList.add(index);
//            score[index] = result; //记录实际得分，方便使用softMax归一化，求出经过预测后，得到的每个预测正样本的分类概率
//            return 1;
//        }else{
//            return -1;
//        }
//    }
//
//    public void printDecisionTree(BTNode root,int m){
//
//        Queue<BTNode> queue = new LinkedList<>();
//        queue.offer(root);
//
//        BTNode head = new BTNode();
//        System.out.println("第" + (m+1) + "树");
//        System.out.println("root");
//
//        BTNode last = root;  //last指向每一层最右节点
//        int levelTemp = 0; //当前层数(以弹出的节点为准）
//        int floor = 0; //插入节点的层数, floor和levelTemp相差一行时，换行
//        while(!queue.isEmpty()){
//            BTNode btNode = queue.poll();
//            if(last == btNode){
//                levelTemp++;
//                if(btNode.rightChild != null){
//                    last = btNode.rightChild;
//                }else{
//                    last = btNode.leftChild;
//                }
//            }
//
//            if(btNode.leftChild != null){
//                System.out.print("左↓ " + featureNames[btNode.featureIndex] + " < " + btNode.borderIndex + "   ");
//                queue.offer(btNode.leftChild);
//                floor = btNode.leftChild.floor;
//            }
//            if(btNode.rightChild != null){
//                System.out.print("右↓" + featureNames[btNode.featureIndex] + " > " + btNode.borderIndex + "   ");
//                queue.offer(btNode.rightChild);
//                floor = btNode.leftChild.floor;
//            }
//            if(levelTemp + 1 == floor && floor != level){
//                System.out.println();
//            }
//        }
//        //System.out.println();
//    }
//
//    public void printClassification(BTNode head){
//
////        BTNode q = head;
////        int count = 1;
////        System.out.println();
////        while(q.next != null){
////            q = q.next;
////            if(count % 2 == 0){
////                System.out.print("右：" + q.parent.borderLeft * (-1) + "           ");
////            }else{
////                System.out.print("左：" + q.parent.borderLeft + "           ");
////            }
////            count++;
////        }
//
//        BTNode p = head;
//        System.out.println();
//        while (p.next != null){
//            p = p.next;
//            if(p.parent.leftChild != null && p.isLeftChild){
//                System.out.print("左：" + p.parent.borderLeft + "           ");
//            }
//            if(p.parent.rightChild != null && p.isRightChild){
//                System.out.print("右：" + p.parent.borderLeft * (-1) + "           ");
//            }
//        }
//        System.out.println();
//        System.out.println();
//    }
//
//    @Override
//    public void setHeight(int heightP) {
//        this.level = heightP;
//    }
//
//    @Override
//    public void setShrehold(double thresholdP) {
//        this.threshold = thresholdP;
//    }
//
//    @Override
//    public void setTIMES(int timesP) {
//        this.TIMES = timesP;
//    }
//
//    @Override
//    public double[] getScore() {
//        return score;
//    }
//
//    public LinkedList<Integer> getPositiveList() {
//        return positiveList;
//    }
//
//    @Override
//    public int getTIMES() {
//        return this.TIMES;
//    }
//
//    @Override
//    public int[] getoutdata(double thresholdT) {
//        return new int[0];
//    }
//}
