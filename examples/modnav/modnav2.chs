testroot : Elem {
    # "Models navigator. Ver.02. Based on DES controlled widgets"
    + GVisComps
    + FvWidgets
    + AvrMdl2
    Launcher : VDesLauncher {
        LogLevel = "Dbg"
        # "Visualisation environment"
        Env : VisEnv
        Window : GVisComps.Window {
            Width < = "SI 1200"
            Height < = "SI 800"
            VrvCp : AvrMdl2.VrViewCp
            # "DRP context"
            DrpCtx : DesCtxSpl (
                _@ <  {
                    ModelMntp : ExtdSystExploring
                    DrpMagUri : ExtdStateInp
                }
                ModelMntp ~ VrvCp.Int.NavCtrl.DrpCp.InpModelMntp
                DrpMagUri ~ VrvCp.Int.NavCtrl.DrpCp.InpModelUri
            )
            Scene : GVisComps.Scene {
                # "Scene"
                VBox : ContainerMod.DVLayout {
                    About = "Application view main vertical layout"
                    LogLevel = "Dbg"
                    # "Unset DrawOnComplete to draw menu even if DRP makes VBox not completed"
                    DrawOnComplete = "no"
                    End.Next !~ Start.Prev
                    Slot_1 : ContainerMod.FVLayoutSlot
                    Slot_1.Next ~ Start.Prev
                    Toolbar : ContainerMod.DHLayout {
                        About = "Application toolbar"
                        End.Next !~ Start.Prev
                        XPadding < = "SI 5"
                        YPadding < = "SI 4"
                        BtnUp : FvWidgets.FButton {
                            SText < = "SS Up"
                            BgColor < = "TPL,SF:r,SF:g,SF:b,SF:a 0.0 0.0 1.0 1.0"
                            FgColor < = "TPL,SF:r,SF:g,SF:b,SF:a 1.0 1.0 1.0 0.0"
                        }
                        Slot_1 : ContainerMod.FHLayoutSlot (
                            Next ~ Start.Prev
                            SCp ~ BtnUp.Cp
                        )
                        Btn2 : FvWidgets.FButton {
                            SText < = "SS Button 2"
                            BgColor < = "TPL,SF:r,SF:g,SF:b,SF:a 0.0 0.0 1.0 1.0"
                            FgColor < = "TPL,SF:r,SF:g,SF:b,SF:a 1.0 1.0 1.0 0.0"
                        }
                        Slot_2 : ContainerMod.FHLayoutSlot (
                            Next ~ Slot_1.Prev
                            SCp ~ Btn2.Cp
                        )
                        Btn3 : FvWidgets.FButton {
                            SText < = "SS Button 3"
                            BgColor < = "TPL,SF:r,SF:g,SF:b,SF:a 0.0 0.0 1.0 1.0"
                            FgColor < = "TPL,SF:r,SF:g,SF:b,SF:a 1.0 1.0 1.0 0.0"
                        }
                        Slot_3 : ContainerMod.FHLayoutSlot (
                            Next ~ Slot_2.Prev
                            SCp ~ Btn3.Cp
                            Prev ~ End.Next
                        )
                    }
                    Slot_1.SCp ~ Toolbar.Cp
                    Slot_2 : ContainerMod.FVLayoutSlot
                    ModelView : ContainerMod.DAlignment {
                        CreateWdg < LogLevel = "Dbg"
                    }
                    Slot_2.SCp ~ ModelView.Cp
                    Slot_2.Next ~ Slot_1.Prev
                    End.Next ~ Slot_2.Prev
                }
                _ <  {
                    Scp : ContainerMod.SlotCp
                    Scp ~ VBox.Cp
                    Scp.InpAlcW ~ Cp.Int.Width
                    Scp.InpAlcH ~ Cp.Int.Height
                }
                VBox.Cp.InpAlcW ~ Cp.Int.Width
                VBox.Cp.InpAlcH ~ Cp.Int.Height
            }
            Scene.Cp ~ ScCpc
            VrvCp.Int.NavCtrl.CmdUp ~ Scene.VBox.Toolbar.BtnUp.Pressed
            BtnUpPressed_Dbg : State (
                _@ < LogLevel = "Dbg"
                _@ < = "SB"
                Inp ~ Scene.VBox.Toolbar.BtnUp.Pressed
            )
            Scene.VBox.ModelView.IoAddWidg ~ VrvCp.Int.NavCtrl.MutAddWidget
            Scene.VBox.ModelView.IoRmWidg ~ VrvCp.Int.NavCtrl.MutRmWidget
            Scene.VBox.ModelView.CreateWdg < LogLevel = "Dbg"
            # "Node selected new desing debug"
            NodeSelected2 : State (
                _@ <  {
                    LogLevel = "Dbg"
                    = "URI"
                }
                Inp ~ Nsl : TrTailVar (
                    Inp ~ : TrHeadVar (
                        Inp ~ Scene.VBox.Cp.LbpUri
                        Tail ~ : State {
                            = "URI Header.Name"
                        }
                    )
                    Head ~ : State {
                        = "URI VBox.ModelView.Drp"
                    }
                )
            )
            NodeSelected : State (
                _@ <  {
                    LogLevel = "Dbg"
                    = "URI _INV"
                }
            )
            VrvCp.Int.NavCtrl.NodeSelected ~ NodeSelected2
        }
        EnvWidth : State
        EnvHeight : State
        Title : State
        EnvWidth ~ Window.Inp_W
        EnvHeight ~ Window.Inp_H
        Title ~ Window.Inp_Title
        # "Visual representation controller"
        Controller : AvrMdl2.VrController {
            ModelMnt < EnvVar = "Model"
        }
        # "Binding Controller and Window"
        Controller.CtrlCp ~ Window.VrvCp
    }
}
