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
// * AdaBoost������ά�������õ�ѧϰģ�ͣ�������������
// */
//public class AdaBoost2 implements BasicBoost {
//
//    private int dimensions;
//    private double [][] x_train;
//    private int [] y_train;
//    private double [][] x_test;
//    private int [] y_test;
//    private double []w;  //�������ݵ�Ȩֵ
//    private double []e;  //ÿ�����������������em����Ҫ�����������õ����յ�em��
//    private double []a;  //ÿ������������Ӧ��ϵ��
//
//    private String[] featureNames;   //��������
//    private String label;  //��ǩ����
//    public double threshold = 0.01;  //���õ���������������ʵ���ֵ
//    public int TIMES = 100;  //�㷨��������
//    private String f_x;  //���ÿһ���Ļ������������������
//    private String G_x;  //������յ�ǿ������
//    private int[] outdata;  //���Լ���Ԥ��ֵ
//    public int level = 3; //���ĸ߶ȣ�Ĭ����dimensions + 1;
//
//    private LinkedList<BTNode> root_m; //����ÿһ�����������ĸ��ڵ�
//    private double []score;  //��¼ÿ������������ĵ÷�
//    private LinkedList<Integer> positiveList = new LinkedList<>();
//
//    public void calculate(){
//
//        /**
//         * 1����ʼ��Ȩֵw��һ��ʼ���е㶼δͨ������Ԥ����࣬���Ը���������Ȩֵ��ͬ����Ϊ1/N
//         */
//        w = new double[x_train.length];
//
//        DecimalFormat dF = new DecimalFormat("0.00000000");
//        for (int i = 0; i < x_train.length; i++) {
//            w[i] = Double.parseDouble(dF.format((float)1/x_train.length));
//        }
//
//
//        int m = 0;  //��m��
//        e[0] = x_train.length;  //��ʼ����һ����������,��һ�������µ��������e[0]
//
//        //��������� = 0, ������ѭ��
//        BigDecimal e_m = new BigDecimal(e[0]);
//        BigDecimal thres = new BigDecimal(threshold);
//        //�����С����ֵ������ѵ��
//        while(e_m.compareTo(thres) > 0) {
//
//            if (m >= TIMES) break;   //���Ƶ�������
//
//            /**
//             * 2�������ڸ�������������С�ķ��������e_m��e_m����ͨ��֮ǰ�ۼӵ���������������ģ�
//             */
//            double [][]eTemp = new double[TIMES][dimensions];  //�������治ͬ����k�µ���С�������
//            BTNode root = new BTNode();  //ÿһ���ĸ��ڵ�
//            root.floor = 1;
//
//            LinkedList<Integer> list = new LinkedList<>();
//            for (int i = 0; i < x_train.length; i++) {
//                list.add(i);
//            }
//            root_m.add(root);
//
//            /**
//             * step3��������������,���õ��������e[m]
//             */
//            Set<Integer> featureSelected = new HashSet<>();  //������ȡ�Ѿ��ù��������������´���ʹ��
//            e[m] = createDecisionTree(root,list,eTemp,m,featureSelected,false,false);
//
//            a[m] = 0.5 * Math.log((double)(1 - e[m])/e[m]);
//
//            BTNode head = levelOrder(root);
//
//            /**
//             * 4������Ȩֵw�����������ݽ���Ȩ�ص����ţ�
//             */
//            double Z_m = getZ_m(head,m);  //�淶������
//
//            updateW_m(head, Z_m, m);  //����Ȩֵw
//
//            //�ж�w���Ƿ�Ϊ1
////            double d = 0.0;
////            for (int i = 0; i < x_train.length; i++) {
////                d += w[i];
////            }
////            System.out.println("w��Ϊ��" + d);
//
//            /**
//             * 5��������������������Ϲ���f_x��������Ҫ�Ǹ���x_borderList��y_borderList�������б�
//             */
////            func_LinearCombination(fs, a[m], borderIndex_m[m][fs], borderleft_m[m][fs], (-1) * borderleft_m[m][fs]);
////
////            f_x = getF_x();
////            G_x = getG_x();
//
//            System.out.print("m = " + m + "  ");
//            System.out.print("�����e_m = " + e[m] + "   ");
//            System.out.print("������ϵ��a_m = " + a[m] + "   ");
//            System.out.print("f(x) = {" + f_x + ")" + "   ");
//
//            //ͨ��G_x�ж�ѵ�����ݣ���������������㣬��G_xΪ���յ�ǿ������
//            int count = getMissPointCount(head,m);
//            if(count == 0){
//                System.out.print("G_x�����������Ϊ" + count + "��  ");
//                System.out.println("ѵ�����Ϊ:" + Double.parseDouble(dF.format((float)count/x_train.length)));
//                break;
//            }
//            System.out.print("G_x�����������Ϊ" + count + "��  ");
//            System.out.println("ѵ�����Ϊ:" + Double.parseDouble(dF.format((float)count/x_train.length)));
//
//            printDecisionTree(root,m);  //���ƾ�����
//
//            printClassification(head);  //���Ʒ�����
//
//            //ɾ����headΪͷ�ڵ�ġ�����Ҷ�ӽڵ�������е�ѵ�����ݼ�����������ռ�ÿռ䡣
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
//         * ��ÿһ���������ݼ�����������Ҫ��һ�����е���ģ�ͣ����������࣬��ÿһ������������λ��Ҷ�ӽڵ��С�
//         * ��Ȩ����õ����յ����֣�����sign����������ӳ�䵽+1��-1�С�
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
//        //����������ĸ߶ȣ������ǵ���Ҷ�ӽڵ㣬�򷵻���������������em
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
//            //�����Ҷ�ӽڵ��em
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
//         * step1���Ƚ����ݼ��Ϸֱ𻮷ֳ�������,������������з������зֵ�
//         */
//
//        //��ѵ�����ݼ�����𣨶������⣩���ֵ�����������
//        int pos = 0;  //ѵ������������Ŀ
//        int neg = 0;  //ѵ�����и�����Ŀ
//
//        //�ж����ฺ����Ŀ
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
//        boolean flag = false;  //�жϻ��ֵļ����Ƿ�ȫΪ�������
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
//         * step2: ���������׮�����ŵ��з������зֵ�
//         */
//        double []borderIndex_k = new double[dimensions];  //������¼ÿһ����������,������k�µı߽�����
//        double []borderleft_k = new double[dimensions];  //������¼ÿһ������������������k�µ���߽߱���
//
//
//        //����ÿ����������С��em���ֲ���
//        for (int k = 0; k < dimensions; k++) {
//
//            //���������֮ǰ�ù�����������
//            if (featureSelected.contains(k)){
//                continue;
//            }
//
//            int h = 0;
//            double borderIndex[] = new double[x_train.length];  //���ܴ��ڵı߽�
//            int borderleft[] = new int[x_train.length];  //��߽�
//
//            //������k����ѵ����������
//            ArraySort.sort(x_trainPos,new int[]{k});
//            ArraySort.sort(x_trainNeg,new int[]{k});
//
//            //ͨ�����࣬���༯�ϣ��������鿴������������ָ���жϱ߽�
//            int j = 0;  //����ָ��
//            int l = 0;  //����ָ��
//
//            //�������ļ�����ȫ��������࣬���޷ֽ��
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
//                    //��ǰԤ�����λ���ǲ��Ǳ߽�
//                    if(j + 1 < x_trainPos.length && x_trainPos[j + 1][k] > x_trainNeg[l][k]){
//                        borderleft[h] = 1;  //j��׷l����߽�Ϊ1
//                        borderIndex[h++] = x_trainPos[j][k] + 0.5;  //ѡ��k���������м���
//                    }
//                    //������������б�ĩβ���򲻼�
//                    if(j < x_trainPos.length - 1){
//                        j++;
//                    }
//                    //�������ĩβС�ڵ�ǰ���࣬���¼�ֽ�㣬������ѭ��
//                    else if(j == x_trainPos.length - 1 && x_trainPos[j][k] < x_trainNeg[l][k]){
//                        borderleft[h] = 1;  //l��׷j����߽�Ϊ-1
//                        borderIndex[h++] = x_trainPos[j][k] + 0.5;  //ѡ��k���������м���
//                        break;
//                    }
//                }
//                //[j] > [l], l++
//                else{
//                    //��ǰԤ�����λ���ǲ��Ǳ߽�
//                    if(l + 1 < x_trainNeg.length && x_trainNeg[l + 1][k] >= x_trainPos[j][k]){
//                        borderleft[h] = -1;  //l��׷j����߽�Ϊ-1
//                        borderIndex[h++] = x_trainNeg[l][k] + 0.5;  //ѡ��k���������м���
//                    }
//                    //������˸����б�ĩβ���򲻼�
//                    if(l < x_trainNeg.length - 1){
//                        l++;
//                    }
//                    //�������ĩβС�ڵ�ǰ���࣬���¼�ֽ�㣬������ѭ��
//                    else if(l == x_trainNeg.length - 1 && x_trainNeg[l][k] < x_trainPos[j][k]){
//                        borderleft[h] = -1;  //l��׷j����߽�Ϊ-1
//                        borderIndex[h++] = x_trainNeg[l][k] + 0.5;  //ѡ��k���������м���
//                        break;
//                    }
//                }
//            }
//
//            //���pos,neg������ĩβ
//            if(j == x_trainPos.length - 1 && l == x_trainNeg.length - 1){
//                //���posĩβԪ��С��negĩβԪ�أ���borderleft = 1
//                if (x_trainPos[j][k] < x_trainNeg[l][k]){
//                    borderleft[h] = 1;
//                    borderIndex[h++] = x_trainPos[j][k] + 0.5;  //ѡ��k���������м���
//                }
//                //���negĩβԪ��С��posĩβԪ�أ���borderleft = -1
//                else if(x_trainNeg[l][k] < x_trainPos[j][k]){
//                    borderleft[h] = -1;
//                    borderIndex[h++] = x_trainNeg[l][k] + 0.5;  //ѡ��k���������м���
//                }
//            }
//
//            double e_temp[] = new double[h]; //���б߽����ȡ���ķ��������
//            for (int i = 0; i < h; i++) {
//
//                double temp = 0.0;
//
//                //ע���ж��������Ƕ��Ӽ����Ե�
//                for (int n = 0; n < list.size(); n++) {
//                    //�ۼ����w��������
//                    if(x_train[list.get(n)][k] < borderIndex[i]){
//                        if(y_train[list.get(n)] != borderleft[i]){
//                            temp += w[list.get(n)] * 1;
//                        }
//                    }
//                    //�ۼ��ұ�w��������
//                    else{
//                        if(y_train[list.get(n)] != borderleft[i] * (-1)){
//                            temp += w[list.get(n)] * 1;
//                        }
//                    }
//                }
//
//                //ע�����е�Ȩֵ*{1��-1}����п��ܵ���double��0�����double��0�ڷ�ĸ�ϣ������NaN��-Infinity,Infinity
//                e_temp[i] = temp;
//            }
//
//            if(!flag){
//                //����õ��������¸�����������Сe_m,�Լ��߽��������߽���ߵ�ֵ
//                double min_temp  = e_temp[0];
//                borderIndex_k[k] = borderIndex[0];
//                borderleft_k[k] = borderleft[0];
//                for (int i = 1; i < h; i++) {
//                    //ȥ��e_temp[i] = 0
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
//            //����������������С��em��ȫ�֣�,������Ӧ��borderIndex��borderLeft�����ڸ��ڵ���
//            double min = eTemp[m][0];
//            root.featureIndex = 0;  //��¼Ҫ���ֵ�����
//            root.borderIndex = borderIndex_k[0];  //��¼Ҫ���ֵ������߽�����
//            root.borderLeft = borderleft_k[0];  //��¼Ҫ���ֵ���������߽�
//            for (int i = 0; i < dimensions; i++) {
//                if(eTemp[m][i] < min && !featureSelected.contains(i)){
//                    e[m] = eTemp[m][i];
//                    root.featureIndex = i;  //��¼Ҫ���ֵ�����
//                    root.borderIndex = borderIndex_k[i];  //��¼Ҫ���ֵ������߽�����
//                    root.borderLeft = borderleft_k[i];  //��¼Ҫ���ֵ���������߽�
//                }
//            }
//            featureSelected.add(root.featureIndex);
//        }
//
//        if(!flag){
//            /**
//             * step3: ���������з������зֵ㻮�����ݼ���
//             */
//            //�����ֵļ��ϱ����ڽڵ���(ֻ���������±꣩
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
//             * step4��������������
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
//            //ȫ����featureSelected
//            Set<Integer> featureSelected1 = new HashSet<>();
//            for (Integer i: featureSelected) {
//                featureSelected1.add(i);
//            }
//
//            boolean left = true;
//            double em1 = createDecisionTree(root.leftChild, x_list1, eTemp, m,featureSelected,left,false);  //left,right��ʶ������ʾ���������ݹ黹���������ݹ�
//            boolean right = true;
//            double em2 = createDecisionTree(root.rightChild, x_list2, eTemp, m,featureSelected1,false,right);
//            return em1 + em2;
//        }
//        //��root�ڵ㱾������Ҷ�ӽڵ�
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
//     * ͨ���������Ĳ�α���������������Ҷ�ӽڵ㴮��������������ͷ���
//     * �������Z[m]
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
//    //Ԥ���������
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
//            score[index] = result; //��¼ʵ�ʵ÷֣�����ʹ��softMax��һ�����������Ԥ��󣬵õ���ÿ��Ԥ���������ķ������
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
//        System.out.println("��" + (m+1) + "��");
//        System.out.println("root");
//
//        BTNode last = root;  //lastָ��ÿһ�����ҽڵ�
//        int levelTemp = 0; //��ǰ����(�Ե����Ľڵ�Ϊ׼��
//        int floor = 0; //����ڵ�Ĳ���, floor��levelTemp���һ��ʱ������
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
//                System.out.print("��� " + featureNames[btNode.featureIndex] + " < " + btNode.borderIndex + "   ");
//                queue.offer(btNode.leftChild);
//                floor = btNode.leftChild.floor;
//            }
//            if(btNode.rightChild != null){
//                System.out.print("�ҡ�" + featureNames[btNode.featureIndex] + " > " + btNode.borderIndex + "   ");
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
////                System.out.print("�ң�" + q.parent.borderLeft * (-1) + "           ");
////            }else{
////                System.out.print("��" + q.parent.borderLeft + "           ");
////            }
////            count++;
////        }
//
//        BTNode p = head;
//        System.out.println();
//        while (p.next != null){
//            p = p.next;
//            if(p.parent.leftChild != null && p.isLeftChild){
//                System.out.print("��" + p.parent.borderLeft + "           ");
//            }
//            if(p.parent.rightChild != null && p.isRightChild){
//                System.out.print("�ң�" + p.parent.borderLeft * (-1) + "           ");
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
