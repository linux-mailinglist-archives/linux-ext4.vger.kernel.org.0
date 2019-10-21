Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94DD2DE7CC
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Oct 2019 11:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbfJUJSC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 21 Oct 2019 05:18:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:48712 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726725AbfJUJSC (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 21 Oct 2019 05:18:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 201F1B732;
        Mon, 21 Oct 2019 09:18:01 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 676431E4AA0; Mon, 21 Oct 2019 11:18:00 +0200 (CEST)
Date:   Mon, 21 Oct 2019 11:18:00 +0200
From:   Jan Kara <jack@suse.cz>
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     jack@suse.com, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext2: adjust block num when retry allocation
Message-ID: <20191021091800.GC17810@quack2.suse.cz>
References: <20191020232326.84881-1-cgxu519@mykernel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191020232326.84881-1-cgxu519@mykernel.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 21-10-19 07:23:26, Chengguang Xu wrote:
> Set block num to original *count in a case
> of retrying allocation in case num < *count
> 
> Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
> ---
> Hi Jan,
> 
> This patch is only compile-tested, I'm not sure if this
> kind of unexpected condition which causes reallocation
> will actually happen but baesd on the code the fix seems
> correct and better.

Yeah, you are right that we should reset 'num' back to *count. Although the
practial effect of this is minimal - we take this code path only when the
filesystem is corrupted. But still... Patch applied. Thanks!

								Honza
> 
>  fs/ext2/balloc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/ext2/balloc.c b/fs/ext2/balloc.c
> index e0cc55164505..924c1c765306 100644
> --- a/fs/ext2/balloc.c
> +++ b/fs/ext2/balloc.c
> @@ -1404,6 +1404,7 @@ ext2_fsblk_t ext2_new_blocks(struct inode *inode, ext2_fsblk_t goal,
>  		 * use.  So we may want to selectively mark some of the blocks
>  		 * as free
>  		 */
> +		num = *count;
>  		goto retry_alloc;
>  	}
>  
> -- 
> 2.21.0
> 
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
