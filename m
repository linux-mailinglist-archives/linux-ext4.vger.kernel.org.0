Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 612A2631D3D
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Nov 2022 10:47:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbiKUJre (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 21 Nov 2022 04:47:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbiKUJrS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 21 Nov 2022 04:47:18 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 896DD97099;
        Mon, 21 Nov 2022 01:47:17 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 406A821C68;
        Mon, 21 Nov 2022 09:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669024036; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=29LxhSu0ucllhODm+Q6o4X/0bZn8l67nJlk+/Wb/gVE=;
        b=nAo8M7nLyVbqW1Y7drnlC8Kw5GmoDNELsziNbO1g7WR0oSpVnA7Vv0m2g8S+9DB0Cq6Jre
        brhfqvJqZdAPU+gv8vxFJ7Ly/tiv6FObTHZmBWtJHo1Np1JByvfoKoUqJN3vN9LIhlP/ls
        igM5DMPBYEKU4RyqCIbnNngFHwQAPUA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669024036;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=29LxhSu0ucllhODm+Q6o4X/0bZn8l67nJlk+/Wb/gVE=;
        b=cPkHzIMMytcKTmvDyFLcsVejF28URu65O9YSdWRUOGJ72WqAppdnwFv8U844QXSxI5N+md
        eL5l1ZH+GCXv/dBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 314131377F;
        Mon, 21 Nov 2022 09:47:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id BG0CDCRJe2MkdwAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 21 Nov 2022 09:47:16 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id A4685A070A; Mon, 21 Nov 2022 10:47:15 +0100 (CET)
Date:   Mon, 21 Nov 2022 10:47:15 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ye Bin <yebin@huaweicloud.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz, Ye Bin <yebin10@huawei.com>
Subject: Re: [PATCH 2/3] ext4: WANR_ON when detect abnormal
 'i_reserved_data_blocks'
Message-ID: <20221121094715.gpha7rkijbwr5r47@quack3>
References: <20221117014246.610202-1-yebin@huaweicloud.com>
 <20221117014246.610202-3-yebin@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117014246.610202-3-yebin@huaweicloud.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 17-11-22 09:42:45, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>
> 
> If 'i_reserved_data_blocks' is not cleared which mean something wrong
> with code, so emit WARN_ON to capture this abnormal closer to the first
> scene.
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
>  fs/ext4/super.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 63ef74eb8091..30885a6fe18b 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1385,11 +1385,14 @@ static void ext4_destroy_inode(struct inode *inode)
>  		dump_stack();
>  	}
>  
> -	if (EXT4_I(inode)->i_reserved_data_blocks)
> -		ext4_msg(inode->i_sb, KERN_ERR,
> -			 "Inode %lu (%p): i_reserved_data_blocks (%u) not cleared!",
> -			 inode->i_ino, EXT4_I(inode),
> -			 EXT4_I(inode)->i_reserved_data_blocks);
> +	if (EXT4_I(inode)->i_reserved_data_blocks) {
> +		ext4_warning(inode->i_sb, "Inode %lu (%p): "
> +			    "i_reserved_data_blocks (%u) not cleared!",
> +			     inode->i_ino, EXT4_I(inode),
> +			     EXT4_I(inode)->i_reserved_data_blocks);
> +
> +		WARN_ON(1);
> +	}

Hum, so I'd think that if this happens, the free space accounting is likely
wrong so we might as well just force the filesystem to error mode with
ext4_error() to force fsck?  I also gives a good chance to various test
systems to detect there is some problem so we don't need the WARN_ON then?
What do others think?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
