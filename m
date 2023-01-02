Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6BFA65B53F
	for <lists+linux-ext4@lfdr.de>; Mon,  2 Jan 2023 17:41:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234163AbjABQlq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 2 Jan 2023 11:41:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjABQlp (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 2 Jan 2023 11:41:45 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897641F1;
        Mon,  2 Jan 2023 08:41:44 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4599E5C675;
        Mon,  2 Jan 2023 16:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1672677703; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2pZDrU8YJJtnMizhBEDQAko+AKSWDe4PtNFAHzaa964=;
        b=OVd56XDdEfXoz1JgdTUwKVJgR5vYC+tqAoYI45ByZaNnUU21aACDMfzK6c4cV6S9i/Q0lK
        BM5tX/qsS11MmYfehyv/tEp54v7RA6qnvKEbqvf7Cn5hhBCVH9O3sVSmTSl66jrl2KeD0w
        y4nWO85wLhcjeFQ2M71VIcSJjix7qbY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1672677703;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2pZDrU8YJJtnMizhBEDQAko+AKSWDe4PtNFAHzaa964=;
        b=w3axUzyL8/+FnvvSR4G9WdygKYk/5JNwkvodx7nB2o1m5etpQ4sUCq7BEi8bWzrJ4xr2F/
        nBltQaZmdqN+FlAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2CBB1139C8;
        Mon,  2 Jan 2023 16:41:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 76pOCkcJs2ONDAAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 02 Jan 2023 16:41:43 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id E208EA0742; Mon,  2 Jan 2023 17:41:41 +0100 (CET)
Date:   Mon, 2 Jan 2023 17:41:41 +0100
From:   Jan Kara <jack@suse.cz>
To:     Tanmay Bhushan <007047221b@gmail.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: remove dead code in updating backup sb
Message-ID: <20230102164141.sfc6ysegyksxryzn@quack3>
References: <20221230141858.3828-1-007047221b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221230141858.3828-1-007047221b@gmail.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 30-12-22 15:18:58, Tanmay Bhushan wrote:
> ext4_update_backup_sb checks for err having some value
> after unlocking buffer. But err has not been updated
> till that point in any code which will lead execution
> of the code in question.
> 
> Signed-off-by: Tanmay Bhushan <007047221b@gmail.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/ioctl.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
> index 8067ccda34e4..2e8c34036313 100644
> --- a/fs/ext4/ioctl.c
> +++ b/fs/ext4/ioctl.c
> @@ -155,9 +155,6 @@ static int ext4_update_backup_sb(struct super_block *sb,
>  	set_buffer_uptodate(bh);
>  	unlock_buffer(bh);
>  
> -	if (err)
> -		goto out_bh;
> -
>  	if (handle) {
>  		err = ext4_handle_dirty_metadata(handle, NULL, bh);
>  		if (err)
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
