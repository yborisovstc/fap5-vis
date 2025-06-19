testroot : Elem {
    # "Unit test of Label agent"
    + GVisComps
    + FvWidgets
    Launcher : DesLauncher {
        LogLevel = "Dbg"
        Test : Des {
            # "Visualisation environment"
            VEnv : VisEnv
            # "Window"
            Wnd : GVisComps.Window {
                Width < = "SI 1200"
                Height < = "SI 800"
                Scene : GVisComps.Scene {
                    # "Visualisation scene"
                    Wdg1 : FvWidgets.FLabel {
                        BgColor < = "TPL,SF:r,SF:g,SF:b,SF:a 1.0 1.0 0.0 1.0"
                        SText < = "SS Test"
                        AlcX < = "SI 200"
                        AlcY < = "SI 100"
                        AlcW < = "SI 200"
                        AlcH < = "SI 20"
                    }
                    Wdg1Cp : FvWidgets.WidgetCpc
                    Wdg1Cp ~ Wdg1.Cp
                }
            }
            EnvWidth : State
            EnvHeight : State
            Title : State
            EnvWidth ~ Wnd.Inp_W
            EnvHeight ~ Wnd.Inp_H
            Title ~ Wnd.Inp_Title
            EnvWidth < = "SI 640"
            EnvHeight < = "SI 480"
            Title < = "SS Title"
            # " Increasing size of widget"
            WdgWidth : State {
                LogLevel = "Dbg"
                = "SI 40"
            }
            WdgHeight : State {
                LogLevel = "Dbg"
                = "SI 60"
            }
            IncrData : Const {
                = "SI 1"
            }
            WdgWidth.Inp ~ IncrW : TrAddVar (
                Inp ~ IncrData
                Inp ~ WdgWidth
            )
            WdgHeight.Inp ~ IncrH : TrAddVar (
                Inp ~ IncrData
                Inp ~ WdgHeight
            )
            WdgWidth ~ Wnd.Scene.Wdg1Cp.InpAlcW
            WdgHeight ~ Wnd.Scene.Wdg1Cp.InpAlcH
            SLbpUri_Dbg : State (
                _@ <  {
                    LogLevel = "Dbg"
                    = "URI"
                }
                Inp ~ Wnd.Scene.Wdg1Cp.LbpUri
            )
        }
    }
}
