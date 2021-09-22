Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C952041473E
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Sep 2021 13:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235299AbhIVLHM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 22 Sep 2021 07:07:12 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:41966 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234760AbhIVLHM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 22 Sep 2021 07:07:12 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 7BB051FDBF;
        Wed, 22 Sep 2021 11:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1632308741; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b+udigm40KHZJVQTzXlcTfCO7RvsQCctT/JAZ2L6RNM=;
        b=ROuCbz/zASY0C21Iq3JWTpT1lbydws2dxQCYPM8DtBE9We7OqunRsnRDXjFxPtdish+XHX
        /KIfPeUJgm8KB57ToUCToRt4Vl8eRQ/EZW00JGWXg+8AbA6ejsXnaZ3/A1cZ+UPuE2oDo+
        7SXHmpCnU+FUBdeDAQ4lkthiSchJ4FE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1632308741;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b+udigm40KHZJVQTzXlcTfCO7RvsQCctT/JAZ2L6RNM=;
        b=r5VdHn4p6cxnsVKcgZjaLdn4cUJvvnwZU02FqDlS60yAXk+glJZO2atKkEZQfO2CJe13SO
        IcjE/O2OBJFCacCg==
Received: from quack2.suse.cz (unknown [10.163.43.118])
        by relay2.suse.de (Postfix) with ESMTP id 6820FA3B8B;
        Wed, 22 Sep 2021 11:05:41 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 4B54E1E37A2; Wed, 22 Sep 2021 13:05:41 +0200 (CEST)
Date:   Wed, 22 Sep 2021 13:05:41 +0200
From:   Jan Kara <jack@suse.cz>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] ext2: fix sleeping in atomic bugs on error
Message-ID: <20210922110541.GA23575@quack2.suse.cz>
References: <20210921203233.GA16529@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210921203233.GA16529@kili>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 21-09-21 23:32:33, Dan Carpenter wrote:
> The ext2_error() function syncs the filesystem so it sleeps.  The caller
> is holding a spinlock so it's not allowed to sleep.
> 
>    ext2_statfs() <- disables preempt
>    -> ext2_count_free_blocks()
>       -> ext2_get_group_desc()
> 
> Fix this by using WARN() to print an error message and a stack trace
> instead of using ext2_error().
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Thanks! I've added the patch to my tree.

								Honza

> ---
> v2: The first version disabled the sync in ext2_error()
> 
>  fs/ext2/balloc.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/ext2/balloc.c b/fs/ext2/balloc.c
> index 1f3f4326bf3c..c17ccc19b938 100644
> --- a/fs/ext2/balloc.c
> +++ b/fs/ext2/balloc.c
> @@ -48,10 +48,9 @@ struct ext2_group_desc * ext2_get_group_desc(struct super_block * sb,
>  	struct ext2_sb_info *sbi = EXT2_SB(sb);
>  
>  	if (block_group >= sbi->s_groups_count) {
> -		ext2_error (sb, "ext2_get_group_desc",
> -			    "block_group >= groups_count - "
> -			    "block_group = %d, groups_count = %lu",
> -			    block_group, sbi->s_groups_count);
> +		WARN(1, "block_group >= groups_count - "
> +		     "block_group = %d, groups_count = %lu",
> +		     block_group, sbi->s_groups_count);
>  
>  		return NULL;
>  	}
> @@ -59,10 +58,9 @@ struct ext2_group_desc * ext2_get_group_desc(struct super_block * sb,
>  	group_desc = block_group >> EXT2_DESC_PER_BLOCK_BITS(sb);
>  	offset = block_group & (EXT2_DESC_PER_BLOCK(sb) - 1);
>  	if (!sbi->s_group_desc[group_desc]) {
> -		ext2_error (sb, "ext2_get_group_desc",
> -			    "Group descriptor not loaded - "
> -			    "block_group = %d, group_desc = %lu, desc = %lu",
> -			     block_group, group_desc, offset);
> +		WARN(1, "Group descriptor not loaded - "
> +		     "block_group = %d, group_desc = %lu, desc = %lu",
> +		      block_group, group_desc, offset);
>  		return NULL;
>  	}
>  
> -- 
> 2.20.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
