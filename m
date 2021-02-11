Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6EA319041
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Feb 2021 17:45:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbhBKQn5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 11 Feb 2021 11:43:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:33650 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230326AbhBKQmF (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 11 Feb 2021 11:42:05 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613061677; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=49277//KwxbjQ405XwayXDeBcBaVqNsLWaTMf3MliEo=;
        b=YV5YY0wNG1juqlUn4dbLg5e38JEvoh38LhXzPWw7qoeQqD4eW6kYuna41RTqh46JN+/Mry
        5awcoW5BM4BtWa4GjbgXfx6pzlWQm1G/96w08Tmo16oMjOTkVb74Y8m4+5necwrZ+bpTJk
        JUcMDs3qmoMDTdlggXe5mSkmOda7ZSY=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C4B87AC43;
        Thu, 11 Feb 2021 16:41:17 +0000 (UTC)
Date:   Thu, 11 Feb 2021 17:41:16 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+bfdded10ab7dcd7507ae@syzkaller.appspotmail.com>,
        Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Theodore Ts'o <tytso@mit.edu>, Linux-MM <linux-mm@kvack.org>
Subject: Re: possible deadlock in start_this_handle (2)
Message-ID: <YCVeLF8aZGfRVY3C@dhcp22.suse.cz>
References: <20210211104947.GL19070@quack2.suse.cz>
 <CACT4Y+b5gSAAtX3DUf-H3aRxbir44MTO6BCC3XYvN=6DniT+jw@mail.gmail.com>
 <CACT4Y+a_iyaYY18Uw28bd178xjso=n6jfMBjyZuYJiNeo8x+LQ@mail.gmail.com>
 <20210211121020.GO19070@quack2.suse.cz>
 <YCUkaJFoPkl7ZvKE@dhcp22.suse.cz>
 <20210211125717.GH308988@casper.infradead.org>
 <YCUr99//z8hJmnDH@dhcp22.suse.cz>
 <20210211132533.GI308988@casper.infradead.org>
 <YCU9OR7SfRpwl4+4@dhcp22.suse.cz>
 <20210211142630.GK308988@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210211142630.GK308988@casper.infradead.org>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 11-02-21 14:26:30, Matthew Wilcox wrote:
> On Thu, Feb 11, 2021 at 03:20:41PM +0100, Michal Hocko wrote:
> > On Thu 11-02-21 13:25:33, Matthew Wilcox wrote:
> > > On Thu, Feb 11, 2021 at 02:07:03PM +0100, Michal Hocko wrote:
> > > > On Thu 11-02-21 12:57:17, Matthew Wilcox wrote:
> > > > > > current->flags should be always manipulated from the user context. But
> > > > > > who knows maybe there is a bug and some interrupt handler is calling it.
> > > > > > This should be easy to catch no?
> > > > > 
> > > > > Why would it matter if it were?
> > > > 
> > > > I was thinking about a clobbered state because updates to ->flags are
> > > > not atomic because this shouldn't ever be updated concurrently. So maybe
> > > > a racing interrupt could corrupt the flags state?
> > > 
> > > I don't think that's possible.  Same-CPU races between interrupt and
> > > process context are simpler because the CPU always observes its own writes
> > > in order and the interrupt handler completes "between" two instructions.
> > 
> > I have to confess I haven't really thought the scenario through. My idea
> > was to simply add a simple check for an irq context into ->flags setting
> > routine because this should never be done in the first place. Not only
> > for scope gfp flags but any other PF_ flags IIRC.
> 
> That's not automatically clear to me.  There are plenty of places
> where an interrupt borrows the context of the task that it happens to
> have interrupted.  Specifically, interrupts should be using GFP_ATOMIC
> anyway, so this doesn't really make a lot of sense, but I don't think
> it's necessarily wrong for an interrupt to call a function that says
> "Definitely don't make GFP_FS allocations between these two points".

Not sure I got your point. IRQ context never does reclaim so anything
outside of NOWAIT/ATOMIC is pointless. But you might be refering to a
future code where GFP_FS might have a meaning outside of the reclaim
context?

Anyway if we are to allow modifying PF_ flags from an interrupt contenxt
then I believe we should make that code IRQ aware at least. I do not
feel really comfortable about async modifications when this is stated to
be safe doing in a non atomic way.

But I suspect we have drifted away from the original issue. I thought
that a simple check would help us narrow down this particular case and
somebody messing up from the IRQ context didn't sound like a completely
off.

-- 
Michal Hocko
SUSE Labs
