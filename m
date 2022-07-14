Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 299F2574C7C
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Jul 2022 13:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238068AbiGNLxb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 14 Jul 2022 07:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbiGNLxa (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 14 Jul 2022 07:53:30 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE77D5B7B9
        for <linux-ext4@vger.kernel.org>; Thu, 14 Jul 2022 04:53:29 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 837071FA4D;
        Thu, 14 Jul 2022 11:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1657799608; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V+hxm4mP0Q5Xg6AXyYaugjhTTHvrHXp7dYT0hUL5IXw=;
        b=b7Cy35R6U6Yq32qf5qZibYvAbYPTifrce/xHsXZW6TUKmUrwUcsJLvMecJ/HTBs51Zhzx3
        lRn7A3qHk6nDuGBkIwpYXEJNKPx/572KlLEJYcEa4GA6ozFh4OeMu0DKLbre5KBV64JJyd
        lfHTvf55VWwJBR3AC/Qg0W6R7TZY6KY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1657799608;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V+hxm4mP0Q5Xg6AXyYaugjhTTHvrHXp7dYT0hUL5IXw=;
        b=FM0V/fKbcbs9m4uX0w4O075TS2wS3mrM/mt8bk9nvCpfHfLTa6BolVjtIHUfAla8UhZ9NM
        vH23KtL0lx4Yn4Dw==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 6E7082C142;
        Thu, 14 Jul 2022 11:53:28 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 76C4BA0659; Thu, 14 Jul 2022 13:53:26 +0200 (CEST)
Date:   Thu, 14 Jul 2022 13:53:26 +0200
From:   Jan Kara <jack@suse.cz>
To:     Eric Whitney <enwlinux@gmail.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu
Subject: Re: [PATCH] ext4: minor defrag code improvements
Message-ID: <20220714115326.qhjsrchoepnnsffu@quack3>
References: <20220621143340.2268087-1-enwlinux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220621143340.2268087-1-enwlinux@gmail.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 21-06-22 10:33:40, Eric Whitney wrote:
> Modify two error paths returning EBUSY for bad argument file types to
> return EOPNOTSUPP instead.  Move an extent tree search whose results are
> only occasionally required to the site always requiring them for
> improved efficiency.  Address a few typos.
> 
> Signed-off-by: Eric Whitney <enwlinux@gmail.com>

So why is EOPNOTSUPP better than EBUSY? Honestly we are rather inconsistent
with errors returned for various operations on swapfile -
read/write/fallocate/truncate return ETXTBSY, unlink returns EPERM, some
ext4 ioctls return EINVAL... I guess ETXTBSY is the most common return
value?

Otherwise the patch looks good.

								Honza

> ---
>  fs/ext4/move_extent.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
> index 701f1d6a217f..4e4b0452106e 100644
> --- a/fs/ext4/move_extent.c
> +++ b/fs/ext4/move_extent.c
> @@ -472,19 +472,17 @@ mext_check_arguments(struct inode *orig_inode,
>  	if (IS_IMMUTABLE(donor_inode) || IS_APPEND(donor_inode))
>  		return -EPERM;
>  
> -	/* Ext4 move extent does not support swapfile */
> +	/* Ext4 move extent does not support swap files */
>  	if (IS_SWAPFILE(orig_inode) || IS_SWAPFILE(donor_inode)) {
> -		ext4_debug("ext4 move extent: The argument files should "
> -			"not be swapfile [ino:orig %lu, donor %lu]\n",
> +		ext4_debug("ext4 move extent: The argument files should not be swap files [ino:orig %lu, donor %lu]\n",
>  			orig_inode->i_ino, donor_inode->i_ino);
> -		return -EBUSY;
> +		return -EOPNOTSUPP;
>  	}
>  
>  	if (ext4_is_quota_file(orig_inode) && ext4_is_quota_file(donor_inode)) {
> -		ext4_debug("ext4 move extent: The argument files should "
> -			"not be quota files [ino:orig %lu, donor %lu]\n",
> +		ext4_debug("ext4 move extent: The argument files should not be quota files [ino:orig %lu, donor %lu]\n",
>  			orig_inode->i_ino, donor_inode->i_ino);
> -		return -EBUSY;
> +		return -EOPNOTSUPP;
>  	}
>  
>  	/* Ext4 move extent supports only extent based file */
> @@ -631,11 +629,11 @@ ext4_move_extents(struct file *o_filp, struct file *d_filp, __u64 orig_blk,
>  		if (ret)
>  			goto out;
>  		ex = path[path->p_depth].p_ext;
> -		next_blk = ext4_ext_next_allocated_block(path);
>  		cur_blk = le32_to_cpu(ex->ee_block);
>  		cur_len = ext4_ext_get_actual_len(ex);
>  		/* Check hole before the start pos */
>  		if (cur_blk + cur_len - 1 < o_start) {
> +			next_blk = ext4_ext_next_allocated_block(path);
>  			if (next_blk == EXT_MAX_BLOCKS) {
>  				ret = -ENODATA;
>  				goto out;
> @@ -663,7 +661,7 @@ ext4_move_extents(struct file *o_filp, struct file *d_filp, __u64 orig_blk,
>  		donor_page_index = d_start >> (PAGE_SHIFT -
>  					       donor_inode->i_blkbits);
>  		offset_in_page = o_start % blocks_per_page;
> -		if (cur_len > blocks_per_page- offset_in_page)
> +		if (cur_len > blocks_per_page - offset_in_page)
>  			cur_len = blocks_per_page - offset_in_page;
>  		/*
>  		 * Up semaphore to avoid following problems:
> -- 
> 2.30.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
