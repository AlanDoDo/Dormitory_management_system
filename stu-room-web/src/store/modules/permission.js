import { asyncRoutes, constantRoutes } from "@/router";
import { getMenuListApi } from "@/api/user.js";
import {getUserId,getUserType} from '@/utils/auth.js'
import Layout from '@/layout'
/**
 * Use meta.role to determine if the current user has permission
 * @param roles
 * @param route
 */
function hasPermission(roles, route) {
  if (route.meta && route.meta.roles) {
    return roles.some(role => route.meta.roles.includes(role));
  } else {
    return true;
  }
}

/**
 * Filter asynchronous routing tables by recursion
 * @param routes asyncRoutes
 * @param roles
 */
export function filterAsyncRoutes(routes, roles) {
  const res = [];
  
  routes.forEach(route => {
    const tmp = { ...route };
    if (hasPermission(roles, tmp)) {
      //动态生成路由
      const component = tmp.component;
      if(component){
        if(component == "Layout"){ //一级菜单
          tmp.component = Layout;
        }else{
          tmp.component = (resolve) => require([`@/views${component}.vue`],resolve)
        }
      }
      if (tmp.children) {
        tmp.children = filterAsyncRoutes(tmp.children, roles);
      }
      res.push(tmp);
    }
  });

  return res;
}

const state = {
  routes: [],
  addRoutes: []
};

const mutations = {
  SET_ROUTES: (state, routes) => {
    state.addRoutes = routes;
    state.routes = constantRoutes.concat(routes);
  }
};

const actions = {
   generateRoutes({ commit }, roles) {
    return new Promise(async resolve => {
      //获取菜单数据
    let res = await getMenuListApi({
      userId:getUserId(),
      userType:getUserType()
    })
    console.log('获取菜单数据')
    console.log(res)
      let accessedRoutes = filterAsyncRoutes(res.data, roles);
      // if (roles.includes("admin")) {
      //   accessedRoutes = asyncRoutes || [];
      // } else {
      //   accessedRoutes = filterAsyncRoutes(asyncRoutes, roles);
      // }
      commit("SET_ROUTES", accessedRoutes);
      resolve(accessedRoutes);
    });
  }
};

export default {
  namespaced: true,
  state,
  mutations,
  actions
};
