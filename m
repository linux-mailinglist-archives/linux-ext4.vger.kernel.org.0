Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2876294622
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Oct 2020 03:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439817AbgJUBK0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 20 Oct 2020 21:10:26 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15756 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2439815AbgJUBK0 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 20 Oct 2020 21:10:26 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0B71E445C77972A34D07;
        Wed, 21 Oct 2020 09:10:23 +0800 (CST)
Received: from [10.174.176.239] (10.174.176.239) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Wed, 21 Oct 2020 09:10:18 +0800
Subject: Re: [PATCH] ext4: remove redundant operation that set bh to NULL
To:     <xiakaixu1987@gmail.com>, <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        Kaixu Xia <kaixuxia@tencent.com>
References: <1603194069-17557-1-git-send-email-kaixuxia@tencent.com>
From:   "zhangyi (F)" <yi.zhang@huawei.com>
Message-ID: <2677070f-f994-f20d-115b-55922d172da6@huawei.com>
Date:   Wed, 21 Oct 2020 09:10:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <1603194069-17557-1-git-send-email-kaixuxia@tencent.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.239]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2020/10/20 19:41, xiakaixu1987@gmail.com wrote:
> From: Kaixu Xia <kaixuxia@tencent.com>
> 
> The out_fail branch path don't release the bh and the second bh is
> valid only in the for statement, so we don't need to set them to NULL.
> 
> Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>

Thanks for the patch. It looks good to me.
Reviewed-by: zhangyi (F) <yi.zhang@huawei.com>

Yi.

> ---
>  fs/ext4/super.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 5308f0d5fb5a..3ebfabc6061a 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -4093,7 +4093,6 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
>  	if (IS_ERR(bh)) {
>  		ext4_msg(sb, KERN_ERR, "unable to read superblock");
>  		ret = PTR_ERR(bh);
> -		bh = NULL;
>  		goto out_fail;
>  	}
>  	/*
> @@ -4721,7 +4720,6 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
>  			       "can't read group descriptor %d", i);
>  			db_count = i;
>  			ret = PTR_ERR(bh);
> -			bh = NULL;
>  			goto failed_mount2;
>  		}
>  		rcu_read_lock();
> 
