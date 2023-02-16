Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1723F699B23
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Feb 2023 18:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbjBPRUz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 16 Feb 2023 12:20:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjBPRUw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 16 Feb 2023 12:20:52 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E244E5DB;
        Thu, 16 Feb 2023 09:20:51 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 76F5B1FDA8;
        Thu, 16 Feb 2023 17:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1676568050; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2AuHHxKUXvB76fx4Zt4gCT8/vnjZH/GFMD7PdFz+ZUQ=;
        b=OiDEZX6ISx9uuPnswQ0fCFyH5lMRiaHPp1jQ6p2JoN2pqgPMpDSHQvC1JeYGB/DmhKlyK+
        uE2dIvLWwM65BKZq1uO3hOrwQjQpCw1peDT7el7c6IhV8D6akSKtHXVRny6J575BW8q68S
        UbDAKutUyw0Z3b7wNKJ+XcNiXOYeuHA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1676568050;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2AuHHxKUXvB76fx4Zt4gCT8/vnjZH/GFMD7PdFz+ZUQ=;
        b=SK2rqAVJVUtxDav9ksURIqfun8RQOkgxOU0RL6qRDZlOQw+d+LGQvs35YYxm8xEk6hz4uy
        kXqUjakox1RKioCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2D11F13438;
        Thu, 16 Feb 2023 17:20:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vGTtCvJl7mMwQgAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 16 Feb 2023 17:20:50 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id EE137A06E1; Thu, 16 Feb 2023 18:20:47 +0100 (CET)
Date:   Thu, 16 Feb 2023 18:20:47 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ye Bin <yebin@huaweicloud.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz, Ye Bin <yebin10@huawei.com>
Subject: Re: [PATCH v3 2/2] ext4: make sure fs error flag setted before clear
 journal error
Message-ID: <20230216172047.lhc3pwv4rqiegbxs@quack3>
References: <20230214022905.765088-1-yebin@huaweicloud.com>
 <20230214022905.765088-3-yebin@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230214022905.765088-3-yebin@huaweicloud.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 14-02-23 10:29:05, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>
> 
> Now, jounral error number maybe cleared even though ext4_commit_super()
> failed. This may lead to error flag miss, then fsck will miss to check
> file system deeply.
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/super.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index b94754ba8556..619ef6d021d4 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -6163,11 +6163,13 @@ static int ext4_clear_journal_err(struct super_block *sb,
>  		errstr = ext4_decode_error(sb, j_errno, nbuf);
>  		ext4_warning(sb, "Filesystem error recorded "
>  			     "from previous mount: %s", errstr);
> -		ext4_warning(sb, "Marking fs in need of filesystem check.");
>  
>  		EXT4_SB(sb)->s_mount_state |= EXT4_ERROR_FS;
>  		es->s_state |= cpu_to_le16(EXT4_ERROR_FS);
> -		ext4_commit_super(sb);
> +		j_errno = ext4_commit_super(sb);
> +		if (j_errno)
> +			return j_errno;
> +		ext4_warning(sb, "Marked fs in need of filesystem check.");
>  
>  		jbd2_journal_clear_err(journal);
>  		jbd2_journal_update_sb_errno(journal);
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
