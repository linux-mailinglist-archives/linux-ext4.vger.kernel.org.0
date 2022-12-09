Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60937647CEC
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Dec 2022 05:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiLIEWR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Dec 2022 23:22:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiLIEWQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Dec 2022 23:22:16 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B5B7D0A7
        for <linux-ext4@vger.kernel.org>; Thu,  8 Dec 2022 20:22:14 -0800 (PST)
Received: from dggpeml500006.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NSxXF2sNczRpqR;
        Fri,  9 Dec 2022 11:36:45 +0800 (CST)
Received: from [10.174.178.112] (10.174.178.112) by
 dggpeml500006.china.huawei.com (7.185.36.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 9 Dec 2022 11:37:38 +0800
Message-ID: <734733d3-4d5d-d153-d26c-2468d47699ca@huawei.com>
Date:   Fri, 9 Dec 2022 11:37:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH] mmp:fix wrong comparison in ext2fs_mmp_stop
Content-Language: en-US
From:   "lihaoxiang (F)" <lihaoxiang9@huawei.com>
To:     <tytso@mit.edu>
CC:     <linux-ext4@vger.kernel.org>,
        Zhiqiang Liu <liuzhiqiang26@huawei.com>,
        <linfeilong@huawei.com>, <louhongxiang@huawei.com>,
        "lijinlin (A)" <lijinlin3@huawei.com>
References: <d791b3d2-c438-3541-76ae-d228ba7b8cd4@huawei.com>
In-Reply-To: <d791b3d2-c438-3541-76ae-d228ba7b8cd4@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.112]
X-ClientProxiedBy: dggpeml500022.china.huawei.com (7.185.36.66) To
 dggpeml500006.china.huawei.com (7.185.36.76)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

friendly ping...

On 2022/11/29 15:02, lihaoxiang (F) wrote:
> In our knowledge, ext2fs_mmp_stop use to process the rest of work
> when mmp will finish. Critically, it must check if the mmp block is
> not changed. But there exist an error in comparing the mmp and mmp_cmp.
> 
> Look to ext2fs_mmp_read, the assignment of mmp_cmp retrieve from the
> superblock of disk and it copy to mmp_buf if mmp_buf is not none
> and not equal to mmp_cmp in the meanwhile. However, ext2fs_mmp_stop
> pass the no NULL pointer fs->mmp_buf which has possed the mmp info to
> ext2fs_mmp_read. Consequently, ext2fs_mmp_read override fs->mmp_buf
> by fs->mmp_cmp so that loss the meaning of comparing themselves
> after that and worse yet, couldn't judge whether the struct of mmp
> has changed.
> 
> In fact, we only need to modify the parameter to NULL pointer for
> solving this problem.
> 
> Signed-off-by: lihaoxiang <lihaoxiang9@huawei.com>
> ---
>  lib/ext2fs/mmp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/ext2fs/mmp.c b/lib/ext2fs/mmp.c
> index 7970aac2..14289706 100644
> --- a/lib/ext2fs/mmp.c
> +++ b/lib/ext2fs/mmp.c
> @@ -407,7 +407,7 @@ errcode_t ext2fs_mmp_stop(ext2_filsys fs)
>  	    (fs->mmp_buf == NULL) || (fs->mmp_cmp == NULL))
>  		goto mmp_error;
> 
> -	retval = ext2fs_mmp_read(fs, fs->super->s_mmp_block, fs->mmp_buf);
> +	retval = ext2fs_mmp_read(fs, fs->super->s_mmp_block, NULL);
>  	if (retval)
>  		goto mmp_error;
> 
