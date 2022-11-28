Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9B563AA54
	for <lists+linux-ext4@lfdr.de>; Mon, 28 Nov 2022 15:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232243AbiK1ODO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 28 Nov 2022 09:03:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbiK1ODN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 28 Nov 2022 09:03:13 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27896D70;
        Mon, 28 Nov 2022 06:03:12 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DDD08218A0;
        Mon, 28 Nov 2022 14:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669644190; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AL1WVG5HfqpNlnbelrIObveaqnJESSqjRYBF3/PfrEg=;
        b=F2mAfwpjpAu4bLvUwh70UxFA7KsMyNiF+PA6DPR3m9DqaRzKrW9Qt5iEb51Q/ubogQg90x
        D0VxGrdikDN7IDL+XGm2zuz6ACXV4HLMlMQ8eGJnF73fWNAuc4UY25lS/NWvmsAdVjtMk5
        kJPccpq8OP+wIQ3LIJm3lqpJNDUIAqA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669644190;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AL1WVG5HfqpNlnbelrIObveaqnJESSqjRYBF3/PfrEg=;
        b=MF8abJNiuNiTVZvajohZTpCDD42XykNHn6FisPoJgdqY39kTJ+4YEqMNsUfN1FvpeDUs07
        btJ0poC9HVbap3CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D05311326E;
        Mon, 28 Nov 2022 14:03:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id abLNMp6/hGN5GQAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 28 Nov 2022 14:03:10 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 640F2A070F; Mon, 28 Nov 2022 15:03:10 +0100 (CET)
Date:   Mon, 28 Nov 2022 15:03:10 +0100
From:   Jan Kara <jack@suse.cz>
To:     Rong Tao <rtoax@foxmail.com>
Cc:     jack@suse.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rong Tao <rongtao@cestc.cn>
Subject: Re: [PATCH v2] fs/ext2: Fix code indentation
Message-ID: <20221128140310.6qp6jpbklhbbkzwl@quack3>
References: <tencent_79CB512A440B831AA1D42CEF4B729591D707@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_79CB512A440B831AA1D42CEF4B729591D707@qq.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 28-11-22 20:05:49, Rong Tao wrote:
> From: Rong Tao <rongtao@cestc.cn>
> 
> ts=4 can cause misunderstanding in code reading. It is better to replace
> 8 spaces with one tab.
> 
> Signed-off-by: Rong Tao <rongtao@cestc.cn>

Thanks! I've merged the patch to my tree.

								Honza

> ---
> v2: Modify more indentation lines
> v1: https://lore.kernel.org/all/tencent_EEC5C049082D4BF0724AC5E9956BD41E5105@qq.com/
> ---
>  fs/ext2/balloc.c | 12 ++++++------
>  fs/ext2/super.c  |  2 +-
>  2 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/ext2/balloc.c b/fs/ext2/balloc.c
> index 5dc0a31f4a08..eca60b747c6b 100644
> --- a/fs/ext2/balloc.c
> +++ b/fs/ext2/balloc.c
> @@ -667,7 +667,7 @@ ext2_try_to_allocate(struct super_block *sb, int group,
>  {
>  	ext2_fsblk_t group_first_block = ext2_group_first_block_no(sb, group);
>  	ext2_fsblk_t group_last_block = ext2_group_last_block_no(sb, group);
> -       	ext2_grpblk_t start, end;
> +	ext2_grpblk_t start, end;
>  	unsigned long num = 0;
>  
>  	start = 0;
> @@ -1481,11 +1481,11 @@ unsigned long ext2_count_free_blocks (struct super_block * sb)
>  		desc_count, bitmap_count);
>  	return bitmap_count;
>  #else
> -        for (i = 0; i < EXT2_SB(sb)->s_groups_count; i++) {
> -                desc = ext2_get_group_desc (sb, i, NULL);
> -                if (!desc)
> -                        continue;
> -                desc_count += le16_to_cpu(desc->bg_free_blocks_count);
> +	for (i = 0; i < EXT2_SB(sb)->s_groups_count; i++) {
> +		desc = ext2_get_group_desc(sb, i, NULL);
> +		if (!desc)
> +			continue;
> +		desc_count += le16_to_cpu(desc->bg_free_blocks_count);
>  	}
>  	return desc_count;
>  #endif
> diff --git a/fs/ext2/super.c b/fs/ext2/super.c
> index 03f2af98b1b4..69c88facfe90 100644
> --- a/fs/ext2/super.c
> +++ b/fs/ext2/super.c
> @@ -1648,7 +1648,7 @@ static int __init init_ext2_fs(void)
>  	err = init_inodecache();
>  	if (err)
>  		return err;
> -        err = register_filesystem(&ext2_fs_type);
> +	err = register_filesystem(&ext2_fs_type);
>  	if (err)
>  		goto out;
>  	return 0;
> -- 
> 2.38.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
