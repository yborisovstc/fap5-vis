#ifndef __FAP5VIS_MWIDGET_H
#define __FAP5VIS_MWIDGET_H


#include <miface.h>

/** @brief Visual style provider
 * */
class MVStyleProvider: public MIface
{
    public:
	inline static constexpr std::string_view idStr() { return "MVStyleProvider"sv;}
	inline static constexpr TIdHash idHash() { return 0xe9f1152914fd852a;}
	// From MIface
	virtual string Uid() const override { return MVStyleProvider_Uid();}
	virtual string MVStyleProvider_Uid() const = 0;
	// Local
	// TODO getting just param value is against DES philocophy
	// consider of how change of top style can be applied by widget
	virtual bool getVStyleParam(const string& aId, string& aParam) = 0;
};

/** @brief Visual style consumer
 * */
class MVStyleConsumer: public MIface
{
    public:
	inline static constexpr std::string_view idStr() { return "MVStyleConsumer"sv;}
	inline static constexpr TIdHash idHash() { return 0xdd3f5725ead43e97;}
	// From MIface
	virtual string Uid() const override { return MVStyleConsumer_Uid();}
	virtual string MVStyleConsumer_Uid() const = 0;
};

#endif

