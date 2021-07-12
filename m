Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 547D53C59D3
	for <lists+linux-ext4@lfdr.de>; Mon, 12 Jul 2021 13:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350982AbhGLJJH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 12 Jul 2021 05:09:07 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:56014 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379744AbhGLJHs (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 12 Jul 2021 05:07:48 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 4A0C81FF64;
        Mon, 12 Jul 2021 09:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1626080699; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XTzSB4J3/KV9nyIyfWQISjsIgq8wiabBhC/21wJ8J7s=;
        b=r9+JNf86vghp3AmGz2Y+BgUigg7+6NU9fboAOWM+kFnkcwwy+VGSapzT8B5cLPClYhVts+
        0JSgNO39hiPSvKHHP2nG4pcRIoFO26FyA255ZHVKejlvLK4DcAa2ROMujTBPsV1LyQoMgN
        DNb8zud25yPdyiFQjZBIT3uVac0LbGw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1626080699;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XTzSB4J3/KV9nyIyfWQISjsIgq8wiabBhC/21wJ8J7s=;
        b=GreD0oYsAv9e4RdhYQOn62ltTqwvcLI0bB22U43iqF4Gh5w14UKwzuXG+2SS2txezGKRRy
        VJgCpMpGJ4VrMzAg==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 3B2C3A3C0D;
        Mon, 12 Jul 2021 09:04:59 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 0A12D1E62D6; Mon, 12 Jul 2021 11:04:59 +0200 (CEST)
Date:   Mon, 12 Jul 2021 11:04:59 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ivan Zahariev <famzah@famzah.net>
Cc:     Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org
Subject: Re: jbd2: fix deadlock while checkpoint thread waits commit thread
 to finish (backport to 4.14)
Message-ID: <20210712090459.GA27936@quack2.suse.cz>
References: <3221ced0-e8f3-53da-3474-28367272f35d@famzah.net>
 <YOY+SXgPShxGzyJO@mit.edu>
 <44dd99fc-11ce-6a73-20bd-6ee645c5dd5e@famzah.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <44dd99fc-11ce-6a73-20bd-6ee645c5dd5e@famzah.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 08-07-21 06:45:35, Ivan Zahariev wrote:
> Out of thousand machines, one would trigger the problem about every 1 to 10
> days. Some machines trigger the problem much often than others. So I can say
> that we have a way to verify quickly if applying the patch will fix this for
> us.
> 
> The most important question is: Is it safe to apply the patch on production
> machines with kernel 4.14?
> 
> We can't risk data loss. And I lack the expertise to asses what risks this
> small patch brings.

The fix should work correctly even for older kernels. I'm not aware of any
changes in this area in the past that could conflict...

								Honza

> On 8.7.2021 г. 2:52, Theodore Ts'o wrote:
> > On Wed, Jul 07, 2021 at 09:42:25PM +0300, Ivan Zahariev wrote:
> > > Hello,
> > > 
> > > We're running Linux kernel 4.14.x and our systems occasionally suffer a bug
> > > which is already fixed: https://github.com/torvalds/linux/commit/53cf978457325d8fb2cdecd7981b31a8229e446e
> > > 
> > > This bugfix hasn't been ported to Linux kernels 4.14 or 4.19. The patch
> > > applies cleanly. The two files "fs/jbd2/checkpoint.c" and
> > > "fs/jbd2/journal.c" seem pretty identical in the affected sections compared
> > > to kernel 5.4 where we have this bugfix already applied.
> > > 
> > > Is it on purpose that this bugfix hasn't been ported to 4.14? Is it safe
> > > that we backport it manually in our kernel 4.14 builds? Or is the "ext4"
> > > system in 4.14 and 5.4 fundamentally different and this would lead to data
> > > loss or other problems?
> > The commit was over two years ago, so my memory is not going to be
> > perfect.  However, Jan had made a comment suggesting the approach in
> > this commit because it should be easier to backport into older stble
> > kernels[1].
> > 
> >     "Since proper locking change is going to be a bit more involved, can you
> >      perhaps fix this deadlock by just dropping j_checkpoint_mutex in
> >      log_do_checkpoint() when we are going to wait for transaction commit. I've
> >      checked and that should be fine and that is going to be much easier change
> >      to backport into stable kernels..."
> > 
> > [1] https://marc.info/?l=linux-ext4&m=154212553014669&w=2
> > 
> > So I suspect it was just that I failed to remember to add a "Cc:
> > stable@kernel.org" and so it was never automatically backported into
> > 4.14 or 4.19.
> > 
> > Do you have a reliable reproduction which is triggering the deadlock
> > on your kernels?  If so, have you tried applying the patch and does it
> > make the problem go away for you?
> > 
> > Cheers,
> > 
> > 						- Ted
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
