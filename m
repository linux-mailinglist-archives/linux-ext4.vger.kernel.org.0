Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC81701CA6
	for <lists+linux-ext4@lfdr.de>; Sun, 14 May 2023 11:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjENJiG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 14 May 2023 05:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjENJiF (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 14 May 2023 05:38:05 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56DD22107;
        Sun, 14 May 2023 02:38:04 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34E9bmJX001314;
        Sun, 14 May 2023 09:37:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=mU/BiDjGWCs2rZnGurNKz3LTl46WS6wlouUMyCPFaLE=;
 b=MiyGTmcx+6rtzYvYv4BqZ7FaoXj6Hw1q3wvdmkToWh9cX3go4vZVjN/WAIhtT2xGr+Ey
 wnsYw1jFJmQ4HgaR8/ujq8YKza2fWKJu5aOqsjnUzFz8ztILLgxDCYBJ0dkqp/kq7zEu
 kV1J95YNGx9bwdq3KICv8PDxBhlny9TDU6EkncM5x944c3IMUTAdsoXLjgrpHaAZrR2w
 DSnlJraaESqUg9ID4GdIkcAnDAhD2Auk3u3b/dlxfpx4AY+3iSPEqSo82ejgk9yqdU1V
 zPsxyZQFxKWW8coCIcW9EcYjROku8ySLOzk+QUxLTJ1IAbKHmNH/Unyxg7KM8P1GhjBe kg== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qjuhp1e83-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 14 May 2023 09:37:52 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34E9NPJ0018157;
        Sun, 14 May 2023 09:33:22 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma03fra.de.ibm.com (PPS) with ESMTPS id 3qj2650et3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 14 May 2023 09:33:21 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34E9XJKo63177196
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 14 May 2023 09:33:19 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4413B20043;
        Sun, 14 May 2023 09:33:19 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B52DF20040;
        Sun, 14 May 2023 09:33:17 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.36.114])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Sun, 14 May 2023 09:33:17 +0000 (GMT)
Date:   Sun, 14 May 2023 15:03:15 +0530
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 14/19] ext4: extent ext4_mb_mark_group_bb to support
 allocation under journal
Message-ID: <ZGCq2yKNyp5VMUM4@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20230417110617.2664129-1-shikemeng@huaweicloud.com>
 <20230417110617.2664129-15-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230417110617.2664129-15-shikemeng@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: cRcbqDCKkx0-HyXE3pXCN9GjzCemDQ0U
X-Proofpoint-GUID: cRcbqDCKkx0-HyXE3pXCN9GjzCemDQ0U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-14_06,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 impostorscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305140085
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Apr 17, 2023 at 07:06:12PM +0800, Kemeng Shi wrote:
> Previously, ext4_mb_mark_group_bb is only called under fast commit
> replay path, so there is no valid handle when we update block bitmap
> and group descriptor. This patch try to extent ext4_mb_mark_group_bb
> to be used by code under journal. There are several improves:
> 1. add "handle_t *handle" to struct ext4_mark_context to accept handle
> to journal block bitmap and group descriptor update inside
> ext4_mb_mark_group_bb (the added journal caode is based on journal
> code in ext4_mb_mark_diskspace_used where ext4_mb_mark_group_bb
> is going to be used.)
> 2. add EXT4_MB_BITMAP_MARKED_CHECK flag to control check if bits in block
> bitmap are already marked as allocation code under journal asserts that
> all bits to be changed are not marked before.
> 3. add "ext4_grpblk_t changed" to struct ext4_mark_context to notify number
> of bits in block bitmap has changed.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Looks good, feel free to add:

Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Regards,
ojaswin

> ---
>  fs/ext4/mballoc.c | 59 ++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 45 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 623508115d98..c3e620f6eded 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -3730,32 +3730,54 @@ void ext4_exit_mballoc(void)
>  	ext4_groupinfo_destroy_slabs();
>  }
>  
> +#define EXT4_MB_BITMAP_MARKED_CHECK 0x0001
> +#define EXT4_MB_SYNC_UPDATE 0x0002
>  struct ext4_mark_context {
> +	handle_t *handle;
>  	struct super_block *sb;
>  	int state;
> +	ext4_grpblk_t changed;
>  };
>  
>  static int
>  ext4_mb_mark_group_bb(struct ext4_mark_context *mc, ext4_group_t group,
> -		      ext4_grpblk_t blkoff, ext4_grpblk_t len)
> +		      ext4_grpblk_t blkoff, ext4_grpblk_t len, int flags)
>  {
> +	handle_t *handle = mc->handle;
>  	struct super_block *sb = mc->sb;
>  	struct ext4_sb_info *sbi = EXT4_SB(sb);
>  	struct buffer_head *bitmap_bh = NULL;
>  	struct ext4_group_desc *gdp;
>  	struct buffer_head *gdp_bh;
>  	int err;
> -	unsigned int i, already, changed;
> +	unsigned int i, already, changed = len;
>  
> +	mc->changed = 0;
>  	bitmap_bh = ext4_read_block_bitmap(sb, group);
>  	if (IS_ERR(bitmap_bh))
>  		return PTR_ERR(bitmap_bh);
>  
> +	if (handle) {
> +		BUFFER_TRACE(bitmap_bh, "getting write access");
> +		err = ext4_journal_get_write_access(handle, sb, bitmap_bh,
> +						    EXT4_JTR_NONE);
> +		if (err)
> +			goto out_err;
> +	}
> +
>  	err = -EIO;
>  	gdp = ext4_get_group_desc(sb, group, &gdp_bh);
>  	if (!gdp)
>  		goto out_err;
>  
> +	if (handle) {
> +		BUFFER_TRACE(gdp_bh, "get_write_access");
> +		err = ext4_journal_get_write_access(handle, sb, gdp_bh,
> +						    EXT4_JTR_NONE);
> +		if (err)
> +			goto out_err;
> +	}
> +
>  	ext4_lock_group(sb, group);
>  	if (ext4_has_group_desc_csum(sb) &&
>  	    (gdp->bg_flags & cpu_to_le16(EXT4_BG_BLOCK_UNINIT))) {
> @@ -3764,12 +3786,14 @@ ext4_mb_mark_group_bb(struct ext4_mark_context *mc, ext4_group_t group,
>  			ext4_free_clusters_after_init(sb, group, gdp));
>  	}
>  
> -	already = 0;
> -	for (i = 0; i < len; i++)
> -		if (mb_test_bit(blkoff + i, bitmap_bh->b_data) ==
> -				mc->state)
> -			already++;
> -	changed = len - already;
> +	if (flags & EXT4_MB_BITMAP_MARKED_CHECK) {
> +		already = 0;
> +		for (i = 0; i < len; i++)
> +			if (mb_test_bit(blkoff + i, bitmap_bh->b_data) ==
> +					mc->state)
> +				already++;
> +		changed = len - already;
> +	}
>  
>  	if (mc->state) {
>  		mb_set_bits(bitmap_bh->b_data, blkoff, len);
> @@ -3784,6 +3808,7 @@ ext4_mb_mark_group_bb(struct ext4_mark_context *mc, ext4_group_t group,
>  	ext4_block_bitmap_csum_set(sb, gdp, bitmap_bh);
>  	ext4_group_desc_csum_set(sb, group, gdp);
>  	ext4_unlock_group(sb, group);
> +	mc->changed = changed;
>  
>  	if (sbi->s_log_groups_per_flex) {
>  		ext4_group_t flex_group = ext4_flex_group(sbi, group);
> @@ -3796,15 +3821,17 @@ ext4_mb_mark_group_bb(struct ext4_mark_context *mc, ext4_group_t group,
>  			atomic64_add(changed, &fg->free_clusters);
>  	}
>  
> -	err = ext4_handle_dirty_metadata(NULL, NULL, bitmap_bh);
> +	err = ext4_handle_dirty_metadata(handle, NULL, bitmap_bh);
>  	if (err)
>  		goto out_err;
> -	err = ext4_handle_dirty_metadata(NULL, NULL, gdp_bh);
> +	err = ext4_handle_dirty_metadata(handle, NULL, gdp_bh);
>  	if (err)
>  		goto out_err;
>  
> -	sync_dirty_buffer(bitmap_bh);
> -	sync_dirty_buffer(gdp_bh);
> +	if (flags & EXT4_MB_SYNC_UPDATE) {
> +		sync_dirty_buffer(bitmap_bh);
> +		sync_dirty_buffer(gdp_bh);
> +	}
>  
>  out_err:
>  	brelse(bitmap_bh);
> @@ -3968,7 +3995,9 @@ void ext4_mb_mark_bb(struct super_block *sb, ext4_fsblk_t block,
>  			break;
>  		}
>  
> -		err = ext4_mb_mark_group_bb(&mc, group, blkoff, clen);
> +		err = ext4_mb_mark_group_bb(&mc, group, blkoff, clen,
> +					    EXT4_MB_BITMAP_MARKED_CHECK |
> +					    EXT4_MB_SYNC_UPDATE);
>  		if (err)
>  			break;
>  
> @@ -6072,7 +6101,9 @@ static void ext4_free_blocks_simple(struct inode *inode, ext4_fsblk_t block,
>  	ext4_grpblk_t blkoff;
>  
>  	ext4_get_group_no_and_offset(sb, block, &group, &blkoff);
> -	ext4_mb_mark_group_bb(&mc, group, blkoff, count);
> +	ext4_mb_mark_group_bb(&mc, group, blkoff, count,
> +			      EXT4_MB_BITMAP_MARKED_CHECK |
> +			      EXT4_MB_SYNC_UPDATE);
>  }
>  
>  /**
> -- 
> 2.30.0
> 
