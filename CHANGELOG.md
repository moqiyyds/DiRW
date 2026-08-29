# 更新日志

本项目遵循 [Keep a Changelog](https://keepachangelog.com/zh-CN/1.1.0/) 格式，
版本号遵循语义化版本。

## [2.5] - 2026-08-29

### 新增

- **TGodRW 后端**：对接自研内核模块 DiDevice.kpm（hook `inet_ioctl`，通过任意 inet
  socket 的 `ioctl` 通信），支持有缓存/无缓存读取与写入内存
- **读模式作用域**：`TGodRW` 的有缓存/无缓存读模式复用 PID 的 Global/Private 语义，
  可全局切换（`setGlobalMod`）或按实例独立（构造第三个参数），多线程互不干扰
- **CMake 构建**：新增 `CMakeLists.txt`，与 `Android.mk` 等价，兼容命令行与
  Android Studio `externalNativeBuild`

### 变更

- **连接状态统一管理**：`connected` 标志上收到 `baseRW` 基类，`isConnected()` 查询；
  驱动对接失败不再退出进程（移除 `exit(1)` 式错误处理），由调用方决定后续逻辑
- **线程安全**：全局 PID（`baseRW::globalPid`）与 TGod 读模式（`globalMod`）改为
  `std::atomic` + relaxed 序，多线程切换立即可见
- **修复**：`Qx11RW`/`RtRW` 的 `fd` 成员未初始化，构造失败路径下析构可能 close 随机句柄
- **文档**：修正 `syscallRW` 的 root 要求描述（跨 UID 进程需要 root）；README 按
  仓库新布局重写

### 移除

- **leidiRW 后端**：由 TGodRW 取代
