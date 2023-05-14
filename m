Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F426701C9C
	for <lists+linux-ext4@lfdr.de>; Sun, 14 May 2023 11:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbjENJcT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 14 May 2023 05:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjENJcS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 14 May 2023 05:32:18 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA331FF6;
        Sun, 14 May 2023 02:32:16 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34E8dFee012130;
        Sun, 14 May 2023 09:32:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=PRKnceF7U66WwtE8g0fNmU5gUV+/h0tamY9vEV9j0UI=;
 b=ACmW9QUsK/qd0am0Uil2JNmQYXaI3lXfEDkCIUJt0U1ClWDwdhcwxVuIBXqwl3dhsU2V
 kffwxQoNP162/Ns7NU9H00+snRnVp/bovMA4t1VwzYloqyBaE9jUJ1KNcB+ApG6lCCJ7
 RpY2x/rEOpkILoyiDqfdiEue4dmjrAjbEiI/i0BY0qj4ouO68MxROWAxR9cNJq6tTCEP
 0OPMstAA9OHW80K1oO45OaR+QoTyMAxfheF6r+MkN03ecYg2gRde78AvWTbtw69Qr8Vy
 CYqDpJIJ+qlrPEJ4y0U9z4p9DUXMeX4gdBbBJ2vxMs57Yswy4Uv1mkBEm+jnXeYaM44n lw== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qj3tmfgh0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 14 May 2023 09:32:09 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34E8r10v026811;
        Sun, 14 May 2023 09:32:07 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma03fra.de.ibm.com (PPS) with ESMTPS id 3qj2650esw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 14 May 2023 09:32:07 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34E9W5Qe37814900
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 14 May 2023 09:32:05 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2204C20043;
        Sun, 14 May 2023 09:32:05 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ABC4B20040;
        Sun, 14 May 2023 09:32:03 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.36.114])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Sun, 14 May 2023 09:32:03 +0000 (GMT)
Date:   Sun, 14 May 2023 15:02:00 +0530
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 13/19] ext4: call ext4_mb_mark_group_bb in
 ext4_free_blocks_simple
Message-ID: <ZGCqkC+UHebpPSwm@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20230417110617.2664129-1-shikemeng@huaweicloud.com>
 <20230417110617.2664129-14-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230417110617.2664129-14-shikemeng@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: dQ8WNTH7rAeHU6CObp4WrpbMLfOgH4cO
X-Proofpoint-GUID: dQ8WNTH7rAeHU6CObp4WrpbMLfOgH4cO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-14_06,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0
 bulkscore=0 adultscore=0 mlxscore=0 mlxlogscore=791 phishscore=0
 lowpriorityscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2305140082
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Apr 17, 2023 at 07:06:11PM +0800, Kemeng Shi wrote:
> call ext4_mb_mark_group_bb in ext4_free_blocks_simple to:
> 1. remove repeat code
> 2. pair update of free_clusters in ext4_mb_new_blocks_simple.
> 3. add missing ext4_lock_group/ext4_unlock_group protection.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Correct me if I'm wrong but I think we will never try to clear bitmap
bits for a BLOCK_UNINIT BG right. Maybe if that's the case we can add a
WARN_ON as follows in ext4_mb_mark_group_bb():

	if (ext4_has_group_desc_csum(sb) &&
		(gdp->bg_flags & cpu_to_le16(EXT4_BG_BLOCK_UNINIT))) {

		WARN_ON(mc->state == 0);
		...

	}

Other than that the patch looks good, feel free to add:

Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Regards,
ojaswin
> ---
>  fs/ext4/mballoc.c | 37 +++++--------------------------------
>  1 file changed, 5 insertions(+), 32 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index ba165dc07890..623508115d98 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -6063,43 +6063,16 @@ ext4_mb_free_metadata(handle_t *handle, struct ext4_buddy *e4b,
>  static void ext4_free_blocks_simple(struct inode *inode, ext4_fsblk_t block,
>  					unsigned long count)
>  {
> -	struct buffer_head *bitmap_bh;
> +	struct ext4_mark_context mc = {
> +		.sb = inode->i_sb,
> +		.state = 0,
> +	};
>  	struct super_block *sb = inode->i_sb;
> -	struct ext4_group_desc *gdp;
> -	struct buffer_head *gdp_bh;
>  	ext4_group_t group;
>  	ext4_grpblk_t blkoff;
> -	int already_freed = 0, err, i;
>  
>  	ext4_get_group_no_and_offset(sb, block, &group, &blkoff);
> -	bitmap_bh = ext4_read_block_bitmap(sb, group);
> -	if (IS_ERR(bitmap_bh)) {
> -		pr_warn("Failed to read block bitmap\n");
> -		return;
> -	}
> -	gdp = ext4_get_group_desc(sb, group, &gdp_bh);
> -	if (!gdp)
> -		goto err_out;
> -
> -	for (i = 0; i < count; i++) {
> -		if (!mb_test_bit(blkoff + i, bitmap_bh->b_data))
> -			already_freed++;
> -	}
> -	mb_clear_bits(bitmap_bh->b_data, blkoff, count);
> -	err = ext4_handle_dirty_metadata(NULL, NULL, bitmap_bh);
> -	if (err)
> -		goto err_out;
> -	ext4_free_group_clusters_set(
> -		sb, gdp, ext4_free_group_clusters(sb, gdp) +
> -		count - already_freed);
> -	ext4_block_bitmap_csum_set(sb, gdp, bitmap_bh);
> -	ext4_group_desc_csum_set(sb, group, gdp);
> -	ext4_handle_dirty_metadata(NULL, NULL, gdp_bh);
> -	sync_dirty_buffer(bitmap_bh);
> -	sync_dirty_buffer(gdp_bh);
> -
> -err_out:
> -	brelse(bitmap_bh);
> +	ext4_mb_mark_group_bb(&mc, group, blkoff, count);
>  }
>  
>  /**
> -- 
> 2.30.0
> 
