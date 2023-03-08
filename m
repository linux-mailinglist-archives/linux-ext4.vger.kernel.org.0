Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 533A36AFEC8
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Mar 2023 07:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjCHGP4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Mar 2023 01:15:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjCHGPy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 Mar 2023 01:15:54 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582FB8FBF1
        for <linux-ext4@vger.kernel.org>; Tue,  7 Mar 2023 22:15:53 -0800 (PST)
Received: from kwepemm600013.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4PWhrc1FVPzKmXy;
        Wed,  8 Mar 2023 14:15:44 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 8 Mar 2023 14:15:50 +0800
Subject: Re: [PATCH] ext4: swap i_disksize when swaping the boot loader inode
To:     Theodore Ts'o <tytso@mit.edu>, <bugzilla-daemon@kernel.org>
CC:     <linux-ext4@vger.kernel.org>
References: <bug-217159-13602@https.bugzilla.kernel.org/>
 <bug-217159-13602-BE3LDOwNA7@https.bugzilla.kernel.org/>
 <20230308041252.GC860405@mit.edu>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <7b72c020-ef61-8d46-805a-747686e17695@huawei.com>
Date:   Wed, 8 Mar 2023 14:15:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20230308041252.GC860405@mit.edu>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Ted,

> The following patch fixes the reported issue.
> 
>>From f4e156cef119f3ffcc56874da4fb9299cc14f68e Mon Sep 17 00:00:00 2001
> From: Theodore Ts'o <tytso@mit.edu>
> Date: Tue, 7 Mar 2023 23:06:59 -0500
> Subject: [PATCH] ext4: swap i_disksize when swaping the boot loader inode
> 
> Normally well-behaved of EXT4_IOC_SWAP_BOOT won't actually try to
> write to the either inode after using the ioctl, but if they do, the
> fact that we're not swapping ei->i_disksize as well as inode->i_size
> can trigger warnings.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217159
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
>   fs/ext4/ioctl.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
> index 2e8c34036313..e552c5db0c95 100644
> --- a/fs/ext4/ioctl.c
> +++ b/fs/ext4/ioctl.c
> @@ -329,9 +329,13 @@ static void swap_inode_data(struct inode *inode1, struct inode *inode2)

Shall we drop the redundant assignments 'swap(ei1->i_disksize, 
ei2->i_disksize);' ?

>   	ext4_es_remove_extent(inode1, 0, EXT_MAX_BLOCKS);
>   	ext4_es_remove_extent(inode2, 0, EXT_MAX_BLOCKS);
>   
> -	isize = i_size_read(inode1);
> -	i_size_write(inode1, i_size_read(inode2));
> -	i_size_write(inode2, isize);
> +	/*
> +	 * Both inodes are locked, so we don't need to fool around
> +	 * with i_size_read() and i_size_write().
> +	 */
> +	isize = inode1->i_size;
> +	inode1->i_size = ei1->i_disksize = inode2->i_size;
> +	inode2->i_size = ei2->i_disksize = isize;
>   }
>   
>   void ext4_reset_inode_seed(struct inode *inode)
> 

