Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5D879AC8E
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Sep 2023 01:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345546AbjIKVVP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 11 Sep 2023 17:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235510AbjIKIts (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 11 Sep 2023 04:49:48 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C3741A1;
        Mon, 11 Sep 2023 01:49:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CF7B71F8A3;
        Mon, 11 Sep 2023 08:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694422181; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xmYheAFnFcMTM/McW9Ep/uL3q2cEMPpomtvxbGF+EAI=;
        b=WtVdusmZ7JUt3hyqzvuM5ictCVmCriRbf5spYlWQ8ys+cGL5f0dTUxFRHV8JoOrEp9cqd1
        DlU2z2El4p4hVL5yjBk5s629I7cc/0Fyl6AsHUQhiJ+dm4x0SZtZHDfa0dp7L308wzadL0
        DcSo18hnLALwv9oXa9O/ureE8A3Ay1o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694422181;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xmYheAFnFcMTM/McW9Ep/uL3q2cEMPpomtvxbGF+EAI=;
        b=/dqQO7uUGy1v5Yq7eIUjnqripMEXCxV3NGPKcGHZ/sy7FcebjbIlPRV7N1Ylg/mkBBskFE
        OgrI/7WmGOVf0wBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C074B13780;
        Mon, 11 Sep 2023 08:49:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id az3sLqXU/mShEwAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 11 Sep 2023 08:49:41 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 4576AA077E; Mon, 11 Sep 2023 10:49:41 +0200 (CEST)
Date:   Mon, 11 Sep 2023 10:49:41 +0200
From:   Jan Kara <jack@suse.cz>
To:     Li Zetao <lizetao1@huawei.com>
Cc:     tytso@mit.edu, jack@suse.com, yi.zhang@huawei.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] jbd2: Fix memory leak in journal_init_common()
Message-ID: <20230911084941.hlptflu2d3s3gjle@quack3>
References: <20230911025138.983101-1-lizetao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230911025138.983101-1-lizetao1@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 11-09-23 10:51:38, Li Zetao wrote:
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

Thanks for the fixup! Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

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
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
