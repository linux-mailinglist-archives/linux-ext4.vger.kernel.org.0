Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A033347B290
	for <lists+linux-ext4@lfdr.de>; Mon, 20 Dec 2021 19:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233610AbhLTSHj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 20 Dec 2021 13:07:39 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:52738 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbhLTSHj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 20 Dec 2021 13:07:39 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C5F45218FC;
        Mon, 20 Dec 2021 18:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1640023657;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jTf/rOfLIo/IHEJv+ideVPj0MhsHO3/HazU84UhMJGo=;
        b=f7s2/f/XtE//e5+p5rqTe+cP4RT8pNVh4oifsm394oTIr7Wzl3ht5ub1dtBmlPEheYm4I+
        WgLqqNGTm4EHv1ca+filzt9wAO9sgP54jw5ONv4epxRiiKe6Pa22qfBWhGsc8mrQ9QtIUd
        VeFk/V8WQt55tX6sM78dG12qXuTTBQ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1640023657;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jTf/rOfLIo/IHEJv+ideVPj0MhsHO3/HazU84UhMJGo=;
        b=aGlRhTL+kYuxwMfUA/QL8cFY29Xlbwnm3Hl+hN1zuD2P7gInmf1b1/Rw+Uw8GYBVhJ84uf
        V+UGUihUJ8bl3JCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 520BF13DBD;
        Mon, 20 Dec 2021 18:07:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id I3sTEWnGwGFJfAAAMHmgww
        (envelope-from <pvorel@suse.cz>); Mon, 20 Dec 2021 18:07:37 +0000
Date:   Mon, 20 Dec 2021 19:07:35 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com, Khazhismel Kumykov <khazhy@google.com>,
        Matthew Bobrowski <repnop@google.com>,
        Jan Kara <jack@suse.com>, Ext4 <linux-ext4@vger.kernel.org>,
        LTP List <ltp@lists.linux.it>, Cyril Hrubis <chrubis@suse.cz>,
        Richard Palethorpe <rpalethorpe@suse.com>
Subject: Re: [LTP] [PATCH v4 0/9] Test the new fanotify FAN_FS_ERROR event
Message-ID: <YcDGZ+eNcQ5fPsmN@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20211118235744.802584-1-krisman@collabora.com>
 <CAOQ4uxhbDgdZZ0qphWg1vnW4ZoAkUxcQp631yZO8W49AE18W9g@mail.gmail.com>
 <8735nsuepi.fsf@collabora.com>
 <YZtLDXW01Cz0BfPU@pevik>
 <YZ4Wf3d+J36NPMfS@pevik>
 <CAOQ4uxgg6BvUtcaD4stDv7meS0it-0-iDWNiz_-=SRN_tvgzYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgg6BvUtcaD4stDv7meS0it-0-iDWNiz_-=SRN_tvgzYQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Amir,

[ Cc Cyril and Richie ]

> On Wed, Nov 24, 2021 at 12:40 PM Petr Vorel <pvorel@suse.cz> wrote:

> > Hi all,

> > <snip>
> > > > Hi Amir,

> > > > I have pushed v4 to :

> > > > https://gitlab.collabora.com/krisman/ltp.git -b fan-fs-error_v4

> > > FYI I've rebased it on my fix 3b2ea2e00 ("configure.ac: Add struct
> > > fanotify_event_info_pidfd check")

> > > https://github.com/linux-test-project/ltp.git -b gertazi/fanotify21.v4.fixes

> > FYI I removed branch from official LTP repository and put it to my fork
> > https://github.com/pevik/ltp.git -b fan-fs-error_v4.fixes


> Hi Petr,

> Are you waiting with this merge for after release of v5.16?
> or is it just waiting behind other work?
Yes. Thanks for this input, we're just discussing our policy about tests for new
(kernel) release functionality. First we agreed to wait [1] (due problems
described in [2]), Richie is suggesting to merge earlier [2], although Cyril
had doubts it's worth of the work [3].

Kind regards,
Petr

> Just asking out of curiosity.
> I've based my tests for fan_rename (queued for v5.17) on top of your branch.

> Thanks,
> Amir.

[1] https://lore.kernel.org/ltp/20211210134556.26091-1-pvorel@suse.cz/
[2] https://lore.kernel.org/ltp/87lf0ffw1y.fsf@suse.de/
[3] https://lore.kernel.org/ltp/Ybc5QJSZM3YIji70@yuki/
