Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24C304463DE
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Nov 2021 14:11:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232143AbhKENNl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 5 Nov 2021 09:13:41 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:33032 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbhKENNl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 5 Nov 2021 09:13:41 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1A91E1FD36;
        Fri,  5 Nov 2021 13:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1636117861;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+D5Uh31VWD03//6yBzOXJIfkMHQ9HsyW0RHryr8K+Ag=;
        b=qZMm9oIwreRzq4vVOZVuu2i9KYXfMMwk4dF/GMjYW17p8KFQqhthLaeTaemDUwFPxfpiBb
        /pkJ7ksrSyNBcfeWpXvj8FGEvNBQN0Q8A6+wmlBlQPpbWxWRKPWYOW4yzXbNyrcEfkln5l
        3VKZ0TYSQaL+iz8vpbRI7qfNN1qHlbg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1636117861;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+D5Uh31VWD03//6yBzOXJIfkMHQ9HsyW0RHryr8K+Ag=;
        b=cQQrQG2+6pdK7zPlEZTtILy3Wdcf3zdS8sAdqDrYvwGZSNP23zmn8geOFSFz4zZAQ2s3Ke
        TAdlbF6irp6pv5Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C227314004;
        Fri,  5 Nov 2021 13:11:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3Mi5LWQthWETXgAAMHmgww
        (envelope-from <pvorel@suse.cz>); Fri, 05 Nov 2021 13:11:00 +0000
Date:   Fri, 5 Nov 2021 14:10:59 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        Jan Kara <jack@suse.com>,
        Matthew Bobrowski <repnop@google.com>,
        Ext4 <linux-ext4@vger.kernel.org>, kernel@collabora.com,
        Khazhismel Kumykov <khazhy@google.com>,
        LTP List <ltp@lists.linux.it>
Subject: Re: [LTP] [PATCH v3 0/9] Test the new fanotify FAN_FS_ERROR event
Message-ID: <YYUtYzn+kK3iqQ9h@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20211029211732.386127-1-krisman@collabora.com>
 <YYUDDU0A9hLFbM4c@pevik>
 <CAOQ4uxjpfmhC722jXban2jfSKT+xYQOyaG8OnwuphqM_G_HZ0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjpfmhC722jXban2jfSKT+xYQOyaG8OnwuphqM_G_HZ0A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

> On Fri, Nov 5, 2021 at 12:10 PM Petr Vorel <pvorel@suse.cz> wrote:

> > Hi Gabriel, all,

> > > Hi,

> > > Now that FAN_FS_ERROR is close to being merged, I'm sending a new
> > > version of the LTP tests.  This is the v3 of this patchset, and it
> > > applies the feedback of the previous version, in particular, it solves
> > > the issue Amir pointed out, that ltp won't gracefully handle a test with
> > > tcnt==0.  To solve that, I merged the patch that set up the environment
> > > with a simple test, that only triggers a fs abort and watches the
> > > event.

> > > I'm also renaming the testcase from fanotify20 to fanotify21, to leave
> > > room for the pidfs test that is also in the baking by Matthew Bobrowski.

> > > One important detail is that, for the tests to succeed, there is a
> > > dependency on an ext4 fix I sent a few days ago:

> > > https://lore.kernel.org/linux-ext4/20211026173302.84000-1-krisman@collabora.com/T/#u
> > It has been merged into Theodore Ts'o ext4 tree into dev branch as c1e2e0350ce3
> > ("ext4: Fix error code saved on super block during file system abort")

> > We should probably add it as .tags (see fanotify06.c).

> No point in doing that.
> There will be no kernel release which meets the test requirements
> and has this bug.
Yes, that's correct for stable kernels, enterprise kernels can backport
FAN_FS_ERROR feature, while miss this fix (it does not mention Fixes).

Kind regards,
Petr


> Thanks,
> Amir.
