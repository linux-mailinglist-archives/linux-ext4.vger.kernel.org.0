Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 262F3341041
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Mar 2021 23:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232096AbhCRWQu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 18 Mar 2021 18:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbhCRWQY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 18 Mar 2021 18:16:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E910C06174A
        for <linux-ext4@vger.kernel.org>; Thu, 18 Mar 2021 15:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=k7Ro5lc1J0OxwKXJ6kFoLtpqg9O1mEoih7hEmVUixZg=; b=AnqKu79NWW6atjWst3/ugWiUIX
        wSFbMGIB7DgrifgIKIzT6+O3AkxwebN3YqzS05BzeANnZRSPalv3eFxx94O9s1+NgvmBpgaFUPqCr
        lim62ywtKg4nGPeIizKWEACD6ericAu2NFOz1DsyrFadCjW5KMSQtHZJfetKkrNZsy+RH4OCPe68z
        FECqcw7dOWpaxGDj29vkviFJJPeZNQ4Y8/mkRoxsTzmpSCuMRJHxS+B8zHBsdbgzlgKQmpdFhG5iX
        P07h7gD/i+Ny0oD40VZU9yvk8pzgHbekNoVK87fnGEHfYTS2pecEc6+l+r9OmCLutwWJ6KN+n2vdL
        2ke7Zwzg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lN0wG-003YZ8-Hn; Thu, 18 Mar 2021 22:16:21 +0000
Date:   Thu, 18 Mar 2021 22:16:20 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Eric Whitney <enwlinux@gmail.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu
Subject: Re: generic/418 regression seen on 5.12-rc3
Message-ID: <20210318221620.GW3420@casper.infradead.org>
References: <20210318181613.GA13891@localhost.localdomain>
 <20210318201506.GU3420@casper.infradead.org>
 <20210318213808.GA26924@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210318213808.GA26924@localhost.localdomain>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Mar 18, 2021 at 05:38:08PM -0400, Eric Whitney wrote:
> * Matthew Wilcox <willy@infradead.org>:
> > On Thu, Mar 18, 2021 at 02:16:13PM -0400, Eric Whitney wrote:
> > > As mentioned in today's ext4 concall, I've seen generic/418 fail from time to
> > > time when run on 5.12-rc3 and 5.12-rc1 kernels.  This first occurred when
> > > running the 1k test case using kvm-xfstests.  I was then able to bisect the
> > > failure to a patch landed in the -rc1 merge window:
> > > 
> > > (bd8a1f3655a7) mm/filemap: support readpage splitting a page
> > 
> > Thanks for letting me know.  This failure is new to me.
> 
> Sure - it's useful to know that it's new to you.  Ted said he's also going
> to test XFS with a large number of generic/418 trials which would be a
> useful comparison.  However, he's had no luck as yet reproducing what I've
> seen on his Google compute engine test setup running ext4.
> 
> > 
> > I don't understand it; this patch changes the behaviour of buffered reads
> > from waiting on a page with a refcount held to waiting on a page without
> > the refcount held, then starting the lookup from scratch once the page
> > is unlocked.  I find it hard to believe this introduces a /new/ failure.
> > Either it makes an existing failure easier to hit, or there's a subtle
> > bug in the retry logic that I'm not seeing.
> > 
> 
> For keeping Murphy at bay I'm rerunning the bisection from scratch just
> to make sure I come out at the same patch.  The initial bisection looked
> clean, but when dealing with a failure that occurs probabilistically it's
> easy enough to get it wrong.  Is this patch revertable in -rc1 or -rc3?
> Ordinarily I like to do that for confirmation.

Alas, not easily.  I've built a lot on top of it since then.  I could
probably come up with a moral reversion (and will have to if we can't
figure out why it's causing a problem!)

> And there's always the chance that a latent ext4 bug is being hit.

That would also be valuable information to find out.  If this
patch is exposing a latent bug, I can't think what it might be.

> I'd be very happy to run whatever debugging patches you might want, though
> you might want to wait until I've reproduced the bisection result.  The
> offsets vary, unfortunately - I've seen 1024, 2048, and 3072 reported when
> running a file system with 4k blocks.

As I expected, but thank you for being willing to run debug patches.
I'll wait for you to confirm the bisection and then work up something
that'll help figure out what's going on.
