Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D35427D0E1E
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Oct 2023 13:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376860AbjJTLHp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 20 Oct 2023 07:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376745AbjJTLHo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 20 Oct 2023 07:07:44 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F0DCA;
        Fri, 20 Oct 2023 04:07:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C297A1F45B;
        Fri, 20 Oct 2023 11:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1697800059; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hqkENciefP1goVr5brNJmEfCB2IMUZkNv2PO6yd0b5o=;
        b=AV/kHOCETVbtL/H+fR/4ic7BkdoBS0HDJwc505gz9HwTk9oli+MavpIeonz3dmPPDhwHFv
        JVNT4yw17XoTsKT0RtFxLwzDusiK5b/g01rHty0TZeYx0vD1vkS4CU27ksX8m6InutKa3Q
        m9LvvV2h432EHzuzkuqxUfk5ZUaDd5g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1697800059;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hqkENciefP1goVr5brNJmEfCB2IMUZkNv2PO6yd0b5o=;
        b=ELRj3NvhoAE9XM0Xs11gNKDNnv1Gjl2oL9fCxEZiB8MNqQcbqOlcnUfUVGVQmVZqOFwCbA
        GTjfKtvZmhmWh5AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B0823138E2;
        Fri, 20 Oct 2023 11:07:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ad/7KntfMmUZZQAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 20 Oct 2023 11:07:39 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 231BDA06E3; Fri, 20 Oct 2023 13:07:39 +0200 (CEST)
Date:   Fri, 20 Oct 2023 13:07:39 +0200
From:   Jan Kara <jack@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>, Jan Kara <jack@suse.cz>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Ferry Toth <ftoth@exalondelft.nl>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [GIT PULL] ext2, quota, and udf fixes for 6.6-rc1
Message-ID: <20231020110739.qfscu56ekan4wqd2@quack3>
References: <ZS6wLKrQJDf1_TUe@smile.fi.intel.com>
 <20231018184613.tphd3grenbxwgy2v@quack3>
 <ZTDtAiDRuPcS2Vwd@smile.fi.intel.com>
 <20231019101854.yb5gurasxgbdtui5@quack3>
 <ZTEap8A1W3IIY7Bg@smile.fi.intel.com>
 <ZTFAzuE58mkFbScV@smile.fi.intel.com>
 <20231019164240.lhg5jotsh6vfuy67@treble>
 <ZTFh0NeYtvgcjSv8@smile.fi.intel.com>
 <CAHk-=wjXG52UNKCwwEU1A+QWHYfvKOieV0uFOpPkLR0NSvOjtg@mail.gmail.com>
 <CAHk-=whis2BJF2fv1xySAg2NTQ+C5fViNSGkLNCOqGzi-3y+8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whis2BJF2fv1xySAg2NTQ+C5fViNSGkLNCOqGzi-3y+8w@mail.gmail.com>
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -4.64
X-Spamd-Result: default: False [-4.64 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         RCPT_COUNT_SEVEN(0.00)[10];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_NOT_FQDN(0.50)[];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-1.04)[87.57%]
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 19-10-23 10:51:18, Linus Torvalds wrote:
> On Thu, 19 Oct 2023 at 10:26, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > That said, the quota dependency is quite odd, since normally I
> > wouldn't expect the quota code to really even trigger much during
> > boot. When it triggers that consistently, and that early during boot,
> > I would expect others to have reported more of this.
> >
> > Strange.
> 
> Hmm. I do think the quota list handling has some odd things going on.
> And it did change with the whole ->dq_free thing.
> 
> Some of it is just bad:
> 
>   #ifdef CONFIG_QUOTA_DEBUG
>           /* sanity check */
>           BUG_ON(!list_empty(&dquot->dq_free));
>   #endif
> 
> is done under a spinlock, and if it ever triggers, the machine is
> dead. Dammit, I *hate* how people use BUG_ON() for assertions. It's a
> disgrace. That should be a WARN_ON_ONCE().

I agree. I should go one day and replace these BUG_ONs. This one is from
2006 when we were more accepting of such checks...

> And it does have quite a bit of list-related changes, with the whole
> series from Baokun Li changing how the ->dq_free list works.
> 
> The fact that it consistently bisects to the merge is still odd.

Yes. Plus Andy said that when he reverts quota changes on top of the merge
commit the resulting kernel still crashes. Really puzzling.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
