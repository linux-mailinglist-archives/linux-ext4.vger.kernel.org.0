Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE0B04F6969
	for <lists+linux-ext4@lfdr.de>; Wed,  6 Apr 2022 20:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbiDFSrR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 6 Apr 2022 14:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiDFSpL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 6 Apr 2022 14:45:11 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2EFB25496A
        for <linux-ext4@vger.kernel.org>; Wed,  6 Apr 2022 10:17:17 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 772741F858;
        Wed,  6 Apr 2022 17:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649265436; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HKuBPiX8aNrG+G1JnAzE78OK8ra/uCqa7p54WFa69xI=;
        b=aaoEnnTJU09Npcmm3LWiV8yRuGjWbJhAsIUfK6xjYd2faopb/BNsIA+xFf7mTrlptjHdEz
        lTrR0xLUtRWltDjZHEuWJovC01eQXyKLku4CzAaf2sJH/wXp40lPNWMgSzln7qXUpZplEL
        zpBGtNBjotda+g8ZComxa1mLoLNqq7c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649265436;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HKuBPiX8aNrG+G1JnAzE78OK8ra/uCqa7p54WFa69xI=;
        b=uq8W//2HUDvJEFQoqjJLoLdczOmUFJTm6p7wXSv4GUWecG6o4XzBAzK+D7K0HMYdCdBdpz
        qmBwUtL32iN2+9DA==
Received: from quack3.suse.cz (unknown [10.163.43.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 33F20A3B89;
        Wed,  6 Apr 2022 17:17:16 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id A8817A061D; Wed,  6 Apr 2022 19:17:15 +0200 (CEST)
Date:   Wed, 6 Apr 2022 19:17:15 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, yukuai3@huawei.com,
        yebin10@huawei.com
Subject: Re: [RFC PATCH] ext4: convert symlink external data block mapping to
 bdev
Message-ID: <20220406171715.35euuzocoe4ljepe@quack3.lan>
References: <20220406084503.1961686-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220406084503.1961686-1-yi.zhang@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 06-04-22 16:45:03, Zhang Yi wrote:
> Symlink's external data block is one kind of metadata block, and now
> that almost all ext4 metadata block's page cache (e.g. directory blocks,
> quota blocks...) belongs to bdev backing inode except the symlink. It
> is essentially worked in data=journal mode like other regular file's
> data block because probably in order to make it simple for generic VFS
> code handling symlinks or some other historical reasons, but the logic
> of creating external data block in ext4_symlink() is complicated. and it
> also make things confused if user do not want to let the filesystem
> worked in data=journal mode. This patch convert the final exceptional
> case and make things clean, move the mapping of the symlink's external
> data block to bdev like any other metadata block does.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> ---
> This RFC patch follow the talking of whether if we could unify the
> journal mode of ext4 metadata blocks[1], it stop using the data=journal
> mode for the final exception case of symlink's external data block. Any
> comments are welcome, thanks.
> 
> [1]. https://lore.kernel.org/linux-ext4/20220321151141.hypnhr6o4vng2sa6@quack3.lan/T/#m84b942a6bb838ba60ae8afd906ebbb987a577488
> 
>  fs/ext4/inode.c   |   9 +---
>  fs/ext4/namei.c   | 123 +++++++++++++++++++++-------------------------
>  fs/ext4/symlink.c |  44 ++++++++++++++---
>  3 files changed, 93 insertions(+), 83 deletions(-)

Hum, we don't save on code but I'd say the result is somewhat more
standard. So I guess this makes some sense. Let's see what Ted thinks...

Otherwise I've found just one small bug below.

> @@ -3270,26 +3296,8 @@ static int ext4_symlink(struct user_namespace *mnt_userns, struct inode *dir,
>  	if (err)
>  		return err;
>  
> -	if ((disk_link.len > EXT4_N_BLOCKS * 4)) {
> -		/*
> -		 * For non-fast symlinks, we just allocate inode and put it on
> -		 * orphan list in the first transaction => we need bitmap,
> -		 * group descriptor, sb, inode block, quota blocks, and
> -		 * possibly selinux xattr blocks.
> -		 */
> -		credits = 4 + EXT4_MAXQUOTAS_INIT_BLOCKS(dir->i_sb) +
> -			  EXT4_XATTR_TRANS_BLOCKS;
> -	} else {
> -		/*
> -		 * Fast symlink. We have to add entry to directory
> -		 * (EXT4_DATA_TRANS_BLOCKS + EXT4_INDEX_EXTRA_TRANS_BLOCKS),
> -		 * allocate new inode (bitmap, group descriptor, inode block,
> -		 * quota blocks, sb is already counted in previous macros).
> -		 */
> -		credits = EXT4_DATA_TRANS_BLOCKS(dir->i_sb) +
> -			  EXT4_INDEX_EXTRA_TRANS_BLOCKS + 3;
> -	}
> -
> +	credits = EXT4_DATA_TRANS_BLOCKS(dir->i_sb) +
> +		  EXT4_INDEX_EXTRA_TRANS_BLOCKS + 3;

This does not seem like enough credits - we may need to allocate inode, add
entry to directory, allocate & initialize symlink block. So I think you
need to add 4 for block allocation + init in case of non-fast symlink. And
please keep the comment explaining what is actually counted in the number
of credits...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
