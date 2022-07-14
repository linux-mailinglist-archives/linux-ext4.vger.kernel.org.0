Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFF2575021
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Jul 2022 15:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239917AbiGNN4X (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 14 Jul 2022 09:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240197AbiGNNzn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 14 Jul 2022 09:55:43 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71253691E6
        for <linux-ext4@vger.kernel.org>; Thu, 14 Jul 2022 06:52:33 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 146691FAB3;
        Thu, 14 Jul 2022 13:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1657806752; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HZeBCCSfbfinkenJK3/a6Cgbl51IpF034A7Oj8/JZfU=;
        b=Ia71PGoqcVvMonuTWErbYeHmd2OXH4Nfm2SKEaSY9b6bdsZSxVIi6cQbNBNMLXGA1Nonmu
        8+184j9PNFaJrRmxX0O7IdYCA1+8t8bCG0AtLaEOkp/wt5EtQVf7tX6E6PnLzNAFg+7PXJ
        BF9FSog6RqtEV8j8PA74+ChTEVtA4uI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1657806752;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HZeBCCSfbfinkenJK3/a6Cgbl51IpF034A7Oj8/JZfU=;
        b=fkeVrjtlym05Pc/98bZ0rh9HRsy3BQ6UOLh4HxgavUIx9gbpq2Y008aNpAlsdJ9sOiC/5/
        oKgQmXJ6lWD5+1Dw==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 051C82C141;
        Thu, 14 Jul 2022 13:52:32 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id A36BAA0659; Thu, 14 Jul 2022 15:52:31 +0200 (CEST)
Date:   Thu, 14 Jul 2022 15:52:31 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Kiselev, Oleg" <okiselev@amazon.com>
Cc:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH 2/2] ext4: avoid resizing to a partial cluster size
Message-ID: <20220714135231.aull3vo44yfa6azg@quack3>
References: <9CDF7393-5645-4E8A-9D68-01CF7F4C4955@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9CDF7393-5645-4E8A-9D68-01CF7F4C4955@amazon.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 30-06-22 02:17:22, Kiselev, Oleg wrote:
> This patch avoids an attempt to resize the filesystem to an
> unaligned cluster boundary.  An online resize to a size that is not
> integral to cluster size results in the last iteration attempting to
> grow the fs by a negative amount, which trips a BUG_ON and leaves the fs
> with a corrupted in-memory superblock.
> 
> Signed-off-by: Oleg Kiselev <okiselev@amazon.com>
> ---
...

> @@ -1624,7 +1624,8 @@ static int ext4_setup_next_flex_gd(struct super_block *sb,
> 
>  	o_blocks_count = ext4_blocks_count(es);
> 
> -	if (o_blocks_count == n_blocks_count)
> +	if ((o_blocks_count == n_blocks_count) ||
> +	    ((n_blocks_count - o_blocks_count) < sbi->s_cluster_ratio))
>  		return 0;

So why do you silently do nothing with unaligned size? I'd expect we should
catch this condition already in ext4_resize_fs() and return EINVAL in that
case...

Also this code does something else than what the commit log says. You
actually check whether there are less than one cluster worth of blocks
instead of checking whether n_blocks_count is properly aligned. Why is that
enough?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
