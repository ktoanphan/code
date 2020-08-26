/** Traditional first program.
* @author Toan Phan */
import java.util.*;
import java.lang.String;

public class Hello {


    public abstract class Traverser {
        @Override
        protected abstract void previsit(Digraph)
    }

    public static void main(String[ ] args) {
        for (int i = 0; i < 100; i ++) {
            System.out.println("i: " + i);
            for (int j = 0; j < i; j++) {
                System.out.println("j: " + j);
                for (int k = 0; k < j; k++) {
                    System.out.println("k: " + k);
                    System.out.println("move");
                }
            }
        }

    }
}
