Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80B8C41DF6D
	for <lists+linux-ext4@lfdr.de>; Thu, 30 Sep 2021 18:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352257AbhI3Qoy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 30 Sep 2021 12:44:54 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:47728 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352255AbhI3Qoy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 30 Sep 2021 12:44:54 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 8D4A3225F4;
        Thu, 30 Sep 2021 16:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633020190; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rUguAQF7nscI2Q3zcA56CIWu6jMWKYbfVNalRTSHFqc=;
        b=kE+MWmLGi+ohX2JMIuT3HpbwFTCqAx89lIiGwPOYVRVlRZeiJthBx0P4eYq24LCrWp34U9
        41SBJ/NeAJ8XNq8/WrQu/4rAEkfIH/r4vGPpefy4Xh+nFcvUbpX8nCkDJ95VBDm4xdQL7a
        ALSAg4UkP67/MRc3ZxAKFWqypa09KcY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633020190;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rUguAQF7nscI2Q3zcA56CIWu6jMWKYbfVNalRTSHFqc=;
        b=liPbDMPHKpcMoLL97Jzecy/ZBUXxiP8+P/bZygWvrDXLWLoC4ajDyUEQWIx1X7FZmhT2ta
        ezxHSwyMU+JNWZBg==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 65EF5A3B91;
        Thu, 30 Sep 2021 16:43:10 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id DBA5E1F2BA4; Thu, 30 Sep 2021 18:43:09 +0200 (CEST)
Date:   Thu, 30 Sep 2021 18:43:09 +0200
From:   Jan Kara <jack@suse.cz>
To:     yangerkun <yangerkun@huawei.com>
Cc:     tytso@mit.edu, jack@suse.cz, linux-ext4@vger.kernel.org,
        yukuai3@huawei.com
Subject: Re: [PATCH 3/3] ext4: stop use path once restart journal in
 ext4_ext_shift_path_extents
Message-ID: <20210930164309.GC17404@quack2.suse.cz>
References: <20210903062748.4118886-1-yangerkun@huawei.com>
 <20210903062748.4118886-4-yangerkun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210903062748.4118886-4-yangerkun@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Let me improve English a bit:

On Fri 03-09-21 14:27:48, yangerkun wrote:
> We get a BUG as follow:

We hit the following bug:

> 
> [52117.465187] ------------[ cut here ]------------
> [52117.465686] kernel BUG at fs/ext4/extents.c:1756!
> ...
> [52117.478306] Call Trace:
> [52117.478565]  ext4_ext_shift_extents+0x3ee/0x710
> [52117.479020]  ext4_fallocate+0x139c/0x1b40
> [52117.479405]  ? __do_sys_newfstat+0x6b/0x80
> [52117.479805]  vfs_fallocate+0x151/0x4b0
> [52117.480177]  ksys_fallocate+0x4a/0xa0
> [52117.480533]  __x64_sys_fallocate+0x22/0x30
> [52117.480930]  do_syscall_64+0x35/0x80
> [52117.481277]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [52117.481769] RIP: 0033:0x7fa062f855ca
> 
> static int ext4_ext_try_to_merge_right(struct inode *inode,
>                                  struct ext4_ext_path *path,
>                                  struct ext4_extent *ex)
> {
>         struct ext4_extent_header *eh;
>         unsigned int depth, len;
>         int merge_done = 0, unwritten;
> 
>         depth = ext_depth(inode);
>         BUG_ON(path[depth].p_hdr == NULL); <=== trigger here
>         eh = path[depth].p_hdr;
> 
> Normally, we protect extent tree with i_data_sem, and once we really
> need drop i_data_sem, we should reload the ext4_ext_path array after we
> recatch i_data_sem since extent tree may has changed, the 'again' in
> ext4_ext_remove_space give us a sample. But the other case
> ext4_ext_shift_path_extents seems forget to do this(ext4_access_path may
> drop i_data_sem and recatch it with not enough credits), and will lead
> the upper BUG when there is a parallel extents split which will grow the
> extent tree.

Normally, the extent tree is protected by i_data_sem and if we drop
i_data_sem in ext4_datasem_ensure_credits(), we need to reload
ext4_ext_path array after reacquiring i_data_sem since the extent tree may
have changed. The 'again' label in ext4_ext_remove_space() is an example of
this. But ext4_ext_shift_path_extents() forgets to reload ext4_ext_path and
thus can cause the above mentioned BUG when there is a parallel extents
split which will grow the extent tree.

> 
> Fix it by introduce the again in ext4_ext_shift_extents.
> 
> Signed-off-by: yangerkun <yangerkun@huawei.com>
> ---
>  fs/ext4/extents.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index a6fb0350f062..0aa14f6ca914 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -5009,8 +5009,11 @@ ext4_ext_shift_path_extents(struct ext4_ext_path *path, ext4_lblk_t shift,
>  			restart_credits = ext4_writepage_trans_blocks(inode);
>  			err = ext4_datasem_ensure_credits(handle, inode, credits,
>  					restart_credits, 0);
> -			if (err)
> +			if (err) {
> +				if (err > 0)
> +					err = -EAGAIN;
>  				goto out;
> +			}

Hum, I'd note that the previous patch actually broke
ext4_ext_shift_path_extents() which could return 1 after patch 2/3 and
probably confuse code upwards in the stack and now you fix it up in this
patch. Can you perhaps fixup the previous patch by changing the condition
to:
	if (err < 0)

and then change it here?

>  
>  			err = ext4_ext_get_access(handle, inode, path + depth);
>  			if (err)
> @@ -5084,6 +5087,7 @@ ext4_ext_shift_extents(struct inode *inode, handle_t *handle,
>  	int ret = 0, depth;
>  	struct ext4_extent *extent;
>  	ext4_lblk_t stop, *iterator, ex_start, ex_end;
> +	ext4_lblk_t tmp = EXT_MAX_BLOCKS;

Can you perhaps name this more descriptively than 'tmp'? Something like
restart_lblk or something like that?
  
>  	/* Let path point to the last extent */
>  	path = ext4_find_extent(inode, EXT_MAX_BLOCKS - 1, NULL,
> @@ -5137,11 +5141,15 @@ ext4_ext_shift_extents(struct inode *inode, handle_t *handle,
>  	 * till we reach stop. In case of right shift, iterator points to stop
>  	 * and it is decreased till we reach start.
>  	 */
> +again:
>  	if (SHIFT == SHIFT_LEFT)
>  		iterator = &start;
>  	else
>  		iterator = &stop;
>  
> +	if (tmp != EXT_MAX_BLOCKS)
> +		*iterator = tmp;
> +
>  	/*
>  	 * Its safe to start updating extents.  Start and stop are unsigned, so
>  	 * in case of right shift if extent with 0 block is reached, iterator
> @@ -5170,6 +5178,7 @@ ext4_ext_shift_extents(struct inode *inode, handle_t *handle,
>  			}
>  		}
>  
> +		tmp = *iterator;
>  		if (SHIFT == SHIFT_LEFT) {
>  			extent = EXT_LAST_EXTENT(path[depth].p_hdr);
>  			*iterator = le32_to_cpu(extent->ee_block) +
> @@ -5188,6 +5197,9 @@ ext4_ext_shift_extents(struct inode *inode, handle_t *handle,
>  		}
>  		ret = ext4_ext_shift_path_extents(path, shift, inode,
>  				handle, SHIFT);
> +		/* iterator can be NULL which means we should break */
> +		if (ret == -EAGAIN)
> +			goto again;

Hum, but while we dropped i_data_sem, the extent depth may have increased
so we may need larger 'path' now?

Otherwise the patch looks good.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
