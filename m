Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE7DCEF9C1
	for <lists+linux-ext4@lfdr.de>; Tue,  5 Nov 2019 10:42:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730804AbfKEJl4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 5 Nov 2019 04:41:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:44780 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730666AbfKEJl4 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 5 Nov 2019 04:41:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3B615B33E;
        Tue,  5 Nov 2019 09:41:54 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 300981E4407; Tue,  5 Nov 2019 10:41:54 +0100 (CET)
Date:   Tue, 5 Nov 2019 10:41:54 +0100
From:   Jan Kara <jack@suse.cz>
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     jack@suse.com, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext2: check err when partial != NULL
Message-ID: <20191105094154.GK22379@quack2.suse.cz>
References: <20191105045100.7104-1-cgxu519@mykernel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191105045100.7104-1-cgxu519@mykernel.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 05-11-19 12:51:00, Chengguang Xu wrote:
> Check err when partial == NULL is meaningless because
> partial == NULL means getting branch successfully without
> error.
> 
> Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>

Good catch! Added to my tree. Thanks!

							Honza

> ---
>  fs/ext2/inode.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
> index 7004ce581a32..a16c53655e77 100644
> --- a/fs/ext2/inode.c
> +++ b/fs/ext2/inode.c
> @@ -701,10 +701,13 @@ static int ext2_get_blocks(struct inode *inode,
>  		if (!partial) {
>  			count++;
>  			mutex_unlock(&ei->truncate_mutex);
> -			if (err)
> -				goto cleanup;
>  			goto got_it;
>  		}
> +
> +		if (err) {
> +			mutex_unlock(&ei->truncate_mutex);
> +			goto cleanup;
> +		}
>  	}
>  
>  	/*
> -- 
> 2.20.1
> 
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
