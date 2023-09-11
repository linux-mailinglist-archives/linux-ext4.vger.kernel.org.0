Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48D8B79A1DE
	for <lists+linux-ext4@lfdr.de>; Mon, 11 Sep 2023 05:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbjIKDgA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 10 Sep 2023 23:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjIKDgA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 10 Sep 2023 23:36:00 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8251B11B;
        Sun, 10 Sep 2023 20:35:50 -0700 (PDT)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RkXPZ2SXdz1M9Bm;
        Mon, 11 Sep 2023 11:33:54 +0800 (CST)
Received: from [10.174.176.34] (10.174.176.34) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 11 Sep 2023 11:35:47 +0800
Subject: Re: [PATCH] jbd2: Fix memory leak in journal_init_common()
To:     Li Zetao <lizetao1@huawei.com>, <tytso@mit.edu>, <jack@suse.com>
CC:     <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230911025138.983101-1-lizetao1@huawei.com>
From:   Zhang Yi <yi.zhang@huawei.com>
Message-ID: <ed08d96e-c46b-5b6b-aa9b-987972425043@huawei.com>
Date:   Mon, 11 Sep 2023 11:35:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20230911025138.983101-1-lizetao1@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.34]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2023/9/11 10:51, Li Zetao wrote:
> There is a memory leak reported by kmemleak:
> 
>   unreferenced object 0xff11000105903b80 (size 64):
>     comm "mount", pid 3382, jiffies 4295032021 (age 27.826s)
>     hex dump (first 32 bytes):
>       04 00 00 00 00 00 00 00 01 00 00 00 00 00 00 00  ................
>       ff ff ff ff 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     backtrace:
>       [<ffffffffae86ac40>] __kmalloc_node+0x50/0x160
>       [<ffffffffaf2486d8>] crypto_alloc_tfmmem.isra.0+0x38/0x110
>       [<ffffffffaf2498e5>] crypto_create_tfm_node+0x85/0x2f0
>       [<ffffffffaf24a92c>] crypto_alloc_tfm_node+0xfc/0x210
>       [<ffffffffaedde777>] journal_init_common+0x727/0x1ad0
>       [<ffffffffaede1715>] jbd2_journal_init_inode+0x2b5/0x500
>       [<ffffffffaed786b5>] ext4_load_and_init_journal+0x255/0x2440
>       [<ffffffffaed8b423>] ext4_fill_super+0x8823/0xa330
>       ...
> 
> The root cause was traced to an error handing path in journal_init_common()
> when malloc memory failed in register_shrinker(). The checksum driver is
> used to reference to checksum algorithm via cryptoapi and the user should
> release the memory when the driver is no longer needed or the journal
> initialization failed.
> 
> Fix it by calling crypto_free_shash() on the "err_cleanup" error handing
> path in journal_init_common().
> 
> Fixes: c30713084ba5 ("jbd2: move load_superblock() into journal_init_common()")
> Signed-off-by: Li Zetao <lizetao1@huawei.com>

Thanks for the fix, it looks good to me.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

> ---
>  fs/jbd2/journal.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index 768fa05bcbed..30dec2bd2ecc 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -1601,6 +1601,8 @@ static journal_t *journal_init_common(struct block_device *bdev,
>  
>  err_cleanup:
>  	percpu_counter_destroy(&journal->j_checkpoint_jh_count);
> +	if (journal->j_chksum_driver)
> +		crypto_free_shash(journal->j_chksum_driver);
>  	kfree(journal->j_wbuf);
>  	jbd2_journal_destroy_revoke(journal);
>  	journal_fail_superblock(journal);
> 
