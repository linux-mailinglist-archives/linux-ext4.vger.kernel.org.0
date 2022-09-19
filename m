Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 498AC5BCC13
	for <lists+linux-ext4@lfdr.de>; Mon, 19 Sep 2022 14:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbiISMoL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 19 Sep 2022 08:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbiISMnx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 19 Sep 2022 08:43:53 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8E425EB6;
        Mon, 19 Sep 2022 05:43:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 23F0E1F37C;
        Mon, 19 Sep 2022 12:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1663591429; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JNX3geAB//04COTSGgSRyqX/fXrPKwlxVbihxLJjBaQ=;
        b=UylC8mAQp4O+cNM3Tcy8fjxSdkSJRh7gc2HsGfzGyM3x+1XS6QZTc+jnSa1Td7bHXoKx/l
        p3jp6cZDWG5/QwCNfq0C3PUc8mCbHtnKhPCUfoK1ArQ5Gw2O74lAJRYe+I5vbQb33DuMkw
        HG7PqAh13vk6cNsvTlZdnfScdU7SRkY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1663591429;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JNX3geAB//04COTSGgSRyqX/fXrPKwlxVbihxLJjBaQ=;
        b=txuzUCvTxHfpl3iN1j6oSXzgGSg5Oclu02kv91fVyUmjHAX++4Gk7ikGF/Xd9JzsQLjRkl
        w/GDh7hu5YspJwAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ACCFB13A96;
        Mon, 19 Sep 2022 12:43:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id DOQiKgRkKGMLMQAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 19 Sep 2022 12:43:48 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id B9944A0682; Mon, 19 Sep 2022 14:43:44 +0200 (CEST)
Date:   Mon, 19 Sep 2022 14:43:44 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ye Bin <yebin10@huawei.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz
Subject: Re: [PATCH -next] jbd2: add miss release buffer head in
 fc_do_one_pass()
Message-ID: <20220919124344.muyhkpxm4d3wumd3@quack3>
References: <20220917093805.1782845-1-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220917093805.1782845-1-yebin10@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat 17-09-22 17:38:05, Ye Bin wrote:
> In fc_do_one_pass() miss release buffer head after use which will lead
> to reference count leak.
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>

Indeed. Good catch! Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/jbd2/recovery.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
> index 1f878c315b03..8286a9ec122f 100644
> --- a/fs/jbd2/recovery.c
> +++ b/fs/jbd2/recovery.c
> @@ -261,6 +261,7 @@ static int fc_do_one_pass(journal_t *journal,
>  		err = journal->j_fc_replay_callback(journal, bh, pass,
>  					next_fc_block - journal->j_fc_first,
>  					expected_commit_id);
> +		brelse(bh);
>  		next_fc_block++;
>  		if (err < 0 || err == JBD2_FC_REPLAY_STOP)
>  			break;
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
