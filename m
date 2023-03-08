Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1C016B0ED8
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Mar 2023 17:37:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbjCHQhL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Mar 2023 11:37:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjCHQhJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 Mar 2023 11:37:09 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2A1C48AB
        for <linux-ext4@vger.kernel.org>; Wed,  8 Mar 2023 08:37:08 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 43ABB1FE52;
        Wed,  8 Mar 2023 16:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678293427; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/auPBvdSlPMpoAYc5nvNc3l/ve+OsvaEWd/pWn1i7lA=;
        b=LiSg47hrX8tuo1G8uyjVMCVaE7IQzIWNZKj5J613vNP+pITyUEyqBiLUIrhMadNhervP/O
        6BcEzJrCQAsj/484gDcItaxS5n4flXA3jRb5eipSGqfcbfy8bpT2ADxNLfcOzmpibH92S0
        lTi1ffqhNCerjyJXUJmVDJ1zcolvFak=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678293427;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/auPBvdSlPMpoAYc5nvNc3l/ve+OsvaEWd/pWn1i7lA=;
        b=SopJcVkqp7jA4iBX7JEQH+1AmX5z0tHuleyXqPZM0dwkaWZrGh07+31TXypZnj6oiDEPVV
        d45KzNcRvcTJuDDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3587D1391B;
        Wed,  8 Mar 2023 16:37:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id T2oJDbO5CGS/OQAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 08 Mar 2023 16:37:07 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id C3ECAA06FF; Wed,  8 Mar 2023 17:37:06 +0100 (CET)
Date:   Wed, 8 Mar 2023 17:37:06 +0100
From:   Jan Kara <jack@suse.cz>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Jan Kara <jack@suse.cz>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH REBASED 0/7] ext4: Cleanup data=journal writeback path
Message-ID: <20230308163706.t5izn75mhoflxa73@quack3>
References: <20230228051319.4085470-1-tytso@mit.edu>
 <20230228135854.ky2zpwal7trz6yg3@quack3>
 <ZACmnwm9in84kbOB@mit.edu>
 <20230303092939.kq4mlowe2y2x6ncx@quack3>
 <20230303103806.77ipbtzz7n5hawim@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230303103806.77ipbtzz7n5hawim@quack3>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 03-03-23 11:38:06, Jan Kara wrote:
> On Fri 03-03-23 10:29:39, Jan Kara wrote:
> > On Thu 02-03-23 08:37:35, Theodore Ts'o wrote:
> > > On Tue, Feb 28, 2023 at 02:58:54PM +0100, Jan Kara wrote:
> > > > 
> > > > Regarding the warning somehow there are dirty pages left after the
> > > > procedures freeze_super() goes through to flush all dirty data. That is not
> > > > too surprising since in data=journal mode pages get (as a surprise to
> > > > freezing code) dirtied when transaction commits. I thought we have this
> > > > covered by jbd2_journal_flush() call in ext4_freeze() but maybe there are
> > > > some stranded PageDirty bits left? It needs more debugging...
> > > 
> > > So the question I have is whether this is a bug that was always there,
> > > or perhaps code changes affected the timing, so that it was much more
> > > likely to happen (although in my testing it's still only triggering
> > > about 50% of the time).
> > > 
> > > This warning can mean that data can be lost, especially if someone was
> > > doing hibernation, right?  We can discuss this at today's ext4 video
> > > conference, but I'm inclined to wait until the next merge cycle for
> > > this patch series until we can figure out what's going on.  Jan, what
> > > do you think?
> > 
> > As we discussed in the meeting, I'll have a look into the failure. For now
> > I'd keep patches on hold as it is not urgent patchset.
> 
> FWIW I'm able to reproduce the issue and also as I'm looking into the
> freeze to it was always there in principle. But my patches likely made it
> much more probable. I'll have a look what I can do...

So in the end this was mostly a cosmetic issue (jbd2 checkpointing code
leaving dirty bits on pages whose buffer heads were already written). Patch
submitted.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
