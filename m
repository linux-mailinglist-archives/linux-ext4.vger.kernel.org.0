Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00A60745C72
	for <lists+linux-ext4@lfdr.de>; Mon,  3 Jul 2023 14:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjGCMpR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 3 Jul 2023 08:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjGCMpP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 3 Jul 2023 08:45:15 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF67AF;
        Mon,  3 Jul 2023 05:45:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3F7611FE17;
        Mon,  3 Jul 2023 12:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688388313; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yZvZo8t8kqg19TzST1EWLf37n+7Zsw7JmHWTtGgRj04=;
        b=RgcCqYZzXb2jktjoHZIXsZzzrDAKDxG7crduxeBoVXKAy7qfT9VdKbvBXAZH4b5iIpyQ9D
        Re+bp18GWmVqRR3snCjKcZDcpNcVMHwY4CDNPwFkyLQOhRoea8JjbjIbv2ntxl8vXJxzKs
        Wd8JWNhAECiINJ4G6+vShLBP4WA7T9U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688388313;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yZvZo8t8kqg19TzST1EWLf37n+7Zsw7JmHWTtGgRj04=;
        b=aMFx6uJ4mlGVvSJtBLxeylXXaT7QiVyGJ4HSAt7Xb0uJ+ODm76QBGC773swo0LflYEfbOT
        hp3pzeWzKdn9m5Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F0CA7138FC;
        Mon,  3 Jul 2023 12:45:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2RG+OtjComQUAgAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 03 Jul 2023 12:45:12 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 225D7A0722; Mon,  3 Jul 2023 14:45:12 +0200 (CEST)
Date:   Mon, 3 Jul 2023 14:45:12 +0200
From:   Jan Kara <jack@suse.cz>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next][V2] ext2: remove redundant assignment to variable
 desc and variable best_desc
Message-ID: <20230703124512.b7ho5ktvjnmifqo2@quack3>
References: <20230630165458.166238-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230630165458.166238-1-colin.i.king@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 30-06-23 17:54:58, Colin Ian King wrote:
> Variable desc is being assigned a value that is never read, the exit
> via label found immeditely returns with no access to desc. The
> assignment is redundant and can be removed. Also remove variable best_desc
> since this is not used. Cleans up clang scan muild warning:
> 
> fs/ext2/ialloc.c:297:4: warning: Value stored to 'desc' is never
> read [deadcode.DeadStores]
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Thanks, I've added the patch to my tree.

								Honza

> ---
> 
> V2: Also remove best_desc. Kudos to Dan Carpenter for spottin this extra
>     janitorial cleanup.
> 
> ---
>  fs/ext2/ialloc.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/fs/ext2/ialloc.c b/fs/ext2/ialloc.c
> index a4e1d7a9c544..34cd5dc1da23 100644
> --- a/fs/ext2/ialloc.c
> +++ b/fs/ext2/ialloc.c
> @@ -273,7 +273,6 @@ static int find_group_orlov(struct super_block *sb, struct inode *parent)
>  
>  	if ((parent == d_inode(sb->s_root)) ||
>  	    (EXT2_I(parent)->i_flags & EXT2_TOPDIR_FL)) {
> -		struct ext2_group_desc *best_desc = NULL;
>  		int best_ndir = inodes_per_group;
>  		int best_group = -1;
>  
> @@ -291,10 +290,8 @@ static int find_group_orlov(struct super_block *sb, struct inode *parent)
>  				continue;
>  			best_group = group;
>  			best_ndir = le16_to_cpu(desc->bg_used_dirs_count);
> -			best_desc = desc;
>  		}
>  		if (best_group >= 0) {
> -			desc = best_desc;
>  			group = best_group;
>  			goto found;
>  		}
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
