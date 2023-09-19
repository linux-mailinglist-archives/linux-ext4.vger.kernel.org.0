Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 498327A5C42
	for <lists+linux-ext4@lfdr.de>; Tue, 19 Sep 2023 10:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjISIQi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 19 Sep 2023 04:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjISIQh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 19 Sep 2023 04:16:37 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81753114;
        Tue, 19 Sep 2023 01:16:31 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-2764b04dc5cso1072152a91.3;
        Tue, 19 Sep 2023 01:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695111391; x=1695716191; darn=vger.kernel.org;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Zc3c+7gvyye0Z9ofgCMWEYYUCVesVSdjLnaXWCS/TTM=;
        b=JF0kkuYFvbO305j91ScNeXHxwchpaZg7gvGB/9LBhFBoaoTMWachtwy9cwKYPF4Wzr
         d7Sg8EHjatZRZMDWhZTdsUr7QovPI9QSKk0nPWW9cOtMrNgsLikcbgtr6HggnqI2qlmH
         mS1wbd4izYnGdE72syk+tJWCBAD6+UHtS+2DHteVc6TDFtS9g9X740ugCtnRCJ2DQTnI
         0pnpraGT3WNzAdPMdJ7gjuL0RQ0ygQqeClsbSSH+kG0OfMo2Jkgk+UYaWZUNnLEpTNsE
         5JIu+eaBT7vl2gbZkvm6f9MOYdtP4ZTDW9+e7e1QgTAOrgeMrj96A+2viwY9h74Zq9pr
         8FOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695111391; x=1695716191;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zc3c+7gvyye0Z9ofgCMWEYYUCVesVSdjLnaXWCS/TTM=;
        b=hImA4mY8joBZJZOApKhULPpb3Ys5EnfIdMo4Az3g+fh3yPldGedJ210Khgj+4PD20G
         44IpxTnyOR6n+AVHGmT2rhiSIw4hh3OHfa9ZfQ8YNtrWHQDsEwXyKG47hmUhURJTaMNg
         wpoRROEsDY2jDRSv7gpcY8La7An5KvYlHGWh+ggRju/mJzKykFVYCNAAd5QN6VZqv1Ax
         HDbt/5VJMS9iRbnWgyl0vGQNxJjRc36AGAbcDsX8IZOMWOwbqXLqgeSXJmxUMDLyThnW
         pQ5mLY1ry0G/zLJJjFb9/Of4wWOQ0yHzt+ttJJ1wSD31x6GVg9QeFwCxd4jsp+5e3ZOi
         gRhw==
X-Gm-Message-State: AOJu0YzR25/zFKB5EkqPU8daiB1UMe3tlT93FwwbxMg5Afg/h9izc0ie
        wrRT8BRL0BdUYdxORg4fNS3VNV3BkoA=
X-Google-Smtp-Source: AGHT+IE6cB/MLQzpP8FCTMqS/se0tNEkmWUyYI3Cw5UjPfjw1mkRcxj0s55hiGTCJwRbIyIaGXk4zw==
X-Received: by 2002:a17:90a:7066:b0:269:3cdb:4edf with SMTP id f93-20020a17090a706600b002693cdb4edfmr8260791pjk.16.1695111390719;
        Tue, 19 Sep 2023 01:16:30 -0700 (PDT)
Received: from dw-tp ([49.207.223.191])
        by smtp.gmail.com with ESMTPSA id g8-20020a17090ace8800b0026b76edd607sm8315390pju.15.2023.09.19.01.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 01:16:30 -0700 (PDT)
Date:   Tue, 19 Sep 2023 13:46:26 +0530
Message-Id: <87fs3a7f39.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Ojaswin Mujoo <ojaswin@linux.ibm.com>, linux-ext4@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>
Cc:     linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v3 1/1] ext4: Mark buffer new if it is unwritten to avoid stale data exposure
In-Reply-To: <d0ed09d70a9733fbb5349c5c7b125caac186ecdf.1695033645.git.ojaswin@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Ojaswin Mujoo <ojaswin@linux.ibm.com> writes:

> ** Short Version **
>
> In ext4 with dioread_nolock, we could have a scenario where the bh returned by
> get_blocks (ext4_get_block_unwritten()) in __block_write_begin_int() has
> UNWRITTEN and MAPPED flag set. Since such a bh does not have NEW flag set we
> never zero out the range of bh that is not under write, causing whatever stale
> data is present in the folio at that time to be written out to disk. To fix this
> mark the buffer as new, in case it is unwritten, in ext4_get_block_unwritten().
>
> ** Long Version **
>
> The issue mentioned above was resulting in two different bugs:
>
> 1. On block size < page size case in ext4, generic/269 was reliably
> failing with dioread_nolock. The state of the write was as follows:
>
>   * The write was extending i_size.
>   * The last block of the file was fallocated and had an unwritten extent
>   * We were near ENOSPC and hence we were switching to non-delayed alloc
>     allocation.
>
> In this case, the back trace that triggers the bug is as follows:
>
>   ext4_da_write_begin()
>     /* switch to nodelalloc due to low space */
>     ext4_write_begin()
>       ext4_should_dioread_nolock() // true since mount flags still have delalloc
>       __block_write_begin(..., ext4_get_block_unwritten)
>         __block_write_begin_int()
>           for(each buffer head in page) {
>             /* first iteration, this is bh1 which contains i_size */
>             if (!buffer_mapped)
>               get_block() /* returns bh with only UNWRITTEN and MAPPED */
>             /* second iteration, bh2 */
>               if (!buffer_mapped)
>                 get_block() /* we fail here, could be ENOSPC */
>           }
>           if (err)
>             /*
>              * this would zero out all new buffers and mark them uptodate.
>              * Since bh1 was never marked new, we skip it here which causes
>              * the bug later.
>              */
>             folio_zero_new_buffers();
>       /* ext4_wrte_begin() error handling */
>       ext4_truncate_failed_write()
>         ext4_truncate()
>           ext4_block_truncate_page()
>             __ext4_block_zero_page_range()
>               if(!buffer_uptodate())
>                 ext4_read_bh_lock()
>                   ext4_read_bh() -> ... ext4_submit_bh_wbc()
>                     BUG_ON(buffer_unwritten(bh)); /* !!! */
>
> 2. The second issue is stale data exposure with page size >= blocksize
> with dioread_nolock. The conditions needed for it to happen are same as
> the previous issue ie dioread_nolock around ENOSPC condition. The issue
> is also similar where in __block_write_begin_int() when we call
> ext4_get_block_unwritten() on the buffer_head and the underlying extent
> is unwritten, we get an unwritten and mapped buffer head. Since it is
> not new, we never zero out the partial range which is not under write,
> thus writing stale data to disk. This can be easily observed with the
> following reproducer:
>
>  fallocate -l 4k testfile
>  xfs_io -c "pwrite 2k 2k" testfile
>  # hexdump output will have stale data in from byte 0 to 2k in testfile
>  hexdump -C testfile
>
> NOTE: To trigger this, we need dioread_nolock enabled and write happening via
> ext4_write_begin(), which is usually used when we have -o nodealloc. Since
> dioread_nolock is disabled with nodelalloc, the only alternate way to call
> ext4_write_begin() is to ensure that delayed alloc switches to nodelalloc ie
> ext4_da_write_begin() calls ext4_write_begin(). This will usually happen when
> ext4 is almost full like the way generic/269 was triggering it in Issue 1 above.
> This might make the issue harder to hit. Hence, for reliable replication, I used
> the below patch to temporarily allow dioread_nolock with nodelalloc and then
> mount the disk with -o nodealloc,dioread_nolock. With this you can hit the stale
> data issue 100% of times:
>
> @@ -508,8 +508,8 @@ static inline int ext4_should_dioread_nolock(struct inode *inode)
>   if (ext4_should_journal_data(inode))
>     return 0;
>   /* temporary fix to prevent generic/422 test failures */
> - if (!test_opt(inode->i_sb, DELALLOC))
> -   return 0;
> + // if (!test_opt(inode->i_sb, DELALLOC))
> + //  return 0;
>   return 1;
>  }
>
> After applying this patch to mark buffer as NEW, both the above issues are
> fixed.
>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> Reviewed-by: Jan Kara <jack@suse.cz>
> ---
>  fs/ext4/inode.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 6c490f05e2ba..8b286a800193 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -789,10 +789,22 @@ int ext4_get_block(struct inode *inode, sector_t iblock,
>  int ext4_get_block_unwritten(struct inode *inode, sector_t iblock,
>  			     struct buffer_head *bh_result, int create)
>  {
> +	int ret = 0;
> +
>  	ext4_debug("ext4_get_block_unwritten: inode %lu, create flag %d\n",
>  		   inode->i_ino, create);
> -	return _ext4_get_block(inode, iblock, bh_result,
> +	ret = _ext4_get_block(inode, iblock, bh_result,
>  			       EXT4_GET_BLOCKS_CREATE_UNWRIT_EXT);
> +
> +	/*
> +	 * If the buffer is marked unwritten, mark it as new to make sure it is
> +	 * zeroed out correctly in case of partial writes. Otherwise, there is
> +	 * a chance of stale data getting exposed.
> +	 */
> +	if (ret == 0 && buffer_unwritten(bh_result))
> +		set_buffer_new(bh_result);
> +
> +	return ret;
>  }

Doing above was my first thought too when we were discussing
the issue internally. But I am glad the discussions happened with Jan to
understand the right reason behing MAP_NEW flag. 

While at it we also noticed that the ext4_map_blocks() returns different
map->m_flags set for the same extent type when passed with different flags
in it's argument :). So it quickly become confusing. Thanks for sorting
out the unknowns.

This patch looks good to me too! Feel free to add - 

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
