#pragma once
#if defined _WIN32 || defined __CYGWIN__
#ifdef __GNUC__
#define PX_API __attribute__((dllexport))
#else
#define PX_API __declspec(dllexport)
#endif
#else
#define PX_API __attribute__((visibility("default")))
#endif

#include "quickjs/quickjs.h"

#ifdef __cplusplus
extern "C" {
#endif
enum PxsEvalFlag
{
	PXS_EVAL_UNKNOWN,
	PXS_EVAL_GLOBAL,
	PXS_EVAL_MODULE,
	PXS_EVAL_PREBUILT,
};
enum PxsEventFlag
{
	PXS_EVENT_SHUTDOWN = 0,
};
PX_API int pxsSetStartClassId(int start);
PX_API JSContext *pxsInit(JSContext *ctx);
PX_API int pxsActiveObject(JSContext *ctx, int dt = 0);
PX_API void pxsUpdate(JSContext *ctx);
PX_API void pxsShutdown(JSContext *ctx, bool destroy);
PX_API JSValue pxsGetValue(JSContext *ctx, const char *key);
PX_API JSValue pxsEval(JSContext *ctx, const char *code, size_t len, const char *name, PxsEvalFlag flag, bool compileOnly);
PX_API JSValue pxsCall(JSContext *ctx, JSValue func, JSValue thiz, int argc, JSValue *argv);

PX_API JSValue pxsFindObject(JSContext *ctx, void *p);
PX_API void pxsLinkObject(JSContext *ctx, void *p, JSValue v);
PX_API void pxsUnlinkObject(JSRuntime *rt, void *p);

typedef void (*PxsListener)(JSContext *ctx, int event, void *ud);
PX_API int pxsAddListener(JSContext *ctx, int event, PxsListener cb, void *ud);
PX_API int pxsDelListener(JSContext *ctx, int id);
PX_API void pxsFireEvent(JSContext *ctx, int ev);

#define PXS_OPAQUE_DELETE ((void *) -1)
#define PXS_OPAQUE_GET ((void *) -2)
PX_API void *pxsRuntimeOpaque(JSRuntime *rt, void *key, void *value);

typedef struct {
	void (*error)(void *eh, JSContext *ctx, const char *type, const char *msg, const char *stacktrace);
} PxsErrorHandler;
#define PXS_ERROR_CALLBACK_NONE ((PxsErrorHandler *) -1)
PX_API PxsErrorHandler *pxsSetErrorHandler(JSContext *ctx, PxsErrorHandler *eh);

typedef void (*PxsLoadCallback)(void *ih, const char *url, void *data, size_t len);
typedef char *(PxsCopyString) (void *ud, const char *s);
typedef struct {
	void *(*loadSync)(void *ih, const char *url, size_t *len);
	void (*loadAsync)(void *ih, const char *url, PxsLoadCallback cb);
	void (*releaseData)(void *ih, void *data);
	char *(*resolve)(void *ih, const char *cur, const char *rel, PxsCopyString dup, void *ud);
} PxsIOHandler;
#define PXS_DEFAULT_IO_HANDLER ((PxsIOHandler *) -1)
PX_API PxsIOHandler *pxsSetIOHandler(JSContext *ctx, PxsIOHandler *io);

typedef void (*TimerCallback)(void *th, int id, void *ud);
typedef struct {
	uint32_t (*add)(void *th, int timeout, int loop, void *ud, TimerCallback cb);
	void (*del)(void *th, uint32_t id);
	void (*tick)(void *th, float dt);
} PxsTimerHandler;
PX_API PxsTimerHandler *pxsAddTimerLib(JSContext *ctx, PxsTimerHandler *th);

typedef struct {
	void (*log2)(void *con, const char *type, int argc, JSValue *argv);
	void (*log)(void *con, const char *type, const char *msg);
} PxsConsoleHandler;
PX_API PxsConsoleHandler *pxsAddConsoleLib(JSContext *ctx, PxsConsoleHandler *ch);

typedef void (*PxsTcpOnOpen)(void *sh, void *ws);
typedef void (*PxsTcpOnRecv)(void *sh, void *ws, const char *data, size_t len);
typedef void (*PxsTcpOnClose)(void *sh, void *ws, int code);
typedef struct {
	void *(*create)(void *sh, const char *url, const char *protocol, PxsTcpOnOpen, PxsTcpOnRecv, PxsTcpOnClose);
	void (*send)(void *sh, void *ws, const char *data, size_t len);
	void (*close)(void *sh, void *ws, int code, const char *reason);
} PxsSocketHandler;
PX_API PxsSocketHandler *pxsAddSocketLib(JSContext *ctx, PxsSocketHandler *ch);


#ifdef __cplusplus
}
#endif
