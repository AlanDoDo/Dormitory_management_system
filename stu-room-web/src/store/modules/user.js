import { login, logout, getInfo,loginApi } from '@/api/user'
import { getToken, setToken, removeToken,setUserId ,setUserType,getUserId,getUserType,clearSession} from '@/utils/auth'
import { resetRouter } from '@/router'

const getDefaultState = () => {
  return {
    token: getToken(),
    name: '',
    avatar: '',
    roles: []
  }
}

const state = getDefaultState()

const mutations = {
  RESET_STATE: (state) => {
    Object.assign(state, getDefaultState())
  },
  SET_TOKEN: (state, token) => {
    state.token = token
  },
  SET_NAME: (state, name) => {
    state.name = name
  },
  SET_AVATAR: (state, avatar) => {
    state.avatar = avatar
  },
  SET_ROLES: (state, roles) => {
    state.roles = roles
  }
}

const actions = {
  // user login
  login({ commit }, userInfo) {
    const { username, password ,userType,code} = userInfo
    return new Promise((resolve, reject) => {
      loginApi({ username: username.trim(), password: password ,userType:userType,code:code}).then(response => {
        const { data } = response
        console.log(data)
        // commit('SET_TOKEN', data.token)
        //采用的是mock的数据，目的是进入首页
        // commit('SET_TOKEN', 'admin-token')
        commit('SET_TOKEN', data.token)
        setToken(data.token)
        //设置用户id
        setUserId(data.userId)
        //设置用户类型
        setUserType(data.userType)
        resolve()
      }).catch(error => {
        reject(error)
      })
    })
  },

  // get user info
  getInfo({ commit, state }) {
    return new Promise((resolve, reject) => {
      getInfo({userId:getUserId(),userType:getUserType()}).then(response => {
        const { data } = response
        console.log('获取用户信息')
        console.log(response)
        if (!data) {
          reject('Verification failed, please Login again.')
        }

        const { roles, name, avatar } = data

        // roles must be a non-empty array
        if (!roles || roles.length <= 0) {
          reject('getInfo: roles must be a non-null array!')
        }

        commit('SET_ROLES', roles)
        commit('SET_NAME', name)
        commit('SET_AVATAR', require('@/assets/images/login_bg.png'))
        resolve(data)
      }).catch(error => {
        reject(error)
      })
    })
  },

  // user logout
  logout({ commit, state,dispatch }) {
    return new Promise((resolve, reject) => {
      logout(state.token).then(() => {
        removeToken() // must remove  token  first
        resetRouter()
        commit('RESET_STATE')
        //清空tagsview里面的数据
        dispatch('tagsView/delAllViews', {}, { root: true })
        clearSession()
        resolve()
      }).catch(error => {
        reject(error)
      })
    })
  },

  // remove token
  resetToken({ commit }) {
    return new Promise(resolve => {
      removeToken() // must remove  token  first
      commit('RESET_STATE')
      resolve()
    })
  }
}

export default {
  namespaced: true,
  state,
  mutations,
  actions
}

