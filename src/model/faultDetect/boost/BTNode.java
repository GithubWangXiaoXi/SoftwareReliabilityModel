package model.faultDetect.boost;

import java.util.LinkedList;

import java.util.LinkedList;

/**
 * �������ڵ�
 */
public class BTNode {

    public boolean isLeaf;  //�ж��ǲ���Ҷ�ӽڵ�
    public boolean isLeftChild;  //�ж��ǲ�����Ҷ�ӽڵ�
    public boolean isRightChild;  //�ж��ǲ�����Ҷ�ӽڵ�
    public BTNode leftChild;
    public BTNode rightChild;
    public BTNode parent;  //����ͨ��Ҷ�ӽڵ���������em
    public Integer floor; //���ڲ���
    public Integer featureIndex; //�ò�ڵ������
    // public List<Integer> interval; //���䣨ÿ���ڵ�ֻ�������ӽڵ㣬���������߽߱缰������ʾ��
    public double borderIndex; //�߽�����
    public double borderLeft; //��߽߱�

    public BTNode next;  //����������Ҷ�ӽڵ㴮��������������ͷ��㷽�����Z[m],����w[m]
    public LinkedList<Integer> train_list;  //ÿ��Ҷ�ӽڵ��ŵ�ѵ�����ݼ���
    public BTNode leafPosNode;  //���Ϊ�����Ҷ�ӽڵ�
    public double probability;  //�����䵽��Ҷ�ӽڵ��ϣ����Ϊ����ĸ���
    public boolean isPrint;  //�жϸ�Ҷ�ӽڵ��Ӧ�ĸ��ʽڵ��Ƿ��ӡ
}