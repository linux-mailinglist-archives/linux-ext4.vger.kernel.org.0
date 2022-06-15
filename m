Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB1F54CC98
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Jun 2022 17:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245501AbiFOPVr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 15 Jun 2022 11:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244213AbiFOPVq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 15 Jun 2022 11:21:46 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3FF53F892;
        Wed, 15 Jun 2022 08:21:45 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 31so10020657pgv.11;
        Wed, 15 Jun 2022 08:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nKq1gYsYNt42m7aC/CsMKERuz+Y95BQJjnRwp5cYf6w=;
        b=lDTWhcXSMe4xy7rcIHnzKdQERRYUviFbK1tlHpHTFEQSfmyj09vDRADI2/Rp8jP8yM
         dHIZFYQDpkxSXnL9rHu5Y9+0aSGWO6YZ4Wdql94G6lafdSUY1RA5wYZXW43v3nxR2X8G
         pCooPP5fXnUjoWkpIOIsO8rmpFqLs57+I1SuwB76YmfTk5aJsQleAMItmsCoSxaAR9hk
         MheiI6lULLqkxRpLvJ5ykk8o04hfxaKceb6oGBWf/LBK5lIPdIFDUsta/o0dek6a2xqB
         crovvRflzRolFdR7pKY8RffXHvH/hsSvLKYl9iSS9qm+ZVKzwHpGfXYho5lUTiMphjXF
         KPYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nKq1gYsYNt42m7aC/CsMKERuz+Y95BQJjnRwp5cYf6w=;
        b=H2dmgREDR73caC165Cm0aw8GlCGVK7SJ1HbRKWWOG6qjLm9Uy0emrvj7aJeKHVt8Ye
         sJCpvWGCIPzSM35z/zYnGIIf8t+ABrM3Ym1yROFp/AaaBCWtfdj1KSbvuGu3e8eZiPLG
         mxrVbxNo5Knw1SvX9udS6M2PPod6w/wbYgQD3fUdQnxKpmaTh/Bb7trp+jf/oC9WXm1o
         ozl6OT9DpuHy1I4N75iTDmd1yP3XKXR+p9U0HTvVJYUVMf90Lnoh1f79EmabNINOftDa
         FYhYknssyDYTCQiS55SZuCevzOG2K35QZujqdzYKHskQaHe+cti7whHVbUeOW/Hpc06N
         iINA==
X-Gm-Message-State: AOAM531msphIv7Z3ePdJ2RcNdVagcV7cYam6k5Tsq61LuhsYcBvQJ94w
        g9K7bZnLx3aKAWXpaud5SRA=
X-Google-Smtp-Source: ABdhPJxqO/2+S3cMCe+9XUYjOW4IoUKuEBhGCKYWu8bJb5C4Cl7qmMOoYQ6U0U2Z12z3LbROAiXbag==
X-Received: by 2002:a62:d40c:0:b0:51b:bc02:703b with SMTP id a12-20020a62d40c000000b0051bbc02703bmr10609776pfh.65.1655306505382;
        Wed, 15 Jun 2022 08:21:45 -0700 (PDT)
Received: from localhost ([2406:7400:63:5d34:e6c2:4c64:12ae:aa11])
        by smtp.gmail.com with ESMTPSA id x195-20020a627ccc000000b005185407eda5sm10041425pfc.44.2022.06.15.08.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 08:21:44 -0700 (PDT)
Date:   Wed, 15 Jun 2022 20:51:39 +0530
From:   Ritesh Harjani <ritesh.list@gmail.com>
To:     Ye Bin <yebin10@huawei.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz
Subject: Re: [PATCH -next] ext4: fix bug_on in ext4_iomap_begin as race
 between bmap and write
Message-ID: <20220615152139.vp64tnv46enwnfcs@riteshh-domain>
References: <20220615135850.1961759-1-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615135850.1961759-1-yebin10@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 22/06/15 09:58PM, Ye Bin wrote:
> We got issue as follows:
> ------------[ cut here ]------------
> WARNING: CPU: 3 PID: 9310 at fs/ext4/inode.c:3441 ext4_iomap_begin+0x182/0x5d0
> RIP: 0010:ext4_iomap_begin+0x182/0x5d0
> RSP: 0018:ffff88812460fa08 EFLAGS: 00010293
> RAX: ffff88811f168000 RBX: 0000000000000000 RCX: ffffffff97793c12
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
> RBP: ffff88812c669160 R08: ffff88811f168000 R09: ffffed10258cd20f
> R10: ffff88812c669077 R11: ffffed10258cd20e R12: 0000000000000001
> R13: 00000000000000a4 R14: 000000000000000c R15: ffff88812c6691ee
> FS:  00007fd0d6ff3740(0000) GS:ffff8883af180000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fd0d6dda290 CR3: 0000000104a62000 CR4: 00000000000006e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  iomap_apply+0x119/0x570
>  iomap_bmap+0x124/0x150
>  ext4_bmap+0x14f/0x250
>  bmap+0x55/0x80
>  do_vfs_ioctl+0x952/0xbd0
>  __x64_sys_ioctl+0xc6/0x170
>  do_syscall_64+0x33/0x40
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> Above issue may happen as follows:
>           bmap                    write
> bmap
>   ext4_bmap
>     iomap_bmap
>       ext4_iomap_begin
>                             ext4_file_write_iter
> 			      ext4_buffered_write_iter
> 			        generic_perform_write
> 				  ext4_da_write_begin
> 				    ext4_da_write_inline_data_begin
> 				      ext4_prepare_inline_data
> 				        ext4_create_inline_data
> 					  ext4_set_inode_flag(inode,
> 						EXT4_INODE_INLINE_DATA);
>       if (WARN_ON_ONCE(ext4_has_inline_data(inode))) ->trigger bug_on
>
> To solved above issue hold inode lock in ext4_bamp.
											^^^ ext4_bmap()

I checked the paths where bmap() kernel api can be called i.e. from jbd2/fc and
generic_swapfile_activate() (apart from ioctl())
For jbd2, it will be called with j_inode within bmap(), hence taking a inode lock
of the inode passed within ext4_bmap() (j_inode in this case) should be safe here.
Same goes with swapfile path as well.

However I feel maybe we should hold inode_lock_shared() since there is no
block/extent map layout changes that can happen via ext4_bmap().
Hence read lock is what IMO should be used here.

-ritesh


>
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
>  fs/ext4/inode.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 53877ffe3c41..f4a95c80f644 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3142,13 +3142,15 @@ static sector_t ext4_bmap(struct address_space *mapping, sector_t block)
>  {
>  	struct inode *inode = mapping->host;
>  	journal_t *journal;
> +	sector_t ret = 0;
>  	int err;
>
> +	inode_lock(inode);
>  	/*
>  	 * We can get here for an inline file via the FIBMAP ioctl
>  	 */
>  	if (ext4_has_inline_data(inode))
> -		return 0;
> +		goto out;
>
>  	if (mapping_tagged(mapping, PAGECACHE_TAG_DIRTY) &&
>  			test_opt(inode->i_sb, DELALLOC)) {
> @@ -3187,10 +3189,14 @@ static sector_t ext4_bmap(struct address_space *mapping, sector_t block)
>  		jbd2_journal_unlock_updates(journal);
>
>  		if (err)
> -			return 0;
> +			goto out;
>  	}
>
> -	return iomap_bmap(mapping, block, &ext4_iomap_ops);
> +	ret = iomap_bmap(mapping, block, &ext4_iomap_ops);
> +
> +out:
> +	inode_unlock(inode);
> +	return ret;
>  }
>
>  static int ext4_read_folio(struct file *file, struct folio *folio)
> --
> 2.31.1
>
