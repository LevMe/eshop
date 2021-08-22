package com.Eshop.controller;

import com.Eshop.utils.SystemContext;
import com.Eshop.utils.UUIDUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

/**
 * @Description: ueditor上传文件处理
 * @Author: Liyunhan
 * @Date: 2021/5/4 14:32
 */
@Controller
@RequestMapping("/ueditor")
public class UeditorController {

    /**
     * 实现富文本框上传多类型文件功能 , 不跳转页面 , 直接返回map给ueditor处理
     * @param file
     * @return
     * @throws IOException
     */
    @ResponseBody
    @RequestMapping("/saveFile")
    public Map<String,Object> saveFile(@RequestParam(value = "upfile",required = false) MultipartFile file) throws IOException {
        //获取参数map
        HashMap<String, Object> params = new HashMap<>();

        String n = UUIDUtils.create();
        //获取随机文件名  (注意此处 SystemContext.getRealPath() 后面已经带了斜杠,因此resource前面不要带斜杠)
        String path = SystemContext.getRealPath() + "resource\\ueditor\\upload\\" + n + file.getOriginalFilename();
        File newFile = new File(path);
        //通过CommonsMultipartFile的方法直接写文件到路径
        file.transferTo(newFile);

        String visitUrl = "/resource/ueditor/upload/" + n + file.getOriginalFilename();
        //将内容写进map (注意ueditor状态码要求大写)
        params.put("state","SUCCESS");
        params.put("url",visitUrl);
        params.put("size",file.getSize());
        params.put("original",file.getOriginalFilename());
        params.put("type",file.getContentType());

        return params;
    }
}
