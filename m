Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 054842DDC33
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Dec 2020 00:58:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731950AbgLQX5b (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 17 Dec 2020 18:57:31 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:53894 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbgLQX5b (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 17 Dec 2020 18:57:31 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BHNsCr0153313;
        Thu, 17 Dec 2020 23:56:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=WcVqVmOGj48c5wVwLqQ9c6WaGfogB0PZuj/Fnx1iDaQ=;
 b=A5tgrP6y2+y8HioPVS+aYRGQ5CgUd4LgXLH4sR7RQBbUfOaARLhZaRk1wswtFNLEFhyh
 j5fHtCgBubpXZrnpwUkXvNRQg2Vpo+bLib73c6T+rBORX2Lj6CLwzv4bf6uYfUMPEUxl
 2riwQZUfonRKbU5rQElVMstEp733ACA72fY5Vh4gNTwhWIwoieDXPxzbOWED+e2EExvW
 7ZwTul794E3vCW3SIjzFQS8g9360cbWxxH+UaimvOFJU7UPkiuv3fZJEqsAzD6g9e6xv
 hBo6hzwTJEaXHdRoV5JGw5YTr6p0Q9JNFUlF6gKSsi/Y1okL4NfwRjZ0Cqg+BQ0ZEFtK yg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 35ckcbr7qx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 17 Dec 2020 23:56:43 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BHNtHoj160128;
        Thu, 17 Dec 2020 23:56:42 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 35e6eu13w5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Dec 2020 23:56:42 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0BHNueVJ010592;
        Thu, 17 Dec 2020 23:56:40 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 17 Dec 2020 15:56:40 -0800
Date:   Thu, 17 Dec 2020 15:56:38 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Saranya Muruganandam <saranyamohan@google.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, Li Xi <lixi@ddn.com>,
        Wang Shilong <wshilong@ddn.com>
Subject: Re: [RFC PATCH v3 02/61] e2fsck: copy context when using
 multi-thread fsck
Message-ID: <20201217235638.GB6908@magnolia>
References: <20201118153947.3394530-1-saranyamohan@google.com>
 <20201118153947.3394530-3-saranyamohan@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118153947.3394530-3-saranyamohan@google.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9838 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012170154
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9838 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 priorityscore=1501 mlxscore=0 suspectscore=0 adultscore=0 phishscore=0
 malwarescore=0 impostorscore=0 lowpriorityscore=0 clxscore=1011
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012170154
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Nov 18, 2020 at 07:38:48AM -0800, Saranya Muruganandam wrote:
> From: Li Xi <lixi@ddn.com>
> 
> This patch only copy the context to a new one when -m is enabled.
> It doesn't actually start any thread. When pass1 test finishes,
> the new context is copied back to the original context.
> 
> Since the signal handler only changes the original context, so
> add global_ctx in "struct e2fsck_struct" and use that to check
> whether there is any signal of canceling.
> 
> This patch handles the long jump properly so that all the existing
> tests can be passed even the context has been copied. Otherwise,
> test f_expisize_ea_del would fail when aborting.
> 
> Signed-off-by: Li Xi <lixi@ddn.com>
> Signed-off-by: Wang Shilong <wshilong@ddn.com>
> Signed-off-by: Saranya Muruganandam <saranyamohan@google.com>
> ---
>  e2fsck/pass1.c | 114 +++++++++++++++++++++++++++++++++++++++++++++----
>  e2fsck/unix.c  |   1 +
>  2 files changed, 107 insertions(+), 8 deletions(-)
> 
> diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
> index 8eecd958..64d237d3 100644
> --- a/e2fsck/pass1.c
> +++ b/e2fsck/pass1.c
> @@ -1144,7 +1144,22 @@ static int quota_inum_is_reserved(ext2_filsys fs, ext2_ino_t ino)
>  	return 0;
>  }
>  
> -void e2fsck_pass1(e2fsck_t ctx)
> +static int e2fsck_should_abort(e2fsck_t ctx)
> +{
> +	e2fsck_t global_ctx;
> +
> +	if (ctx->flags & E2F_FLAG_SIGNAL_MASK)
> +		return 1;
> +
> +	if (ctx->global_ctx) {
> +		global_ctx = ctx->global_ctx;
> +		if (global_ctx->flags & E2F_FLAG_SIGNAL_MASK)
> +			return 1;
> +	}
> +	return 0;
> +}
> +
> +void e2fsck_pass1_thread(e2fsck_t ctx)
>  {
>  	int	i;
>  	__u64	max_sizes;
> @@ -1360,7 +1375,7 @@ void e2fsck_pass1(e2fsck_t ctx)
>  		if (ino > ino_threshold)
>  			pass1_readahead(ctx, &ra_group, &ino_threshold);
>  		ehandler_operation(old_op);
> -		if (ctx->flags & E2F_FLAG_SIGNAL_MASK)
> +		if (e2fsck_should_abort(ctx))
>  			goto endit;
>  		if (pctx.errcode == EXT2_ET_BAD_BLOCK_IN_INODE_TABLE) {
>  			/*
> @@ -1955,7 +1970,7 @@ void e2fsck_pass1(e2fsck_t ctx)
>  		if (process_inode_count >= ctx->process_inode_size) {
>  			process_inodes(ctx, block_buf);
>  
> -			if (ctx->flags & E2F_FLAG_SIGNAL_MASK)
> +			if (e2fsck_should_abort(ctx))
>  				goto endit;
>  		}
>  	}
> @@ -2068,6 +2083,89 @@ endit:
>  	else
>  		ctx->invalid_bitmaps++;
>  }
> +
> +static errcode_t e2fsck_pass1_thread_prepare(e2fsck_t global_ctx, e2fsck_t *thread_ctx)
> +{
> +	errcode_t	retval;
> +	e2fsck_t	thread_context;
> +
> +	retval = ext2fs_get_mem(sizeof(struct e2fsck_struct), &thread_context);

Hm, so I guess the strategy here is that parallel e2fsck makes
per-thread copies of the ext2_filsys and e2fsck_t global contexts?
And then after the threaded parts complete, each thread merges its
per-thread contexts back into the global one, right?

This means that we have to be careful to track which fields in those
cloned contexts have been updated by the thread so that we can copy them
back and not lose any data.

I'm wondering if for future maintainability it would be better to track
the per-thread data in a separate structure to make it very explicit
which data (sub)structures are effectively per-thread and hence don't
require locking?

(I ask that mostly because I'm having a hard time figuring out which
fields are supposed to be shared and which ones aren't...)

--D

> +	if (retval) {
> +		com_err(global_ctx->program_name, retval, "while allocating memory");
> +		return retval;
> +	}
> +	memcpy(thread_context, global_ctx, sizeof(struct e2fsck_struct));
> +	thread_context->fs->priv_data = thread_context;
> +	thread_context->global_ctx = global_ctx;
> +
> +	*thread_ctx = thread_context;
> +	return 0;
> +}
> +
> +static int e2fsck_pass1_thread_join(e2fsck_t global_ctx, e2fsck_t thread_ctx)
> +{
> +	int	flags = global_ctx->flags;
> +#ifdef HAVE_SETJMP_H
> +	jmp_buf	old_jmp;
> +
> +	memcpy(old_jmp, global_ctx->abort_loc, sizeof(jmp_buf));
> +#endif
> +	memcpy(global_ctx, thread_ctx, sizeof(struct e2fsck_struct));
> +#ifdef HAVE_SETJMP_H
> +	memcpy(global_ctx->abort_loc, old_jmp, sizeof(jmp_buf));
> +#endif
> +	/* Keep the global singal flags*/
> +	global_ctx->flags |= (flags & E2F_FLAG_SIGNAL_MASK) |
> +			     (global_ctx->flags & E2F_FLAG_SIGNAL_MASK);
> +
> +	global_ctx->fs->priv_data = global_ctx;
> +	ext2fs_free_mem(&thread_ctx);
> +	return 0;
> +}
> +
> +void e2fsck_pass1_multithread(e2fsck_t ctx)
> +{
> +	errcode_t	retval;
> +	e2fsck_t	thread_ctx;
> +
> +	retval = e2fsck_pass1_thread_prepare(ctx, &thread_ctx);
> +	if (retval) {
> +		com_err(ctx->program_name, 0,
> +			_("while preparing pass1 thread\n"));
> +		ctx->flags |= E2F_FLAG_ABORT;
> +		return;
> +	}
> +
> +#ifdef HAVE_SETJMP_H
> +	/*
> +	 * When fatal_error() happens, jump to here. The thread
> +	 * context's flags will be saved, but its abort_loc will
> +	 * be overwritten by original jump buffer for the later
> +	 * tests.
> +	 */
> +	if (setjmp(thread_ctx->abort_loc)) {
> +		thread_ctx->flags &= ~E2F_FLAG_SETJMP_OK;
> +		e2fsck_pass1_thread_join(ctx, thread_ctx);
> +		return;
> +	}
> +	thread_ctx->flags |= E2F_FLAG_SETJMP_OK;
> +#endif
> +
> +	e2fsck_pass1_thread(thread_ctx);
> +	retval = e2fsck_pass1_thread_join(ctx, thread_ctx);
> +	if (retval) {
> +		com_err(ctx->program_name, 0,
> +			_("while joining pass1 thread\n"));
> +		ctx->flags |= E2F_FLAG_ABORT;
> +		return;
> +	}
> +}
> +
> +void e2fsck_pass1(e2fsck_t ctx)
> +{
> +	e2fsck_pass1_multithread(ctx);
> +}
> +
>  #undef FINISH_INODE_LOOP
>  
>  /*
> @@ -2130,7 +2228,7 @@ static void process_inodes(e2fsck_t ctx, char *block_buf)
>  		ehandler_operation(buf);
>  		check_blocks(ctx, &pctx, block_buf,
>  			     &inodes_to_process[i].ea_ibody_quota);
> -		if (ctx->flags & E2F_FLAG_SIGNAL_MASK)
> +		if (e2fsck_should_abort(ctx))
>  			break;
>  	}
>  	ctx->stashed_inode = old_stashed_inode;
> @@ -3300,7 +3398,7 @@ static void check_blocks(e2fsck_t ctx, struct problem_context *pctx,
>  	inlinedata_fs = ext2fs_has_feature_inline_data(ctx->fs->super);
>  
>  	if (check_ext_attr(ctx, pctx, block_buf, &ea_block_quota)) {
> -		if (ctx->flags & E2F_FLAG_SIGNAL_MASK)
> +		if (e2fsck_should_abort(ctx))
>  			goto out;
>  		pb.num_blocks += EXT2FS_B2C(ctx->fs, ea_block_quota.blocks);
>  	}
> @@ -3355,7 +3453,7 @@ static void check_blocks(e2fsck_t ctx, struct problem_context *pctx,
>  	}
>  	end_problem_latch(ctx, PR_LATCH_BLOCK);
>  	end_problem_latch(ctx, PR_LATCH_TOOBIG);
> -	if (ctx->flags & E2F_FLAG_SIGNAL_MASK)
> +	if (e2fsck_should_abort(ctx))
>  		goto out;
>  	if (pctx->errcode)
>  		fix_problem(ctx, PR_1_BLOCK_ITERATE, pctx);
> @@ -3836,7 +3934,7 @@ static int process_bad_block(ext2_filsys fs,
>  				*block_nr = 0;
>  				return BLOCK_CHANGED;
>  			}
> -			if (ctx->flags & E2F_FLAG_SIGNAL_MASK)
> +			if (e2fsck_should_abort(ctx))
>  				return BLOCK_ABORT;
>  		} else
>  			mark_block_used(ctx, blk);
> @@ -3933,7 +4031,7 @@ static int process_bad_block(ext2_filsys fs,
>  			*block_nr = 0;
>  			return BLOCK_CHANGED;
>  		}
> -		if (ctx->flags & E2F_FLAG_SIGNAL_MASK)
> +		if (e2fsck_should_abort(ctx))
>  			return BLOCK_ABORT;
>  		return 0;
>  	}
> diff --git a/e2fsck/unix.c b/e2fsck/unix.c
> index 051b31a5..42f616e2 100644
> --- a/e2fsck/unix.c
> +++ b/e2fsck/unix.c
> @@ -1445,6 +1445,7 @@ int main (int argc, char *argv[])
>  	}
>  	reserve_stdio_fds();
>  
> +	ctx->global_ctx = NULL;
>  	set_up_logging(ctx);
>  	if (ctx->logf) {
>  		int i;
> -- 
> 2.29.2.299.gdc1121823c-goog
> 
