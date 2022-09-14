Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0445B8AC0
	for <lists+linux-ext4@lfdr.de>; Wed, 14 Sep 2022 16:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbiINOhB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 14 Sep 2022 10:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbiINOgr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 14 Sep 2022 10:36:47 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA803DF3A;
        Wed, 14 Sep 2022 07:36:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EC2B71F9DD;
        Wed, 14 Sep 2022 14:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1663166204; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ts63K9+BZFjVvhPwPuIDL4A00GqKvQBXdrJR6qxlQKA=;
        b=kr58rQcSt/nuC0nlXNcczZ3fE+sNrzp5D/QChCY/vfUXgpDL6CbLUhNuNEkh1CM98yDMqE
        bEXYP56RD2P7KV3QeY4qH4rRK0MGn+QIkGnbe1j2gWXOKleXopuoAz/9rwio5n7iJ0YxmM
        rs6LA4xg9Y5rVcWSxftiIJKDF3gpktg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1663166204;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ts63K9+BZFjVvhPwPuIDL4A00GqKvQBXdrJR6qxlQKA=;
        b=jt2rK/KineqJLYEYrjFO1tuh+9r3Xt9NZm+gufclXQEh/nutMufjQUu5a045CwBni1aLI1
        nNW7j8adUbJ3sGDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DF5C5134B3;
        Wed, 14 Sep 2022 14:36:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fhGHNvzmIWMoOQAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 14 Sep 2022 14:36:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 86AF5A0680; Wed, 14 Sep 2022 16:36:44 +0200 (CEST)
Date:   Wed, 14 Sep 2022 16:36:44 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ye Bin <yebin10@huawei.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz
Subject: Re: [PATCH -next 2/2] jbd2: fix potential use-after-free in
 jbd2_fc_wait_bufs
Message-ID: <20220914143644.chjvnr3eiv6uxaaj@quack3>
References: <20220914100812.1414768-1-yebin10@huawei.com>
 <20220914100812.1414768-3-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914100812.1414768-3-yebin10@huawei.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 14-09-22 18:08:12, Ye Bin wrote:
> In 'jbd2_fc_wait_bufs' use 'bh' after put buffer head reference count
> which may lead to use-after-free.
> So judge buffer if uptodate before put buffer head reference count.
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/jbd2/journal.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index 1c833d8cb0fe..4d49f629d06b 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -923,16 +923,16 @@ int jbd2_fc_wait_bufs(journal_t *journal, int num_blks)
>  	for (i = j_fc_off - 1; i >= j_fc_off - num_blks; i--) {
>  		bh = journal->j_fc_wbuf[i];
>  		wait_on_buffer(bh);
> -		put_bh(bh);
> -		journal->j_fc_wbuf[i] = NULL;
>  		/*
>  		 * Update j_fc_off so jbd2_fc_release_bufs can release remain
>  		 * buffer head.
>  		 */
>  		if (unlikely(!buffer_uptodate(bh))) {
> -			journal->j_fc_off = i;
> +			journal->j_fc_off = i + 1;
>  			return -EIO;
>  		}
> +		put_bh(bh);
> +		journal->j_fc_wbuf[i] = NULL;
>  	}
>  
>  	return 0;
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
