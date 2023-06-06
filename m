Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5611723C9B
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Jun 2023 11:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbjFFJKL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 6 Jun 2023 05:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231371AbjFFJKI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 6 Jun 2023 05:10:08 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 830938F
        for <linux-ext4@vger.kernel.org>; Tue,  6 Jun 2023 02:10:07 -0700 (PDT)
Received: from dggpeml500016.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Qb4Ll0dTkz18M3M;
        Tue,  6 Jun 2023 17:05:19 +0800 (CST)
Received: from [10.174.176.102] (10.174.176.102) by
 dggpeml500016.china.huawei.com (7.185.36.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 6 Jun 2023 17:10:04 +0800
Message-ID: <37829291-c0e2-69dc-64d6-feb3b3afed4f@huawei.com>
Date:   Tue, 6 Jun 2023 17:10:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 1/2] e2fsck: save EXT2_ERROR_FS flag during journal replay
To:     Baokun Li <libaokun1@huawei.com>, <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <yi.zhang@huawei.com>, <yangerkun@huawei.com>, <yukuai3@huawei.com>
References: <20230217100922.588961-1-libaokun1@huawei.com>
 <20230217100922.588961-2-libaokun1@huawei.com>
From:   zhanchengbin <zhanchengbin1@huawei.com>
In-Reply-To: <20230217100922.588961-2-libaokun1@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.102]
X-ClientProxiedBy: dggpeml100013.china.huawei.com (7.185.36.238) To
 dggpeml500016.china.huawei.com (7.185.36.70)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


On 2023/2/17 18:09, Baokun Li wrote:
> When repairing a file system with s_errno missing from the journal
> superblock but the file system superblock contains the ERROR_FS flag,
> the ERROR_FS flag on the file system image is overwritten after the
> journal replay, followed by a reload of the file system data from disk
> and the ERROR_FS flag in memory is overwritten. Also s_errno is not set
> and the ERROR_FS flag is not reset. Therefore, when checked later, no
> forced check is performed, which makes it possible to have some errors
> hidden in the disk image, which may make it read-only when using the
> file system. So we save the ERROR_FS flag to the superblock after the
> journal replay, instead of just relying on the jsb->s_errno to do this.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good to me. Feel free to add:

Reviewed-by: zhanchengbin <zhanchengbin1@huawei.com>

  - bin.

> ---
>   e2fsck/journal.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/e2fsck/journal.c b/e2fsck/journal.c
> index c7868d89..0144aa45 100644
> --- a/e2fsck/journal.c
> +++ b/e2fsck/journal.c
> @@ -1683,6 +1683,7 @@ errcode_t e2fsck_run_ext3_journal(e2fsck_t ctx)
>   	errcode_t	retval, recover_retval;
>   	io_stats	stats = 0;
>   	unsigned long long kbytes_written = 0;
> +	__u16 s_error_state;
>   
>   	printf(_("%s: recovering journal\n"), ctx->device_name);
>   	if (ctx->options & E2F_OPT_READONLY) {
> @@ -1705,6 +1706,7 @@ errcode_t e2fsck_run_ext3_journal(e2fsck_t ctx)
>   		ctx->fs->io->manager->get_stats(ctx->fs->io, &stats);
>   	if (stats && stats->bytes_written)
>   		kbytes_written = stats->bytes_written >> 10;
> +	s_error_state = ctx->fs->super->s_state & EXT2_ERROR_FS;
>   
>   	ext2fs_mmp_stop(ctx->fs);
>   	ext2fs_free(ctx->fs);
> @@ -1721,6 +1723,7 @@ errcode_t e2fsck_run_ext3_journal(e2fsck_t ctx)
>   	ctx->fs->now = ctx->now;
>   	ctx->fs->flags |= EXT2_FLAG_MASTER_SB_ONLY;
>   	ctx->fs->super->s_kbytes_written += kbytes_written;
> +	ctx->fs->super->s_state |= s_error_state;
>   
>   	/* Set the superblock flags */
>   	e2fsck_clear_recover(ctx, recover_retval != 0);
> 
