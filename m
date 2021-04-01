Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9E1351EC4
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Apr 2021 20:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236817AbhDASqp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 1 Apr 2021 14:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238227AbhDASoo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 1 Apr 2021 14:44:44 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DEB7C02258B
        for <linux-ext4@vger.kernel.org>; Thu,  1 Apr 2021 10:46:42 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id iu14so1403702qvb.4
        for <linux-ext4@vger.kernel.org>; Thu, 01 Apr 2021 10:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5OMntDA2FM97HxcZAmCmRSP2NYssDkXawHr9+Rd4nAA=;
        b=AfvQo1Arr/cRsrPUwMC94gLCqLOCUn1dHPoesBklBaAwf9COaxYji90TrCqQX1Hyy2
         CyBsmXJdkVpoTTNGGCWvPbcBDUqsOlpBQBYPf3+mEd8Ylnd9LyoKTyM9DAZUOPkG9wTn
         SiTN1IkrECcWfod+s20ZzPVR46kwjyiRIG0uVPPO6yabUohcK6XjbLHMrD3d/u2WnpyK
         w4RIYzf29AhtkLccbW96M6xQ8+InKh0zzCnCXfNVXI4+C1nKZR0KBnLsLCsSEfLQXg6v
         MLtMPvV6BsC4tY7qZWSg6jtJC3G0FxvXgK7X6d+tjb1N4S/pU11rkwusPyfxr0NnpmV7
         WCcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5OMntDA2FM97HxcZAmCmRSP2NYssDkXawHr9+Rd4nAA=;
        b=uCalNlHkWd2K+gVrwR9IDatsabn2uHS/HevXaHUMyfVf4o0H0LQbMWLlLcnhI7Mh85
         i21r0fQemnhyanJrKL1+EfmROj8RvIneXaMr8xAaiA4+k9sNR3S9RkrC9LN32K4GViRF
         b1f0suDOnY6i5QaMyEbg0HWAm55Nq+x3UKzkmZtWp7lL4I/gX8FGvaOtPa/sBupX4/Fl
         p2QhlIO0j8+dQH8nVper2QlWcorp/lq318L8tUM1hZmm1K6i/EVJIsgd2DP1TJbeKu1A
         Od6LCN0KFZN5KlzDrSswLEhfPX5IUB1PQFKB26iKs5pWRnvONjZitcCex6p6A8XJRUK2
         JVhg==
X-Gm-Message-State: AOAM532T5M1g2Jcb26NyPisbnhywx8MTPH6qRkpej1dYu1Sou4FGdJpk
        QoJVsj19QMUEfHpvnCKxLnXxcol7/Rk=
X-Google-Smtp-Source: ABdhPJz5+SG2/RLPlspacpdsm1T2r1nNIDX24CyY/fHhcoupzSSQ5RR5azz8Lt8pQ33Zr4AbU6q4sw==
X-Received: by 2002:a05:6214:80a:: with SMTP id df10mr9454422qvb.46.1617299201339;
        Thu, 01 Apr 2021 10:46:41 -0700 (PDT)
Received: from localhost.localdomain (c-73-60-226-25.hsd1.nh.comcast.net. [73.60.226.25])
        by smtp.gmail.com with ESMTPSA id f9sm4475916qkk.115.2021.04.01.10.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 10:46:41 -0700 (PDT)
Date:   Thu, 1 Apr 2021 13:46:39 -0400
From:   Eric Whitney <enwlinux@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Eric Whitney <enwlinux@gmail.com>, linux-ext4@vger.kernel.org,
        tytso@mit.edu
Subject: Re: generic/418 regression seen on 5.12-rc3
Message-ID: <20210401174639.GA714@localhost.localdomain>
References: <20210318181613.GA13891@localhost.localdomain>
 <20210318201506.GU3420@casper.infradead.org>
 <20210318213808.GA26924@localhost.localdomain>
 <20210318221620.GW3420@casper.infradead.org>
 <20210322163703.GA32047@localhost.localdomain>
 <20210328024106.GK1719932@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210328024106.GK1719932@casper.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

* Matthew Wilcox <willy@infradead.org>:
> On Mon, Mar 22, 2021 at 12:37:03PM -0400, Eric Whitney wrote:
> > * Matthew Wilcox <willy@infradead.org>:
> > > On Thu, Mar 18, 2021 at 05:38:08PM -0400, Eric Whitney wrote:
> > > > * Matthew Wilcox <willy@infradead.org>:
> > > > > On Thu, Mar 18, 2021 at 02:16:13PM -0400, Eric Whitney wrote:
> > > > > > As mentioned in today's ext4 concall, I've seen generic/418 fail from time to
> > > > > > time when run on 5.12-rc3 and 5.12-rc1 kernels.  This first occurred when
> > > > > > running the 1k test case using kvm-xfstests.  I was then able to bisect the
> > > > > > failure to a patch landed in the -rc1 merge window:
> > > > > > 
> > > > > > (bd8a1f3655a7) mm/filemap: support readpage splitting a page
> > > > > 
> > > > > Thanks for letting me know.  This failure is new to me.
> > > > 
> > > > Sure - it's useful to know that it's new to you.  Ted said he's also going
> > > > to test XFS with a large number of generic/418 trials which would be a
> > > > useful comparison.  However, he's had no luck as yet reproducing what I've
> > > > seen on his Google compute engine test setup running ext4.
> > > > 
> > > > > 
> > > > > I don't understand it; this patch changes the behaviour of buffered reads
> > > > > from waiting on a page with a refcount held to waiting on a page without
> > > > > the refcount held, then starting the lookup from scratch once the page
> > > > > is unlocked.  I find it hard to believe this introduces a /new/ failure.
> > > > > Either it makes an existing failure easier to hit, or there's a subtle
> > > > > bug in the retry logic that I'm not seeing.
> > > > > 
> > > > 
> > > > For keeping Murphy at bay I'm rerunning the bisection from scratch just
> > > > to make sure I come out at the same patch.  The initial bisection looked
> > > > clean, but when dealing with a failure that occurs probabilistically it's
> > > > easy enough to get it wrong.  Is this patch revertable in -rc1 or -rc3?
> > > > Ordinarily I like to do that for confirmation.
> > > 
> > > Alas, not easily.  I've built a lot on top of it since then.  I could
> > > probably come up with a moral reversion (and will have to if we can't
> > > figure out why it's causing a problem!)
> > > 
> > > > And there's always the chance that a latent ext4 bug is being hit.
> > > 
> > > That would also be valuable information to find out.  If this
> > > patch is exposing a latent bug, I can't think what it might be.
> > > 
> > > > I'd be very happy to run whatever debugging patches you might want, though
> > > > you might want to wait until I've reproduced the bisection result.  The
> > > > offsets vary, unfortunately - I've seen 1024, 2048, and 3072 reported when
> > > > running a file system with 4k blocks.
> > > 
> > > As I expected, but thank you for being willing to run debug patches.
> > > I'll wait for you to confirm the bisection and then work up something
> > > that'll help figure out what's going on.
> > 
> > An update:
> > 
> > I've been able to rerun the bisection on a freshly installed test appliance
> > using a kernel built from a new tree using different test hardware.  It ended
> > at the same patch - "mm/filemap: support readpage splitting a page".
> > 
> > I'd thought I'd been able to reproduce the failure using ext4's 4K block size,
> > but my test logs say otherwise, as do a few thousand trial runs of generic/418.
> > So, at the moment I can only say definitively that I've seen the failures when
> > running with 1k blocks (block size < page size).
> > 
> > I've been able to simplify generic/418 by reducing the set of test cases it
> > uses to just "-w", or direct I/O writes.  When I modify the test to remove
> > just that test case and leaving the remainder, I no longer see test failures.
> > A beneficial side effect of the simplification is that it reduces the running
> > time by an order of magnitude.
> > 
> > When it fails, it looks like the test is writing via dio a chunk of bytes all
> > of which have been set to 0x1 and then reading back via dio the same chunk with
> > all those bytes equal to 0x0.
> > 
> > I'm attempting to create a simpler reproducer.  generic/418 actually has a
> > number of processes simultaneously writing to and reading from disjoint
> > regions of the same file, and I'd like to see if the failure is dependent
> > upon that behavior, or whether it can be isolated to a single writer/reader.
> 
> I've managed to reproduce this bug here now.  There are _two_ places
> in xfstests that I need to specify "-b 1024" *grumble*.
> 
> You've definitely identified the correct commit.  I can go back-and-forth
> applying it and removing it, and the failure definitely tracks this
> commit.
> 
> I think what's going on is that we have a dio write vs a buffered read.
> That is, we're only specifying -w to diotest and not -w -r.  So we have
> a read-vs-invalidate situation.

Sorry about this - when writing this up, I was misled by a buggy comment in
dio-invalidate-cache.c's text which states that the reads are direct reads.

I've only seen the failure occur with a dio write to a region followed by
a buffered read of the same region.  A dio write followed by a dio read always
succeeds in obtaining the written data (multiple thousands of test runs to
support this claim).

In addition, if any of generic/418's preallocation options (-F, -p, -t) are
specified, the test does not fail even with the combination of a dio write
followed by a buffered read.  This is the first suggestion that ext4 might
be at fault.

With some work to simplify the test, the description of the problem looks like:

1) test on file system with block size < page size (1k on x86_64, say)

2) two processes do one dio write each to two disjoint regions of the same
size in a freshly created file

3) each process does a buffered read of the region it wrote for verification

4) if the region written is less than the file system block size (512 bytes
on a 1k file system, first write at offset 0, second at offset 512), the
test does not fail

5) if the region written is equal to or greater than the system page size,
the test does not fail

6) if the region written is less than the system page size, and equal to or
greater than the file system block size (1024 bytes on 1k file system, say,
first write at offset 0, second write at offset 1024), the test can (but
does not always) fail

7) in my data, it's always the second process writing at the non-zero offset
that sees the failure

8) failure rate is around 1% on my test system

So, point 6) also suggests the problem might be due to ext4.

> 
> What used to happen:
> 
>  - Look up page in page cache, happens to be there
>  - Check page is uptodate (it isn't; another thread started IO that hasn't
>    finished yet)
>  - Wait for page to be unlocked when the read finishes
>  - See if page is now uptodate (it is)
>  - Copy data from it
> 
> What happens now:
> 
>  - Look up page in page cache, happens to be there
>  - Check page is uptodate (it isn't; another thread started IO that hasn't
>    finished yet)
>  - Wait for page to be unlocked when the read finishes
>  - Go back and look up the page again
>  - Allocate a new page and call readpage
>  - Wait for IO to complete
>  - Copy data from it
> 
> So if there's a subtle race in ext4 between DIO writes and ->readpage,
> this might be exposing it?
> 
> I think this theory is given more credence by going to the parent commit
> (480546259811) and applying this:
> 
> +++ b/mm/filemap.c
> @@ -2301,6 +2301,10 @@ static struct page *filemap_update_page(struct kiocb *iocb, struct file *filp,
>                 put_page(page);
>                 return ERR_PTR(error);
>         }
> +       if (!page->mapping) {
> +               put_page(page);
> +               return NULL;
> +       }
>         if (PageUptodate(page))
>                 return page;
>  
> ie refusing to use a truncated page, even if it's still marked uptodate.
> That reproduces the g/418 crash within a minute for me.
> 
> Note that if the read had come in a few instructions later, it wouldn't've
> found a page in the page cache, so this is just widening the window in
> which this race can happen.

Yes, it seems likely your patch simply enlarged a race window somewhere in
ext4's dio implementation.  In parallel with this posting, Jan has noted
he's got a possible explanation.  So, we'll pursue that direction next.

Matthew - thanks very much for your time and effort in reproducing this
failure and considering it in the context of your patch!  

Eric

