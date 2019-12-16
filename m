Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 889BB1200EC
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Dec 2019 10:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbfLPJWZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 16 Dec 2019 04:22:25 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7248 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727035AbfLPJWZ (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 16 Dec 2019 04:22:25 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C912240E73482E47C8B;
        Mon, 16 Dec 2019 17:22:22 +0800 (CST)
Received: from [10.177.249.225] (10.177.249.225) by smtp.huawei.com
 (10.3.19.207) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 16 Dec
 2019 17:22:17 +0800
Reply-To: <miaoxie@huawei.com>
Subject: Re: [PATCH] ext4: unlock on error in ext4_expand_extra_isize()
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Theodore Ts'o <tytso@mit.edu>
CC:     Andreas Dilger <adilger.kernel@dilger.ca>,
        <linux-ext4@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
References: <20191213185010.6k7yl2tck3wlsdkt@kili.mountain>
From:   Miao Xie <miaoxie@huawei.com>
Organization: Huawei Technologies Co., LTD.
Message-ID: <5b8569d5-9fbe-0bcf-8fcc-852ded7cd672@huawei.com>
Date:   Mon, 16 Dec 2019 17:22:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20191213185010.6k7yl2tck3wlsdkt@kili.mountain>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.249.225]
X-CFilter-Loop: Reflected
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi, Dan Carpenter

I forgot to reply your mail because I'm busy recently. Sorry.
Thanks for your fix.

Regards
Miao

on 2019/12/14 at 2:50, Dan Carpenter wrote:
> We need to unlock the xattr before returning on this error path.
> 
> Fixes: c03b45b853f5 ("ext4, project: expand inode extra size if possible")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  fs/ext4/inode.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 28f28de0c1b6..629a25d999f0 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -5692,7 +5692,7 @@ int ext4_expand_extra_isize(struct inode *inode,
>  	error = ext4_journal_get_write_access(handle, iloc->bh);
>  	if (error) {
>  		brelse(iloc->bh);
> -		goto out_stop;
> +		goto out_unlock;
>  	}
>  
>  	error = __ext4_expand_extra_isize(inode, new_extra_isize, iloc,
> @@ -5702,8 +5702,8 @@ int ext4_expand_extra_isize(struct inode *inode,
>  	if (!error)
>  		error = rc;
>  
> +out_unlock:
>  	ext4_write_unlock_xattr(inode, &no_expand);
> -out_stop:
>  	ext4_journal_stop(handle);
>  	return error;
>  }
> 
