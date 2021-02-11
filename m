Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EEAC318C0E
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Feb 2021 14:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbhBKN3m (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 11 Feb 2021 08:29:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231803AbhBKN00 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 11 Feb 2021 08:26:26 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F6F5C061756;
        Thu, 11 Feb 2021 05:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7Zj6jFAS+43OA9xryJ9Sq954x04SppEwar4znZPx9xs=; b=WfRimx5FHijTwPQj7TC/MRA2qw
        XdqVvkmsjawqktNsX27cT8MSQHul4JBuIDryEYK83ezFS3WTGXftzxVQnGs/DewS/bUNry+5y8bJA
        1iGdiNZr7SyIW8PpSqBpaMEb6+vzBjTJCwPBKML1Os01dP5K6rLD68MfH+jwao3Y3uaS3iAqnB5q7
        UuzYK1TlkiDAZfFLtvyxy5SZNYNX2wcJna/ix2xTcu7ncmH4O4nDE0TxpFWK/tu5aJfZo5BURfKle
        htvDfxOr9GmAvr0HkDzOC8Zl8+mf02HxTzmrNaQD7fqobaC3oZBWVVyBNg79IT0yL2/r1FNi8gYt3
        RR8rRK9A==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lAByP-00AHMu-21; Thu, 11 Feb 2021 13:25:33 +0000
Date:   Thu, 11 Feb 2021 13:25:33 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Jan Kara <jack@suse.cz>, Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+bfdded10ab7dcd7507ae@syzkaller.appspotmail.com>,
        Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Theodore Ts'o <tytso@mit.edu>, Linux-MM <linux-mm@kvack.org>
Subject: Re: possible deadlock in start_this_handle (2)
Message-ID: <20210211132533.GI308988@casper.infradead.org>
References: <000000000000563a0205bafb7970@google.com>
 <20210211104947.GL19070@quack2.suse.cz>
 <CACT4Y+b5gSAAtX3DUf-H3aRxbir44MTO6BCC3XYvN=6DniT+jw@mail.gmail.com>
 <CACT4Y+a_iyaYY18Uw28bd178xjso=n6jfMBjyZuYJiNeo8x+LQ@mail.gmail.com>
 <20210211121020.GO19070@quack2.suse.cz>
 <YCUkaJFoPkl7ZvKE@dhcp22.suse.cz>
 <20210211125717.GH308988@casper.infradead.org>
 <YCUr99//z8hJmnDH@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YCUr99//z8hJmnDH@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Feb 11, 2021 at 02:07:03PM +0100, Michal Hocko wrote:
> On Thu 11-02-21 12:57:17, Matthew Wilcox wrote:
> > > current->flags should be always manipulated from the user context. But
> > > who knows maybe there is a bug and some interrupt handler is calling it.
> > > This should be easy to catch no?
> > 
> > Why would it matter if it were?
> 
> I was thinking about a clobbered state because updates to ->flags are
> not atomic because this shouldn't ever be updated concurrently. So maybe
> a racing interrupt could corrupt the flags state?

I don't think that's possible.  Same-CPU races between interrupt and
process context are simpler because the CPU always observes its own writes
in order and the interrupt handler completes "between" two instructions.

eg a load-store CPU will do:

load 0 from address A
or 8 with result
store 8 to A

Two CPUs can do:

CPU 0			CPU 1
load 0 from A
			load 0 from A
or 8 with 0
			or 4 with 0
store 8 to A
			store 4 to A

and the store of 8 is lost.

process			interrupt
load 0 from A
			load 0 from A
			or 4 with 0
			store 4 to A
or 8 with 0
store 8 to A

so the store of 4 would be lost.

but we expect the interrupt handler to restore it.  so we actually have this:

load 0 from A
			load 0 from A
			or 4 with 0
			store 4 to A
			load 4 from A
			clear 4 from 4
			store 0 to A
or 8 with 0
store 8 to A


If we have a leak where someone forgets to restore the nofs, that might
cause this.  We could check for the allocation mask bits being clear at
syscall exit (scheduling with these flags set is obviously ok).
