FvWidgets : Elem {
    About = "FAP5 visualization system. Widget-to-slot linkage approach"
    WidgetCp : Socket {
        InpAlcX : CpStateOutpPin
        InpAlcY : CpStateOutpPin
        InpAlcW : CpStateOutpPin
        InpAlcH : CpStateOutpPin
        OutAlcX : CpStateInpPin
        OutAlcY : CpStateInpPin
        OutAlcW : CpStateInpPin
        OutAlcH : CpStateInpPin
        RqsW : CpStateInpPin
        RqsH : CpStateInpPin
        LbpUri : CpStateInpPin
    }
    WidgetCpc : Socket {
        InpAlcX : CpStateInpPin
        InpAlcY : CpStateInpPin
        InpAlcW : CpStateInpPin
        InpAlcH : CpStateInpPin
        OutAlcX : CpStateOutpPin
        OutAlcY : CpStateOutpPin
        OutAlcW : CpStateOutpPin
        OutAlcH : CpStateOutpPin
        RqsW : CpStateOutpPin
        RqsH : CpStateOutpPin
        LbpUri : CpStateOutpPin
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
        AlcX.Inp ~ Cp.InpAlcX
        AlcY.Inp ~ Cp.InpAlcY
        AlcW.Inp ~ Cp.InpAlcW
        AlcH.Inp ~ Cp.InpAlcH
        AlcX ~ Cp.OutAlcX
        AlcY ~ Cp.OutAlcY
        AlcW ~ Cp.OutAlcW
        AlcH ~ Cp.OutAlcH
        RqsW ~ Cp.RqsW
        RqsH ~ Cp.RqsH
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
        Cp.LbpUri ~ WdgAgent.OutpLbpUri
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
        Cp.LbpUri ~ WdgAgent.OutpLbpUri
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
        Cp.LbpUri ~ WdgAgent.OutpLbpUri
        VisPars : Des {
            Border : State {
                = "SB true"
            }
        }
        Pressed : State
        Pressed < LogLevel = "Dbg"
        Pressed < = "SB false"
        PressedReset : State
        PressedReset < = "SB false"
        Pressed.Inp ~ PressedReset
    }
}
