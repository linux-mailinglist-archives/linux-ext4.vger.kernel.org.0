Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 836B0701C97
	for <lists+linux-ext4@lfdr.de>; Sun, 14 May 2023 11:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbjENJYf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 14 May 2023 05:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236794AbjENJYQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 14 May 2023 05:24:16 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8862703;
        Sun, 14 May 2023 02:23:45 -0700 (PDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34E99prY027978;
        Sun, 14 May 2023 09:23:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=1/Vb7U/5f9HvnyqLndL1PyxA1TMR7shWc5n8edjUypg=;
 b=DlK5/CW8NyXb8EvPEiUkKkoF8Nzmco5ai48UlUVBcWn+kf4t99yseczPZxfcO3BNnnL2
 cg3sMIBpX69tgUnmziXjYRoI7zuAc6EQ+Zyv0NI/nkWqcMmTglHNDVeyJ0vfmjTfjv5k
 1HcckHYwlkoUQj//BNGVEvF0gOb4EcIt2FELyrF7mN6zv+/PyVjirHusmEXcOS6oci9g
 lRZVfaiLzSVAddjomsm67dNskD5/Spjnr+VZQHd99yAqRhqpCutKOL+9/U/NgKdDXYEu
 YiXN0+Oot68LxUTwgtm4r7T9iZ6JQkBnprP2DYeU/yqwFNd6GLBn6rJkJw482sOHlIUc 1A== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qjm9fyjkr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 14 May 2023 09:23:24 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34E8X2Dn009018;
        Sun, 14 May 2023 09:23:22 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3qj1tdrh43-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 14 May 2023 09:23:22 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34E9NKAu5440202
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 14 May 2023 09:23:20 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 394FA20043;
        Sun, 14 May 2023 09:23:20 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D0C6D20040;
        Sun, 14 May 2023 09:23:18 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.36.114])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Sun, 14 May 2023 09:23:18 +0000 (GMT)
Date:   Sun, 14 May 2023 14:53:16 +0530
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 12/19] ext4: factor out codes to update block bitmap
 and group descriptor on disk from ext4_mb_mark_bb
Message-ID: <ZGCohNhPuBLStNwv@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20230417110617.2664129-1-shikemeng@huaweicloud.com>
 <20230417110617.2664129-13-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230417110617.2664129-13-shikemeng@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: CvnkRX-B2Zab45rSC470GK8XqcGSXba2
X-Proofpoint-ORIG-GUID: CvnkRX-B2Zab45rSC470GK8XqcGSXba2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-14_06,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 mlxscore=0 bulkscore=0 malwarescore=0 spamscore=0 mlxlogscore=622
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305140082
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Apr 17, 2023 at 07:06:10PM +0800, Kemeng Shi wrote:
> There are several reasons to add a general function to update block
> bitmap and group descriptor on disk:
> 1. pair behavior of alloc/free bits. For example,
> ext4_mb_new_blocks_simple will update free_clusters in struct flex_groups
> in ext4_mb_mark_bb while ext4_free_blocks_simple forgets this.
> 2. remove repeat code to read from disk, update and write back to disk.
> 3. reduce future unit test mocks to catch real IO to update structure
> on disk.
> 

Looks good to me. Feel free to add:

Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>  fs/ext4/mballoc.c | 157 +++++++++++++++++++++++++---------------------
>  1 file changed, 87 insertions(+), 70 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 6d4471fd3049..ba165dc07890 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -3730,6 +3730,86 @@ void ext4_exit_mballoc(void)
>  	ext4_groupinfo_destroy_slabs();
>  }
>  
> +struct ext4_mark_context {
> +	struct super_block *sb;
> +	int state;
> +};
> +
> +static int
> +ext4_mb_mark_group_bb(struct ext4_mark_context *mc, ext4_group_t group,
> +		      ext4_grpblk_t blkoff, ext4_grpblk_t len)
> +{
> +	struct super_block *sb = mc->sb;
> +	struct ext4_sb_info *sbi = EXT4_SB(sb);
> +	struct buffer_head *bitmap_bh = NULL;
> +	struct ext4_group_desc *gdp;
> +	struct buffer_head *gdp_bh;
> +	int err;
> +	unsigned int i, already, changed;
> +
> +	bitmap_bh = ext4_read_block_bitmap(sb, group);
> +	if (IS_ERR(bitmap_bh))
> +		return PTR_ERR(bitmap_bh);
> +
> +	err = -EIO;
> +	gdp = ext4_get_group_desc(sb, group, &gdp_bh);
> +	if (!gdp)
> +		goto out_err;
> +
> +	ext4_lock_group(sb, group);
> +	if (ext4_has_group_desc_csum(sb) &&
> +	    (gdp->bg_flags & cpu_to_le16(EXT4_BG_BLOCK_UNINIT))) {
> +		gdp->bg_flags &= cpu_to_le16(~EXT4_BG_BLOCK_UNINIT);
> +		ext4_free_group_clusters_set(sb, gdp,
> +			ext4_free_clusters_after_init(sb, group, gdp));
> +	}
> +
> +	already = 0;
> +	for (i = 0; i < len; i++)
> +		if (mb_test_bit(blkoff + i, bitmap_bh->b_data) ==
> +				mc->state)
> +			already++;
> +	changed = len - already;
> +
> +	if (mc->state) {
> +		mb_set_bits(bitmap_bh->b_data, blkoff, len);
> +		ext4_free_group_clusters_set(sb, gdp,
> +			ext4_free_group_clusters(sb, gdp) - changed);
> +	} else {
> +		mb_clear_bits(bitmap_bh->b_data, blkoff, len);
> +		ext4_free_group_clusters_set(sb, gdp,
> +			ext4_free_group_clusters(sb, gdp) + changed);
> +	}
> +
> +	ext4_block_bitmap_csum_set(sb, gdp, bitmap_bh);
> +	ext4_group_desc_csum_set(sb, group, gdp);
> +	ext4_unlock_group(sb, group);
> +
> +	if (sbi->s_log_groups_per_flex) {
> +		ext4_group_t flex_group = ext4_flex_group(sbi, group);
> +		struct flex_groups *fg = sbi_array_rcu_deref(sbi,
> +					   s_flex_groups, flex_group);
> +
> +		if (mc->state)
> +			atomic64_sub(changed, &fg->free_clusters);
> +		else
> +			atomic64_add(changed, &fg->free_clusters);
> +	}
> +
> +	err = ext4_handle_dirty_metadata(NULL, NULL, bitmap_bh);
> +	if (err)
> +		goto out_err;
> +	err = ext4_handle_dirty_metadata(NULL, NULL, gdp_bh);
> +	if (err)
> +		goto out_err;
> +
> +	sync_dirty_buffer(bitmap_bh);
> +	sync_dirty_buffer(gdp_bh);
> +
> +out_err:
> +	brelse(bitmap_bh);
> +	return err;
> +}
>  
>  /*
>   * Check quota and mark chosen space (ac->ac_b_ex) non-free in bitmaps
> @@ -3856,15 +3936,15 @@ ext4_mb_mark_diskspace_used(struct ext4_allocation_context *ac,
>  void ext4_mb_mark_bb(struct super_block *sb, ext4_fsblk_t block,
>  			int len, int state)
>  {
> -	struct buffer_head *bitmap_bh = NULL;
> -	struct ext4_group_desc *gdp;
> -	struct buffer_head *gdp_bh;
> +	struct ext4_mark_context mc = {
> +		.sb = sb,
> +		.state = state,
> +	};
>  	struct ext4_sb_info *sbi = EXT4_SB(sb);
>  	ext4_group_t group;
>  	ext4_grpblk_t blkoff;
> -	int i, err;
> -	int already;
> -	unsigned int clen, clen_changed, thisgrp_len;
> +	int err;
> +	unsigned int clen, thisgrp_len;
>  
>  	while (len > 0) {
>  		ext4_get_group_no_and_offset(sb, block, &group, &blkoff);
> @@ -3885,80 +3965,17 @@ void ext4_mb_mark_bb(struct super_block *sb, ext4_fsblk_t block,
>  			ext4_error(sb, "Marking blocks in system zone - "
>  				   "Block = %llu, len = %u",
>  				   block, thisgrp_len);
> -			bitmap_bh = NULL;
>  			break;
>  		}
>  
> -		bitmap_bh = ext4_read_block_bitmap(sb, group);
> -		if (IS_ERR(bitmap_bh)) {
> -			err = PTR_ERR(bitmap_bh);
> -			bitmap_bh = NULL;
> -			break;
> -		}
> -
> -		err = -EIO;
> -		gdp = ext4_get_group_desc(sb, group, &gdp_bh);
> -		if (!gdp)
> -			break;
> -
> -		ext4_lock_group(sb, group);
> -		already = 0;
> -		for (i = 0; i < clen; i++)
> -			if (!mb_test_bit(blkoff + i, bitmap_bh->b_data) ==
> -					 !state)
> -				already++;
> -
> -		clen_changed = clen - already;
> -		if (state)
> -			mb_set_bits(bitmap_bh->b_data, blkoff, clen);
> -		else
> -			mb_clear_bits(bitmap_bh->b_data, blkoff, clen);
> -		if (ext4_has_group_desc_csum(sb) &&
> -		    (gdp->bg_flags & cpu_to_le16(EXT4_BG_BLOCK_UNINIT))) {
> -			gdp->bg_flags &= cpu_to_le16(~EXT4_BG_BLOCK_UNINIT);
> -			ext4_free_group_clusters_set(sb, gdp,
> -			     ext4_free_clusters_after_init(sb, group, gdp));
> -		}
> -		if (state)
> -			clen = ext4_free_group_clusters(sb, gdp) - clen_changed;
> -		else
> -			clen = ext4_free_group_clusters(sb, gdp) + clen_changed;
> -
> -		ext4_free_group_clusters_set(sb, gdp, clen);
> -		ext4_block_bitmap_csum_set(sb, gdp, bitmap_bh);
> -		ext4_group_desc_csum_set(sb, group, gdp);
> -
> -		ext4_unlock_group(sb, group);
> -
> -		if (sbi->s_log_groups_per_flex) {
> -			ext4_group_t flex_group = ext4_flex_group(sbi, group);
> -			struct flex_groups *fg = sbi_array_rcu_deref(sbi,
> -						   s_flex_groups, flex_group);
> -
> -			if (state)
> -				atomic64_sub(clen_changed, &fg->free_clusters);
> -			else
> -				atomic64_add(clen_changed, &fg->free_clusters);
> -
> -		}
> -
> -		err = ext4_handle_dirty_metadata(NULL, NULL, bitmap_bh);
> -		if (err)
> -			break;
> -		sync_dirty_buffer(bitmap_bh);
> -		err = ext4_handle_dirty_metadata(NULL, NULL, gdp_bh);
> -		sync_dirty_buffer(gdp_bh);
> +		err = ext4_mb_mark_group_bb(&mc, group, blkoff, clen);
>  		if (err)
>  			break;
>  
>  		block += thisgrp_len;
>  		len -= thisgrp_len;
> -		brelse(bitmap_bh);
>  		BUG_ON(len < 0);
>  	}
> -
> -	if (err)
> -		brelse(bitmap_bh);
>  }
>  
>  /*
> -- 
> 2.30.0
> 
