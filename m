Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85EC979A1DA
	for <lists+linux-ext4@lfdr.de>; Mon, 11 Sep 2023 05:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbjIKDc3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 10 Sep 2023 23:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbjIKDc2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 10 Sep 2023 23:32:28 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3CA99;
        Sun, 10 Sep 2023 20:32:24 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-565403bda57so2460845a12.3;
        Sun, 10 Sep 2023 20:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694403143; x=1695007943; darn=vger.kernel.org;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8Jb9MR9AYWtXuR6qO0QNDU334MaQE9Bv7HRVUlFV5Tc=;
        b=RjCjmPw2oXyH3N7ix4jSZT0UHIHPoEi1HMY+osW9x4O5BKVu4hQ4z9kc5N2f3gtxZQ
         prfQ7GfX1XL9EydTpvSp5aiNZwM8CCa+ZfTj+lk9SDyMvOSjo98lWvUlx6tAXeFiNoaB
         +nir9ranF7SUkDc1jYrPSypJOic3EznlycNR5HXy7P7EPFr2NjG7T5InGpCHvgidoml5
         m/+hdpPKcihXNtVUM82Y5nMyhrB7ApCta2/QtdbEoXu/goIv+LhkMOwgTW48Rv6eEwFl
         6MwHGnvrPHCcbHtYmnOTUX/xkH3mKYgHI6q3mVgAY1dhLIOsxtHU8a9GSSxpMmBbIodX
         eGSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694403143; x=1695007943;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8Jb9MR9AYWtXuR6qO0QNDU334MaQE9Bv7HRVUlFV5Tc=;
        b=RFnVPtHBeoyoev4+xlD0Sv7Y9TRcxxijn+pRGkKiCu2GglFdg7YTk413XLoRlwMYPA
         ahn3JMZQc3hwOqNT0P1aVlTqbJjnSBy6AsoA1W7/itnaCT+FYXiUNChFgb/CB+d89JkQ
         tYFZ4Vj8ufwLf1rfMMfvKsbhmeKuj9tdpxO3IUSgoCqJLvUJsoRZjyvM7YRVF3OPEQY5
         HdR/cV/rBLd63VkXj6DH8zyIwQ0HC5KxdAQF7rtk9zzJZfVa0coqG3VxnAhLg1DxyDel
         JxvzAZHI0jxaVnp8L0D4+3+zeqN5i2sjgTEGBdstuleWdJUIeIVsJcyOl/xqzMPZLRx8
         YThg==
X-Gm-Message-State: AOJu0Yx4tqk43nCjyRjLsLkIWF/zpUUm3ZpuPK++kRXb4E5j1Vbxn5wL
        U3I8mNbFHQNZyotiUdigA9HLXZk/s0Y=
X-Google-Smtp-Source: AGHT+IH28xYTAgPl0RVhvaqH04wckRRe7XsPUqKo6rZdXRzEo8tnOW2t7O3KvkMJLZrLr20XTBjBaQ==
X-Received: by 2002:a05:6a20:7d84:b0:129:3bb4:77f1 with SMTP id v4-20020a056a207d8400b001293bb477f1mr8689250pzj.0.1694403142987;
        Sun, 10 Sep 2023 20:32:22 -0700 (PDT)
Received: from dw-tp ([49.207.223.191])
        by smtp.gmail.com with ESMTPSA id q25-20020a62e119000000b00686236718d8sm4593817pfh.41.2023.09.10.20.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Sep 2023 20:32:22 -0700 (PDT)
Date:   Mon, 11 Sep 2023 09:02:13 +0530
Message-Id: <87zg1tbd1e.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Li Zetao <lizetao1@huawei.com>, tytso@mit.edu, jack@suse.com,
        yi.zhang@huawei.com
Cc:     lizetao1@huawei.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] jbd2: Fix memory leak in journal_init_common()
In-Reply-To: <20230911025138.983101-1-lizetao1@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Li Zetao <lizetao1@huawei.com> writes:

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

Thanks for the fix. I looked at your patch and it looks correct to me. 
The patch mentioned in the "Fixes" tag moved the "load_superblock"
function into journal_init_common() and from there onwards the cleanup
routine in case of an error was not properly handled for
crypto_alloc_shash()/j_chcksum_driver.
IMO too, the correct place to handle the cleanup routine is
journal_init_common() which is where this patch adds the cleanup.

Looks good to me. Feel free to add:-
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>


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
> -- 
> 2.34.1
