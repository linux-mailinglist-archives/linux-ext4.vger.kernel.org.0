Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53042425501
	for <lists+linux-ext4@lfdr.de>; Thu,  7 Oct 2021 16:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241910AbhJGOIg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 7 Oct 2021 10:08:36 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:55786 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240542AbhJGOIf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 7 Oct 2021 10:08:35 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0A09422536;
        Thu,  7 Oct 2021 14:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633615601; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Xka3Ua8GP8dwpZVcT+jCR5YGpMzAvZ9aMTAX/ErpUZs=;
        b=hw3U+6Xwd56vOSZN6W22mge/JpjzKqf/YAYWubamVh6NwMP2LawE8jDeFf4kj+mF6L7fT5
        /2q3mo/J1gY4aJBOe72NuN88JmoHiAp/Iggxb+EWsOssYCprIkgsxKrVFUbHmVFsefrvwF
        4Ug2Tct0IQoBbO6sU0npabl8Dq6nfW0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633615601;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Xka3Ua8GP8dwpZVcT+jCR5YGpMzAvZ9aMTAX/ErpUZs=;
        b=bJHonUxGlYgQaI/vYqrrLwLs7fLB23cTO2UGXojcwD70xA0olKouIvYPHv1uLdPgU0g5kH
        BX+zPyXRlkoN6LAw==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 9C5A7A3B81;
        Thu,  7 Oct 2021 14:06:40 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 621641F2C96; Thu,  7 Oct 2021 16:06:40 +0200 (CEST)
Date:   Thu, 7 Oct 2021 16:06:40 +0200
From:   Jan Kara <jack@suse.cz>
To:     Chenyuan Mi <cymi20@fudan.edu.cn>
Cc:     yuanxzhang@fudan.edu.cn, Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: Fix handle refcount leak in ext4_write_begin()
Message-ID: <20211007140640.GA2670@quack2.suse.cz>
References: <20210908070640.7135-1-cymi20@fudan.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210908070640.7135-1-cymi20@fudan.edu.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 08-09-21 15:06:40, Chenyuan Mi wrote:
> The reference counting issue happens when ret is zero,
> the function forgets to decrease the refcount of handle
> increased by ext4_journal_start().
> 
> Fix this issue by using ext4_journal_stop() to decrease
> the refcount of handle.
> 
> Signed-off-by: Chenyuan Mi <cymi20@fudan.edu.cn>
> Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
> Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>

Yes, but that is deliberate. We want to keep the transaction running until
the write is done - i.e., until ->write_end() callback where we call
ext4_journal_stop(). As a side note, please test your patches. You clearly
didn't test this patch because if you did, you would notice that your patch
breaks writing to ext4.

                                                                Honza

> ---
>  fs/ext4/inode.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index d18852d6029c..90c57d8e3de1 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -1249,6 +1249,7 @@ static int ext4_write_begin(struct file *file, struct address_space *mapping,
>  		put_page(page);
>  		return ret;
>  	}
> +	ext4_journal_stop(handle);
>  	*pagep = page;
>  	return ret;
>  }
> -- 
> 2.17.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
