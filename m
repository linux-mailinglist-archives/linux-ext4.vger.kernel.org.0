Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0911D52E8D7
	for <lists+linux-ext4@lfdr.de>; Fri, 20 May 2022 11:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347732AbiETJbV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 20 May 2022 05:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237460AbiETJbM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 20 May 2022 05:31:12 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F232B1145A
        for <linux-ext4@vger.kernel.org>; Fri, 20 May 2022 02:31:08 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id AECBF21C13;
        Fri, 20 May 2022 09:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1653039067; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PdFyBA1Zm4T2/g9BpeXMqAcMuawZCO06hiwFM2zcvyM=;
        b=VjgQvdXLrneqHqhcCXFx++ay1gcNkWzx9N+ZiOyl6x1VN8884MT94KEa7J1AWYpMi+NGjJ
        fKb3Pm3rYpqvVL2BqCPPPFKTl+dphWg/a5crhz+R2UMR9Cw/yaopF1It2UhY4UaVdlyAAa
        4eDpimfv55KYux0s66zLCYCusheXBuo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1653039067;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PdFyBA1Zm4T2/g9BpeXMqAcMuawZCO06hiwFM2zcvyM=;
        b=W8R3IHq0VJvtb5DbL8xLBEYY4yIfUYvcsfs18a+0u0NbdxZU0bEoxDlTW1nTKVWUgS3TrP
        5HwGLKVfa898EQAA==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 827DB2C141;
        Fri, 20 May 2022 09:31:07 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id D32ADA0634; Fri, 20 May 2022 11:31:05 +0200 (CEST)
Date:   Fri, 20 May 2022 11:31:05 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
        yukuai3@huawei.com
Subject: Re: [PATCH v2] ext4: fix warning when submitting superblock in
 ext4_commit_super()
Message-ID: <20220520093105.qlvrp3pyy7egdjce@quack3>
References: <20220520023216.3065073-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520023216.3065073-1-yi.zhang@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 20-05-22 10:32:16, Zhang Yi wrote:
> We have already check the io_error and uptodate flag before submitting
> the superblock buffer, and re-set the uptodate flag if it has been
> failed to write out. But it was lockless and could be raced by another
> ext4_commit_super(), and finally trigger '!uptodate' WARNING when
> marking buffer dirty. Fix it by submit buffer directly.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> v2->v1:
>  - Add clear_buffer_dirty() before submit_bh().
> 
>  fs/ext4/super.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 1466fbdbc8e3..9f6892665be4 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -6002,7 +6002,6 @@ static void ext4_update_super(struct super_block *sb)
>  static int ext4_commit_super(struct super_block *sb)
>  {
>  	struct buffer_head *sbh = EXT4_SB(sb)->s_sbh;
> -	int error = 0;
>  
>  	if (!sbh)
>  		return -EINVAL;
> @@ -6011,6 +6010,13 @@ static int ext4_commit_super(struct super_block *sb)
>  
>  	ext4_update_super(sb);
>  
> +	lock_buffer(sbh);
> +	/* Buffer got discarded which means block device got invalidated */
> +	if (!buffer_mapped(sbh)) {
> +		unlock_buffer(sbh);
> +		return -EIO;
> +	}
> +
>  	if (buffer_write_io_error(sbh) || !buffer_uptodate(sbh)) {
>  		/*
>  		 * Oh, dear.  A previous attempt to write the
> @@ -6025,17 +6031,21 @@ static int ext4_commit_super(struct super_block *sb)
>  		clear_buffer_write_io_error(sbh);
>  		set_buffer_uptodate(sbh);
>  	}
> -	BUFFER_TRACE(sbh, "marking dirty");
> -	mark_buffer_dirty(sbh);
> -	error = __sync_dirty_buffer(sbh,
> -		REQ_SYNC | (test_opt(sb, BARRIER) ? REQ_FUA : 0));
> +	get_bh(sbh);
> +	/* Clear potential dirty bit if it was journalled update */
> +	clear_buffer_dirty(sbh);
> +	sbh->b_end_io = end_buffer_write_sync;
> +	submit_bh(REQ_OP_WRITE,
> +		  REQ_SYNC | (test_opt(sb, BARRIER) ? REQ_FUA : 0), sbh);
> +	wait_on_buffer(sbh);
>  	if (buffer_write_io_error(sbh)) {
>  		ext4_msg(sb, KERN_ERR, "I/O error while writing "
>  		       "superblock");
>  		clear_buffer_write_io_error(sbh);
>  		set_buffer_uptodate(sbh);
> +		return -EIO;
>  	}
> -	return error;
> +	return 0;
>  }
>  
>  /*
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
