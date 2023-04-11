Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE87D6DD7D4
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Apr 2023 12:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjDKKZe (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 11 Apr 2023 06:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjDKKZe (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 11 Apr 2023 06:25:34 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123B2A9;
        Tue, 11 Apr 2023 03:25:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B859E1FDDF;
        Tue, 11 Apr 2023 10:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1681208731; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XE42yeO9Fwjo78eoc1CzQG0kqmd7Ls/r5eYFNrVSovI=;
        b=DqTRuYYbfaBC/WVo4d/D2GAUzPwhztc+mOVIEWOesTdRqefHHJ6Xl7My6KmJPJ8TQyPJhi
        NaTfR0yRXJK17DCo6rLQHYHOBKW6LJb2HCK4XJgZTq7uP1qjq/W/7JWJdShJmvYRNKRQCp
        hvmb1aZWwPv1eVWDFUB3/WYpm99Oves=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1681208731;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XE42yeO9Fwjo78eoc1CzQG0kqmd7Ls/r5eYFNrVSovI=;
        b=djAuxYikuJcRGa1C48u0m1G+T7fmGE3RsigGf37v5c58N+Z/l83ayB0S1bQFti3fUK76nQ
        hrVeTit1UljDe9AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 768AF13638;
        Tue, 11 Apr 2023 10:25:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id L7DsHJs1NWQ5SQAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 11 Apr 2023 10:25:31 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 5BBB1A0732; Tue, 11 Apr 2023 12:25:30 +0200 (CEST)
Date:   Tue, 11 Apr 2023 12:25:30 +0200
From:   Jan Kara <jack@suse.cz>
To:     Guoqing Cai <u202112087@hust.edu.cn>
Cc:     Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.com>,
        HUST OS Kernel Contribution 
        <hust-os-kernel-patches@googlegroups.com>,
        Dongliang Mu <dzm91@hust.edu.cn>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: jbd2: fix an incorrect warn log
Message-ID: <20230411102530.qfgmxh33azztpxz5@quack3>
References: <20230410172039.1752440-1-u202112087@hust.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230410172039.1752440-1-u202112087@hust.edu.cn>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 11-04-23 01:20:38, Guoqing Cai wrote:
> In jbd2_journal_load(), when journal_reset fails, it prints an incorrect
> warn log.
> 
> Fix this by changing the goto statement to return statement.
> 
> Signed-off-by: Guoqing Cai <u202112087@hust.edu.cn>
> Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>

...

> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index e80c781731f8..555f09ca1d99 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -2082,8 +2082,10 @@ int jbd2_journal_load(journal_t *journal)
>  
>  	/* Let the recovery code check whether it needs to recover any
>  	 * data from the journal. */
> -	if (jbd2_journal_recover(journal))
> -		goto recovery_error;
> +	if (jbd2_journal_recover(journal)) {
> +		printk(KERN_WARNING "JBD2: recovery failed\n");
> +		return -EIO;
> +	}
>  
>  	if (journal->j_failed_commit) {
>  		printk(KERN_ERR "JBD2: journal transaction %u on %s "
> @@ -2101,14 +2103,10 @@ int jbd2_journal_load(journal_t *journal)
>  	 * reinitialise the dynamic contents of the superblock in memory
>  	 * and reset them on disk. */
>  	if (journal_reset(journal))
> -		goto recovery_error;
> +		return -EIO;

So when you touch this code it would make more sense to actually return the
error returned by journal_reset() - that is most definitely not going to be
EIO but most likely ENOMEM.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
