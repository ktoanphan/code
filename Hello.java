/** Traditional first program.
* @author Toan Phan */
import java.util.*;
import java.lang.String;

public class Hello {

    public static void main(String[ ] args) {
        int a = (byte) (64*2);
        System.out.println(a);

        ArrayList<Integer> intArr = new ArrayList<>();

        for (int i = 0; i < 100; i++) {
            intArr.add(i);
        }

        int[] arr = new int[16];
        for (int i = 0; i < arr.size(); i += 1) {
            arr.set(i, i % 8);
        }

        System.out.println(Integer.toBinaryString(156));
        System.out.println(intArr);



    }


}
