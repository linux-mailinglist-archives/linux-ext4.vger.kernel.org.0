Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E56E42DDBE5
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Dec 2020 00:34:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729166AbgLQXds (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 17 Dec 2020 18:33:48 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:59550 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbgLQXds (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 17 Dec 2020 18:33:48 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BHNV3da148336;
        Thu, 17 Dec 2020 23:33:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=Vbz3zFCtCF18eH8Wh4CcqPj8B9UhYGmOgUNAu7zs1vE=;
 b=lEQ2sYrhP4LQlp8fhHvTKksB+gxaIeJTY366AGvtL5qlaPGchgPuz1Xj1MJHp9UqNVbg
 2jiZInuwCzDkeY0DV1LgWg4OB+IkAPigfsTlBNzD9r9cRt+ehh15EsQMR5d/Wa96dEIY
 gEPzpmioz8U3wPqjA83FduWLChSEMMotiIW2+rGycftHt6eGgChfgwYEiC527t/QDsCK
 huc07KW1aIoQexFWnnM0sdRnqVUA5dkAsCeZ9Y6XsFS+kCBIkzAHI0RV8/QuHxtaLxwQ
 s5Q9peI2vWImmJj5dtXLVKejXNV36Qin974NPiotEejUrxfLRDv3L8uRrP/UIEGysQZi Cw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 35cn9rr113-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 17 Dec 2020 23:33:00 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BHNLL28088410;
        Thu, 17 Dec 2020 23:31:00 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 35e6eu0mdt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Dec 2020 23:31:00 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0BHNUwY6030600;
        Thu, 17 Dec 2020 23:30:58 GMT
Received: from localhost (/10.159.157.202)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 17 Dec 2020 15:30:58 -0800
Date:   Thu, 17 Dec 2020 15:30:56 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Saranya Muruganandam <saranyamohan@google.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, Wang Shilong <wshilong@ddn.com>
Subject: Re: [RFC PATCH v3 37/61] e2fsck: merge options after threads finish
Message-ID: <20201217233056.GA6908@magnolia>
References: <20201118153947.3394530-1-saranyamohan@google.com>
 <20201118153947.3394530-38-saranyamohan@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118153947.3394530-38-saranyamohan@google.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9838 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012170150
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9838 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 impostorscore=0 lowpriorityscore=0 clxscore=1011 spamscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012170151
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Nov 18, 2020 at 07:39:23AM -0800, Saranya Muruganandam wrote:
> From: Wang Shilong <wshilong@ddn.com>
> 
> It will be possible that threads might append E2F_OPT_YES,
> so we need merge options to global, test f_yesall cover this.

I don't get it -- presumably fix_problem already has to take some sort
of a lock to complain the console and (possibly) wait for input, right?
Why not just set E2F_OPT_YES right then and there and have it take
effect across all threads immediately?  I guess you'd have to add
another lock to protect the options bitflags.

--D

> Signed-off-by: Wang Shilong <wshilong@ddn.com>
> Signed-off-by: Saranya Muruganandam <saranyamohan@google.com>
> ---
>  e2fsck/pass1.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
> index ad3bd8be..1a68a2fb 100644
> --- a/e2fsck/pass1.c
> +++ b/e2fsck/pass1.c
> @@ -2935,6 +2935,7 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
>  	ext2_refcount_t ea_inode_refs = global_ctx->ea_inode_refs;
>  	ext2fs_block_bitmap  block_found_map = global_ctx->block_found_map;
>  	ext2fs_block_bitmap  block_dup_map = global_ctx->block_dup_map;
> +	int options = global_ctx->options;
>  
>  #ifdef HAVE_SETJMP_H
>  	jmp_buf		 old_jmp;
> @@ -2987,7 +2988,8 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
>  	global_ctx->fs_fragmented += fs_fragmented;
>  	global_ctx->fs_fragmented_dir += fs_fragmented_dir;
>  	global_ctx->large_files += large_files;
> -
> +	/* threads might enable E2F_OPT_YES */
> +	global_ctx->options |= options;
>  	global_ctx->flags |= flags;
>  
>  	retval = e2fsck_pass1_merge_fs(global_fs, thread_fs);
> @@ -3022,10 +3024,7 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
>  					      thread_ctx->qctx);
>  	if (retval)
>  		return retval;
> -	global_ctx->invalid_block_bitmap_flag = invalid_block_bitmap_flag;
> -	global_ctx->invalid_inode_bitmap_flag = invalid_inode_bitmap_flag;
> -	global_ctx->invalid_inode_table_flag = invalid_inode_table_flag;
> -	global_ctx->invalid_bitmaps = invalid_bitmaps;
> +
>  	e2fsck_pass1_merge_invalid_bitmaps(global_ctx, thread_ctx);
>  
>  	retval = e2fsck_pass1_merge_bitmap(global_fs,
> -- 
> 2.29.2.299.gdc1121823c-goog
> 
