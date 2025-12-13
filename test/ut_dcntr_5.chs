testroot : Elem {
    # "DES controlled Vert layout. Massive insertion and removal"
    + GVisComps
    + ContainerMod
    Test : DesLauncher {
        # "Visualisation environment"
        LogLevel = "Dbg"
        VEnv : VisEnv
        # "Window"
        Wnd : GVisComps.Window {
            Width < = "SI 1200"
            Height < = "SI 800"
            Scene : GVisComps.Scene {
                # "Visualisation scene"
                Box : ContainerMod.DVLayout {
                    CreateWdg < LogLevel = "Dbg"
                    SdcInsert < LogLevel = "Dbg"
                    SdcConnWdg < LogLevel = "Dbg"
                    SdcExtrSlot < LogLevel = "Dbg"
                    RmWdg < LogLevel = "Dbg"
                    RmSlot < LogLevel = "Dbg"
                    Start.Prev !~ End.Next
                    XPadding < = "SI 20"
                    AlcW < = "SI 220"
                    AlcH < = "SI 330"
                    Btn1 : FvWidgets.FButton {
                        SText < = "SS 'Button 1'"
                        BgColor < = "TPL,SF:r,SF:g,SF:b,SF:a 1.0 1.0 0.0 1.0"
                        FgColor < = "TPL,SF:r,SF:g,SF:b,SF:a 1.0 0.0 0.0 0.0"
                    }
                    Slot_Btn1 : ContainerMod.FVLayoutSlot (
                        SCp ~ Btn1.Cp
                        Next ~ Start.Prev
                    )
                    Btn2 : FvWidgets.FButton {
                        SText < = "SS 'Button 2'"
                        BgColor < = "TPL,SF:r,SF:g,SF:b,SF:a 1.0 1.0 0.0 1.0"
                        FgColor < = "TPL,SF:r,SF:g,SF:b,SF:a 1.0 0.0 0.0 0.0"
                    }
                    Slot_Btn2 : ContainerMod.FVLayoutSlot (
                        SCp ~ Btn2.Cp
                        Next ~ Slot_Btn1.Prev
                        Prev ~ End.Next
                    )
                }
            }
        }
        # "Items Iterator"
        ItemsIter : DesUtils.IdxItr (
            InpCnt ~ : Const {
                = "SI 10"
            }
            InpReset ~ : SB_False
        )
        # " Adding new button"
        HBox_AddWdg : ContainerMod.DcAddWdgCp (
            Enable ~ : SB_True
            Name ~ ItemName : TrApndVar (
                Inp1 ~ : Const {
                    = "SS Bnt_"
                }
                Inp2 ~ : TrTostrVar (
                    Inp ~ ItemsIter.Outp
                )
            )
            Parent ~ : State {
                = "SS FvWidgets.FButton"
            }
            Pos ~ : State {
                = "SI 0"
            }
            Mut ~ : State {
                = "CHR2 '{ SText < = \\\"SS Button_3\\\";  BgColor < = \\\"TPL,SF:r,SF:g,SF:b,SF:a 1.0 1.0 0.0 1.0\\\";  FgColor < =  \\\"TPL,SF:r,SF:g,SF:b,SF:a 1.0 0.0 0.0 0.0\\\" }'"
            }
        )
        HBox_AddWdg.Int ~ Wnd.Scene.Box.IoAddWidg
        ItemsIter.InpDone ~ HBox_AddWdg.Added
        AddedWdg_Dbg : State (
            _@ <  {
                LogLevel = "Dbg"
                = "SB false"
            }
            Inp ~ HBox_AddWdg.Added
        )
        # "Removing Items Iterator"
        RmItemsIter : DesUtils.IdxItr (
            InpCnt ~ : Const {
                = "SI 10"
            }
            InpReset ~ : TrNegVar (
                Inp ~ ItemsIter.OutpDone
            )
        )
        Box_RmWdg : ContainerMod.DcRmWdgCp (
            Enable ~ ItemsIter.OutpDone
            Name ~ RmItemName : TrApndVar (
                Inp1 ~ : Const {
                    = "SS Bnt_"
                }
                Inp2 ~ : TrTostrVar (
                    Inp ~ RmItemsIter.Outp
                )
            )
        )
        RmItemsIter.InpDone ~ Box_RmWdg.Done
        Box_RmWdg.Int ~ Wnd.Scene.Box.IoRmWidg
        RmWdg_Dbg : State (
            _@ <  {
                LogLevel = "Dbg"
                = "SB false"
            }
            Inp ~ Box_RmWdg.Done
        )
        # " Misc env"
        EnvWidth : State
        EnvHeight : State
        Title : State
        EnvWidth ~ Wnd.Inp_W
        EnvHeight ~ Wnd.Inp_H
        Title ~ Wnd.Inp_Title
        EnvWidth < = "SI 640"
        EnvHeight < = "SI 480"
        Title < = "SS Title"
    }
}
