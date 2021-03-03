Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C310332BD14
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Mar 2021 23:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240019AbhCCPRu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 3 Mar 2021 10:17:50 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:13462 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241153AbhCCAwd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 2 Mar 2021 19:52:33 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DqwPc56vBzjVbj;
        Wed,  3 Mar 2021 08:49:40 +0800 (CST)
Received: from [127.0.0.1] (10.174.176.117) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.498.0; Wed, 3 Mar 2021
 08:51:15 +0800
Subject: Re: [PATCH] misc: remove useless code in set_inode_xattr()
To:     <linux-ext4@vger.kernel.org>, "Theodore Y. Ts'o" <tytso@mit.edu>
CC:     harshad shirwadkar <harshadshirwadkar@gmail.com>,
        linfeilong <linfeilong@huawei.com>,
        lihaotian <lihaotian9@huawei.com>
References: <283210da-b281-2dd7-6ef7-b31e81e72e01@huawei.com>
From:   Zhiqiang Liu <liuzhiqiang26@huawei.com>
Message-ID: <0949867f-5ed8-6a51-1b8e-b116b833ef22@huawei.com>
Date:   Wed, 3 Mar 2021 08:51:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <283210da-b281-2dd7-6ef7-b31e81e72e01@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.117]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

ping...

On 2021/2/26 9:22, Zhiqiang Liu wrote:
> 
> In set_inode_xattr(), there are two returns as follows,
> -
>   return retval;
>   return 0;
> -
> Here, we remove useless 'return 0;' code.
> 
> Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
> ---
>  misc/create_inode.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/misc/create_inode.c b/misc/create_inode.c
> index 54d8d343..d62e1cb4 100644
> --- a/misc/create_inode.c
> +++ b/misc/create_inode.c
> @@ -234,7 +234,6 @@ static errcode_t set_inode_xattr(ext2_filsys fs, ext2_ino_t ino,
>  		retval = retval ? retval : close_retval;
>  	}
>  	return retval;
> -	return 0;
>  }
>  #else /* HAVE_LLISTXATTR */
>  static errcode_t set_inode_xattr(ext2_filsys fs EXT2FS_ATTR((unused)),
> 

