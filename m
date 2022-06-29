Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5218555FD08
	for <lists+linux-ext4@lfdr.de>; Wed, 29 Jun 2022 12:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233289AbiF2KVH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 29 Jun 2022 06:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233285AbiF2KVF (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 29 Jun 2022 06:21:05 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE0042C100
        for <linux-ext4@vger.kernel.org>; Wed, 29 Jun 2022 03:21:04 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 6BE311FEEE;
        Wed, 29 Jun 2022 10:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1656498063; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nG3xrpE0RmxxwQ1BMAgB8wUxT5mGp98YX7TTDxo0Le0=;
        b=yhDqnLwcTZO81b2ZJOqmr2zeP7spglezOo8FFKeWb2/oklijytGkkKZ0cHbvCn6U5BCRHt
        3O93wRD5qn5JdTnmb5uXhsQSx71yD7GOVHUwx5xRvYFljx1ITiPxbe4FVBrKUAAxH6NzBx
        4KZV/X4tmGLOwk3Xdbvn5a2uIwAEBJE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1656498063;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nG3xrpE0RmxxwQ1BMAgB8wUxT5mGp98YX7TTDxo0Le0=;
        b=qnYKwv17jYSvnmwBSrKqtVggo7SFIjkX2vlW/dCmZnKTVPa2N+eBLqyZ17pwEo5wS56k6T
        aAb7SzH7UsxevbDQ==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 595FC2C141;
        Wed, 29 Jun 2022 10:21:03 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 14AACA062F; Wed, 29 Jun 2022 12:21:03 +0200 (CEST)
Date:   Wed, 29 Jun 2022 12:21:03 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, yukuai3@huawei.com
Subject: Re: [PATCH v2 2/2] ext4: check and assert if marking an no_delete
 evicting inode dirty
Message-ID: <20220629102103.y3nmymc26m6qp4jj@quack3>
References: <20220629022940.2855538-1-yi.zhang@huawei.com>
 <20220629022940.2855538-2-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220629022940.2855538-2-yi.zhang@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 29-06-22 10:29:40, Zhang Yi wrote:
> In ext4_evict_inode(), if we evicting an inode in the 'no_delete' path,
> it cannot be raced by another mark_inode_dirty(). If it happens,
> someone else may accidentally dirty it without holding inode refcount
> and probably cause use-after-free issues in the writeback procedure.
> It's indiscoverable and hard to debug, so add an ASSERT to check and
> detect this issue in advance.
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> ---
>  fs/ext4/inode.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 702cc208689a..2ba74412aa89 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -333,6 +333,12 @@ void ext4_evict_inode(struct inode *inode)
>  	ext4_xattr_inode_array_free(ea_inode_array);
>  	return;
>  no_delete:
> +	/*
> +	 * Check out some where else accidentally dirty the evicting inode,
> +	 * which may probably cause inode use-after-free issues later.
> +	 */
> +	ASSERT(list_empty_careful(&inode->i_io_list));

ASSERT() is harsh as it will take the kernel down. Just use WARN_ON_ONCE()
to notify us of the coming problems :).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
