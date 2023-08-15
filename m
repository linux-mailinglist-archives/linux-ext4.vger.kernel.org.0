Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE4F877CB23
	for <lists+linux-ext4@lfdr.de>; Tue, 15 Aug 2023 12:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235376AbjHOK1r (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 15 Aug 2023 06:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234320AbjHOK1R (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 15 Aug 2023 06:27:17 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A2019A3;
        Tue, 15 Aug 2023 03:27:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 61B8721999;
        Tue, 15 Aug 2023 10:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1692095235; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XUdE5GVXS2U4tq5EGM2we+22dQo5/Hv3fjeHigUh0oQ=;
        b=SgYBwhsgg7ZC4zYq8cBmux6gaJ5kJqcr1bLFchY2fUEM/UUBOXJnNNroYJ7mw7FFz9Rva2
        LzgICdbUV7vTKvIY7QzlEZzZ9FHbFrPoxjXWm2aNrZ5FaDKHNxsjZ0g2KFZoANynS86EYG
        /O6Hwizn5U2nrD/rJkapJmL5opBJzBA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1692095235;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XUdE5GVXS2U4tq5EGM2we+22dQo5/Hv3fjeHigUh0oQ=;
        b=rqyE9+e4qYyK7OYuGH7g7lpvzSzRKk/3iPJaSIuHWqqcgSBjmq41yX8zB+Z46irGi2n+nj
        t78BTFR0+VpnALDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5020913909;
        Tue, 15 Aug 2023 10:27:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6J2EEwNT22S6WgAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 15 Aug 2023 10:27:15 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 9D074A0769; Tue, 15 Aug 2023 12:27:14 +0200 (CEST)
Date:   Tue, 15 Aug 2023 12:27:14 +0200
From:   Jan Kara <jack@suse.cz>
To:     Georg Ottinger <g.ottinger@gmx.at>
Cc:     jack@suse.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] ext2: fix datatype of block number in
 ext2_xattr_set2()
Message-ID: <20230815102714.ymmasd762kygxst4@quack3>
References: <20230815100340.22121-1-g.ottinger@gmx.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815100340.22121-1-g.ottinger@gmx.at>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 15-08-23 12:03:40, Georg Ottinger wrote:
> I run a small server that uses external hard drives for backups. The
> backup software I use uses ext2 filesystems with 4KiB block size and
> the server is running SELinux and therefore relies on xattr. I recently
> upgraded the hard drives from 4TB to 12TB models. I noticed that after
> transferring some TBs I got a filesystem error "Freeing blocks not in
> datazone - block = 18446744071529317386, count = 1" and the backup
> process stopped. Trying to fix the fs with e2fsck resulted in a
> completely corrupted fs. The error probably came from ext2_free_blocks(),
> and because of the large number 18e19 this problem immediately looked
> like some kind of integer overflow. Whereas the 4TB fs was about 1e9
> blocks, the new 12TB is about 3e9 blocks. So, searching the ext2 code,
> I came across the line in fs/ext2/xattr.c:745 where ext2_new_block()
> is called and the resulting block number is stored in the variable block
> as an int datatype. If a block with a block number greater than
> INT32_MAX is returned, this variable overflows and the call to
> sb_getblk() at line fs/ext2/xattr.c:750 fails, then the call to
> ext2_free_blocks() produces the error.
> 
> Signed-off-by: Georg Ottinger <g.ottinger@gmx.at>

Yeah, definitely looks like a bug. Thanks for the fix! I've added it to my
tree.

BTW I'm not sure which kernel (and with which config) you are using but in
most distribution kernels, ext2 filesystem driver is not used and instead
ext4 driver is used for handling even ext2 filesystems. Just mentioning
that in case your fs corruption is in fact related to ext4 driver...

								Honza

> ---
>  fs/ext2/xattr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ext2/xattr.c b/fs/ext2/xattr.c
> index 8906ba479..5e13f7ea1 100644
> --- a/fs/ext2/xattr.c
> +++ b/fs/ext2/xattr.c
> @@ -742,7 +742,7 @@ ext2_xattr_set2(struct inode *inode, struct buffer_head *old_bh,
>  			/* We need to allocate a new block */
>  			ext2_fsblk_t goal = ext2_group_first_block_no(sb,
>  						EXT2_I(inode)->i_block_group);
> -			int block = ext2_new_block(inode, goal, &error);
> +			ext2_fsblk_t block = ext2_new_block(inode, goal, &error);
>  			if (error)
>  				goto cleanup;
>  			ea_idebug(inode, "creating block %d", block);
> --
> 2.17.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
