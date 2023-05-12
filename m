Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 913E47000EE
	for <lists+linux-ext4@lfdr.de>; Fri, 12 May 2023 08:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240037AbjELG4N (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 12 May 2023 02:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240023AbjELG4J (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 12 May 2023 02:56:09 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D905DDC7A;
        Thu, 11 May 2023 23:56:07 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34C6muFk003626;
        Fri, 12 May 2023 06:55:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=VzS9eGWWB1U+k/wSJd257OOg1LxfksYfJbzavw0+Cgg=;
 b=CxY8fX7J+tocJqY0OYXF9bJVE7QG+ki//bDeyvRBt59Nd9c2MUJ0j+jDftbw7XlERi0B
 iicQ3RBOchBIrG5h4PstYVaUMSSBkinF5rh1XOl/kAndWORHw+/1p4SVHF4Fi5piFTt7
 NipciLUKn9HceiAGzBsORK7D/TZ8/M7+eLgbnp5HH3AEvq24JhJZhBucEDPJxZZsHKqt
 L+tGn2eooxGKxGIAYU37PkXQJ3Nna7Tpx4mFvisslzcGB8qSWQW1CauCd0CXAWw/EV1e
 6FN3Ujvqa88DZPJ6ik+kzIBiKCeVS12Ej1FapTXy1vgJvomDG4OuwWOb/7iAbxLrXD5z tA== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qhg7cgvq9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 May 2023 06:55:49 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34C5aRxh029414;
        Fri, 12 May 2023 06:37:07 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3qf7nh25ge-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 May 2023 06:37:07 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34C6b5WO852730
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 06:37:05 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ECEC720043;
        Fri, 12 May 2023 06:37:04 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8A3BB20040;
        Fri, 12 May 2023 06:37:03 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.7.84])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri, 12 May 2023 06:37:03 +0000 (GMT)
Date:   Fri, 12 May 2023 12:07:00 +0530
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 09/19] ext4: remove unsed parameter and unnecessary
 forward declaration of ext4_mb_new_blocks_simple
Message-ID: <ZF3ejB3W6UCp9/MZ@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20230417110617.2664129-1-shikemeng@huaweicloud.com>
 <20230417110617.2664129-10-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230417110617.2664129-10-shikemeng@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3RaMELDIXerXK8K6FhcR0CJ55jxClWR-
X-Proofpoint-GUID: 3RaMELDIXerXK8K6FhcR0CJ55jxClWR-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-12_03,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 spamscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305120056
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Apr 17, 2023 at 07:06:07PM +0800, Kemeng Shi wrote:
> Two cleanups for ext4_mb_new_blocks_simple:
> Remove unsed parameter handle of ext4_mb_new_blocks_simple.
> Move ext4_mb_new_blocks_simple definition before ext4_mb_new_blocks to
> remove unnecessary forward declaration of ext4_mb_new_blocks_simple.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Feel free to add:

Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

> ---
>  fs/ext4/mballoc.c | 137 +++++++++++++++++++++++-----------------------
>  1 file changed, 67 insertions(+), 70 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index f37e921c11e5..774f969b39d8 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -5729,8 +5729,72 @@ static bool ext4_mb_discard_preallocations_should_retry(struct super_block *sb,
>  	return ret;
>  }
>  
> -static ext4_fsblk_t ext4_mb_new_blocks_simple(handle_t *handle,
> -				struct ext4_allocation_request *ar, int *errp);
> +/*
> + * Simple allocator for Ext4 fast commit replay path. It searches for blocks
> + * linearly starting at the goal block and also excludes the blocks which
> + * are going to be in use after fast commit replay.
> + */
> +static ext4_fsblk_t
> +ext4_mb_new_blocks_simple(struct ext4_allocation_request *ar, int *errp)
> +{
> +	struct buffer_head *bitmap_bh;
> +	struct super_block *sb = ar->inode->i_sb;
> +	struct ext4_sb_info *sbi = EXT4_SB(sb);
> +	ext4_group_t group, nr;
> +	ext4_grpblk_t blkoff;
> +	ext4_grpblk_t max = EXT4_CLUSTERS_PER_GROUP(sb);
> +	ext4_grpblk_t i = 0;
> +	ext4_fsblk_t goal, block;
> +	struct ext4_super_block *es = EXT4_SB(sb)->s_es;
> +
> +	goal = ar->goal;
> +	if (goal < le32_to_cpu(es->s_first_data_block) ||
> +			goal >= ext4_blocks_count(es))
> +		goal = le32_to_cpu(es->s_first_data_block);
> +
> +	ar->len = 0;
> +	ext4_get_group_no_and_offset(sb, goal, &group, &blkoff);
> +	for (nr = ext4_get_groups_count(sb); nr > 0; nr--) {
> +		bitmap_bh = ext4_read_block_bitmap(sb, group);
> +		if (IS_ERR(bitmap_bh)) {
> +			*errp = PTR_ERR(bitmap_bh);
> +			pr_warn("Failed to read block bitmap\n");
> +			return 0;
> +		}
> +
> +		while (1) {
> +			i = mb_find_next_zero_bit(bitmap_bh->b_data, max,
> +						blkoff);
> +			if (i >= max)
> +				break;
> +			if (ext4_fc_replay_check_excluded(sb,
> +				ext4_group_first_block_no(sb, group) +
> +				EXT4_C2B(sbi, i))) {
> +				blkoff = i + 1;
> +			} else
> +				break;
> +		}
> +		brelse(bitmap_bh);
> +		if (i < max)
> +			break;
> +
> +		if (++group >= ext4_get_groups_count(sb))
> +			group = 0;
> +
> +		blkoff = 0;
> +	}
> +
> +	if (i >= max) {
> +		*errp = -ENOSPC;
> +		return 0;
> +	}
> +
> +	block = ext4_group_first_block_no(sb, group) + EXT4_C2B(sbi, i);
> +	ext4_mb_mark_bb(sb, block, 1, 1);
> +	ar->len = 1;
> +
> +	return block;
> +}
>  
>  /*
>   * Main entry point into mballoc to allocate blocks
> @@ -5755,7 +5819,7 @@ ext4_fsblk_t ext4_mb_new_blocks(handle_t *handle,
>  
>  	trace_ext4_request_blocks(ar);
>  	if (sbi->s_mount_state & EXT4_FC_REPLAY)
> -		return ext4_mb_new_blocks_simple(handle, ar, errp);
> +		return ext4_mb_new_blocks_simple(ar, errp);
>  
>  	/* Allow to use superuser reservation for quota file */
>  	if (ext4_is_quota_file(ar->inode))
> @@ -5979,73 +6043,6 @@ ext4_mb_free_metadata(handle_t *handle, struct ext4_buddy *e4b,
>  	spin_unlock(&sbi->s_md_lock);
>  }
>  
> -/*
> - * Simple allocator for Ext4 fast commit replay path. It searches for blocks
> - * linearly starting at the goal block and also excludes the blocks which
> - * are going to be in use after fast commit replay.
> - */
> -static ext4_fsblk_t ext4_mb_new_blocks_simple(handle_t *handle,
> -				struct ext4_allocation_request *ar, int *errp)
> -{
> -	struct buffer_head *bitmap_bh;
> -	struct super_block *sb = ar->inode->i_sb;
> -	struct ext4_sb_info *sbi = EXT4_SB(sb);
> -	ext4_group_t group, nr;
> -	ext4_grpblk_t blkoff;
> -	ext4_grpblk_t max = EXT4_CLUSTERS_PER_GROUP(sb);
> -	ext4_grpblk_t i = 0;
> -	ext4_fsblk_t goal, block;
> -	struct ext4_super_block *es = EXT4_SB(sb)->s_es;
> -
> -	goal = ar->goal;
> -	if (goal < le32_to_cpu(es->s_first_data_block) ||
> -			goal >= ext4_blocks_count(es))
> -		goal = le32_to_cpu(es->s_first_data_block);
> -
> -	ar->len = 0;
> -	ext4_get_group_no_and_offset(sb, goal, &group, &blkoff);
> -	for (nr = ext4_get_groups_count(sb); nr > 0; nr--) {
> -		bitmap_bh = ext4_read_block_bitmap(sb, group);
> -		if (IS_ERR(bitmap_bh)) {
> -			*errp = PTR_ERR(bitmap_bh);
> -			pr_warn("Failed to read block bitmap\n");
> -			return 0;
> -		}
> -
> -		while (1) {
> -			i = mb_find_next_zero_bit(bitmap_bh->b_data, max,
> -						blkoff);
> -			if (i >= max)
> -				break;
> -			if (ext4_fc_replay_check_excluded(sb,
> -				ext4_group_first_block_no(sb, group) +
> -				EXT4_C2B(sbi, i))) {
> -				blkoff = i + 1;
> -			} else
> -				break;
> -		}
> -		brelse(bitmap_bh);
> -		if (i < max)
> -			break;
> -
> -		if (++group >= ext4_get_groups_count(sb))
> -			group = 0;
> -
> -		blkoff = 0;
> -	}
> -
> -	if (i >= max) {
> -		*errp = -ENOSPC;
> -		return 0;
> -	}
> -
> -	block = ext4_group_first_block_no(sb, group) + EXT4_C2B(sbi, i);
> -	ext4_mb_mark_bb(sb, block, 1, 1);
> -	ar->len = 1;
> -
> -	return block;
> -}
> -
>  static void ext4_free_blocks_simple(struct inode *inode, ext4_fsblk_t block,
>  					unsigned long count)
>  {
> -- 
> 2.30.0
> 
