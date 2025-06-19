GVisComps : Elem {
    About = "Visualization system based on GLUT"
    SceneCp : Socket {
        Width : CpStateOutpPin
        Height : CpStateOutpPin
    }
    SceneCpc : Socket {
        Width : CpStateInpPin
        Height : CpStateInpPin
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
        ScCpc.Width ~ Width
        ScCpc.Height ~ Height
    }
    Scene : GtScene {
        About = "Visualization system scene"
        Cp : SceneCp
    }
}
