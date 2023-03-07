Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F11CA6ADC72
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Mar 2023 11:54:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbjCGKxp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 7 Mar 2023 05:53:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbjCGKxN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 7 Mar 2023 05:53:13 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 933987EDB
        for <linux-ext4@vger.kernel.org>; Tue,  7 Mar 2023 02:53:11 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0E7B61FE17;
        Tue,  7 Mar 2023 10:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678186390; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eWhj0K8bKAiqB0pPHaw4Ym+gCEDZ8x1LrFltvxThpT8=;
        b=Uuik6W2DzqBpN6UAb6zf4EllLmIN0bDr/kHuXB6wAzAuQRQ9TjBhYtUFOKPVQlKVFpQAJ5
        TMq0kA1EXB5QBWld4YmFNBtc+AVAP4FcYL/mbJeD5uzRsCthDh23tp5WFnz/+BfzEgLRWO
        cPIIRPMduLBa/RnZbTAVk5ZujVB+V4E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678186390;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eWhj0K8bKAiqB0pPHaw4Ym+gCEDZ8x1LrFltvxThpT8=;
        b=d0yo7e0L9cmcib92VYx67DnD1RtcNAtbPHog/lkmV5d7ZoqrFQyGPHZ6Z/RWpfS4H40/Ki
        5lO0d4iPlOWuPMDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E904213440;
        Tue,  7 Mar 2023 10:53:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FgbXOJUXB2SLcQAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 07 Mar 2023 10:53:09 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 7C1B0A06F3; Tue,  7 Mar 2023 11:53:09 +0100 (CET)
Date:   Tue, 7 Mar 2023 11:53:09 +0100
From:   Jan Kara <jack@suse.cz>
To:     Eric Whitney <enwlinux@gmail.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu
Subject: Re: [PATCH] ext4: fix RENAME_WHITEOUT handling for inline directories
Message-ID: <20230307105309.xddxh3tqtzsqxjuz@quack3>
References: <20230210173244.679890-1-enwlinux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230210173244.679890-1-enwlinux@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 10-02-23 12:32:44, Eric Whitney wrote:
> A significant number of xfstests can cause ext4 to log one or more
> warning messages when they are run on a test file system where the
> inline_data feature has been enabled.  An example:
> 
> "EXT4-fs warning (device vdc): ext4_dirblock_csum_set:425: inode
>  #16385: comm fsstress: No space for directory leaf checksum. Please
> run e2fsck -D."
> 
> The xfstests include: ext4/057, 058, and 307; generic/013, 051, 068,
> 070, 076, 078, 083, 232, 269, 270, 390, 461, 475, 476, 482, 579, 585,
> 589, 626, 631, and 650.
> 
> In this situation, the warning message indicates a bug in the code that
> performs the RENAME_WHITEOUT operation on a directory entry that has
> been stored inline.  It doesn't detect that the directory is stored
> inline, and incorrectly attempts to compute a dirent block checksum on
> the whiteout inode when creating it.  This attempt fails as a result
> of the integrity checking in get_dirent_tail (usually due to a failure
> to match the EXT4_FT_DIR_CSUM magic cookie), and the warning message
> is then emitted.
> 
> Fix this by simply collecting the inlined data state at the time the
> search for the source directory entry is performed.  Existing code
> handles the rest, and this is sufficient to eliminate all spurious
> warning messages produced by the tests above.  Go one step further
> and do the same in the code that resets the source directory entry in
> the event of failure.  The inlined state should be present in the
> "old" struct, but given the possibility of a race there's no harm
> in taking a conservative approach and getting that information again
> since the directory entry is being reread anyway.
> 
> Fixes: b7ff91fd030d ("ext4: find old entry again if failed to rename whiteout")
> 
> Signed-off-by: Eric Whitney <enwlinux@gmail.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/namei.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> index dd28453d6ea3..924e16b239e0 100644
> --- a/fs/ext4/namei.c
> +++ b/fs/ext4/namei.c
> @@ -1595,11 +1595,10 @@ static struct buffer_head *__ext4_find_entry(struct inode *dir,
>  		int has_inline_data = 1;
>  		ret = ext4_find_inline_entry(dir, fname, res_dir,
>  					     &has_inline_data);
> -		if (has_inline_data) {
> -			if (inlined)
> -				*inlined = 1;
> +		if (inlined)
> +			*inlined = has_inline_data;
> +		if (has_inline_data)
>  			goto cleanup_and_exit;
> -		}
>  	}
>  
>  	if ((namelen <= 2) && (name[0] == '.') &&
> @@ -3646,7 +3645,8 @@ static void ext4_resetent(handle_t *handle, struct ext4_renament *ent,
>  	 * so the old->de may no longer valid and need to find it again
>  	 * before reset old inode info.
>  	 */
> -	old.bh = ext4_find_entry(old.dir, &old.dentry->d_name, &old.de, NULL);
> +	old.bh = ext4_find_entry(old.dir, &old.dentry->d_name, &old.de,
> +				 &old.inlined);
>  	if (IS_ERR(old.bh))
>  		retval = PTR_ERR(old.bh);
>  	if (!old.bh)
> @@ -3813,7 +3813,8 @@ static int ext4_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
>  			return retval;
>  	}
>  
> -	old.bh = ext4_find_entry(old.dir, &old.dentry->d_name, &old.de, NULL);
> +	old.bh = ext4_find_entry(old.dir, &old.dentry->d_name, &old.de,
> +				 &old.inlined);
>  	if (IS_ERR(old.bh))
>  		return PTR_ERR(old.bh);
>  	/*
> -- 
> 2.30.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
