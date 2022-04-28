Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCD34513627
	for <lists+linux-ext4@lfdr.de>; Thu, 28 Apr 2022 16:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241806AbiD1OFc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 28 Apr 2022 10:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239094AbiD1OFb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 28 Apr 2022 10:05:31 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1673DAC06A
        for <linux-ext4@vger.kernel.org>; Thu, 28 Apr 2022 07:02:14 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id BE2B4210EC;
        Thu, 28 Apr 2022 14:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1651154532; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HQq3hohrygeEyutBkMRMYQCwFSZKPQ/7siy7yK1JQ28=;
        b=xT61fBr3IwFPrkSIlUkPTq6TPxpdKuFDD7GKMUvuCMp+1RsicKJ6IUGYLWD929EdE5+IEI
        xf2hIUofo4kpvGY+T4xfIiI/imFpsQKoKsIh073qPJ3Fb3bO2rtR4wdFyoEUhBLoOxNBPZ
        CBIOIDGTGsMbYW2hHaJx9SIRQq2vdtA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1651154532;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HQq3hohrygeEyutBkMRMYQCwFSZKPQ/7siy7yK1JQ28=;
        b=GN/58eDAeiYMKjeugMKyGeQfXJ7XxOganCcMRin+lZSJy7JWTdEz6+tcPqtN8b1JKk3lNl
        TWnfkpmM/Xg67MDQ==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 9F0092C141;
        Thu, 28 Apr 2022 14:02:12 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 2D66CA061A; Thu, 28 Apr 2022 16:02:09 +0200 (CEST)
Date:   Thu, 28 Apr 2022 16:02:09 +0200
From:   Jan Kara <jack@suse.cz>
To:     Tadeusz Struk <tadeusz.struk@linaro.org>
Cc:     syzbot+fcc629d1a1ae8d3fe8a5@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, tytso@mit.edu
Subject: Re: [PATCH v2] ext4: check if offset+length is within valid fallocate
Message-ID: <20220428140209.mewduy4rzr25iepb@quack3.lan>
References: <00000000000042d70e05da43401f@google.com>
 <20220315213857.268414-1-tadeusz.struk@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220315213857.268414-1-tadeusz.struk@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 15-03-22 14:38:57, Tadeusz Struk wrote:
> #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

Did this fix fall through the cracks? Tadeusz, can you do a proper patch
submission with your Signed-off-by etc.? Thanks!

								Honza

> 
> ==============================================
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 01c9e4f743ba..355384007d11 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3924,7 +3924,8 @@ int ext4_punch_hole(struct inode *inode, loff_t offset, loff_t length)
>  	struct super_block *sb = inode->i_sb;
>  	ext4_lblk_t first_block, stop_block;
>  	struct address_space *mapping = inode->i_mapping;
> -	loff_t first_block_offset, last_block_offset;
> +	loff_t first_block_offset, last_block_offset, max_length;
> +	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
>  	handle_t *handle;
>  	unsigned int credits;
>  	int ret = 0, ret2 = 0;
> @@ -3967,6 +3968,16 @@ int ext4_punch_hole(struct inode *inode, loff_t offset, loff_t length)
>  		   offset;
>  	}
>  
> +	/*
> +	 * For punch hole the length + offset needs to be at least within
> +	 * one block before last
> +	 */
> +	max_length = sbi->s_bitmap_maxbytes - inode->i_sb->s_blocksize;
> +	if (offset + length >= max_length) {
> +		ret = -ENOSPC;
> +		goto out_mutex;
> +	}
> +
>  	if (offset & (sb->s_blocksize - 1) ||
>  	    (offset + length) & (sb->s_blocksize - 1)) {
>  		/*
> -- 
> 2.35.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
