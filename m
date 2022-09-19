Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA9515BD0DB
	for <lists+linux-ext4@lfdr.de>; Mon, 19 Sep 2022 17:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbiISP0s (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 19 Sep 2022 11:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbiISP0m (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 19 Sep 2022 11:26:42 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D49F4BF53;
        Mon, 19 Sep 2022 08:26:38 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 693EB1F8FC;
        Mon, 19 Sep 2022 15:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1663601197; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kUr8P/96HJrY1GhMUSLM+sWE/Riyfc74tyHg8I4RdLc=;
        b=DnwERxlv9+C+Cx6qBU7217ZI/o1DWCzvZtwOXQFOKt6EEofvywE4yaKkET3CM0eseFt89+
        KKsxrNL8i+B7U9+2YsJQN7Ldrm0IwSRAEfm1JZ0LnlkODjiSdfRa3owm4FbD4+8YxvXdXr
        qQWjBmqO2VcQLnLxGnf+44nFcliuJec=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1663601197;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kUr8P/96HJrY1GhMUSLM+sWE/Riyfc74tyHg8I4RdLc=;
        b=knoS4T7eYzl9Qa0QMf3BKKkYtfLbepOXWKFQJBRXncHKBl/GawDI+fhM32ie7YJlQ/eLKu
        8iR9EfB3T+KDXECA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 56B2913A96;
        Mon, 19 Sep 2022 15:26:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Q8Y6FS2KKGODeAAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 19 Sep 2022 15:26:37 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id E11B2A0682; Mon, 19 Sep 2022 17:26:36 +0200 (CEST)
Date:   Mon, 19 Sep 2022 17:26:36 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ye Bin <yebin10@huawei.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz
Subject: Re: [PATCH -next 2/2] ext4: fix potential memory leak in
 ext4_fc_record_modified_inode()
Message-ID: <20220919152636.fe2gqx5xkk6tooem@quack3>
References: <20220919144021.2162295-1-yebin10@huawei.com>
 <20220919144021.2162295-3-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220919144021.2162295-3-yebin10@huawei.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 19-09-22 22:40:21, Ye Bin wrote:
> As krealloc may return NULL, in this case 'state->fc_modified_inodes'
> may not be freed by krealloc, but 'state->fc_modified_inodes' already
> set NULL. Then will lead to 'state->fc_modified_inodes' memory leak.
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/fast_commit.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> index cc8c8db075ba..5ab58cb4ce8d 100644
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
