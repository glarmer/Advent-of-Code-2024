import java.util.ArrayList;

public class AdventOfCode {

    public ArrayList<Integer> convertRow(String[] row) {
        ArrayList<Integer> intRow = new ArrayList<Integer>();
        for(int i = 0;i < row.length;i++)
        {
            intRow.add(Integer.parseInt(row[i]));
        }
        return intRow;
    }

    public boolean validateRow(ArrayList<Integer> row, int task, boolean levelRemoved) {
        boolean decreasing = true;
        boolean increasing = true;
        boolean errored = false;
        for (int i = 1; i < row.size(); i++) {
            if (Math.abs(row.get(i) - row.get(i - 1)) > 3 || Math.abs(row.get(i) - row.get(i - 1)) < 1) {
                errored = true;
            }
            if (row.get(i - 1) < row.get(i)) {
                decreasing = false;
            }
            if (row.get(i - 1) > row.get(i)) {
                increasing = false;
            }
            if ((decreasing || increasing) == false && !levelRemoved) {
                errored = true;
            }
        }

        if (task == 2) {
            if (errored && !levelRemoved) {
                for (int i = 0; i < row.size(); i++) {
                    ArrayList<Integer> copy = new ArrayList<>(row);
                    copy.remove(i);
                    boolean result = validateRow(copy, 2, true);
                    if (result) {
                        return true;
                    }
                }
            }
        }

        return (decreasing || increasing) && !errored;
    }
}