Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D68A9E2B08
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Oct 2019 09:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407153AbfJXHY6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 24 Oct 2019 03:24:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:52772 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390783AbfJXHY6 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 24 Oct 2019 03:24:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EF08BAEB8;
        Thu, 24 Oct 2019 07:24:56 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 8506E1E4A99; Thu, 24 Oct 2019 09:24:56 +0200 (CEST)
Date:   Thu, 24 Oct 2019 09:24:56 +0200
From:   Jan Kara <jack@suse.cz>
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     jack@suse.com, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext2: return error when fail to allocating memory in
 ioctl
Message-ID: <20191024072456.GH31271@quack2.suse.cz>
References: <20191023135643.28837-1-cgxu519@mykernel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023135643.28837-1-cgxu519@mykernel.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 23-10-19 21:56:43, Chengguang Xu wrote:
> Currently, we do not check memory allocation
> result for ei->i_block_alloc_info in ioctl,
> this patch checks it and returns error in
> failure case.
> 
> Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>

Makes sense. Applied. Thanks!

							Honza

> ---
>  fs/ext2/ioctl.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext2/ioctl.c b/fs/ext2/ioctl.c
> index 1b853fb0b163..32a8d10b579d 100644
> --- a/fs/ext2/ioctl.c
> +++ b/fs/ext2/ioctl.c
> @@ -145,10 +145,13 @@ long ext2_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  		if (ei->i_block_alloc_info){
>  			struct ext2_reserve_window_node *rsv = &ei->i_block_alloc_info->rsv_window_node;
>  			rsv->rsv_goal_size = rsv_window_size;
> +		} else {
> +			ret = -ENOMEM;
>  		}
> +
>  		mutex_unlock(&ei->truncate_mutex);
>  		mnt_drop_write_file(filp);
> -		return 0;
> +		return ret;
>  	}
>  	default:
>  		return -ENOTTY;
> -- 
> 2.21.0
> 
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
