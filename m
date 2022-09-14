Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41AC85B8AB9
	for <lists+linux-ext4@lfdr.de>; Wed, 14 Sep 2022 16:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbiINOgk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 14 Sep 2022 10:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbiINOg3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 14 Sep 2022 10:36:29 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E86475721E;
        Wed, 14 Sep 2022 07:36:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 63966338DF;
        Wed, 14 Sep 2022 14:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1663166187; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EcKFFNOXpymxwv8o+pvzoP8IcYNUQYJkgNRkyvMjD40=;
        b=G1GhRhSnTMNSetoHStSUHA8hxFmnY4Vs9n9HFMHkqoCi2BYPteUhGO2kIdoBtT1Db6C+Mp
        037B6NnLWgyqXzbI6yRG7bHNm9/3qPjsG6n0ysSM490zECG5EMzi4lzZOnwxAJ1QsBc4dC
        LsxnpBI9Bx2o/wNytiRO/7tCmbrdybw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1663166187;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EcKFFNOXpymxwv8o+pvzoP8IcYNUQYJkgNRkyvMjD40=;
        b=Gudm51E509PRvna+wt36JZR8YSuasRr39N6d+A0jiDv+eYLqOayVioIFJ8eBtpbFAQYlIQ
        wOIhgLGOIUvjDPBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 53FC2134B3;
        Wed, 14 Sep 2022 14:36:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9KFyFOvmIWMOOQAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 14 Sep 2022 14:36:27 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id DEB49A0680; Wed, 14 Sep 2022 16:36:26 +0200 (CEST)
Date:   Wed, 14 Sep 2022 16:36:26 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ye Bin <yebin10@huawei.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz
Subject: Re: [PATCH -next 1/2] jbd2: fix potential buffer head reference
 count leak
Message-ID: <20220914143626.gq7vpbibihcn6jng@quack3>
References: <20220914100812.1414768-1-yebin10@huawei.com>
 <20220914100812.1414768-2-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220914100812.1414768-2-yebin10@huawei.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 14-09-22 18:08:11, Ye Bin wrote:
> As in 'jbd2_fc_wait_bufs' if buffer isn't uptodate, will return -EIO without
> update 'journal->j_fc_off'. But 'jbd2_fc_release_bufs' will release buffer head
> from ‘j_fc_off - 1’ if 'bh' is NULL will terminal release which will lead to
> buffer head buffer head reference count leak.
> To solve above issue, update 'journal->j_fc_off' before return -EIO.
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/jbd2/journal.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index 140b070471c0..1c833d8cb0fe 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -925,8 +925,14 @@ int jbd2_fc_wait_bufs(journal_t *journal, int num_blks)
>  		wait_on_buffer(bh);
>  		put_bh(bh);
>  		journal->j_fc_wbuf[i] = NULL;
> -		if (unlikely(!buffer_uptodate(bh)))
> +		/*
> +		 * Update j_fc_off so jbd2_fc_release_bufs can release remain
> +		 * buffer head.
> +		 */
> +		if (unlikely(!buffer_uptodate(bh))) {
> +			journal->j_fc_off = i;
>  			return -EIO;
> +		}
>  	}
>  
>  	return 0;
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
