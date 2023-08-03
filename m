Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3040276EC17
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Aug 2023 16:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236166AbjHCOOV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 3 Aug 2023 10:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbjHCOOF (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 3 Aug 2023 10:14:05 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0DA510F0
        for <linux-ext4@vger.kernel.org>; Thu,  3 Aug 2023 07:13:38 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3C689218B0;
        Thu,  3 Aug 2023 14:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691072017; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5kH4FHNdWFBSwFaEcTyu76qRD4K+M2NBrHwhDcx+Qek=;
        b=v9QAWrQLSCjQ7/+Sqq03ql2HD10ZEpAK52uX1f759wxcCknPWbzNiDw2ZRiLgxhesZlDrB
        apDlP0TBwzrK5OV8IiVEyxQ6HAZHvHUTWhQO5XSxR2ApV1gd6OZeEZOO4oThERhHxMkzJN
        LiNsyKMleLTEwmLzqbpe3upZZWicSjs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691072017;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5kH4FHNdWFBSwFaEcTyu76qRD4K+M2NBrHwhDcx+Qek=;
        b=1c8bQqLkyjoe/N6FDBuBRzLakyj3t4EsPpw9Zm9neziHizbQaNN1ztaAsykdFYLq9oTFIu
        OqFdtuCkMWBe+nCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2C36A1333C;
        Thu,  3 Aug 2023 14:13:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ONfAChG2y2RUCQAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 03 Aug 2023 14:13:37 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id B1635A076B; Thu,  3 Aug 2023 16:13:36 +0200 (CEST)
Date:   Thu, 3 Aug 2023 16:13:36 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huaweicloud.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, yi.zhang@huawei.com,
        chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH 02/12] jbd2: move load_superblock() into
 journal_init_common()
Message-ID: <20230803141336.23ce6xams3x333hd@quack3>
References: <20230704134233.110812-1-yi.zhang@huaweicloud.com>
 <20230704134233.110812-3-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704134233.110812-3-yi.zhang@huaweicloud.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 04-07-23 21:42:23, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Moving the call to load_superblock() from jbd2_journal_load() and
  ^^ Move

> jbd2_journal_wipe() eraly into journal_init_common(), the journal
                      ^^^ early

> superblock gets read and the in-memory jounal_t structure gets
					  ^^ journal_t

> initialised after calling jbd2_journal_init_{dev,inode}, it's safe to
> do following initialization according to it.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Otherwise the patch looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/jbd2/journal.c | 16 +++++-----------
>  1 file changed, 5 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index 48c44c7fccf4..b247d374e7a6 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -1582,6 +1582,10 @@ static journal_t *journal_init_common(struct block_device *bdev,
>  	journal->j_sb_buffer = bh;
>  	journal->j_superblock = (journal_superblock_t *)bh->b_data;
>  
> +	err = load_superblock(journal);
> +	if (err)
> +		goto err_cleanup;
> +
>  	journal->j_shrink_transaction = NULL;
>  	journal->j_shrinker.scan_objects = jbd2_journal_shrink_scan;
>  	journal->j_shrinker.count_objects = jbd2_journal_shrink_count;
> @@ -2056,13 +2060,7 @@ EXPORT_SYMBOL(jbd2_journal_update_sb_errno);
>  int jbd2_journal_load(journal_t *journal)
>  {
>  	int err;
> -	journal_superblock_t *sb;
> -
> -	err = load_superblock(journal);
> -	if (err)
> -		return err;
> -
> -	sb = journal->j_superblock;
> +	journal_superblock_t *sb = journal->j_superblock;
>  
>  	/*
>  	 * If this is a V2 superblock, then we have to check the
> @@ -2521,10 +2519,6 @@ int jbd2_journal_wipe(journal_t *journal, int write)
>  
>  	J_ASSERT (!(journal->j_flags & JBD2_LOADED));
>  
> -	err = load_superblock(journal);
> -	if (err)
> -		return err;
> -
>  	if (!journal->j_tail)
>  		goto no_recovery;
>  
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
