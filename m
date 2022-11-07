Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7513161F379
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Nov 2022 13:38:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbiKGMh7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Nov 2022 07:37:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231459AbiKGMh6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Nov 2022 07:37:58 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463B8DFB3;
        Mon,  7 Nov 2022 04:37:57 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E27061F891;
        Mon,  7 Nov 2022 12:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1667824675; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ed3REcqcinrJmLgLbLfIF+BRE6o6gpBSlWOSlOSmye8=;
        b=XKvTy4K7d5rJbT0/gAR4YVSgUEGDOS74T0duAaEJrGsfYjdEcVjw0q0jLhzwGQteL79+Nr
        0ErsIv89i0DE17A5pNCBURW/+IJFnpI5NPbUpCNUrYgU41Ak8RFp6I2Iq9F6b9kG5q5CD/
        mocLb4rUtf9Ex/5+1NXRPB1TFgwtGHQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1667824675;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ed3REcqcinrJmLgLbLfIF+BRE6o6gpBSlWOSlOSmye8=;
        b=HuOPH3TBs36mze9bR2eYP3JR+gdguQ0bIFLHONbWf+z5B1/Pa0+tELmGWvUfwHGnlipVhH
        wJhJtGWJcSbm1IDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D280F13AC7;
        Mon,  7 Nov 2022 12:37:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ILMkMyP8aGPYPAAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 07 Nov 2022 12:37:55 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 688B0A0704; Mon,  7 Nov 2022 13:37:55 +0100 (CET)
Date:   Mon, 7 Nov 2022 13:37:55 +0100
From:   Jan Kara <jack@suse.cz>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Theodore Tso <tytso@mit.edu>, Jan Kara <jack@suse.com>,
        linux-ext4@vger.kernel.org
Subject: Re: [RFC][PATCH v3 30/33] timers: jbd2: Use timer_shutdown() before
 freeing timer
Message-ID: <20221107123755.vrailpdu5wxrb7se@quack3>
References: <20221104054053.431922658@goodmis.org>
 <20221104054917.365008421@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221104054917.365008421@goodmis.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 04-11-22 01:41:23, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> Before a timer is freed, timer_shutdown() must be called. Note that it is
> assumed that the timer is not running while being freed, so only
> timer_shutdown() is used, and not timer_shutdown_sync().
> 
> Link: https://lore.kernel.org/all/20220407161745.7d6754b3@gandalf.local.home/
> 
> Cc: "Theodore Ts'o" <tytso@mit.edu>
> Cc: Jan Kara <jack@suse.com>
> Cc: linux-ext4@vger.kernel.org
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/jbd2/journal.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index 2696f43e7239..57d2445d8c8b 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -2157,6 +2157,8 @@ int jbd2_journal_destroy(journal_t *journal)
>  	J_ASSERT(journal->j_checkpoint_transactions == NULL);
>  	spin_unlock(&journal->j_list_lock);
>  
> +	timer_shutdown(&journal->j_commit_timer);
> +
>  	/*
>  	 * OK, all checkpoint transactions have been checked, now check the
>  	 * write out io error flag and abort the journal if some buffer failed
> -- 
> 2.35.1
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
