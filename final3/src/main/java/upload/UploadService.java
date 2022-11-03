package upload;



public interface UploadService {

	int insertFile(UploadDTO dto);
	void deleteFile(int product_num);
}
