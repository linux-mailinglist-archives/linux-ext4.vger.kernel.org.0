Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 493D073BD3F
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Jun 2023 18:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232178AbjFWQxw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 23 Jun 2023 12:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232540AbjFWQxq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 23 Jun 2023 12:53:46 -0400
Received: from striker.routify.me (striker.routify.me [IPv6:2602:fe90:604:1b::87c:418e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4BAB2723;
        Fri, 23 Jun 2023 09:53:40 -0700 (PDT)
Received: from glitch (unknown [IPv6:2602:24c:b8f:cd90::8eb3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by striker.routify.me (Postfix) with ESMTPSA id C41DE2A78;
        Fri, 23 Jun 2023 16:53:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 striker.routify.me C41DE2A78
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seangreenslade.com;
        s=striker-outgoing; t=1687539199;
        bh=JdVIXA6SQTydrIZabMWKryrH42Nzq9Wv8AlAOPcXMpI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=doMNkoVcD4sJ0aPa6n9b2/uRXkwn+iIdsoTKuV5/D7p69MLf8Wq3w5V2qGh8+IKYr
         JzX5dyns29b6bhvodB3wMt91jn78Lyy/FLF/hNw79VHDW9d8P0nqzamDpvQA2WCxDN
         w2VhPmVOIQgZJ1RZIT2y3dZngryRgAkIsVOgK0Qw=
Date:   Fri, 23 Jun 2023 09:53:36 -0700
From:   Sean Greenslade <sean@seangreenslade.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, linux-ext4@vger.kernel.org,
        Ye Bin <yebin10@huawei.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>
Subject: Re: RO mount of ext4 filesystem causes writes
Message-ID: <ZJXOEJkCbAb0nG_I@glitch>
References: <ZIauBR7YiV3rVAHL@glitch>
 <ZIa5P1HqE62rmzqu@debian.me>
 <ZJTv+it2x/glkmpp@debian.me>
 <20230623044611.GD34229@mit.edu>
 <ZJU5HN3bmXR3FvzE@glitch>
 <20230623143411.GF34229@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230623143411.GF34229@mit.edu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Jun 23, 2023 at 10:34:11AM -0400, Theodore Ts'o wrote:
> Ah, yes, your initial report said "small writes", but it didn't
> specify whether the issue was that writes were modifying the image, or
> just simply touching the mtime field of the backing file.  I assume
> these must be largish fs images, since it must have made the increased
> rsync time noticeable?

Yeah, these are ~30 GB images on spinning drives, so it's the difference
between near-instant and several minutes.

> This appears to fix the problem for me, given the clarified
> reproduction information.  Could you please try it on your end?
> 
> 	     		   	     	    - Ted

Yup, this patch does indeed solve the problem I'm seeing. Thanks!

--Sean

> From 6bb438fa0aac4c08acd626d408cb6d4b745df7fd Mon Sep 17 00:00:00 2001
> From: Theodore Ts'o <tytso@mit.edu>
> Date: Fri, 23 Jun 2023 10:18:51 -0400
> Subject: [PATCH] ext4: avoid updating the superblock on a r/o mount if not
>  needed
> 
> This was noticed by a user who noticied that the mtime of a file
> backing a loopback device was getting bumped when the loopback device
> is mounted read/only.  Note: This doesn't show up when doing a
> loopback mount of a file directly, via "mount -o ro /tmp/foo.img
> /mnt", since the loop device is set read-only when mount automatically
> creates loop device.  However, this is noticeable for a LUKS loop
> device like this:
> 
> % cryptsetup luksOpen /tmp/foo.img test
> % mount -o ro /dev/loop0 /mnt ; umount /mnt
> 
> or, if LUKS is not in use, if the user manually creates the loop
> device like this:
> 
> % losetup /dev/loop0 /tmp/foo.img
> % mount -o ro /dev/loop0 /mnt ; umount /mnt
> 
> The modified mtime causes rsync to do a rolling checksum scan of the
> file on the local and remote side, incrementally increasing the time
> to rsync the not-modified-but-touched image file.
> 
> Fixes: eee00237fa5e ("ext4: commit super block if fs record error when journal record without error")
> Cc: stable@kernel.org
> Link: https://lore.kernel.org/r/ZIauBR7YiV3rVAHL@glitch
> Reported-by: Sean Greenslade <sean@seangreenslade.com>
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
>  fs/ext4/super.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index b3819e70093e..c638b0db3b2b 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -5997,19 +5997,27 @@ static int ext4_load_journal(struct super_block *sb,
>  		err = jbd2_journal_wipe(journal, !really_read_only);
>  	if (!err) {
>  		char *save = kmalloc(EXT4_S_ERR_LEN, GFP_KERNEL);
> +		__le16 orig_state;
> +		bool changed = false;
>  
>  		if (save)
>  			memcpy(save, ((char *) es) +
>  			       EXT4_S_ERR_START, EXT4_S_ERR_LEN);
>  		err = jbd2_journal_load(journal);
> -		if (save)
> +		if (save && memcmp(((char *) es) + EXT4_S_ERR_START,
> +				   save, EXT4_S_ERR_LEN)) {
>  			memcpy(((char *) es) + EXT4_S_ERR_START,
>  			       save, EXT4_S_ERR_LEN);
> +			changed = true;
> +		}
>  		kfree(save);
> +		orig_state = es->s_state;
>  		es->s_state |= cpu_to_le16(EXT4_SB(sb)->s_mount_state &
>  					   EXT4_ERROR_FS);
> +		if (orig_state != es->s_state)
> +			changed = true;
>  		/* Write out restored error information to the superblock */
> -		if (!bdev_read_only(sb->s_bdev)) {
> +		if (changed && !really_read_only) {
>  			int err2;
>  			err2 = ext4_commit_super(sb);
>  			err = err ? : err2;
> -- 
> 2.31.0
