/** Traditional first program.
* @author Toan Phan */

public class Hello {
	public static void main(String[] args) {
		System.out.println("Hello World! How are you? My name is Toan Phan.");

		//Three dimensional array
		int[][][] arr = { {{1, 2}, {3, 4}},  {{5, 6}, {7, 8}} };
		for (int a = 0; a < arr.length; a ++) {
			for (int b = 0; b < arr[a].length; b++) {
				for (int c = 0; c < arr[a][b].length; c++) {
					System.out.println("Hello " + arr[a][b][c]);
				}
			}
		}

		Int[][][] M = new Int[width][height][9];
        for (int x0 = 0; x0 < width; x0 += 1) {

            for (int y0 = 0; y0 < height; y0 += 1) {

                int[][] places0 = M[x0][y0];

                for (int dir = 1; dir <= 8; dir += 1) {  // dir = 0 -> dir = 1
                    places0[dir] = new int[];
                }

                for (int x1 = 0; x1 < width; x1 += 1) { //x0->x1

                    for (int y1 = 0; y1 < height; y1 += 1) {
                    	
                        int dir = dirOf(x0, y0, x1, y1);
                        Place p = pl(x1, y1);
                        places0[dir].add(p);
                        places0[0].add(p);
                    }
                }
            }
        }

	}
}