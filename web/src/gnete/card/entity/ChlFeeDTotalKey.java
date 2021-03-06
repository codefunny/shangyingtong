package gnete.card.entity;

import gnete.card.entity.type.ChlFeeContentType;

public class ChlFeeDTotalKey {
    private String chlCode;

    private String feeDate;

    private String transType;

    public String getChlCode() {
        return chlCode;
    }

    public void setChlCode(String chlCode) {
        this.chlCode = chlCode;
    }

    public String getFeeDate() {
        return feeDate;
    }

    public void setFeeDate(String feeDate) {
        this.feeDate = feeDate;
    }

    public String getTransType() {
        return transType;
    }

    public void setTransType(String transType) {
        this.transType = transType;
    }
    
    public String getTransTypeName() {
		return ChlFeeContentType.ALL.get(this.transType) == null ? "" : ChlFeeContentType
				.valueOf(this.transType).getName();
	}
}