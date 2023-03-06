Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCDA86ABFC2
	for <lists+linux-ext4@lfdr.de>; Mon,  6 Mar 2023 13:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjCFMll (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 6 Mar 2023 07:41:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjCFMlj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 6 Mar 2023 07:41:39 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 563C42B2BD;
        Mon,  6 Mar 2023 04:41:36 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 14BC52229F;
        Mon,  6 Mar 2023 12:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678106495; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HI6JlS7hJSDM0R1Llsm8+r83GtIOvPDGo3kiUyn7gmo=;
        b=Lhfwwo82a+fjOa8vunJ07m6qHB6X+FOnsAeRzQt/rT4OUUbWB6lsO1TajfcYWnqOMA+PzR
        qSVARIPyHdaF6Zc2q7ZfofVp4EE50xhRq6AEkmsDM5lxJDZU6XVe7WTz0t7sLqI4wfEMlY
        a0gNuWolhLtztOe8ZecpH3gVW7ey25w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678106495;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HI6JlS7hJSDM0R1Llsm8+r83GtIOvPDGo3kiUyn7gmo=;
        b=hZ0H3qhSxYc0rgaOEaezrExx2qNmE5XUTrPND99JEd/TcGZO4357fCCilY8B2Qi0kRSrJc
        EBwvLNEasDhYrEBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0321613A66;
        Mon,  6 Mar 2023 12:41:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 07eyAH/fBWRcRQAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 06 Mar 2023 12:41:35 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 76870A064F; Mon,  6 Mar 2023 13:41:34 +0100 (CET)
Date:   Mon, 6 Mar 2023 13:41:34 +0100
From:   Jan Kara <jack@suse.cz>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        ext4 Development <linux-ext4@vger.kernel.org>
Subject: Re: The state of ext4 tree merging (was Re: Linux 6.3-rc1)
Message-ID: <20230306124134.hmeuvjhihs4ubpmz@quack3>
References: <CAHk-=wgr1D8hb75Z+nn+4LXUnosp0HM+gP+YJEcEav1DgTC=Cw@mail.gmail.com>
 <ZAVbZJSyOdF0BxAJ@debian.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAVbZJSyOdF0BxAJ@debian.me>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 06-03-23 10:17:56, Bagas Sanjaya wrote:
> On Sun, Mar 05, 2023 at 03:24:41PM -0800, Linus Torvalds wrote:
> > In fact, it was quite nice in a couple of ways: not only didn't I have
> > a hugely compressed merge window where I felt I had to cram as much as
> > possible into the first few days, but the fact that we _have_ had a
> > couple of merge windows where I really asked for people to have
> > everything ready when the merge window opened seems to have set a
> > pattern: the bulk of everything really did come in early.
> > 
> 
> Not so for me watching updates to ext4 merging hell...
> 
> In this merge window, Ted only submitted the first part of ext4 updates
> [1] as noted in the resolution message [2]. The second part didn't make
> through the merge window (PR not sent). As such, the data=writepage
> cleanups have to wait for 6.4 merge window, and it is IMO inconvenient
> for linux-next to contain ext4 tree from next-20230217 for about
> seven weeks, as any enhancements and fixes applied to the tree are
> holding back from testing in linux-next until this hell can be sorted
> out.
> 
> In the long term, I'd like to see a co-maintainer step in to help
> maintaining the tree in case Ted is busy. Of couse I'm not eligible
> for that role (I played as documentation janitor instead), but
> any developer with deep knowledge and experience for the fs and its
> internals should fit the role.

To be fair, the data=journal cleanups got held back only partially due to
the merge issues. Another problem is that they somehow make problems with
filesystem freezing in data=journal mode more frequent and we wanted to
understand (and hopefully fix) that. Of course if Ted could look into this
earlier or I could earlier debug these issues, we could have merged the
cleanups but that's always the case that you have to prioritize and these
cleanups don't have that high priority...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
