import Vue from 'vue'
import Router from 'vue-router'

Vue.use(Router)

/* Layout */
import Layout from '@/layout'

/**
 * Note: sub-menu only appear when route children.length >= 1
 * Detail see: https://panjiachen.github.io/vue-element-admin-site/guide/essentials/router-and-nav.html
 *
 * hidden: true                   if set true, item will not show in the sidebar(default is false)
 * alwaysShow: true               if set true, will always show the root menu
 *                                if not set alwaysShow, when item has more than one children route,
 *                                it will becomes nested mode, otherwise not show the root menu
 * redirect: noRedirect           if set noRedirect will no redirect in the breadcrumb
 * name:'router-name'             the name is used by <keep-alive> (must set!!!)
 * meta : {
    roles: ['admin','editor']    control the page roles (you can set multiple roles)
    title: 'title'               the name show in sidebar and breadcrumb (recommend set)
    icon: 'svg-name'/'el-icon-x' the icon show in the sidebar
    breadcrumb: false            if set false, the item will hidden in breadcrumb(default is true)
    activeMenu: '/example/list'  if set path, the sidebar will highlight the path you set
  }
 */

/**
 * constantRoutes
 * a base page that does not have permission requirements
 * all roles can be accessed
 */
export const constantRoutes = [
  {
    path: '/login',
    component: () => import('@/views/login/index'),
    hidden: true
  },

  {
    path: '/404',
    component: () => import('@/views/404'),
    hidden: true
  },

  {
    path: '/',
    component: Layout,
    redirect: '/dashboard',
    children: [{
      path: 'dashboard',
      name: 'Dashboard',
      component: () => import('@/views/dashboard/index'),
      meta: { title: '首页', icon: 'dashboard', affix: true }
    }]
  }
]

/**
 * asyncRoutes
 * the routes that need to be dynamically loaded based on user roles
 */
export const asyncRoutes = [

  // {
  //   path: '/system',
  //   component: Layout,
  //   alwaysShow: true,
  //   name: 'system',
  //   meta: { title: '系统管理', icon: 'el-icon-s-help' },
  //   children: [
  //     {
  //       path: '/sysUserList',
  //       name: 'sysUserList',
  //       component: () => import('@/views/system/sysUserList'),
  //       meta: { title: '用户管理', icon: 'table' }
  //     },
  //     {
  //       path: '/sysRoleList',
  //       name: 'sysRoleList',
  //       component: () => import('@/views/system/sysRoleList'),
  //       meta: { title: '角色管理', icon: 'tree' }
  //     },
  //     {
  //       path: '/sysMenuList',
  //       name: 'sysMenuList',
  //       component: () => import('@/views/system/sysMenuList'),
  //       meta: { title: '菜单管理', icon: 'tree' }
  //     }
  //   ]
  // },
  // {
  //   path: '/colloge',
  //   component: Layout,
  //   name: 'colloge',
  //   alwaysShow: true,
  //   meta: { title: '学院管理', icon: 'el-icon-s-help' },
  //   children: [
  //     {
  //       path: '/collogeList',
  //       name: 'collogeList',
  //       component: () => import('@/views/colloge/collogeList'),
  //       meta: { title: '学院管理', icon: 'table' }
  //     },
  //     {
  //       path: '/majorList',
  //       name: 'majorList',
  //       component: () => import('@/views/colloge/majorList'),
  //       meta: { title: '专业管理', icon: 'tree' }
  //     },
  //     {
  //       path: '/classList',
  //       name: 'classList',
  //       component: () => import('@/views/colloge/classList'),
  //       meta: { title: '班级管理', icon: 'tree' }
  //     }
  //   ]
  // },
  // {
  //   path: '/stuRoot',
  //   component: Layout,
  //   alwaysShow: true,
  //   name: 'stuRoot',
  //   meta: { title: '学生管理', icon: 'el-icon-s-help' },
  //   children: [
  //     {
  //       path: '/stuList',
  //       name: 'stuList',
  //       component: () => import('@/views/student/stuList'),
  //       meta: { title: '学生列表', icon: 'table' }
  //     }
  //   ]
  // },
  // {
  //   path: '/buildRoot',
  //   component: Layout,
  //   alwaysShow: true,
  //   name: 'buildRoot',
  //   meta: { title: '宿舍管理', icon: 'el-icon-s-help' },
  //   children: [
  //     {
  //       path: '/buildList',
  //       name: 'buildList',
  //       component: () => import('@/views/drom/buildList'),
  //       meta: { title: '楼栋管理', icon: 'table' }
  //     },
  //     {
  //       path: '/buildCode',
  //       name: 'buildCode',
  //       component: () => import('@/views/drom/buildCode'),
  //       meta: { title: '设置编号', icon: 'table' }
  //     },
  //     {
  //       path: '/houseList',
  //       name: 'houseList',
  //       component: () => import('@/views/drom/houseList'),
  //       meta: { title: '宿舍管理', icon: 'table' }
  //     }
  //   ]
  // },
  // 404 page must be placed at the end !!!
  // { path: '*', redirect: '/404', hidden: true }
]

const createRouter = () => new Router({
  // mode: 'history', // require service support
  scrollBehavior: () => ({ y: 0 }),
  routes: constantRoutes
})

const router = createRouter()

// Detail see: https://github.com/vuejs/vue-router/issues/1234#issuecomment-357941465
export function resetRouter() {
  const newRouter = createRouter()
  router.matcher = newRouter.matcher // reset router
}

export default router
