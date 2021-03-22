Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C233344BAC
	for <lists+linux-ext4@lfdr.de>; Mon, 22 Mar 2021 17:38:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbhCVQhc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 22 Mar 2021 12:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231920AbhCVQhG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 22 Mar 2021 12:37:06 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F6DC061574
        for <linux-ext4@vger.kernel.org>; Mon, 22 Mar 2021 09:37:06 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id j17so8902795qvo.13
        for <linux-ext4@vger.kernel.org>; Mon, 22 Mar 2021 09:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=la+QqpGX3lLyOU/7V5En2ziGH1Lu6wBsMwAgjRuSSvk=;
        b=MNsB3BCUUIEaQ4mOMQAY3leg5DulEEoo3SCq/9qN2zcrbuGzdRKUDbJhNe9T/q4nc2
         kJ2YgO+Zx8XnUOcbF0KI1w/Yii1kacxsdZuF7aDcSpeLbZkceNUnr7azDqYUVgt4FoB2
         bZ8v4tVVSDaDR7ofECvjLcB1c3z0i5S654iUuPTGOnxnSX0d9bZbACub1WFiX7gB5LRE
         YMviSyRd6SwuAJVFVZn82GUip6dUu7Sm77yOqca/65966yY5zYSPiEAgcU75W6zB0dgm
         H/5W+BRvPq61+SX/I+EnsNxMXyBosxSPgvCviKZsbNqT29mr2waGhfh6mGKSiWm/tvGU
         JeUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=la+QqpGX3lLyOU/7V5En2ziGH1Lu6wBsMwAgjRuSSvk=;
        b=h/AN/ay1XwOst3s8g+AoxNTczVCpGFHXWC7sw2pJ/dWNnGjvLJuvudAcAMvj9n4Ghl
         otIbjRfOHsnrkzSZne+ffuWJWZ6w6plTOOPe8dFh/8Ay6wlJfioBGA4QaiPJbK+tY9yP
         PWB0HoJZOMktlTRt2kQxBdjS2ZuHkxY86SiIeJXPycJFv67Qo580a9ZSrIQTcjwkRhvP
         ikCg7wvGS+SGy1/lpR7G9FwDnLz/5+IMZsIUBqYymTXVQfD29YsI283G3Yk6WlcUXuCo
         hSAMhapCq5jRCJDvpxi+garRhhJVg4MDM4bLYQuuQEvmS6YmoOam5oIsY5Q3KlTVmYyR
         GqSg==
X-Gm-Message-State: AOAM531DIHo+vf+TLrdyjomzeMD+XH06CCBq0zCKCZh+sd0Xnpp41CwP
        T4/BuicMHgTFMYt9QR0nkk0=
X-Google-Smtp-Source: ABdhPJyfIkKUr8xVozLcZLY3pgkIMF9stNTQvnzhylr7jRyDr0Aa5bwev/NQAZqLY2PHxgDV3kElqQ==
X-Received: by 2002:a0c:e385:: with SMTP id a5mr494676qvl.12.1616431025494;
        Mon, 22 Mar 2021 09:37:05 -0700 (PDT)
Received: from localhost.localdomain (c-73-60-226-25.hsd1.nh.comcast.net. [73.60.226.25])
        by smtp.gmail.com with ESMTPSA id d24sm11288589qko.54.2021.03.22.09.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 09:37:05 -0700 (PDT)
Date:   Mon, 22 Mar 2021 12:37:03 -0400
From:   Eric Whitney <enwlinux@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Eric Whitney <enwlinux@gmail.com>, linux-ext4@vger.kernel.org,
        tytso@mit.edu
Subject: Re: generic/418 regression seen on 5.12-rc3
Message-ID: <20210322163703.GA32047@localhost.localdomain>
References: <20210318181613.GA13891@localhost.localdomain>
 <20210318201506.GU3420@casper.infradead.org>
 <20210318213808.GA26924@localhost.localdomain>
 <20210318221620.GW3420@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210318221620.GW3420@casper.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

* Matthew Wilcox <willy@infradead.org>:
> On Thu, Mar 18, 2021 at 05:38:08PM -0400, Eric Whitney wrote:
> > * Matthew Wilcox <willy@infradead.org>:
> > > On Thu, Mar 18, 2021 at 02:16:13PM -0400, Eric Whitney wrote:
> > > > As mentioned in today's ext4 concall, I've seen generic/418 fail from time to
> > > > time when run on 5.12-rc3 and 5.12-rc1 kernels.  This first occurred when
> > > > running the 1k test case using kvm-xfstests.  I was then able to bisect the
> > > > failure to a patch landed in the -rc1 merge window:
> > > > 
> > > > (bd8a1f3655a7) mm/filemap: support readpage splitting a page
> > > 
> > > Thanks for letting me know.  This failure is new to me.
> > 
> > Sure - it's useful to know that it's new to you.  Ted said he's also going
> > to test XFS with a large number of generic/418 trials which would be a
> > useful comparison.  However, he's had no luck as yet reproducing what I've
> > seen on his Google compute engine test setup running ext4.
> > 
> > > 
> > > I don't understand it; this patch changes the behaviour of buffered reads
> > > from waiting on a page with a refcount held to waiting on a page without
> > > the refcount held, then starting the lookup from scratch once the page
> > > is unlocked.  I find it hard to believe this introduces a /new/ failure.
> > > Either it makes an existing failure easier to hit, or there's a subtle
> > > bug in the retry logic that I'm not seeing.
> > > 
> > 
> > For keeping Murphy at bay I'm rerunning the bisection from scratch just
> > to make sure I come out at the same patch.  The initial bisection looked
> > clean, but when dealing with a failure that occurs probabilistically it's
> > easy enough to get it wrong.  Is this patch revertable in -rc1 or -rc3?
> > Ordinarily I like to do that for confirmation.
> 
> Alas, not easily.  I've built a lot on top of it since then.  I could
> probably come up with a moral reversion (and will have to if we can't
> figure out why it's causing a problem!)
> 
> > And there's always the chance that a latent ext4 bug is being hit.
> 
> That would also be valuable information to find out.  If this
> patch is exposing a latent bug, I can't think what it might be.
> 
> > I'd be very happy to run whatever debugging patches you might want, though
> > you might want to wait until I've reproduced the bisection result.  The
> > offsets vary, unfortunately - I've seen 1024, 2048, and 3072 reported when
> > running a file system with 4k blocks.
> 
> As I expected, but thank you for being willing to run debug patches.
> I'll wait for you to confirm the bisection and then work up something
> that'll help figure out what's going on.

An update:

I've been able to rerun the bisection on a freshly installed test appliance
using a kernel built from a new tree using different test hardware.  It ended
at the same patch - "mm/filemap: support readpage splitting a page".

I'd thought I'd been able to reproduce the failure using ext4's 4K block size,
but my test logs say otherwise, as do a few thousand trial runs of generic/418.
So, at the moment I can only say definitively that I've seen the failures when
running with 1k blocks (block size < page size).

I've been able to simplify generic/418 by reducing the set of test cases it
uses to just "-w", or direct I/O writes.  When I modify the test to remove
just that test case and leaving the remainder, I no longer see test failures.
A beneficial side effect of the simplification is that it reduces the running
time by an order of magnitude.

When it fails, it looks like the test is writing via dio a chunk of bytes all
of which have been set to 0x1 and then reading back via dio the same chunk with
all those bytes equal to 0x0.

I'm attempting to create a simpler reproducer.  generic/418 actually has a
number of processes simultaneously writing to and reading from disjoint
regions of the same file, and I'd like to see if the failure is dependent
upon that behavior, or whether it can be isolated to a single writer/reader.

Eric





