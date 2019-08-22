import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class test {
    public static List<Integer> getOneBits(int n) {
        // Write your code here
        List<Integer> temp = new ArrayList<Integer>();
        List<Integer> result = new ArrayList<Integer>();
        for(int i = n;i>=1;i=i/2){
            if(i%2 == 0){
                temp.add(0);
            }else{
                temp.add(1);
            }
        }
        int count = 0;
        Collections.reverse(temp);
        for(int j = 0;j<temp.size();j++){
            if(temp.get(j) != 0){
                result.add(j+1);
                ++count;
            }
        }
        result.add(0,count);
        for(int a : result){
            System.out.println(a);
        }
        System.out.println(temp);
        return result;

    }



    public static void main(String[] args) {
        test t = new test();
        List<Integer> l = new ArrayList<Integer>();
        l = t.getOneBits(161);
        System.out.println(l);
    }
}
