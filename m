Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCA93560047
	for <lists+linux-ext4@lfdr.de>; Wed, 29 Jun 2022 14:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbiF2Mk5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 29 Jun 2022 08:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbiF2Mk4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 29 Jun 2022 08:40:56 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7EF32062
        for <linux-ext4@vger.kernel.org>; Wed, 29 Jun 2022 05:40:55 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 366D821FAE;
        Wed, 29 Jun 2022 12:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1656506454; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1o69SsiRwr4iph4t5IfeSWdyIv9lAvX0szOXrf0Mg/Q=;
        b=nFrOXIo4siWSLjiaSXhI8BSfPVKluvjsMy1BTnwNtlq8MuuX4POCUNrVbvfbeobFkeN/MR
        yCOLPe3gTfpRO1lwusrehqGiELJK7kmOC4zN/TLWbKdt+8Ak9+QZfsJ6+Lj1c5GD9PYFet
        cc8b8K0Osg5GSpg9GO1KFEKYp6TBSvI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1656506454;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1o69SsiRwr4iph4t5IfeSWdyIv9lAvX0szOXrf0Mg/Q=;
        b=kywNiBEz08+9PAJ0ZO+X7G7sreLJjnyXYELJyWhOzkTIoura8UqI2vphZAECZvpOfqk3xP
        AktCm/pfeO+XNGBQ==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E51132C141;
        Wed, 29 Jun 2022 12:40:53 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 2133FA062F; Wed, 29 Jun 2022 14:40:51 +0200 (CEST)
Date:   Wed, 29 Jun 2022 14:40:51 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, yukuai3@huawei.com
Subject: Re: [PATCH v3 2/2] ext4: check and assert if marking an no_delete
 evicting inode dirty
Message-ID: <20220629124051.qpc2voxvzbyhir3y@quack3.lan>
References: <20220629112647.4141034-1-yi.zhang@huawei.com>
 <20220629112647.4141034-2-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220629112647.4141034-2-yi.zhang@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 29-06-22 19:26:47, Zhang Yi wrote:
> In ext4_evict_inode(), if we evicting an inode in the 'no_delete' path,
> it cannot be raced by another mark_inode_dirty(). If it happens,
> someone else may accidentally dirty it without holding inode refcount
> and probably cause use-after-free issues in the writeback procedure.
> It's indiscoverable and hard to debug, so add an WARN_ON_ONCE() to
> check and detect this issue in advance.
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> ---
> v2->v3:
>  - Switch to use WARN_ON_ONCE instead of ASSERT.

Thanks! Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> 
>  fs/ext4/inode.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 702cc208689a..902393373152 100644
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
> +	WARN_ON_ONCE(!list_empty_careful(&inode->i_io_list));
> +
>  	if (!list_empty(&EXT4_I(inode)->i_fc_list))
>  		ext4_fc_mark_ineligible(inode->i_sb, EXT4_FC_REASON_NOMEM, NULL);
>  	ext4_clear_inode(inode);	/* We must guarantee clearing of inode... */
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
