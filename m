Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 328296442D7
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Dec 2022 13:04:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234542AbiLFMEG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 6 Dec 2022 07:04:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234583AbiLFMDn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 6 Dec 2022 07:03:43 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72402982D
        for <linux-ext4@vger.kernel.org>; Tue,  6 Dec 2022 04:00:59 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 153411FE3E;
        Tue,  6 Dec 2022 12:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1670328024; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F4IyDqUPoos1n4daPIzOiHmUkjZMp7441vMEo9ubdZ0=;
        b=d7aIPUG4eadwQZrkLLtFV39ylz9t4BMz1dLfS9ycJ9Q4yT8oPX/pyQmQSMqSPaRG9Jn8FZ
        Yef/SHLHPOwa8m0zROUyXZywoWBu9SsHCqhujvrshcl9TbeR7FcKBM1dBXQcGasYbIOayT
        1EzVXOrg8nh5BR6YExMIccgTUPxr0IM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1670328024;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F4IyDqUPoos1n4daPIzOiHmUkjZMp7441vMEo9ubdZ0=;
        b=eDzjJRCGmxSDHffqbzfBuJhbryhTQpeYdvAHUaYjdi9dQ5waj9KEAlVjjW+70w5WiPhXlH
        YpSJNd5QuLgRYCCQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 08C7F13326;
        Tue,  6 Dec 2022 12:00:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id HskKAtguj2PsWAAAGKfGzw
        (envelope-from <jack@suse.cz>); Tue, 06 Dec 2022 12:00:24 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 92A48A0725; Tue,  6 Dec 2022 13:00:23 +0100 (CET)
Date:   Tue, 6 Dec 2022 13:00:23 +0100
From:   Jan Kara <jack@suse.cz>
To:     "lihaoxiang (F)" <lihaoxiang9@huawei.com>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
        Zhiqiang Liu <liuzhiqiang26@huawei.com>, linfeilong@huawei.com,
        "lijinlin (A)" <lijinlin3@huawei.com>, louhongxiang@huawei.com
Subject: Re: [PATCH] quota-nld:remove redundant description after fix
 setup_sigterm_handler()
Message-ID: <20221206120023.icw6iqsbtbmn6pnl@quack3>
References: <3f405e2f-b18a-f12d-7b0e-8cb031df37eb@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f405e2f-b18a-f12d-7b0e-8cb031df37eb@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 06-12-22 19:51:26, lihaoxiang (F) wrote:
> In the commit 06b93e5c1caf5d36d51132cb85c11a96cbdae023, it renamed the
> function `use_pid_file` to `setup_sigterm_handler` and excluded to store
> daemon's pid here. So we need to clean the corresponding note in time.

Thanks! I've folded the fixup patch in the previous fix.

								Honza

> ---
>  quota_nld.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/quota_nld.c b/quota_nld.c
> index 82e60c2..58a62af 100644
> --- a/quota_nld.c
> +++ b/quota_nld.c
> @@ -459,7 +459,7 @@ static void remove_pid(int signal)
>  	exit(EXIT_SUCCESS);
>  }
> 
> -/* Store daemon's PID into file and register its removal on SIGTERM */
> +/* Register daemon's PID file removal on SIGTERM */
>  static void setup_sigterm_handler(void)
>  {
>  	struct sigaction term_action;
> -- 
> 2.37.0.windows.1
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
