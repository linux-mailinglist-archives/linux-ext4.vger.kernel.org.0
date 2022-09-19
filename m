Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95A055BC49C
	for <lists+linux-ext4@lfdr.de>; Mon, 19 Sep 2022 10:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbiISIrx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 19 Sep 2022 04:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbiISIrw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 19 Sep 2022 04:47:52 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D76AE09F;
        Mon, 19 Sep 2022 01:47:51 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id F019A1FA24;
        Mon, 19 Sep 2022 08:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1663577269; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yw15En4jSsXDnhe5JfPpQkuiIALL+KUjANdMgYW3b0M=;
        b=1EpD+I4+mmbxR1WxeJU5tkf/uymY/gjfVXxMgYJQpz17n8taRYDJwedPxjZn8ePiyXuGd0
        Gwi3iWDGpJuLOQdpOUv8je/aMR+DcktG0LIp3cpXLWjed2CwS8XkcF6kGIZnbPVmZEy+hV
        +i8m5COXogvubWA597VnH328PqsrMK4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1663577269;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yw15En4jSsXDnhe5JfPpQkuiIALL+KUjANdMgYW3b0M=;
        b=p8KhqE4GHGpWkx7y4RtkR0bgzrFSh05H3EqXeeYFqy/JsE0JkvTosmE1ElbAXDZO8Z/lWR
        utjVjL2dbLAfQDBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D445713A96;
        Mon, 19 Sep 2022 08:47:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YV/OM7UsKGMcQwAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 19 Sep 2022 08:47:49 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id F3084A0682; Mon, 19 Sep 2022 10:47:48 +0200 (CEST)
Date:   Mon, 19 Sep 2022 10:47:48 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ye Bin <yebin10@huawei.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz
Subject: Re: [PATCH -next v2 2/2] ext4: adjust fast commit disable judgement
 order in ext4_fc_track_inode
Message-ID: <20220919084748.pfvsjg3iglzoyg2r@quack3>
References: <20220916083836.388347-1-yebin10@huawei.com>
 <20220916083836.388347-3-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220916083836.388347-3-yebin10@huawei.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 16-09-22 16:38:36, Ye Bin wrote:
> If fastcommit is already disabled, there isn't need to mark inode ineligible.
> So move 'ext4_fc_disabled()' judgement bofore 'ext4_should_journal_data(inode)'
> judgement which can avoid to do meaningless judgement.
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/fast_commit.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> index eadab945b856..9217a588afd1 100644
> --- a/fs/ext4/fast_commit.c
> +++ b/fs/ext4/fast_commit.c
> @@ -577,15 +577,15 @@ void ext4_fc_track_inode(handle_t *handle, struct inode *inode)
>  	if (S_ISDIR(inode->i_mode))
>  		return;
>  
> +	if (ext4_fc_disabled(inode->i_sb))
> +		return;
> +
>  	if (ext4_should_journal_data(inode)) {
>  		ext4_fc_mark_ineligible(inode->i_sb,
>  					EXT4_FC_REASON_INODE_JOURNAL_DATA, handle);
>  		return;
>  	}
>  
> -	if (ext4_fc_disabled(inode->i_sb))
> -		return;
> -
>  	if (ext4_test_mount_flag(inode->i_sb, EXT4_MF_FC_INELIGIBLE))
>  		return;
>  
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
