import http from "@/utils/http";
//新增
export const addApi = async(parm)=>{
    return await http.post("/api/into",parm)
}
//列表
export const listApi = async(parm)=>{
    return await http.get("/api/into/list",parm)
}
//编辑
export const editApi = async(parm)=>{
    return await http.put("/api/into",parm)
}
//删除
export const deleteApi = async(parm)=>{
    return await http.delete("/api/into",parm)
}