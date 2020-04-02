Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D81419BA4A
	for <lists+linux-ext4@lfdr.de>; Thu,  2 Apr 2020 04:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733230AbgDBC3X (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 1 Apr 2020 22:29:23 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:47118 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732462AbgDBC3X (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 1 Apr 2020 22:29:23 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 90C198785B598A99A593;
        Thu,  2 Apr 2020 10:29:14 +0800 (CST)
Received: from [127.0.0.1] (10.173.223.234) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Thu, 2 Apr 2020
 10:29:10 +0800
Subject: Re: [PATCH -next] ext4: Fix build error while CONFIG_PRINTK is n
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
References: <20200401073038.33076-1-yuehaibing@huawei.com>
 <20200401212859.GN768293@mit.edu>
CC:     <adilger.kernel@dilger.ca>, <linux-ext4@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
From:   Yuehaibing <yuehaibing@huawei.com>
Message-ID: <b9e56f54-2180-4a2c-3e0b-47e85dec221b@huawei.com>
Date:   Thu, 2 Apr 2020 10:29:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20200401212859.GN768293@mit.edu>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.173.223.234]
X-CFilter-Loop: Reflected
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2020/4/2 5:28, Theodore Y. Ts'o wrote:
> On Wed, Apr 01, 2020 at 03:30:38PM +0800, YueHaibing wrote:
>> fs/ext4/balloc.c: In function ‘ext4_wait_block_bitmap’:
>> fs/ext4/balloc.c:519:3: error: implicit declaration of function ‘ext4_error_err’; did you mean ‘ext4_error’? [-Werror=implicit-function-declaration]
>>    ext4_error_err(sb, EIO, "Cannot read block bitmap - "
>>    ^~~~~~~~~~~~~~
>>
>> Add missing stub helper and fix ext4_abort.
>>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Fixes: 2ea2fc775321 ("ext4: save all error info in save_error_info() and drop ext4_set_errno()")
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> 
> Thanks; the patch isn't quite correct, though.  This is what I merged
> into my tree's version of the "save all error info..." commit.
> 
>      	       	       	      	    	      - Ted
> 

Ok, good to know this and thansk!

> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index eacd2f9cc833..91eb4381cae5 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -2848,6 +2848,11 @@ do {									\
>  	no_printk(fmt, ##__VA_ARGS__);					\
>  	__ext4_error_inode(inode, "", 0, block, 0, " ");		\
>  } while (0)
> +#define ext4_error_inode_err(inode, func, line, block, err, fmt, ...)	\
> +do {									\
> +	no_printk(fmt, ##__VA_ARGS__);					\
> +	__ext4_error_inode(inode, "", 0, block, err, " ");		\
> +} while (0)
>  #define ext4_error_file(file, func, line, block, fmt, ...)		\
>  do {									\
>  	no_printk(fmt, ##__VA_ARGS__);					\
> @@ -2858,10 +2863,15 @@ do {									\
>  	no_printk(fmt, ##__VA_ARGS__);					\
>  	__ext4_error(sb, "", 0, 0, 0, " ");				\
>  } while (0)
> -#define ext4_abort(sb, fmt, ...)					\
> +#define ext4_error_err(sb, err, fmt, ...)				\
> +do {									\
> +	no_printk(fmt, ##__VA_ARGS__);					\
> +	__ext4_error(sb, "", 0, err, 0, " ");				\
> +} while (0)
> +#define ext4_abort(sb, err, fmt, ...)					\
>  do {									\
>  	no_printk(fmt, ##__VA_ARGS__);					\
> -	__ext4_abort(sb, "", 0, " ");					\
> +	__ext4_abort(sb, "", 0, err, " ");				\
>  } while (0)
>  #define ext4_warning(sb, fmt, ...)					\
>  do {									\
> 
> .
> 

