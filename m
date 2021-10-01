Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5E541E980
	for <lists+linux-ext4@lfdr.de>; Fri,  1 Oct 2021 11:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352731AbhJAJUV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 1 Oct 2021 05:20:21 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:51854 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbhJAJUS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 1 Oct 2021 05:20:18 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C4F682042D;
        Fri,  1 Oct 2021 09:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633079913; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7PFkK4hkKs1GgSCwanwEAsJw6bVakGEaZx7v2dUtT3s=;
        b=dTcPf5iC6uNvHsMgzUKFgexC7mLkljbn0dChBRAuMw2ZDoMznY+LmaNpTXYeHCj3fh1KN2
        zI2oZTX3gbKXYvz5A//vKWqoX3ETFZdHJsorsOqmxDnz925b8kAUMI+3n7A6amIPPRiCWK
        CpzEzFpjqA0XnaxEq9FwRoed38BJA/o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633079913;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7PFkK4hkKs1GgSCwanwEAsJw6bVakGEaZx7v2dUtT3s=;
        b=AnIYNwgoMf5kEc8UgjIoYPh2138GJwbggVr7TjiTuV0bdjlHYlQHFMg8WWorhOcDYpt/9o
        q8Mj1SRKErqAn3Aw==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id B6301A3BC3;
        Fri,  1 Oct 2021 09:18:33 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 2F1231F2BA4; Fri,  1 Oct 2021 11:18:33 +0200 (CEST)
Date:   Fri, 1 Oct 2021 11:18:33 +0200
From:   Jan Kara <jack@suse.cz>
To:     yangerkun <yangerkun@huawei.com>
Cc:     tytso@mit.edu, jack@suse.cz, linux-ext4@vger.kernel.org,
        yukuai3@huawei.com
Subject: Re: [PATCH 2/2] ext4: check magic even the extent block bh is
 verified
Message-ID: <20211001091833.GB28799@quack2.suse.cz>
References: <20210904044946.2102404-1-yangerkun@huawei.com>
 <20210904044946.2102404-3-yangerkun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210904044946.2102404-3-yangerkun@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat 04-09-21 12:49:46, yangerkun wrote:
> Our stress testing with IO error can trigger follow OOB with a very low
> probability.
> 
> [59898.282466] BUG: KASAN: slab-out-of-bounds in ext4_find_extent+0x2e4/0x480
> ...
> [59898.287162] Call Trace:
> [59898.287575]  dump_stack+0x8b/0xb9
> [59898.288070]  print_address_description+0x73/0x280
> [59898.289903]  ext4_find_extent+0x2e4/0x480
> [59898.290553]  ext4_ext_map_blocks+0x125/0x1470
> [59898.295481]  ext4_map_blocks+0x5ee/0x940
> [59898.315984]  ext4_mpage_readpages+0x63c/0xdb0
> [59898.320231]  read_pages+0xe6/0x370
> [59898.321589]  __do_page_cache_readahead+0x233/0x2a0
> [59898.321594]  ondemand_readahead+0x157/0x450
> [59898.321598]  generic_file_read_iter+0xcb2/0x1550
> [59898.328828]  __vfs_read+0x233/0x360
> [59898.328840]  vfs_read+0xa5/0x190
> [59898.330126]  ksys_read+0xa5/0x150
> [59898.331405]  do_syscall_64+0x6d/0x1f0
> [59898.331418]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> Digging deep and we found it's actually a xattr block which can happened
> with follow steps:
> 
> 1. extent update for file1 and will remove a leaf extent block(block A)
> 2. we need update the idx extent block too
> 3. block A has been allocated as a xattr block and will set verified
> 3. io error happened for this idx block and will the buffer has been
>    released late
> 4. extent find for file1 will read the idx block and see block A again
> 5. since the buffer of block A is already verified, we will use it
>    directly, which can lead the upper OOB
> 
> Same as __ext4_xattr_check_block, we can check magic even the buffer is
> verified to fix the problem.
> 
> Signed-off-by: yangerkun <yangerkun@huawei.com>

Honestly, I'm not sure if this is worth it. What you suggest will work if
the magic is overwritten but if we reallocate the block for something else
but the magic happens to stay intact, we have a problem. The filesystem is
corrupted at that point with metadata blocks being multiply claimed and
that's very difficult to deal with. Maybe we should start ignoring
buffer_verified() bit once the fs is known to have errors and recheck the
buffer contents on each access? Sure it will be slow but I have little
sympathy towards people running filesystems with errors... What do people
think?

								Honza

> ---
>  fs/ext4/extents.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 8559e288472f..d2e2ae90bc4a 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -506,6 +506,14 @@ __read_extent_tree_block(const char *function, unsigned int line,
>  			goto errout;
>  	}
>  	if (buffer_verified(bh)) {
> +		if (unlikely(ext_block_hdr(bh)->eh_magic != EXT4_EXT_MAGIC)) {
> +			err = -EFSCORRUPTED;
> +			ext4_error_inode(inode, function, line, 0,
> +				"invalid magic for verified extent block %llu",
> +				(unsigned long long)bh->b_blocknr);
> +			goto errout;
> +		}
> +
>  		if (!(flags & EXT4_EX_FORCE_CACHE))
>  			return bh;
>  	} else {
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
