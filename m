Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2544B5B9D1E
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Sep 2022 16:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiIOOaN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 15 Sep 2022 10:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbiIOOaM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 15 Sep 2022 10:30:12 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90DC23846C;
        Thu, 15 Sep 2022 07:30:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id F05AB33786;
        Thu, 15 Sep 2022 14:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1663252208; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LbhmGjCvkeNneLmFaHzzNfVQsclXD7BkZKZeexJiJmU=;
        b=xBgP5PVYdcnLnEoanc50FexGxJrd3qbDY5gHzD88WBqaPjmXPiOHlxe5/1RpVqlxVboHhT
        qgL3ucsDo/MIAnsT1QMRbc1+ch0LX//we+NFv5MN4YdtA9WEbxHqxtwcSqcrSzdBRvSvJx
        9b6fr+m7h5QMpTqmrad5wPzshU+EWUo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1663252208;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LbhmGjCvkeNneLmFaHzzNfVQsclXD7BkZKZeexJiJmU=;
        b=//wYkh1FkCgxufxrFp8RaivcCzo0DUarv4uJXO/SndD6ftqv6i9uMR3fwAoGTnkbrxeOq+
        sMEcj+ExoCSk2CCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E3912133B6;
        Thu, 15 Sep 2022 14:30:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id so6LN/A2I2MAegAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 15 Sep 2022 14:30:08 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 886ACA0682; Thu, 15 Sep 2022 16:30:08 +0200 (CEST)
Date:   Thu, 15 Sep 2022 16:30:08 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ye Bin <yebin10@huawei.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz
Subject: Re: [PATCH -next 2/2] ext4: adjust fast commit disable judgement
 order in ext4_fc_track_inode
Message-ID: <20220915143008.27woacjur6sg32t2@quack3>
References: <20220915135611.3040776-1-yebin10@huawei.com>
 <20220915135611.3040776-3-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220915135611.3040776-3-yebin10@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 15-09-22 21:56:11, Ye Bin wrote:
> Judge filesystem if fast commit disabled before test inode's journal mode.
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>

Probably makes sense but is there any particular reason why you do this?

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
