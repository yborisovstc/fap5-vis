GVisComps : Elem {
    About = "Visualization system based on GLUT"
    SceneSc : Socket2 {
        Width : CpStateOutp
        Height : CpStateOutp
    }
    SceneS : Socket2 {
        Width : CpStateInp
        Height : CpStateInp
    }
    SceneCp : SceneS {
        Int : SceneSc
    }
    SceneCpc : SceneSc {
        Int : SceneS
    }
    Window : GWindow {
        About = "Top-level window"
        Inp_X : ExtdStateInp
        Inp_Y : CpStateInp
        Inp_W : CpStateInp
        Inp_H : CpStateInp
        Inp_Title : CpStateInp
        Width : State {
            = "SI 640"
        }
        Height : State {
            = "SI 480"
        }
        ScCpc : SceneCpc
        ScCpc.Int.Width ~ Width
        ScCpc.Int.Height ~ Height
    }
    Scene : GtScene {
        About = "Visualization system scene"
        Cp : SceneCp
    }
}
