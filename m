Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2300060F025
	for <lists+linux-ext4@lfdr.de>; Thu, 27 Oct 2022 08:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbiJ0G3l (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 27 Oct 2022 02:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233757AbiJ0G3k (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 27 Oct 2022 02:29:40 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE90186E7
        for <linux-ext4@vger.kernel.org>; Wed, 26 Oct 2022 23:29:38 -0700 (PDT)
Received: from canpemm500004.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MybHs4J0wz15MBn;
        Thu, 27 Oct 2022 14:24:41 +0800 (CST)
Received: from [10.174.179.14] (10.174.179.14) by
 canpemm500004.china.huawei.com (7.192.104.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 27 Oct 2022 14:29:35 +0800
Subject: Re: [PATCH] ext4: make ext4_mb_initialize_context return void
To:     Guoqing Jiang <guoqing.jiang@linux.dev>, <tytso@mit.edu>,
        <adilger.kernel@dilger.ca>
CC:     <linux-ext4@vger.kernel.org>
References: <20221027032435.27374-1-guoqing.jiang@linux.dev>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <bf9dba6f-50c6-5ba8-31e3-b60de18105f1@huawei.com>
Date:   Thu, 27 Oct 2022 14:29:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20221027032435.27374-1-guoqing.jiang@linux.dev>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.14]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500004.china.huawei.com (7.192.104.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


On 2022/10/27 11:24, Guoqing Jiang wrote:
> Change the return type to void since it always return 0, and no need
> to do the checking in ext4_mb_new_blocks.
> 
> Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
> ---
>   fs/ext4/mballoc.c | 10 ++--------
>   1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 9dad93059945..5b2ae37a8b80 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -5204,7 +5204,7 @@ static void ext4_mb_group_or_file(struct ext4_allocation_context *ac)
>   	mutex_lock(&ac->ac_lg->lg_mutex);
>   }
>   
> -static noinline_for_stack int
> +static noinline_for_stack void
>   ext4_mb_initialize_context(struct ext4_allocation_context *ac,
>   				struct ext4_allocation_request *ar)
>   {
> @@ -5253,8 +5253,6 @@ ext4_mb_initialize_context(struct ext4_allocation_context *ac,
>   			(unsigned) ar->lleft, (unsigned) ar->pleft,
>   			(unsigned) ar->lright, (unsigned) ar->pright,
>   			inode_is_open_for_write(ar->inode) ? "" : "non-");
> -	return 0;
> -
>   }
>   
>   static noinline_for_stack void
> @@ -5591,11 +5589,7 @@ ext4_fsblk_t ext4_mb_new_blocks(handle_t *handle,
>   		goto out;
>   	}
>   
> -	*errp = ext4_mb_initialize_context(ac, ar);
> -	if (*errp) {
> -		ar->len = 0;
> -		goto out;
> -	}
> +	ext4_mb_initialize_context(ac, ar);

This changed the logic here slightly. *errp will not be intialized with 
zero after this change. So we need to carefully check whether this will 
cause any issues.

Thanks,
Jason

>   
>   	ac->ac_op = EXT4_MB_HISTORY_PREALLOC;
>   	seq = this_cpu_read(discard_pa_seq);
> 
