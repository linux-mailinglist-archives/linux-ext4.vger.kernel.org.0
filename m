Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5E1701CA8
	for <lists+linux-ext4@lfdr.de>; Sun, 14 May 2023 11:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234383AbjENJiW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 14 May 2023 05:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236310AbjENJiS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 14 May 2023 05:38:18 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4FB26B9;
        Sun, 14 May 2023 02:38:11 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34E9buZE019072;
        Sun, 14 May 2023 09:38:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=zkO8daX/fYDQ3u/j/k1ZYMS5G0RwJxz/M8PpT8RrFOY=;
 b=OheXM2jI4olSGO50m35H8RG1sdGD6BcrrUEAS7n2fbvC36GLFPZGgU0Y9J9so6sNnhZb
 MEJoWMHS8ge6UkK5521QN+CVScGUbsxNevglivyZjnz1VDV1oI21mrs6zGVYeOYd/v16
 Cehue1I8JjE4JQn4Z7HkbSpc1HnwAm4CG5qc6/6FbEIcYGTkyrqGDu1tepl66ax384Nu
 AkFpR1FCCHeeKlrvuUyu2rHjz9+N5oShSdKc1T5ajMGJxZTOLg1VHsxIH4ueiJDZ7n+b
 K8QBHykZP5qpHYX3OfSu7vewnTWnIOFpUHpXz1fQtJ2dNCFK3MxxuRTIOGww/AaGEcZy 9A== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qjuy390vy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 14 May 2023 09:38:01 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34E3Evgr028131;
        Sun, 14 May 2023 09:37:58 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3qj264rh9c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 14 May 2023 09:37:58 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34E9btNE48300508
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 14 May 2023 09:37:55 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C635720040;
        Sun, 14 May 2023 09:37:55 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5F62E2004B;
        Sun, 14 May 2023 09:37:54 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.36.114])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Sun, 14 May 2023 09:37:54 +0000 (GMT)
Date:   Sun, 14 May 2023 15:07:51 +0530
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 15/19] ext4: call ext4_mb_mark_group_bb in
 ext4_mb_mark_diskspace_used
Message-ID: <ZGCr74q8dfqMgq0t@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20230417110617.2664129-1-shikemeng@huaweicloud.com>
 <20230417110617.2664129-16-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230417110617.2664129-16-shikemeng@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: MYTYV8NRZGhV85VdatizEDuPxDTzS4nE
X-Proofpoint-ORIG-GUID: MYTYV8NRZGhV85VdatizEDuPxDTzS4nE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-14_06,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 suspectscore=0 mlxscore=0 impostorscore=0
 malwarescore=0 mlxlogscore=999 priorityscore=1501 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305140085
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Apr 17, 2023 at 07:06:13PM +0800, Kemeng Shi wrote:
> call ext4_mb_mark_group_bb in ext4_mb_mark_diskspace_used to:
> 1. remove repeat code to normally update bitmap and group descriptor
> on disk.
> 2. call ext4_mb_mark_group_bb instead of only setting bits in block bitmap
> to fix the bitmap. Function ext4_mb_mark_group_bb will also update
> checksum of bitmap and other counter along with the bit change to keep
> the cosistent with bit change or block bitmap will be marked corrupted as
> checksum of bitmap is in inconsistent state.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Looks good, feel free to add:

Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Just a minor suggestion below:
> ---
>  fs/ext4/mballoc.c | 90 +++++++++++++----------------------------------
>  1 file changed, 24 insertions(+), 66 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index c3e620f6eded..bd440614db76 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -3846,9 +3846,12 @@ static noinline_for_stack int
>  ext4_mb_mark_diskspace_used(struct ext4_allocation_context *ac,
>  				handle_t *handle, unsigned int reserv_clstrs)
>  {
> -	struct buffer_head *bitmap_bh = NULL;
> +	struct ext4_mark_context mc = {
> +		.handle = handle,
> +		.sb = ac->ac_sb,
> +		.state = 1,
> +	};
>  	struct ext4_group_desc *gdp;
> -	struct buffer_head *gdp_bh;
>  	struct ext4_sb_info *sbi;
>  	struct super_block *sb;
>  	ext4_fsblk_t block;
> @@ -3860,32 +3863,13 @@ ext4_mb_mark_diskspace_used(struct ext4_allocation_context *ac,
>  	sb = ac->ac_sb;
>  	sbi = EXT4_SB(sb);
>  
> -	bitmap_bh = ext4_read_block_bitmap(sb, ac->ac_b_ex.fe_group);
> -	if (IS_ERR(bitmap_bh)) {
> -		return PTR_ERR(bitmap_bh);
> -	}
> -
> -	BUFFER_TRACE(bitmap_bh, "getting write access");
> -	err = ext4_journal_get_write_access(handle, sb, bitmap_bh,
> -					    EXT4_JTR_NONE);
> -	if (err)
> -		goto out_err;
> -
> -	err = -EIO;
> -	gdp = ext4_get_group_desc(sb, ac->ac_b_ex.fe_group, &gdp_bh);
> +	gdp = ext4_get_group_desc(sb, ac->ac_b_ex.fe_group, NULL);
>  	if (!gdp)
> -		goto out_err;
> -
> +		return -EIO;
>  	ext4_debug("using block group %u(%d)\n", ac->ac_b_ex.fe_group,
>  			ext4_free_group_clusters(sb, gdp));
>  
> -	BUFFER_TRACE(gdp_bh, "get_write_access");
> -	err = ext4_journal_get_write_access(handle, sb, gdp_bh, EXT4_JTR_NONE);
> -	if (err)
> -		goto out_err;
> -
>  	block = ext4_grp_offs_to_block(sb, &ac->ac_b_ex);
> -
>  	len = EXT4_C2B(sbi, ac->ac_b_ex.fe_len);
>  	if (!ext4_inode_block_valid(ac->ac_inode, block, len)) {
>  		ext4_error(sb, "Allocating blocks %llu-%llu which overlap "
> @@ -3894,41 +3878,30 @@ ext4_mb_mark_diskspace_used(struct ext4_allocation_context *ac,
>  		 * Fix the bitmap and return EFSCORRUPTED
>  		 * We leak some of the blocks here.
>  		 */
> -		ext4_lock_group(sb, ac->ac_b_ex.fe_group);
> -		mb_set_bits(bitmap_bh->b_data, ac->ac_b_ex.fe_start,
> -			      ac->ac_b_ex.fe_len);
> -		ext4_unlock_group(sb, ac->ac_b_ex.fe_group);
> -		err = ext4_handle_dirty_metadata(handle, NULL, bitmap_bh);
> +		err = ext4_mb_mark_group_bb(&mc, ac->ac_b_ex.fe_group,
> +					    ac->ac_b_ex.fe_start,
> +					    ac->ac_b_ex.fe_len,
> +					    0);
>  		if (!err)
>  			err = -EFSCORRUPTED;
> -		goto out_err;
> +		return err;
>  	}
>  
> -	ext4_lock_group(sb, ac->ac_b_ex.fe_group);
>  #ifdef AGGRESSIVE_CHECK
> -	{
> -		int i;
> -		for (i = 0; i < ac->ac_b_ex.fe_len; i++) {
> -			BUG_ON(mb_test_bit(ac->ac_b_ex.fe_start + i,
> -						bitmap_bh->b_data));
> -		}
> -	}
> +	err = ext4_mb_mark_group_bb(&mc, ac->ac_b_ex.fe_group,
> +				    ac->ac_b_ex.fe_start, ac->ac_b_ex.fe_len,
> +				    EXT4_MB_BITMAP_MARKED_CHECK);
> +#else
> +	err = ext4_mb_mark_group_bb(&mc, ac->ac_b_ex.fe_group,
> +				    ac->ac_b_ex.fe_start, ac->ac_b_ex.fe_len,
> +				    0);
>  #endif

I think, the refactoring the AGGRESSIVE_CHECK as follows makes the
intent more obvious and easier to read.

#ifdef AGGRESSIVE_CHECK

flags |= EXT4_MB_BITMAP_MARKED_CHECK;

#endif

err = ext4_mb_mark_group_bb(&mc, ac->ac_b_ex.fe_group,
			    ac->ac_b_ex.fe_start, ac->ac_b_ex.fe_len,
			    flags);

Regards,
ojaswin

> -	mb_set_bits(bitmap_bh->b_data, ac->ac_b_ex.fe_start,
> -		      ac->ac_b_ex.fe_len);
> -	if (ext4_has_group_desc_csum(sb) &&
> -	    (gdp->bg_flags & cpu_to_le16(EXT4_BG_BLOCK_UNINIT))) {
> -		gdp->bg_flags &= cpu_to_le16(~EXT4_BG_BLOCK_UNINIT);
> -		ext4_free_group_clusters_set(sb, gdp,
> -					     ext4_free_clusters_after_init(sb,
> -						ac->ac_b_ex.fe_group, gdp));
> -	}
> -	len = ext4_free_group_clusters(sb, gdp) - ac->ac_b_ex.fe_len;
> -	ext4_free_group_clusters_set(sb, gdp, len);
> -	ext4_block_bitmap_csum_set(sb, gdp, bitmap_bh);
> -	ext4_group_desc_csum_set(sb, ac->ac_b_ex.fe_group, gdp);
> +	if (err && mc.changed == 0)
> +		return err;
>  
> -	ext4_unlock_group(sb, ac->ac_b_ex.fe_group);
> +#ifdef AGGRESSIVE_CHECK
> +	BUG_ON(mc.changed != ac->ac_b_ex.fe_len);
> +#endif
>  	percpu_counter_sub(&sbi->s_freeclusters_counter, ac->ac_b_ex.fe_len);
>  	/*
>  	 * Now reduce the dirty block count also. Should not go negative
> @@ -3938,21 +3911,6 @@ ext4_mb_mark_diskspace_used(struct ext4_allocation_context *ac,
>  		percpu_counter_sub(&sbi->s_dirtyclusters_counter,
>  				   reserv_clstrs);
>  
> -	if (sbi->s_log_groups_per_flex) {
> -		ext4_group_t flex_group = ext4_flex_group(sbi,
> -							  ac->ac_b_ex.fe_group);
> -		atomic64_sub(ac->ac_b_ex.fe_len,
> -			     &sbi_array_rcu_deref(sbi, s_flex_groups,
> -						  flex_group)->free_clusters);
> -	}
> -
> -	err = ext4_handle_dirty_metadata(handle, NULL, bitmap_bh);
> -	if (err)
> -		goto out_err;
> -	err = ext4_handle_dirty_metadata(handle, NULL, gdp_bh);
> -
> -out_err:
> -	brelse(bitmap_bh);
>  	return err;
>  }
>  
> -- 
> 2.30.0
> 
