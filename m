Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB9302DDC4A
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Dec 2020 01:08:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732113AbgLRAIK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 17 Dec 2020 19:08:10 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:34302 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727172AbgLRAIJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 17 Dec 2020 19:08:09 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BHNs2Ek153132;
        Fri, 18 Dec 2020 00:07:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=hqqoayJPswmANHoF71Dg2sSPX/g0jkYd2+Q3Bh+oD3s=;
 b=wEXx5eh2rWQS0016RSK7yE0A8H6sZX9bGGOHmaYMdLEncL7pE6oRA6d8YDB860e8iGhR
 r6UXrCyEpGxZ39jJQ8a3eulZ5+jTyZA1lpu0p0i5BaEI7o3gE/jrAriJUN3Dv9IDgma6
 wcRq0jfbmQTs3By9OxS7WhwaAKs/Qr91W6Nd5mbLPOXkQtd4A0lYV1GZaUzqlACifUwO
 QheqJ+TkrBeOH05oK/CGdFwVKjb2qK+kNNQYjSHDV2Pn5hsx5yZ7QKZQD42MyzoaHgcn
 bq763iLRPVuZgPxRI/CJ601o3p+WuJIrI+Fi4up/yePKPAAJrkDAjv/O6ph+if4mXS/S MA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 35ckcbr8je-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 18 Dec 2020 00:07:19 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BHNuGou064260;
        Fri, 18 Dec 2020 00:05:18 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 35d7t14a65-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Dec 2020 00:05:18 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0BI05HVt005076;
        Fri, 18 Dec 2020 00:05:17 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 17 Dec 2020 16:05:16 -0800
Date:   Thu, 17 Dec 2020 16:05:15 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Saranya Muruganandam <saranyamohan@google.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, Wang Shilong <wshilong@ddn.com>
Subject: Re: [RFC PATCH v3 31/61] e2fsck: split and merge invalid bitmaps
Message-ID: <20201218000515.GC6908@magnolia>
References: <20201118153947.3394530-1-saranyamohan@google.com>
 <20201118153947.3394530-32-saranyamohan@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118153947.3394530-32-saranyamohan@google.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9838 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012170154
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9838 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 priorityscore=1501 mlxscore=0 suspectscore=0 adultscore=0 phishscore=0
 malwarescore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012170154
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Nov 18, 2020 at 07:39:17AM -0800, Saranya Muruganandam wrote:
> From: Wang Shilong <wshilong@ddn.com>
> 
> Invalid bitmaps are splitted per thread, and we
> should merge them after thread finish.

For a large filesystem, would it make more sense to merge results
periodically to reduce the peak memory consumption?  That might not be
all that high of a peak though since the end merges could be deleting
records from the per-thread data structure after each succesful
insertion merge.

--D

> Signed-off-by: Wang Shilong <wshilong@ddn.com>
> Signed-off-by: Saranya Muruganandam <saranyamohan@google.com>
> ---
>  e2fsck/pass1.c | 71 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 71 insertions(+)
> 
> diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
> index 49bdba21..29954e88 100644
> --- a/e2fsck/pass1.c
> +++ b/e2fsck/pass1.c
> @@ -2379,6 +2379,62 @@ out:
>  	return retval;
>  }
>  
> +static void e2fsck_pass1_copy_invalid_bitmaps(e2fsck_t global_ctx,
> +					      e2fsck_t thread_ctx)
> +{
> +	dgrp_t i, j;
> +	dgrp_t grp_start = thread_ctx->thread_info.et_group_start;
> +	dgrp_t grp_end = thread_ctx->thread_info.et_group_end;
> +	dgrp_t total = grp_end - grp_start;
> +
> +	thread_ctx->invalid_inode_bitmap_flag =
> +			e2fsck_allocate_memory(global_ctx, sizeof(int) * total,
> +						"invalid_inode_bitmap");
> +	thread_ctx->invalid_block_bitmap_flag =
> +			e2fsck_allocate_memory(global_ctx, sizeof(int) * total,
> +					       "invalid_block_bitmap");
> +	thread_ctx->invalid_inode_table_flag =
> +			e2fsck_allocate_memory(global_ctx, sizeof(int) * total,
> +					       "invalid_inode_table");
> +
> +	memcpy(thread_ctx->invalid_block_bitmap_flag,
> +	       &global_ctx->invalid_block_bitmap_flag[grp_start],
> +	       total * sizeof(int));
> +	memcpy(thread_ctx->invalid_inode_bitmap_flag,
> +	       &global_ctx->invalid_inode_bitmap_flag[grp_start],
> +	       total * sizeof(int));
> +	memcpy(thread_ctx->invalid_inode_table_flag,
> +	       &global_ctx->invalid_inode_table_flag[grp_start],
> +	       total * sizeof(int));
> +
> +	thread_ctx->invalid_bitmaps = 0;
> +	for (i = grp_start, j = 0; i < grp_end; i++, j++) {
> +		if (thread_ctx->invalid_block_bitmap_flag[j])
> +			thread_ctx->invalid_bitmaps++;
> +		if (thread_ctx->invalid_inode_bitmap_flag[j])
> +			thread_ctx->invalid_bitmaps++;
> +		if (thread_ctx->invalid_inode_table_flag[j])
> +			thread_ctx->invalid_bitmaps++;
> +	}
> +}
> +
> +static void e2fsck_pass1_merge_invalid_bitmaps(e2fsck_t global_ctx,
> +					       e2fsck_t thread_ctx)
> +{
> +	dgrp_t i, j;
> +	dgrp_t grp_start = thread_ctx->thread_info.et_group_start;
> +	dgrp_t grp_end = thread_ctx->thread_info.et_group_end;
> +	dgrp_t total = grp_end - grp_start;
> +
> +	memcpy(&global_ctx->invalid_block_bitmap_flag[grp_start],
> +	       thread_ctx->invalid_block_bitmap_flag, total * sizeof(int));
> +	memcpy(&global_ctx->invalid_inode_bitmap_flag[grp_start],
> +	       thread_ctx->invalid_inode_bitmap_flag, total * sizeof(int));
> +	memcpy(&global_ctx->invalid_inode_table_flag[grp_start],
> +	       thread_ctx->invalid_inode_table_flag, total * sizeof(int));
> +	global_ctx->invalid_bitmaps += thread_ctx->invalid_bitmaps;
> +}
> +
>  static errcode_t e2fsck_pass1_thread_prepare(e2fsck_t global_ctx, e2fsck_t *thread_ctx,
>  					     int thread_index, int num_threads)
>  {
> @@ -2455,6 +2511,7 @@ static errcode_t e2fsck_pass1_thread_prepare(e2fsck_t global_ctx, e2fsck_t *thre
>  		goto out_fs;
>  	}
>  	*thread_ctx = thread_context;
> +	e2fsck_pass1_copy_invalid_bitmaps(global_ctx, thread_context);
>  	return 0;
>  out_fs:
>  	ext2fs_free_mem(&thread_fs);
> @@ -2589,6 +2646,10 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
>  	ext2_ino_t dx_dir_info_count = global_ctx->dx_dir_info_count;
>  	ext2_u32_list dirs_to_hash = global_ctx->dirs_to_hash;
>  	quota_ctx_t qctx = global_ctx->qctx;
> +	int *invalid_block_bitmap_flag = global_ctx->invalid_block_bitmap_flag;
> +	int *invalid_inode_bitmap_flag = global_ctx->invalid_inode_bitmap_flag;
> +	int *invalid_inode_table_flag  = global_ctx->invalid_inode_table_flag;
> +	int invalid_bitmaps = global_ctx->invalid_bitmaps;
>  
>  #ifdef HAVE_SETJMP_H
>  	jmp_buf		 old_jmp;
> @@ -2667,6 +2728,11 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
>  					      thread_ctx->qctx);
>  	if (retval)
>  		return retval;
> +	global_ctx->invalid_block_bitmap_flag = invalid_block_bitmap_flag;
> +	global_ctx->invalid_inode_bitmap_flag = invalid_inode_bitmap_flag;
> +	global_ctx->invalid_inode_table_flag = invalid_inode_table_flag;
> +	global_ctx->invalid_bitmaps = invalid_bitmaps;
> +	e2fsck_pass1_merge_invalid_bitmaps(global_ctx, thread_ctx);
>  
>  	retval = e2fsck_pass1_merge_bitmap(global_fs,
>  				&thread_ctx->inode_used_map,
> @@ -2739,6 +2805,9 @@ static int e2fsck_pass1_thread_join(e2fsck_t global_ctx, e2fsck_t thread_ctx)
>  	if (thread_ctx->dirs_to_hash)
>  		ext2fs_badblocks_list_free(thread_ctx->dirs_to_hash);
>  	quota_release_context(&thread_ctx->qctx);
> +	ext2fs_free_mem(&thread_ctx->invalid_block_bitmap_flag);
> +	ext2fs_free_mem(&thread_ctx->invalid_inode_bitmap_flag);
> +	ext2fs_free_mem(&thread_ctx->invalid_inode_table_flag);
>  	ext2fs_free_mem(&thread_ctx);
>  
>  	return retval;
> @@ -2752,6 +2821,8 @@ static int e2fsck_pass1_threads_join(struct e2fsck_thread_info *infos,
>  	int				 i;
>  	struct e2fsck_thread_info	*pinfo;
>  
> +	/* merge invalid bitmaps will recalculate it */
> +	global_ctx->invalid_bitmaps = 0;
>  	for (i = 0; i < num_threads; i++) {
>  		pinfo = &infos[i];
>  
> -- 
> 2.29.2.299.gdc1121823c-goog
> 
