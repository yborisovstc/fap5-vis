FvWidgets : Elem {
    About = "FAP5 visualization system. Widget-to-slot linkage approach"
    WidgetCpSc : Socket2 {
        InpAlcX : CpStateOutp
        InpAlcY : CpStateOutp
        InpAlcW : CpStateOutp
        InpAlcH : CpStateOutp
        OutAlcX : CpStateInp
        OutAlcY : CpStateInp
        OutAlcW : CpStateInp
        OutAlcH : CpStateInp
        RqsW : CpStateInp
        RqsH : CpStateInp
        LbpUri : CpStateInp
    }
    WidgetCpS : Socket2 {
        InpAlcX : CpStateInp
        InpAlcY : CpStateInp
        InpAlcW : CpStateInp
        InpAlcH : CpStateInp
        OutAlcX : CpStateOutp
        OutAlcY : CpStateOutp
        OutAlcW : CpStateOutp
        OutAlcH : CpStateOutp
        RqsW : CpStateOutp
        RqsH : CpStateOutp
        LbpUri : CpStateOutp
    }
    WidgetCp : WidgetCpS {
        Int : WidgetCpSc
    }
    WidgetCpc : WidgetCpSc {
        Int : WidgetCpS
    }
    IWidget : Des {
        # "Widget iface"
        Cp : WidgetCp
    }
    FWidgetBase : Des {
        # " Widget base"
        Font : State {
            = "SS /usr/share/fonts/truetype/ubuntu/Ubuntu-R.ttf"
        }
        FontSize : State {
            = "SI 16"
        }
        SText : State {
            = "SS"
        }
        Cp : WidgetCp
        # " Allocation"
        AlcX : State {
            LogLevel = "Dbg"
            = "SI 0"
        }
        AlcY : State {
            LogLevel = "Dbg"
            = "SI 0"
        }
        AlcW : State {
            LogLevel = "Dbg"
            = "SI 0"
        }
        AlcH : State {
            LogLevel = "Dbg"
            = "SI 0"
        }
        # "Color"
        FgColor : State {
            = "TPL,SI:r,SI:g,SI:b,SI:a  0 0 0 0"
        }
        BgColor : State {
            = "TPL,SI:r,SI:g,SI:b,SI:a  0 0 0 0"
        }
        Border : State {
            = "SI 0"
        }
        # " Requisition"
        RqsW : State {
            LogLevel = "Dbg"
            = "SI 0"
        }
        RqsH : State {
            LogLevel = "Dbg"
            = "SI 0"
        }
        # " Connections"
        AlcX.Inp ~ Cp.Int.InpAlcX
        AlcY.Inp ~ Cp.Int.InpAlcY
        AlcW.Inp ~ Cp.Int.InpAlcW
        AlcH.Inp ~ Cp.Int.InpAlcH
        AlcX ~ Cp.Int.OutAlcX
        AlcY ~ Cp.Int.OutAlcY
        AlcW ~ Cp.Int.OutAlcW
        AlcH ~ Cp.Int.OutAlcH
        RqsW ~ Cp.Int.RqsW
        RqsH ~ Cp.Int.RqsH
    }
    FWidget : FWidgetBase {
        # " Widget"
        WdgAgent : AVWidget
        # " Internal connections"
        # "TODO to do dynamic connection in WdgBase as soon as WdgAgent created"
        # "TODO or to apply named segment, ref ds_cli_nseg"
        WdgAgent.InpFont ~ Font
        WdgAgent.InpText ~ SText
        RqsW.Inp ~ WdgAgent.OutpRqsW
        RqsH.Inp ~ WdgAgent.OutpRqsH
        Cp.Int.LbpUri ~ WdgAgent.OutpLbpUri
    }
    FLabel : FWidgetBase {
        # " Label"
        WdgAgent : AVLabel
        # " Internal connections"
        # "TODO duplicated in widgets, to avoid"
        WdgAgent.InpFont ~ Font
        WdgAgent.InpFontSize ~ FontSize
        WdgAgent.InpText ~ SText
        RqsW.Inp ~ WdgAgent.OutpRqsW
        RqsH.Inp ~ WdgAgent.OutpRqsH
        Cp.Int.LbpUri ~ WdgAgent.OutpLbpUri
    }
    FButton : FWidgetBase {
        # " Button"
        WdgAgent : AButton
        # " Internal connections"
        WdgAgent.InpFont ~ Font
        WdgAgent.InpFontSize ~ FontSize
        WdgAgent.InpText ~ SText
        RqsW.Inp ~ WdgAgent.OutpRqsW
        RqsH.Inp ~ WdgAgent.OutpRqsH
        Cp.Int.LbpUri ~ WdgAgent.OutpLbpUri
        VisPars : Des {
            Border : State {
                = "SB true"
            }
        }
        Pressed : State {
            LogLevel = "Dbg"
            = "SB false"
        }
        PressedReset : Const {
            = "SB false"
        }
        Pressed.Inp ~ PressedReset
    }
}
