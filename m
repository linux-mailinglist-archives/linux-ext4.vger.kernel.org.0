Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E52CB3E02B7
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Aug 2021 16:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238477AbhHDOGY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 4 Aug 2021 10:06:24 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:48934 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237979AbhHDOGX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 4 Aug 2021 10:06:23 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 47AF420143;
        Wed,  4 Aug 2021 14:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628085970; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tzr6CcVcxQ4M0p4KnYKpLMG7rXzzmshzIZI/+DXMCH0=;
        b=D/vUzQDVPNLmg00YzT/BO9mLp1AE9VuI7R8HMeEjLO7qnARwEzTbXZoEF9Lm083QeNE4vf
        kwjQLQvQFnftgRb7vklHnAncR3DtXLecPlOh8wwdJNHWA9/ms6C+qiA89/XnAcQa6Gn+OM
        6xFg06EpWkGsitkLnovIAJSGwEVGqAY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628085970;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tzr6CcVcxQ4M0p4KnYKpLMG7rXzzmshzIZI/+DXMCH0=;
        b=Y+G5DfX5Bv8N9PU4vLxJccmM0K4Le1ObVzXHnR9/xWFI/G3BruPQQ4qQ4bPLwbqqlrdiQe
        iOfQP3tWRnmwr3DQ==
Received: from quack2.suse.cz (unknown [10.163.43.118])
        by relay2.suse.de (Postfix) with ESMTP id E83F6A3B8C;
        Wed,  4 Aug 2021 14:06:09 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 5678D1E62D6; Wed,  4 Aug 2021 16:06:04 +0200 (CEST)
Date:   Wed, 4 Aug 2021 16:06:04 +0200
From:   Jan Kara <jack@suse.cz>
To:     Xiyu Yang <xiyuyang19@fudan.edu.cn>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        yuanxzhang@fudan.edu.cn, Xin Tan <tanxin.ctf@gmail.com>
Subject: Re: [PATCH] ext4: Convert from atomic_t to refcount_t on
 ext4_io_end->count
Message-ID: <20210804140604.GF4578@quack2.suse.cz>
References: <1626674355-55795-1-git-send-email-xiyuyang19@fudan.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1626674355-55795-1-git-send-email-xiyuyang19@fudan.edu.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 19-07-21 13:59:14, Xiyu Yang wrote:
> refcount_t type and corresponding API can protect refcounters from
> accidental underflow and overflow and further use-after-free situations.
> 
> Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
> Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/ext4.h    | 3 ++-
>  fs/ext4/page-io.c | 8 ++++----
>  2 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 3c51e243450d..e5b3575da7e9 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -17,6 +17,7 @@
>  #ifndef _EXT4_H
>  #define _EXT4_H
>  
> +#include <linux/refcount.h>
>  #include <linux/types.h>
>  #include <linux/blkdev.h>
>  #include <linux/magic.h>
> @@ -241,7 +242,7 @@ typedef struct ext4_io_end {
>  	struct bio		*bio;		/* Linked list of completed
>  						 * bios covering the extent */
>  	unsigned int		flag;		/* unwritten or not */
> -	atomic_t		count;		/* reference counter */
> +	refcount_t		count;		/* reference counter */
>  	struct list_head	list_vec;	/* list of ext4_io_end_vec */
>  } ext4_io_end_t;
>  
> diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
> index f038d578d8d8..9cb261714991 100644
> --- a/fs/ext4/page-io.c
> +++ b/fs/ext4/page-io.c
> @@ -279,14 +279,14 @@ ext4_io_end_t *ext4_init_io_end(struct inode *inode, gfp_t flags)
>  		io_end->inode = inode;
>  		INIT_LIST_HEAD(&io_end->list);
>  		INIT_LIST_HEAD(&io_end->list_vec);
> -		atomic_set(&io_end->count, 1);
> +		refcount_set(&io_end->count, 1);
>  	}
>  	return io_end;
>  }
>  
>  void ext4_put_io_end_defer(ext4_io_end_t *io_end)
>  {
> -	if (atomic_dec_and_test(&io_end->count)) {
> +	if (refcount_dec_and_test(&io_end->count)) {
>  		if (!(io_end->flag & EXT4_IO_END_UNWRITTEN) ||
>  				list_empty(&io_end->list_vec)) {
>  			ext4_release_io_end(io_end);
> @@ -300,7 +300,7 @@ int ext4_put_io_end(ext4_io_end_t *io_end)
>  {
>  	int err = 0;
>  
> -	if (atomic_dec_and_test(&io_end->count)) {
> +	if (refcount_dec_and_test(&io_end->count)) {
>  		if (io_end->flag & EXT4_IO_END_UNWRITTEN) {
>  			err = ext4_convert_unwritten_io_end_vec(io_end->handle,
>  								io_end);
> @@ -314,7 +314,7 @@ int ext4_put_io_end(ext4_io_end_t *io_end)
>  
>  ext4_io_end_t *ext4_get_io_end(ext4_io_end_t *io_end)
>  {
> -	atomic_inc(&io_end->count);
> +	refcount_inc(&io_end->count);
>  	return io_end;
>  }
>  
> -- 
> 2.7.4
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
