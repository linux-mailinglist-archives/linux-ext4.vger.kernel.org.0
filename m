Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 753F8340EEC
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Mar 2021 21:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbhCRUQE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 18 Mar 2021 16:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbhCRUPd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 18 Mar 2021 16:15:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D4CC06174A
        for <linux-ext4@vger.kernel.org>; Thu, 18 Mar 2021 13:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LTHFHulTROzVRNighBu1q8OFHj3hlf6wYWUkl34JuRo=; b=H/7KweRP91fvPd/ZUZcyGShzMw
        Mt7FAR0aCuNfUf19+FizaGlkxEgDhTd/3KzBn30LwRfXGkGiJDvNuHRibqkzIUxmPQU2lESC4hL8k
        QhGHJL03c6mL/5q56/nAmJoQWb1ELgnlWOGlh31XY+aYt+DQH0c0MgyPjugFGCxQUZHYsUFR27Xio
        SREZZjNCaU/3mHKtTssUkmjCoqrqCjxi9dBHD83LSnwUrC7/5PJWUac8bRSCGNxUp6CyBTo5kA9DK
        Iv/nfFgFiEm0Ej9n5t8Z6bA0ldSeNWtQGVyl43LIUCtFslEml+le/lS7hwjgVb++lfOeirR39/RM+
        LXHqEGHg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lMz2w-003SJB-FB; Thu, 18 Mar 2021 20:15:14 +0000
Date:   Thu, 18 Mar 2021 20:15:06 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Eric Whitney <enwlinux@gmail.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu
Subject: Re: generic/418 regression seen on 5.12-rc3
Message-ID: <20210318201506.GU3420@casper.infradead.org>
References: <20210318181613.GA13891@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210318181613.GA13891@localhost.localdomain>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Mar 18, 2021 at 02:16:13PM -0400, Eric Whitney wrote:
> As mentioned in today's ext4 concall, I've seen generic/418 fail from time to
> time when run on 5.12-rc3 and 5.12-rc1 kernels.  This first occurred when
> running the 1k test case using kvm-xfstests.  I was then able to bisect the
> failure to a patch landed in the -rc1 merge window:
> 
> (bd8a1f3655a7) mm/filemap: support readpage splitting a page

Thanks for letting me know.  This failure is new to me.

I don't understand it; this patch changes the behaviour of buffered reads
from waiting on a page with a refcount held to waiting on a page without
the refcount held, then starting the lookup from scratch once the page
is unlocked.  I find it hard to believe this introduces a /new/ failure.
Either it makes an existing failure easier to hit, or there's a subtle
bug in the retry logic that I'm not seeing.

> Typical test output resulting from a failure looks like:
> 
>      QA output created by 418
>     +cmpbuf: offset 0: Expected: 0x1, got 0x0
>     +[6:0] FAIL - comparison failed, offset 3072
>     +diotest -w -b 512 -n 8 -i 4 failed at loop 0
>      Silence is golden
>     ...
> 
> I've also been able to reproduce the failure on -rc3 in the 4k test case as
> well.  The failure frequency there was 10 out of 100 runs.  It was anywhere
> from 2 to 8 failures out of 100 runs in the 1k case.
> 
> So, the failure isn't dependent upon block size less than page size.

That's a good data point.  I'll take a look at g/418 and see if i can
figure out what race we're hitting.  Nice that it happens so often.
I suppose I could get you to put some debugging in -- maybe dumping the
page if we hit a contended case, then again if we're retrying?

I presume it doesn't always happen at the same offset or anything
convenient like that.
