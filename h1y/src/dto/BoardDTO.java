package dto;

public class BoardDTO {

	private int boardId;
	private String boardWriter;
	private String boardTitle;
	private String boardContent;
	private String boardCreateDate;
	private String boardUpdateDate;
	private int boardHit;
	
	public int getBoardId() {
		return boardId;
	}
	public void setBoardId(int boardId) {
		this.boardId = boardId;
	}
	public String getBoardWriter() {
		return boardWriter;
	}
	public void setBoardWriter(String boardWriter) {
		if (boardWriter == null) boardWriter = "boardWriter Null";
		this.boardWriter = boardWriter;
	}
	public String getBoardTitle() {
		return boardTitle;
	}
	public void setBoardTitle(String boardTitle) {
		if (boardTitle == null) boardTitle = "boardTitle Null";
		this.boardTitle = boardTitle;
	}
	public String getBoardContent() {
		return boardContent;
	}
	public void setBoardContent(String boardContent) {
		if (boardContent == null) boardContent = "boardContent Null";
		this.boardContent = boardContent;
	}
	public String getBoardCreateDate() {
		return boardCreateDate;
	}
	public void setBoardCreateDate(String boardCreateDate) {
		if (boardCreateDate == null) boardCreateDate = "boardCreateDate Null";
		this.boardCreateDate = boardCreateDate;
	}
	public String getBoardUpdateDate() {
		return boardUpdateDate;
	}
	public void setBoardUpdateDate(String boardUpdateDate) {
		if (boardUpdateDate == null) boardUpdateDate = "boardUpdateDate Null";
		this.boardUpdateDate = boardUpdateDate;
	}
	public int getBoardHit() {
		return boardHit;
	}
	public void setBoardHit(int boardHit) {
		this.boardHit = boardHit;
	}
	
	@Override
	public String toString() {
		return "BoardDTO [boardId=" + boardId + ", boardWriter=" + boardWriter + ", boardTitle=" + boardTitle
				+ ", boardContent=" + boardContent + ", boardCreateDate=" + boardCreateDate + ", boardUpdateDate="
				+ boardUpdateDate + ", boardHit=" + boardHit + "]";
	}
	
	
	
}
