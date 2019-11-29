Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8427F10D372
	for <lists+linux-ext4@lfdr.de>; Fri, 29 Nov 2019 10:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbfK2Jsy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 29 Nov 2019 04:48:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:53794 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725892AbfK2Jsy (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 29 Nov 2019 04:48:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 184FDAB7F;
        Fri, 29 Nov 2019 09:48:53 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id A56C51E0B63; Fri, 29 Nov 2019 10:48:52 +0100 (CET)
Date:   Fri, 29 Nov 2019 10:48:52 +0100
From:   Jan Kara <jack@suse.cz>
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     jack@suse.com, linux-ext4@vger.kernel.org
Subject: Re: [Resend PATCH] ext2: set proper errno in error case of
 ext2_fill_super()
Message-ID: <20191129094852.GA1121@quack2.suse.cz>
References: <20191129013636.7624-1-cgxu519@mykernel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191129013636.7624-1-cgxu519@mykernel.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 29-11-19 09:36:36, Chengguang Xu wrote:
> Set proper errno in the case of failure of
> initializing percpu variables.
> 
> Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>

Thanks. I've added the patch to my tree.

								Honza

> ---
> Forgot to cc ext4 maillist, so resend it.
> 
>  fs/ext2/super.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/ext2/super.c b/fs/ext2/super.c
> index 30c630d73f0f..74a9e3e71c13 100644
> --- a/fs/ext2/super.c
> +++ b/fs/ext2/super.c
> @@ -1147,6 +1147,7 @@ static int ext2_fill_super(struct super_block *sb, void *data, int silent)
>  				ext2_count_dirs(sb), GFP_KERNEL);
>  	}
>  	if (err) {
> +		ret = err;
>  		ext2_msg(sb, KERN_ERR, "error: insufficient memory");
>  		goto failed_mount3;
>  	}
> -- 
> 2.20.1
> 
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
