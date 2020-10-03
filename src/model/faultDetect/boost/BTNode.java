package model.faultDetect.boost;

import java.util.LinkedList;

import java.util.LinkedList;

/**
 * 二叉树节点
 */
public class BTNode {

    public boolean isLeaf;  //判断是不是叶子节点
    public boolean isLeftChild;  //判断是不是左叶子节点
    public boolean isRightChild;  //判断是不是右叶子节点
    public BTNode leftChild;
    public BTNode rightChild;
    public BTNode parent;  //方便通过叶子节点计算误差率em
    public Integer floor; //所在层数
    public Integer featureIndex; //该层节点的特征
    // public List<Integer> interval; //区间（每个节点只有两个子节点，区间可用左边边界及索引表示）
    public double borderIndex; //边界索引
    public double borderLeft; //左边边界

    public BTNode next;  //将二叉树的叶子节点串联起来，并返回头结点方便计算Z[m],更新w[m]
    public LinkedList<Integer> train_list;  //每个叶子节点存放的训练数据集合
    public BTNode leafPosNode;  //标记为正类的叶子节点
    public double probability;  //样本落到该叶子节点上，标记为正类的概率
    public boolean isPrint;  //判断该叶子节点对应的概率节点是否打印
}