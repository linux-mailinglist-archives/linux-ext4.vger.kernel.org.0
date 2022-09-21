Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 219C15BFCF9
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Sep 2022 13:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiIULbK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 21 Sep 2022 07:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiIULbJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 21 Sep 2022 07:31:09 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73EDA86882;
        Wed, 21 Sep 2022 04:31:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 142DE21B2C;
        Wed, 21 Sep 2022 11:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1663759867; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dKyBnaUQKclgSFDRAU7XBhYoWw2RHfeoGLz/adPg6nA=;
        b=Qk90BVk3NGPouon8Zpda33keSHA/rl821O8OsRuhRJxh1FXxQdHGr1HO5r7i4l7QuAWnc2
        7ELmtGtgG8vL+99X/MzETA0yVli9jan6dUOPsZnzjbYyrMfutuoIroItjH4z+0jETsvu1H
        zqfQUBw8e56raucj1CWZfozJJqZw9mc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1663759867;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dKyBnaUQKclgSFDRAU7XBhYoWw2RHfeoGLz/adPg6nA=;
        b=92cKdXVluB3+zHVHzGXROLCPu+qdi8E1xHsQEmVcQrUZ9Z/TOeAasJgs9QkovYdbY5qvMD
        WcJnEcDbEVtiqZAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 04EB213A00;
        Wed, 21 Sep 2022 11:31:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9/QsAfv1KmMjBAAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 21 Sep 2022 11:31:07 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 44028A0684; Wed, 21 Sep 2022 13:31:06 +0200 (CEST)
Date:   Wed, 21 Sep 2022 13:31:06 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ye Bin <yebin10@huawei.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz
Subject: Re: [PATCH -next v2 1/3] ext4: fix potential memory leak in
 ext4_fc_record_modified_inode()
Message-ID: <20220921113106.mk4h4rjdfpwdkzs6@quack3>
References: <20220921064040.3693255-1-yebin10@huawei.com>
 <20220921064040.3693255-2-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220921064040.3693255-2-yebin10@huawei.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 21-09-22 14:40:38, Ye Bin wrote:
> As krealloc may return NULL, in this case 'state->fc_modified_inodes'
> may not be freed by krealloc, but 'state->fc_modified_inodes' already
> set NULL. Then will lead to 'state->fc_modified_inodes' memory leak.
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>

Still looks good to me. I think this didn't change since last time, did it?
Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/fast_commit.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> index 88575f3d0dc5..29a22ee0adb8 100644
> --- a/fs/ext4/fast_commit.c
> +++ b/fs/ext4/fast_commit.c
> @@ -1486,13 +1486,15 @@ static int ext4_fc_record_modified_inode(struct super_block *sb, int ino)
>  		if (state->fc_modified_inodes[i] == ino)
>  			return 0;
>  	if (state->fc_modified_inodes_used == state->fc_modified_inodes_size) {
> -		state->fc_modified_inodes = krealloc(
> -				state->fc_modified_inodes,
> +		int *fc_modified_inodes;
> +
> +		fc_modified_inodes = krealloc(state->fc_modified_inodes,
>  				sizeof(int) * (state->fc_modified_inodes_size +
>  				EXT4_FC_REPLAY_REALLOC_INCREMENT),
>  				GFP_KERNEL);
> -		if (!state->fc_modified_inodes)
> +		if (!fc_modified_inodes)
>  			return -ENOMEM;
> +		state->fc_modified_inodes = fc_modified_inodes;
>  		state->fc_modified_inodes_size +=
>  			EXT4_FC_REPLAY_REALLOC_INCREMENT;
>  	}
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
