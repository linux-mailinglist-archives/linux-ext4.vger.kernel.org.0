Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17D49723C95
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Jun 2023 11:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236133AbjFFJKG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 6 Jun 2023 05:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232099AbjFFJJy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 6 Jun 2023 05:09:54 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0801E77
        for <linux-ext4@vger.kernel.org>; Tue,  6 Jun 2023 02:09:41 -0700 (PDT)
Received: from dggpeml500016.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Qb4NF5FDSzLptq;
        Tue,  6 Jun 2023 17:06:37 +0800 (CST)
Received: from [10.174.176.102] (10.174.176.102) by
 dggpeml500016.china.huawei.com (7.185.36.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 6 Jun 2023 17:09:39 +0800
Message-ID: <3a0b37ff-8e81-04a6-09bd-c8584f1d02cd@huawei.com>
Date:   Tue, 6 Jun 2023 17:09:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] e2fsck: restore sb->s_state before journal recover
To:     <tytso@mit.edu>
CC:     <linux-ext4@vger.kernel.org>, <linfeilong@huawei.com>,
        <louhongxiang@huawei.com>
References: <20230602082759.4062633-1-zhanchengbin1@huawei.com>
From:   zhanchengbin <zhanchengbin1@huawei.com>
In-Reply-To: <20230602082759.4062633-1-zhanchengbin1@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.102]
X-ClientProxiedBy: dggpeml100013.china.huawei.com (7.185.36.238) To
 dggpeml500016.china.huawei.com (7.185.36.70)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Okey, I found that this patch can fix my problem.
https://patchwork.ozlabs.org/project/linux-ext4/list/?series=342467

  - bin.

On 2023/6/2 16:27, zhanchengbin wrote:
> ext4_handle_error
>      EXT4_SB(sb)->s_mount_state |= EXT4_ERROR_FS;
>      if remount-ro
>          ext4_commit_super(sb);
> As you can see, when the filesystem error in the kernel, the last sb commit
> not record the journal, So sb->s_state will be overwritten by journal recover.
> In some cases , modifying metadata and superblock data are placed in two
> transactions, if the previous transaction is already in the journal, and
> ext4_handle_error occurs when updating sb, the filesystem is still error even
> if the journal is recovered(I know that this situation should not occur in
> theory, but I encountered this error when testing quota. Therefore, I think
> we cannot fully rely on the kernel).
> So when the filesystem is error before the journal recover, keep the error
> state and perform deep check later.
> 
> Signed-off-by: zhanchengbin <zhanchengbin1@huawei.com>
> ---
>   e2fsck/journal.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/e2fsck/journal.c b/e2fsck/journal.c
> index c7868d89..6f49321d 100644
> --- a/e2fsck/journal.c
> +++ b/e2fsck/journal.c
> @@ -1683,6 +1683,7 @@ errcode_t e2fsck_run_ext3_journal(e2fsck_t ctx)
>   	errcode_t	retval, recover_retval;
>   	io_stats	stats = 0;
>   	unsigned long long kbytes_written = 0;
> +	__u16 state = ctx->fs->super->s_state;
>   
>   	printf(_("%s: recovering journal\n"), ctx->device_name);
>   	if (ctx->options & E2F_OPT_READONLY) {
> @@ -1722,6 +1723,9 @@ errcode_t e2fsck_run_ext3_journal(e2fsck_t ctx)
>   	ctx->fs->flags |= EXT2_FLAG_MASTER_SB_ONLY;
>   	ctx->fs->super->s_kbytes_written += kbytes_written;
>   
> +	if (EXT2_ERROR_FS | state)
> +		ctx->fs->super->s_state = state | EXT2_ERROR_FS;
> +
>   	/* Set the superblock flags */
>   	e2fsck_clear_recover(ctx, recover_retval != 0);
>   
> 
