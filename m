Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 101A5485F2A
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Jan 2022 04:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbiAFDWT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 5 Jan 2022 22:22:19 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:59668 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229773AbiAFDWT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 5 Jan 2022 22:22:19 -0500
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2063MBO3016171
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 5 Jan 2022 22:22:11 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id BDDED15C00E1; Wed,  5 Jan 2022 22:22:10 -0500 (EST)
Date:   Wed, 5 Jan 2022 22:22:10 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Xin Yin <yinxin.x@bytedance.com>
Cc:     harshadshirwadkar@gmail.com, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] ext4:fix different behavior of fsync when use
 fast commit
Message-ID: <YdZgYvC4K87PiMfO@mit.edu>
References: <20211224065728.5820-1-yinxin.x@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211224065728.5820-1-yinxin.x@bytedance.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Dec 24, 2021 at 02:57:28PM +0800, Xin Yin wrote:
> For the follow test example:
> -mkdir test/
> -create&write test/a.txt
> -fsync test/a.txt
> -crash (before a full commit)
> 
> If fast commit is used then "a.txt" will lost, while the normal
> journaling can recover it.

The problem is that your proposed fix: 

> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> index 3deb97b22ca4..4b843648ffe5 100644
> --- a/fs/ext4/fast_commit.c
> +++ b/fs/ext4/fast_commit.c
> @@ -423,7 +423,7 @@ void __ext4_fc_track_create(handle_t *handle, struct inode *inode,
>  	args.op = EXT4_FC_TAG_CREAT;
>  
>  	ret = ext4_fc_track_template(handle, inode, __track_dentry_update,
> -					(void *)&args, 0);
> +					(void *)&args, 1);
>  	trace_ext4_fc_track_create(inode, dentry, ret);
>  }

affects both file creations as well as directory creations (mkdir).
Putting the inode on the fast commit list is something that is meant
for files, and means that on a fast commit we need to force the data
blocks out.  So it seems that isn't the right fix for the problem.

Why do something really simple?  Look at the parent directory's inode,
and check its i_sync_tid.  If it's not equal to
handle->h_transaction->t_tid, then it's safe to do the fast commit.
If it's equal to the current transaction, we can either force a full
commit.

Optionally, in the case where i_sync_tid == current tid, since there's
a chance that the parent directory's inode could have been freshly
fetched from disk (see __ext4_iget() in fs/ext4/inode.c), we could
compare its i_crtime against ktime_get_real_seconds(), and if the
inode was created in the last 2*journal->j_commit_interval/HZ seconds,
it's safe to do a fast commit; otherwise do a full commit.

Cheers,

					- Ted
