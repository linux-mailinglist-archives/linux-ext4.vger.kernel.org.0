Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBA2432489D
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Feb 2021 02:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234613AbhBYBkT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 24 Feb 2021 20:40:19 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:13375 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234799AbhBYBkR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 24 Feb 2021 20:40:17 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DmFm70D9zz7m28;
        Thu, 25 Feb 2021 09:37:59 +0800 (CST)
Received: from [127.0.0.1] (10.174.176.117) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.498.0; Thu, 25 Feb 2021
 09:39:27 +0800
Subject: Re: [PATCH] debugfs: fix memory leak problem in read_list()
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>
CC:     harshad shirwadkar <harshadshirwadkar@gmail.com>,
        linfeilong <linfeilong@huawei.com>,
        lihaotian <lihaotian9@huawei.com>,
        "lijinlin (A)" <lijinlin3@huawei.com>
References: <c6fb0951-a472-dbb4-1970-fe9cece5d182@huawei.com>
From:   Zhiqiang Liu <liuzhiqiang26@huawei.com>
Message-ID: <8f18dd0d-aad2-1b34-d7a9-18b473f9c8b3@huawei.com>
Date:   Thu, 25 Feb 2021 09:39:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <c6fb0951-a472-dbb4-1970-fe9cece5d182@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.117]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

friendly ping ...

On 2021/2/20 16:41, Zhiqiang Liu wrote:
> 
> In read_list func, if strtoull() fails in while loop,
> we will return the error code directly. Then, memory of
> variable lst will be leaked without setting to *list.
> 
> Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
> Signed-off-by: linfeilong <linfeilong@huawei.com>
> ---
>  debugfs/util.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/debugfs/util.c b/debugfs/util.c
> index be6b550e..9e880548 100644
> --- a/debugfs/util.c
> +++ b/debugfs/util.c
> @@ -530,12 +530,16 @@ errcode_t read_list(char *str, blk64_t **list, size_t *len)
> 
>  		errno = 0;
>  		y = x = strtoull(tok, &e, 0);
> -		if (errno)
> -			return errno;
> +		if (errno) {
> +			retval = errno;
> +			break;
> +		}
>  		if (*e == '-') {
>  			y = strtoull(e + 1, NULL, 0);
> -			if (errno)
> -				return errno;
> +			if (errno) {
> +				retval = errno;
> +				break;
> +			}
>  		} else if (*e != 0) {
>  			retval = EINVAL;
>  			break;
> 

