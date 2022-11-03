package upload;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

@Service("uploadservice")
public class UploadServiceImpl implements UploadService{

	@Autowired
	@Qualifier("uploaddao")
	UploadDAO uploadDAO;
	
	@Override
	public int insertFile(UploadDTO dto) {
		return uploadDAO.insertFile(dto);
	}

	@Override
	public void deleteFile(int product_num) {
		uploadDAO.deleteFile(product_num);
	}
}
