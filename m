Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37FF053E2F5
	for <lists+linux-ext4@lfdr.de>; Mon,  6 Jun 2022 10:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbiFFHxc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 6 Jun 2022 03:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbiFFHx3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 6 Jun 2022 03:53:29 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD2A12604;
        Mon,  6 Jun 2022 00:53:28 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 744181F8E0;
        Mon,  6 Jun 2022 07:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654502007; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Plp7QO6DjeaVo4L0I7qwxoyinYY3rWjsTv20EHvALNA=;
        b=xkJJo+6x3Rm2AGwodwh5qhNqYiKsw3yz+y7KihrmZJKlRoL41YisBx+ptT1lbRPiXeM56m
        pWqQVj+dtdeQt6E/s0TnWPU23hZ6WJaLeEBGPr+BQsklecjnRx+aYkd2/ab6vw9ZYTWsmO
        IIEeqEdkj9P+kpUrGkAaJZyazy03iCU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654502007;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Plp7QO6DjeaVo4L0I7qwxoyinYY3rWjsTv20EHvALNA=;
        b=gcNFNZIPGg36DWBeCGNRAoxXnHN5xZuR/D0JgX9C5U8A43Sa+2LOuXkvkDiFlhsgSGM3aG
        Br7gxWcKCNw5+4CA==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 640D02C142;
        Mon,  6 Jun 2022 07:53:27 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id D2B02A0633; Mon,  6 Jun 2022 09:53:26 +0200 (CEST)
Date:   Mon, 6 Jun 2022 09:53:26 +0200
From:   Jan Kara <jack@suse.cz>
To:     Xiang wangx <wangxiang@cdjrlc.com>
Cc:     jack@suse.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: Fix syntax errors in comments
Message-ID: <20220606075326.n2ji5jwwz7ch4ycw@quack3.lan>
References: <20220605125509.14837-1-wangxiang@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220605125509.14837-1-wangxiang@cdjrlc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun 05-06-22 20:55:09, Xiang wangx wrote:
> Delete the redundant word 'not'.
> 
> Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>

Thanks! I've added the patch to my tree.

								Honza

> ---
>  fs/ext2/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
> index 360ce3604a2d..e6b932219803 100644
> --- a/fs/ext2/inode.c
> +++ b/fs/ext2/inode.c
> @@ -1549,7 +1549,7 @@ static int __ext2_write_inode(struct inode *inode, int do_sync)
>  	if (IS_ERR(raw_inode))
>   		return -EIO;
>  
> -	/* For fields not not tracking in the in-memory inode,
> +	/* For fields not tracking in the in-memory inode,
>  	 * initialise them to zero for new inodes. */
>  	if (ei->i_state & EXT2_STATE_NEW)
>  		memset(raw_inode, 0, EXT2_SB(sb)->s_inode_size);
> -- 
> 2.36.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
