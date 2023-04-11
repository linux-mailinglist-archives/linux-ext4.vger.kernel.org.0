Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91EA76DD7DC
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Apr 2023 12:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjDKK0v (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 11 Apr 2023 06:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjDKK0u (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 11 Apr 2023 06:26:50 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 424A9121;
        Tue, 11 Apr 2023 03:26:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E614421A2E;
        Tue, 11 Apr 2023 10:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1681208807; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PYoZDebHALlWy9pzXUZpc9ryOJInt8WxbJMh5qJF4pc=;
        b=DkYSc6YxRaY4Eg1JMsJV93oCMhCu/SVCA7j6mFoiAAaDoUosm4zT4QNbwB1UjPZJ2bkNUz
        kWXSh/XFzLsClHiRr5y6VUt1B1H88ZrkOMinV3MnZ3espXbVHaW2EBlMaXOBe5d+2m7C0Y
        p7nD1uDE3bB/1pFtNVb5wjeRdbI7kCs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1681208807;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PYoZDebHALlWy9pzXUZpc9ryOJInt8WxbJMh5qJF4pc=;
        b=FxDTMsC5mYjqSeekju6Ueer4c7DImr7xPBcB/2qDmyf2eHfTB/j7EYvHI2xpaoHFMQRmRB
        EJHrrZn4pQO+2aDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B3D3813638;
        Tue, 11 Apr 2023 10:26:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fKLsK+c1NWTpSQAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 11 Apr 2023 10:26:47 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 9BB77A0732; Tue, 11 Apr 2023 12:26:45 +0200 (CEST)
Date:   Tue, 11 Apr 2023 12:26:45 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Guoqing Cai <u202112087@hust.edu.cn>,
        Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.com>,
        HUST OS Kernel Contribution 
        <hust-os-kernel-patches@googlegroups.com>,
        Dongliang Mu <dzm91@hust.edu.cn>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: jbd2: fix an incorrect warn log
Message-ID: <20230411102645.geqbaksm2yxuevjg@quack3>
References: <20230410172039.1752440-1-u202112087@hust.edu.cn>
 <20230410174545.GA360877@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230410174545.GA360877@frogsfrogsfrogs>
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 10-04-23 10:45:45, Darrick J. Wong wrote:
> On Tue, Apr 11, 2023 at 01:20:38AM +0800, Guoqing Cai wrote:
> > In jbd2_journal_load(), when journal_reset fails, it prints an incorrect
> > warn log.
> > 
> > Fix this by changing the goto statement to return statement.
> > 
> > Signed-off-by: Guoqing Cai <u202112087@hust.edu.cn>
> > Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
> > ---
> >  fs/jbd2/journal.c | 12 +++++-------
> >  1 file changed, 5 insertions(+), 7 deletions(-)
> > 
> > diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> > index e80c781731f8..555f09ca1d99 100644
> > --- a/fs/jbd2/journal.c
> > +++ b/fs/jbd2/journal.c
> > @@ -2082,8 +2082,10 @@ int jbd2_journal_load(journal_t *journal)
> >  
> >  	/* Let the recovery code check whether it needs to recover any
> >  	 * data from the journal. */
> > -	if (jbd2_journal_recover(journal))
> > -		goto recovery_error;
> > +	if (jbd2_journal_recover(journal)) {
> > +		printk(KERN_WARNING "JBD2: recovery failed\n");
> > +		return -EIO;
> > +	}
> >  
> >  	if (journal->j_failed_commit) {
> >  		printk(KERN_ERR "JBD2: journal transaction %u on %s "
> > @@ -2101,14 +2103,10 @@ int jbd2_journal_load(journal_t *journal)
> >  	 * reinitialise the dynamic contents of the superblock in memory
> >  	 * and reset them on disk. */
> >  	if (journal_reset(journal))
> > -		goto recovery_error;
> > +		return -EIO;
> 
> Why wouldn't you warn about the journal reset failing here?

Well, ext4 will still print:

	ext4_msg(sb, KERN_ERR, "error loading journal");

which I guess is good enough for such strange failure.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
