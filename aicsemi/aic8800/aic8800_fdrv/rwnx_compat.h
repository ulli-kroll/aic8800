/**
 ******************************************************************************
 *
 * @file rwnx_compat.h
 *
 * Ensure driver compilation for linux 3.16 to 3.19
 *
 * To avoid too many #if LINUX_VERSION_CODE if the code, when prototype change
 * between different kernel version:
 * - For external function, define a macro whose name is the function name with
 *   _compat suffix and prototype (actually the number of parameter) of the
 *   latest version. Then latest version this macro simply call the function
 *   and for older kernel version it call the function adapting the api.
 * - For internal function (e.g. cfg80211_ops) do the same but the macro name
 *   doesn't need to have the _compat suffix when the function is not used
 *   directly by the driver
 *
 * Copyright (C) RivieraWaves 2018
 *
 ******************************************************************************
 */
#ifndef _RWNX_COMPAT_H_
#define _RWNX_COMPAT_H_
#include <linux/version.h>

/* Generic */
#include <linux/bitfield.h>

/* CFG80211 */
#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 20, 0)
#define IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_MASK IEEE80211_HE_MAC_CAP3_MAX_A_AMPDU_LEN_EXP_MASK
#endif

#if LINUX_VERSION_CODE > KERNEL_VERSION(5, 15, 60)
#define IEEE80211_MAX_AMPDU_BUF IEEE80211_MAX_AMPDU_BUF_HE
#endif

#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 19, 0)
#define IEEE80211_RADIOTAP_HE 23
#define IEEE80211_RADIOTAP_HE_MU 24

struct ieee80211_radiotap_he {
	__le16 data1, data2, data3, data4, data5, data6;
};

enum ieee80211_radiotap_he_bits {
	IEEE80211_RADIOTAP_HE_DATA1_FORMAT_MASK		= 3,
	IEEE80211_RADIOTAP_HE_DATA1_FORMAT_SU		= 0,
	IEEE80211_RADIOTAP_HE_DATA1_FORMAT_EXT_SU	= 1,
	IEEE80211_RADIOTAP_HE_DATA1_FORMAT_MU		= 2,
	IEEE80211_RADIOTAP_HE_DATA1_FORMAT_TRIG		= 3,

	IEEE80211_RADIOTAP_HE_DATA1_BSS_COLOR_KNOWN	= 0x0004,
	IEEE80211_RADIOTAP_HE_DATA1_BEAM_CHANGE_KNOWN	= 0x0008,
	IEEE80211_RADIOTAP_HE_DATA1_UL_DL_KNOWN		= 0x0010,
	IEEE80211_RADIOTAP_HE_DATA1_DATA_MCS_KNOWN	= 0x0020,
	IEEE80211_RADIOTAP_HE_DATA1_DATA_DCM_KNOWN	= 0x0040,
	IEEE80211_RADIOTAP_HE_DATA1_CODING_KNOWN	= 0x0080,
	IEEE80211_RADIOTAP_HE_DATA1_LDPC_XSYMSEG_KNOWN	= 0x0100,
	IEEE80211_RADIOTAP_HE_DATA1_STBC_KNOWN		= 0x0200,
	IEEE80211_RADIOTAP_HE_DATA1_SPTL_REUSE_KNOWN	= 0x0400,
	IEEE80211_RADIOTAP_HE_DATA1_SPTL_REUSE2_KNOWN	= 0x0800,
	IEEE80211_RADIOTAP_HE_DATA1_SPTL_REUSE3_KNOWN	= 0x1000,
	IEEE80211_RADIOTAP_HE_DATA1_SPTL_REUSE4_KNOWN	= 0x2000,
	IEEE80211_RADIOTAP_HE_DATA1_BW_RU_ALLOC_KNOWN	= 0x4000,
	IEEE80211_RADIOTAP_HE_DATA1_DOPPLER_KNOWN	= 0x8000,

	IEEE80211_RADIOTAP_HE_DATA2_PRISEC_80_KNOWN	= 0x0001,
	IEEE80211_RADIOTAP_HE_DATA2_GI_KNOWN		= 0x0002,
	IEEE80211_RADIOTAP_HE_DATA2_NUM_LTF_SYMS_KNOWN	= 0x0004,
	IEEE80211_RADIOTAP_HE_DATA2_PRE_FEC_PAD_KNOWN	= 0x0008,
	IEEE80211_RADIOTAP_HE_DATA2_TXBF_KNOWN		= 0x0010,
	IEEE80211_RADIOTAP_HE_DATA2_PE_DISAMBIG_KNOWN	= 0x0020,
	IEEE80211_RADIOTAP_HE_DATA2_TXOP_KNOWN		= 0x0040,
	IEEE80211_RADIOTAP_HE_DATA2_MIDAMBLE_KNOWN	= 0x0080,
	IEEE80211_RADIOTAP_HE_DATA2_RU_OFFSET		= 0x3f00,
	IEEE80211_RADIOTAP_HE_DATA2_RU_OFFSET_KNOWN	= 0x4000,
	IEEE80211_RADIOTAP_HE_DATA2_PRISEC_80_SEC	= 0x8000,

	IEEE80211_RADIOTAP_HE_DATA3_BSS_COLOR		= 0x003f,
	IEEE80211_RADIOTAP_HE_DATA3_BEAM_CHANGE		= 0x0040,
	IEEE80211_RADIOTAP_HE_DATA3_UL_DL		= 0x0080,
	IEEE80211_RADIOTAP_HE_DATA3_DATA_MCS		= 0x0f00,
	IEEE80211_RADIOTAP_HE_DATA3_DATA_DCM		= 0x1000,
	IEEE80211_RADIOTAP_HE_DATA3_CODING		= 0x2000,
	IEEE80211_RADIOTAP_HE_DATA3_LDPC_XSYMSEG	= 0x4000,
	IEEE80211_RADIOTAP_HE_DATA3_STBC		= 0x8000,

	IEEE80211_RADIOTAP_HE_DATA4_SU_MU_SPTL_REUSE	= 0x000f,
	IEEE80211_RADIOTAP_HE_DATA4_MU_STA_ID		= 0x7ff0,
	IEEE80211_RADIOTAP_HE_DATA4_TB_SPTL_REUSE1	= 0x000f,
	IEEE80211_RADIOTAP_HE_DATA4_TB_SPTL_REUSE2	= 0x00f0,
	IEEE80211_RADIOTAP_HE_DATA4_TB_SPTL_REUSE3	= 0x0f00,
	IEEE80211_RADIOTAP_HE_DATA4_TB_SPTL_REUSE4	= 0xf000,

	IEEE80211_RADIOTAP_HE_DATA5_DATA_BW_RU_ALLOC	= 0x000f,
		IEEE80211_RADIOTAP_HE_DATA5_DATA_BW_RU_ALLOC_20MHZ	= 0,
		IEEE80211_RADIOTAP_HE_DATA5_DATA_BW_RU_ALLOC_40MHZ	= 1,
		IEEE80211_RADIOTAP_HE_DATA5_DATA_BW_RU_ALLOC_80MHZ	= 2,
		IEEE80211_RADIOTAP_HE_DATA5_DATA_BW_RU_ALLOC_160MHZ	= 3,
		IEEE80211_RADIOTAP_HE_DATA5_DATA_BW_RU_ALLOC_26T	= 4,
		IEEE80211_RADIOTAP_HE_DATA5_DATA_BW_RU_ALLOC_52T	= 5,
		IEEE80211_RADIOTAP_HE_DATA5_DATA_BW_RU_ALLOC_106T	= 6,
		IEEE80211_RADIOTAP_HE_DATA5_DATA_BW_RU_ALLOC_242T	= 7,
		IEEE80211_RADIOTAP_HE_DATA5_DATA_BW_RU_ALLOC_484T	= 8,
		IEEE80211_RADIOTAP_HE_DATA5_DATA_BW_RU_ALLOC_996T	= 9,
		IEEE80211_RADIOTAP_HE_DATA5_DATA_BW_RU_ALLOC_2x996T	= 10,

	IEEE80211_RADIOTAP_HE_DATA5_GI			= 0x0030,
		IEEE80211_RADIOTAP_HE_DATA5_GI_0_8			= 0,
		IEEE80211_RADIOTAP_HE_DATA5_GI_1_6			= 1,
		IEEE80211_RADIOTAP_HE_DATA5_GI_3_2			= 2,

	IEEE80211_RADIOTAP_HE_DATA5_LTF_SIZE		= 0x00c0,
		IEEE80211_RADIOTAP_HE_DATA5_LTF_SIZE_UNKNOWN		= 0,
		IEEE80211_RADIOTAP_HE_DATA5_LTF_SIZE_1X			= 1,
		IEEE80211_RADIOTAP_HE_DATA5_LTF_SIZE_2X			= 2,
		IEEE80211_RADIOTAP_HE_DATA5_LTF_SIZE_4X			= 3,
	IEEE80211_RADIOTAP_HE_DATA5_NUM_LTF_SYMS	= 0x0700,
	IEEE80211_RADIOTAP_HE_DATA5_PRE_FEC_PAD		= 0x3000,
	IEEE80211_RADIOTAP_HE_DATA5_TXBF		= 0x4000,
	IEEE80211_RADIOTAP_HE_DATA5_PE_DISAMBIG		= 0x8000,

	IEEE80211_RADIOTAP_HE_DATA6_NSTS		= 0x000f,
	IEEE80211_RADIOTAP_HE_DATA6_DOPPLER		= 0x0010,
	IEEE80211_RADIOTAP_HE_DATA6_TXOP		= 0x7f00,
	IEEE80211_RADIOTAP_HE_DATA6_MIDAMBLE_PDCTY	= 0x8000,
};

struct ieee80211_radiotap_he_mu {
	__le16 flags1, flags2;
	u8 ru_ch1[4];
	u8 ru_ch2[4];
};

enum ieee80211_radiotap_he_mu_bits {
	IEEE80211_RADIOTAP_HE_MU_FLAGS1_SIG_B_MCS		= 0x000f,
	IEEE80211_RADIOTAP_HE_MU_FLAGS1_SIG_B_MCS_KNOWN		= 0x0010,
	IEEE80211_RADIOTAP_HE_MU_FLAGS1_SIG_B_DCM		= 0x0020,
	IEEE80211_RADIOTAP_HE_MU_FLAGS1_SIG_B_DCM_KNOWN		= 0x0040,
	IEEE80211_RADIOTAP_HE_MU_FLAGS1_CH2_CTR_26T_RU_KNOWN	= 0x0080,
	IEEE80211_RADIOTAP_HE_MU_FLAGS1_CH1_RU_KNOWN		= 0x0100,
	IEEE80211_RADIOTAP_HE_MU_FLAGS1_CH2_RU_KNOWN		= 0x0200,
	IEEE80211_RADIOTAP_HE_MU_FLAGS1_CH1_CTR_26T_RU_KNOWN	= 0x1000,
	IEEE80211_RADIOTAP_HE_MU_FLAGS1_CH1_CTR_26T_RU		= 0x2000,
	IEEE80211_RADIOTAP_HE_MU_FLAGS1_SIG_B_COMP_KNOWN	= 0x4000,
	IEEE80211_RADIOTAP_HE_MU_FLAGS1_SIG_B_SYMS_USERS_KNOWN	= 0x8000,

	IEEE80211_RADIOTAP_HE_MU_FLAGS2_BW_FROM_SIG_A_BW	= 0x0003,
		IEEE80211_RADIOTAP_HE_MU_FLAGS2_BW_FROM_SIG_A_BW_20MHZ	= 0x0000,
		IEEE80211_RADIOTAP_HE_MU_FLAGS2_BW_FROM_SIG_A_BW_40MHZ	= 0x0001,
		IEEE80211_RADIOTAP_HE_MU_FLAGS2_BW_FROM_SIG_A_BW_80MHZ	= 0x0002,
		IEEE80211_RADIOTAP_HE_MU_FLAGS2_BW_FROM_SIG_A_BW_160MHZ	= 0x0003,
	IEEE80211_RADIOTAP_HE_MU_FLAGS2_BW_FROM_SIG_A_BW_KNOWN	= 0x0004,
	IEEE80211_RADIOTAP_HE_MU_FLAGS2_SIG_B_COMP		= 0x0008,
	IEEE80211_RADIOTAP_HE_MU_FLAGS2_SIG_B_SYMS_USERS	= 0x00f0,
	IEEE80211_RADIOTAP_HE_MU_FLAGS2_PUNC_FROM_SIG_A_BW	= 0x0300,
	IEEE80211_RADIOTAP_HE_MU_FLAGS2_PUNC_FROM_SIG_A_BW_KNOWN= 0x0400,
	IEEE80211_RADIOTAP_HE_MU_FLAGS2_CH2_CTR_26T_RU		= 0x0800,
};
#endif

#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 12, 0)
#define rwnx_cfg80211_add_iface(wiphy, name, name_assign_type, type, params) \
    rwnx_cfg80211_add_iface(wiphy, name, name_assign_type, type, u32 *flags, params)

#define rwnx_cfg80211_change_iface(wiphy, dev, type, params) \
    rwnx_cfg80211_change_iface(wiphy, dev, type, u32 *flags, params)

#define CCFS0(vht) vht->center_freq_seg1_idx
#define CCFS1(vht) vht->center_freq_seg2_idx

#else
#define CCFS0(vht) vht->center_freq_seg0_idx
#define CCFS1(vht) vht->center_freq_seg1_idx

#endif

#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 11, 0)
#define cfg80211_cqm_rssi_notify(dev, event, level, gfp) \
    cfg80211_cqm_rssi_notify(dev, event, gfp)
#endif

#if (0) && !(defined CONFIG_VENDOR_RWNX)
#define ieee80211_chandef_to_operating_class(chan_def, op_class) 0
#endif

#define SURVEY_TIME(s) s->time
#define SURVEY_TIME_BUSY(s) s->time_busy

#define STA_TDLS_INITIATOR(sta) sta->tdls_initiator

#ifndef REGULATORY_IGNORE_STALE_KICKOFF
#define REGULATORY_IGNORE_STALE_KICKOFF 0
#endif



#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 19, 0)
enum {
    IEEE80211_HE_MCS_SUPPORT_0_7    = 0,
    IEEE80211_HE_MCS_SUPPORT_0_9    = 1,
    IEEE80211_HE_MCS_SUPPORT_0_11   = 2,
    IEEE80211_HE_MCS_NOT_SUPPORTED  = 3,
};
#endif

/* MAC80211 */
#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 18, 0)
#define rwnx_ops_mgd_prepare_tx(hw, vif, duration) \
    rwnx_ops_mgd_prepare_tx(hw, vif)
#endif

#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 12, 0)

#define RX_ENC_HT(s) s->flag |= RX_FLAG_HT
#define RX_ENC_HT_GF(s) s->flag |= (RX_FLAG_HT | RX_FLAG_HT_GF)
#define RX_ENC_VHT(s) s->flag |= RX_FLAG_HT
#define RX_ENC_HE(s) s->flag |= RX_FLAG_HT
#define RX_ENC_FLAG_SHORT_GI(s) s->flag |= RX_FLAG_SHORT_GI
#define RX_ENC_FLAG_SHORT_PRE(s) s->flag |= RX_FLAG_SHORTPRE
#define RX_ENC_FLAG_LDPC(s) s->flag |= RX_FLAG_LDPC
#define RX_BW_40MHZ(s) s->flag |= RX_FLAG_40MHZ
#define RX_BW_80MHZ(s) s->vht_flag |= RX_VHT_FLAG_80MHZ
#define RX_BW_160MHZ(s) s->vht_flag |= RX_VHT_FLAG_160MHZ
#define RX_NSS(s) s->vht_nss

#else
#define RX_ENC_HT(s) s->encoding = RX_ENC_HT
#define RX_ENC_HT_GF(s) { s->encoding = RX_ENC_HT;      \
        s->enc_flags |= RX_ENC_FLAG_HT_GF; }
#define RX_ENC_VHT(s) s->encoding = RX_ENC_VHT
#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 19, 0)
#define RX_ENC_HE(s) s->encoding = RX_ENC_VHT
#else
#define RX_ENC_HE(s) s->encoding = RX_ENC_HE
#endif
#define RX_ENC_FLAG_SHORT_GI(s) s->enc_flags |= RX_ENC_FLAG_SHORT_GI
#define RX_ENC_FLAG_SHORT_PRE(s) s->enc_flags |= RX_ENC_FLAG_SHORTPRE
#define RX_ENC_FLAG_LDPC(s) s->enc_flags |= RX_ENC_FLAG_LDPC
#define RX_BW_40MHZ(s) s->bw = RATE_INFO_BW_40
#define RX_BW_80MHZ(s) s->bw = RATE_INFO_BW_80
#define RX_BW_160MHZ(s) s->bw = RATE_INFO_BW_160
#define RX_NSS(s) s->nss

#endif

#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 11, 0)
#define ieee80211_cqm_rssi_notify(vif, event, level, gfp) \
    ieee80211_cqm_rssi_notify(vif, event, gfp)
#endif

#ifndef CONFIG_VENDOR_RWNX_AMSDUS_TX
#endif /* CONFIG_VENDOR_RWNX_AMSDUS_TX */

/* NET */
#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 19, 0)
#define rwnx_select_queue(dev, skb, sb_dev) \
    rwnx_select_queue(dev, skb, void *accel_priv, select_queue_fallback_t fallback)
#elif LINUX_VERSION_CODE < KERNEL_VERSION(5, 2, 0)
#define rwnx_select_queue(dev, skb, sb_dev) \
    rwnx_select_queue(dev, skb, sb_dev, select_queue_fallback_t fallback)
#else
#define rwnx_select_queue(dev, skb, sb_dev) \
    rwnx_select_queue(dev, skb, sb_dev)
#endif

#if (LINUX_VERSION_CODE < KERNEL_VERSION(4, 16, 0)) && !(defined CONFIG_VENDOR_RWNX)
#define sk_pacing_shift_update(sk, shift)
#endif

#endif /* _RWNX_COMPAT_H_ */
