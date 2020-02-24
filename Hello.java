/** Traditional first program.
* @author Toan Phan */

public class Hello {
    public void MultiArray() {
        /** Method for processing multi-dimensional arrays*/
        //Three dimensional array
        int[][][] arr = {{{1, 2}, {3, 4}}, {{5, 6}, {7, 8}}};
        for (int a = 0; a < arr.length; a++) {
            for (int b = 0; b < arr[a].length; b++) {
                for (int c = 0; c < arr[a][b].length; c++) {
                    System.out.println("Hello " + arr[a][b][c]);
                }
            }
        }
    }

    public static void main(String[] args) {
        /** This is the main method for the Hello class */
        System.out.println("Hello World! How are you? My name is Toan Phan.");
        Integer[] someInts = { 1, 2, 3 };
        for (int x : someInts) {
            System.out.println(x);
        }
        System.out.println(someInts[0]);
    }
}