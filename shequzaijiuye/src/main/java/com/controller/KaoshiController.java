
package com.controller;

import java.io.File;
import java.math.BigDecimal;
import java.net.URL;
import java.text.SimpleDateFormat;
import com.alibaba.fastjson.JSONObject;
import java.util.*;
import org.springframework.beans.BeanUtils;
import javax.servlet.http.HttpServletRequest;
import org.springframework.web.context.ContextLoader;
import javax.servlet.ServletContext;
import com.service.TokenService;
import com.utils.*;
import java.lang.reflect.InvocationTargetException;

import com.service.DictionaryService;
import org.apache.commons.lang3.StringUtils;
import com.annotation.IgnoreAuth;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.entity.*;
import com.entity.view.*;
import com.service.*;
import com.utils.PageUtils;
import com.utils.R;
import com.alibaba.fastjson.*;

/**
 * 考试
 * 后端接口
 * @author
 * @email
*/
@RestController
@Controller
@RequestMapping("/kaoshi")
public class KaoshiController {
    private static final Logger logger = LoggerFactory.getLogger(KaoshiController.class);

    @Autowired
    private KaoshiService kaoshiService;


    @Autowired
    private TokenService tokenService;
    @Autowired
    private DictionaryService dictionaryService;

    //级联表service
    @Autowired
    private LaoshiService laoshiService;

    @Autowired
    private RenyuanService renyuanService;


    /**
    * 后端列表
    */
    @RequestMapping("/page")
    public R page(@RequestParam Map<String, Object> params, HttpServletRequest request){
        logger.debug("page方法:,,Controller:{},,params:{}",this.getClass().getName(),JSONObject.toJSONString(params));
        String role = String.valueOf(request.getSession().getAttribute("role"));
        if(false)
            return R.error(511,"永不会进入");
        else if("再就业人员".equals(role))
            params.put("renyuanId",request.getSession().getAttribute("userId"));
        else if("老师".equals(role))
            params.put("laoshiId",request.getSession().getAttribute("userId"));
        if(params.get("orderBy")==null || params.get("orderBy")==""){
            params.put("orderBy","id");
        }
        PageUtils page = kaoshiService.queryPage(params);

        //字典表数据转换
        List<KaoshiView> list =(List<KaoshiView>)page.getList();
        for(KaoshiView c:list){
            //修改对应字典表字段
            dictionaryService.dictionaryConvert(c, request);
        }
        return R.ok().put("data", page);
    }

    /**
    * 后端详情
    */
    @RequestMapping("/info/{id}")
    public R info(@PathVariable("id") Long id, HttpServletRequest request){
        logger.debug("info方法:,,Controller:{},,id:{}",this.getClass().getName(),id);
        KaoshiEntity kaoshi = kaoshiService.selectById(id);
        if(kaoshi !=null){
            //entity转view
            KaoshiView view = new KaoshiView();
            BeanUtils.copyProperties( kaoshi , view );//把实体数据重构到view中

                //级联表
                LaoshiEntity laoshi = laoshiService.selectById(kaoshi.getLaoshiId());
                if(laoshi != null){
                    BeanUtils.copyProperties( laoshi , view ,new String[]{ "id", "createTime", "insertTime", "updateTime"});//把级联的数据添加到view中,并排除id和创建时间字段
                    view.setLaoshiId(laoshi.getId());
                }
            //修改对应字典表字段
            dictionaryService.dictionaryConvert(view, request);
            return R.ok().put("data", view);
        }else {
            return R.error(511,"查不到数据");
        }

    }

    /**
    * 后端保存
    */
    @RequestMapping("/save")
    public R save(@RequestBody KaoshiEntity kaoshi, HttpServletRequest request){
        logger.debug("save方法:,,Controller:{},,kaoshi:{}",this.getClass().getName(),kaoshi.toString());

        String role = String.valueOf(request.getSession().getAttribute("role"));
        if(false)
            return R.error(511,"永远不会进入");
        else if("老师".equals(role))
            kaoshi.setLaoshiId(Integer.valueOf(String.valueOf(request.getSession().getAttribute("userId"))));

        Wrapper<KaoshiEntity> queryWrapper = new EntityWrapper<KaoshiEntity>()
            .eq("laoshi_id", kaoshi.getLaoshiId())
            .eq("kaoshi_uuid_number", kaoshi.getKaoshiUuidNumber())
            .eq("kaoshi_name", kaoshi.getKaoshiName())
            .eq("kaoshi_address", kaoshi.getKaoshiAddress())
            .eq("kaoshi_types", kaoshi.getKaoshiTypes())
            ;

        logger.info("sql语句:"+queryWrapper.getSqlSegment());
        KaoshiEntity kaoshiEntity = kaoshiService.selectOne(queryWrapper);
        if(kaoshiEntity==null){
            kaoshi.setInsertTime(new Date());
            kaoshi.setCreateTime(new Date());
            kaoshiService.insert(kaoshi);
            return R.ok();
        }else {
            return R.error(511,"表中有相同数据");
        }
    }

    /**
    * 后端修改
    */
    @RequestMapping("/update")
    public R update(@RequestBody KaoshiEntity kaoshi, HttpServletRequest request){
        logger.debug("update方法:,,Controller:{},,kaoshi:{}",this.getClass().getName(),kaoshi.toString());

        String role = String.valueOf(request.getSession().getAttribute("role"));
//        if(false)
//            return R.error(511,"永远不会进入");
//        else if("老师".equals(role))
//            kaoshi.setLaoshiId(Integer.valueOf(String.valueOf(request.getSession().getAttribute("userId"))));
        //根据字段查询是否有相同数据
        Wrapper<KaoshiEntity> queryWrapper = new EntityWrapper<KaoshiEntity>()
            .notIn("id",kaoshi.getId())
            .andNew()
            .eq("laoshi_id", kaoshi.getLaoshiId())
            .eq("kaoshi_uuid_number", kaoshi.getKaoshiUuidNumber())
            .eq("kaoshi_name", kaoshi.getKaoshiName())
            .eq("kaoshi_address", kaoshi.getKaoshiAddress())
            .eq("kaoshi_types", kaoshi.getKaoshiTypes())
            ;

        logger.info("sql语句:"+queryWrapper.getSqlSegment());
        KaoshiEntity kaoshiEntity = kaoshiService.selectOne(queryWrapper);
        if(kaoshiEntity==null){
            kaoshiService.updateById(kaoshi);//根据id更新
            return R.ok();
        }else {
            return R.error(511,"表中有相同数据");
        }
    }

    /**
    * 删除
    */
    @RequestMapping("/delete")
    public R delete(@RequestBody Integer[] ids){
        logger.debug("delete:,,Controller:{},,ids:{}",this.getClass().getName(),ids.toString());
        kaoshiService.deleteBatchIds(Arrays.asList(ids));
        return R.ok();
    }


    /**
     * 批量上传
     */
    @RequestMapping("/batchInsert")
    public R save( String fileName, HttpServletRequest request){
        logger.debug("batchInsert方法:,,Controller:{},,fileName:{}",this.getClass().getName(),fileName);
        Integer yonghuId = Integer.valueOf(String.valueOf(request.getSession().getAttribute("userId")));
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        try {
            List<KaoshiEntity> kaoshiList = new ArrayList<>();//上传的东西
            Map<String, List<String>> seachFields= new HashMap<>();//要查询的字段
            Date date = new Date();
            int lastIndexOf = fileName.lastIndexOf(".");
            if(lastIndexOf == -1){
                return R.error(511,"该文件没有后缀");
            }else{
                String suffix = fileName.substring(lastIndexOf);
                if(!".xls".equals(suffix)){
                    return R.error(511,"只支持后缀为xls的excel文件");
                }else{
                    URL resource = this.getClass().getClassLoader().getResource("../../upload/" + fileName);//获取文件路径
                    File file = new File(resource.getFile());
                    if(!file.exists()){
                        return R.error(511,"找不到上传文件，请联系管理员");
                    }else{
                        List<List<String>> dataList = PoiUtil.poiImport(file.getPath());//读取xls文件
                        dataList.remove(0);//删除第一行，因为第一行是提示
                        for(List<String> data:dataList){
                            //循环
                            KaoshiEntity kaoshiEntity = new KaoshiEntity();
//                            kaoshiEntity.setLaoshiId(Integer.valueOf(data.get(0)));   //老师 要改的
//                            kaoshiEntity.setKaoshiUuidNumber(data.get(0));                    //考试编号 要改的
//                            kaoshiEntity.setKaoshiName(data.get(0));                    //考试名称 要改的
//                            kaoshiEntity.setKaoshiAddress(data.get(0));                    //考试地点 要改的
//                            kaoshiEntity.setKaoshiTime(sdf.parse(data.get(0)));          //考试时间 要改的
//                            kaoshiEntity.setKaoshiTypes(Integer.valueOf(data.get(0)));   //考试类型 要改的
//                            kaoshiEntity.setKaoshiContent("");//详情和图片
//                            kaoshiEntity.setInsertTime(date);//时间
//                            kaoshiEntity.setCreateTime(date);//时间
                            kaoshiList.add(kaoshiEntity);


                            //把要查询是否重复的字段放入map中
                                //考试编号
                                if(seachFields.containsKey("kaoshiUuidNumber")){
                                    List<String> kaoshiUuidNumber = seachFields.get("kaoshiUuidNumber");
                                    kaoshiUuidNumber.add(data.get(0));//要改的
                                }else{
                                    List<String> kaoshiUuidNumber = new ArrayList<>();
                                    kaoshiUuidNumber.add(data.get(0));//要改的
                                    seachFields.put("kaoshiUuidNumber",kaoshiUuidNumber);
                                }
                        }

                        //查询是否重复
                         //考试编号
                        List<KaoshiEntity> kaoshiEntities_kaoshiUuidNumber = kaoshiService.selectList(new EntityWrapper<KaoshiEntity>().in("kaoshi_uuid_number", seachFields.get("kaoshiUuidNumber")));
                        if(kaoshiEntities_kaoshiUuidNumber.size() >0 ){
                            ArrayList<String> repeatFields = new ArrayList<>();
                            for(KaoshiEntity s:kaoshiEntities_kaoshiUuidNumber){
                                repeatFields.add(s.getKaoshiUuidNumber());
                            }
                            return R.error(511,"数据库的该表中的 [考试编号] 字段已经存在 存在数据为:"+repeatFields.toString());
                        }
                        kaoshiService.insertBatch(kaoshiList);
                        return R.ok();
                    }
                }
            }
        }catch (Exception e){
            e.printStackTrace();
            return R.error(511,"批量插入数据异常，请联系管理员");
        }
    }






}
