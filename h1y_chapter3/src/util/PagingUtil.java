package util;

import java.util.ArrayList;
import java.util.List;

public class PagingUtil {

	private List<Integer> list;
	private int totalCount;
	private int perpage;
	
	
//	private int startRow;
//	private int endRow;
	
	public PagingUtil(int totalCount, int perPage) {
		
		setTotalCount(totalCount);
		setPerpage(perPage);
		calculator();
		
	}
	
	private void calculator() {
		
		List<Integer> list = new ArrayList<Integer>();
		
		int totalPage = 0;
		
		if ( getTotalCount() % getPerpage() == 0 ) totalPage = getTotalCount() / getPerpage();
		else totalPage = ( getTotalCount() / getPerpage() ) + 1;
		
		System.out.println("PagingUtil totalPage ==== " + totalPage);
		
		for(int i=1; i<=totalPage; i++) {
			
			list.add(i);
			
		}
		
		setList(list);
		
	}
	
	public List<Integer> getList() {
		return list;
	}
	private void setList(List<Integer> list) {
		this.list = list;
	}
	public int getTotalCount() {
		return totalCount;
	}
	private void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}
	public int getPerpage() {
		return perpage;
	}
	private void setPerpage(int perpage) {
		this.perpage = perpage;
	}
}