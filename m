Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD50472D2F
	for <lists+linux-ext4@lfdr.de>; Mon, 13 Dec 2021 14:25:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237416AbhLMNZG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 13 Dec 2021 08:25:06 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:37066 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233368AbhLMNZG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 13 Dec 2021 08:25:06 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id BCEC72111A;
        Mon, 13 Dec 2021 13:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1639401904; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z08bvynEOqmSRcFo2go9b5d9kJ4T48wKCSB2KtdhCEI=;
        b=Mantq8urHQw3eG27JceCzgVXS7SuAgGljOzezVccgKc0vcTnILc2KLgO84XqgwbetD6KuP
        /fmnJBcKFBKjro0N8Vt+rVGMNplKH7R4Twt19paoVL0s8qWxLrgNTMl9qCLAejjOPClrAQ
        oRXtlTFJ2tJIMNbgch+xODif4WmQrkA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1639401904;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z08bvynEOqmSRcFo2go9b5d9kJ4T48wKCSB2KtdhCEI=;
        b=3jUY6JTIX5acd6f2yxkuHjX8g6Uz2SKw8HKy7KHY0FoL5WHKYsUTxT+Wb0u8tvkWYPwfPt
        VKe6sSowURjTBCDQ==
Received: from quack2.suse.cz (unknown [10.163.28.18])
        by relay2.suse.de (Postfix) with ESMTP id AB462A3B8B;
        Mon, 13 Dec 2021 13:25:04 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 17B591E11F3; Mon, 13 Dec 2021 14:24:59 +0100 (CET)
Date:   Mon, 13 Dec 2021 14:24:59 +0100
From:   Jan Kara <jack@suse.cz>
To:     Guo Zhengkui <guozhengkui@vivo.com>
Cc:     Jan Kara <jack@suse.com>,
        "open list:EXT2 FILE SYSTEM" <linux-ext4@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, kernel@vivo.com
Subject: Re: [PATCH] fs: ext2: remove duplicate includes
Message-ID: <20211213132459.GA14044@quack2.suse.cz>
References: <20211207085525.4390-1-guozhengkui@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211207085525.4390-1-guozhengkui@vivo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 07-12-21 16:55:24, Guo Zhengkui wrote:
> remove a duplicate "#include <linux/dax.h>"
> 
> Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>

Thanks for the patch. Which kernel is it based on? Because I don't see the
duplicate line in my tree...

								Honza

> ---
>  fs/ext2/inode.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
> index 602578b72d8c..da4c301b4305 100644
> --- a/fs/ext2/inode.c
> +++ b/fs/ext2/inode.c
> @@ -29,21 +29,20 @@
>  #include <linux/dax.h>
>  #include <linux/blkdev.h>
>  #include <linux/quotaops.h>
>  #include <linux/writeback.h>
>  #include <linux/buffer_head.h>
>  #include <linux/mpage.h>
>  #include <linux/fiemap.h>
>  #include <linux/iomap.h>
>  #include <linux/namei.h>
>  #include <linux/uio.h>
> -#include <linux/dax.h>
>  #include "ext2.h"
>  #include "acl.h"
>  #include "xattr.h"
>  
>  static int __ext2_write_inode(struct inode *inode, int do_sync);
>  
>  /*
>   * Test whether an inode is a fast symlink.
>   */
>  static inline int ext2_inode_is_fast_symlink(struct inode *inode)
> -- 
> 2.20.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
