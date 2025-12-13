#ifndef __FAP5VIS_ENV_H
#define __FAP5VIS_ENV_H

//#include <syst.h>
#include <des.h>
#include <mdata.h>
#include <mvisenv.h>
#include <mwindow.h>


#include <GL/glew.h>
#include <GL/gl.h>
#include <GLFW/glfw3.h>

#include "mscene.h"


using namespace std;

class GLFWwindow;

/** @brief Visual environment
 * */
class VisEnv:  public Node
{
    public:
	inline static constexpr std::string_view idStr() { return "VisEnv"sv;}
	VisEnv(const string& aType, const string& aName, MEnv* aEnv);
	virtual ~VisEnv();
    protected:
	void Construct() override;
	void Init();
	static void CheckGlErrors();
    protected:
	bool mIsInitialised = false;
	GLuint mProgram;
	GLint mMvpLocation;
};


/** @brief Top window
 * */
class GWindow: public Des, public MWindow
{
    protected:
	using TSceneCp = NCpOnp<MWindow, MScene>;  /*!< Scene connpoint */
    public:
	inline static constexpr std::string_view idStr() { return "GWindow"sv;}
	GWindow(const string& aType, const string& aName, MEnv* aEnv);
	virtual ~GWindow();
	// From MNode
	MIface* MNode_getLif(TIdHash aId) override;
        void onOwnedAttached(MOwned* aOwned) override;
	// From MWindow
	string MWindow_Uid() const override { return getUid<MWindow>();}
	void GetCursorPos(double& aX, double& aY) const override;
	void GetFbSize(int* aW, int* aH) const override;
	// From MDesSyncable
	void update() override;
	void confirm() override;
    protected:
	void InitGlCtx();
	void doConstruct();
	void Render();
	const GLFWwindow* RawWindow() const { return mWindow;}
	static void onWindowSizeChanged (GLFWwindow *aWnd, int aW, int aH);
	static void onWindowClosed(GLFWwindow *aWnd);
	static void onCursorPosition(GLFWwindow *aWnd, double aX, double aY);
	static void onMouseButton(GLFWwindow *aWnd, int aButton, int aAction, int aMods);
	void onWindowClosed();
	/** @brief Handles cursor position
	 * @param[in] aX, aY screen coordinates relative to the top-left corner of the window
	 * */
	void onCursorPosition(double aX, double aY);
	/** @brief Handles mouse button events
	 * @param[in] aButton - button Id
	 * @param[in] aAction - action: GLFW_PRESS or GLFW_RELEASE
	 * @param[in] aMods - modes
	 * */
	void onMouseButton(TFvButton aButton, TFvButtonAction aAction, int aMods);
	static void RegisterInstance(GWindow* aInst);
	static GWindow* FindInstance(GLFWwindow* aWnd);
	//<! Window width native settier iface
	MDVarSet* StWidth();
	MDVarSet* StHeight();
	int GetParInt(const string& aUri);
	static void CheckGlErrors();
    protected:
	bool mWndInit;
	GLFWwindow* mWindow = nullptr;
	// TODO the instances mechanism seems is used just for assosiating GLFW window instance
	// with AGWindow instance. Why don't use glfwSetWindowUserPointer for that?
	static vector<GWindow*> mInstances; //!< Register of instances
	int mCnt = 0;
	GLuint mProgram;
	bool mDrawOnComplete = true;
	GLint mMvpLocation;
	TSceneCp mSceneCp;  /*!< Scene connpoint */
	MWindow* mMWindowPtr = nullptr;
};


/** @brief Launcher agent
 * */
class VDesLauncher: public DesLauncher
{
    public:
	inline static constexpr std::string_view idStr() { return "VDesLauncher"sv;}
	VDesLauncher(const string& aType, const string& aName = string(), MEnv* aEnv = NULL);
	// From DesLauncher
	virtual void OnIdle() override;
};

#endif

