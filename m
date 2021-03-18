Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D427A340FEF
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Mar 2021 22:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbhCRViM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 18 Mar 2021 17:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbhCRViL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 18 Mar 2021 17:38:11 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59BEC06174A
        for <linux-ext4@vger.kernel.org>; Thu, 18 Mar 2021 14:38:11 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id h3so4005496qvh.8
        for <linux-ext4@vger.kernel.org>; Thu, 18 Mar 2021 14:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ijZLDZJw1KASTV+buLMb199FCNBTdfkTCz9KSB1FFgE=;
        b=lKEXq+E2xGtJlTJfSd+4XTVa7L7wZIjUDzcmdYAyZTgSBC1bPQZ1n4DDJrnLaZLs3e
         N4avE/aViValm9oVsmN9DfgQ3+jG9M/2LnyIK+PFLpmiQGVwsOIjF+aK8liqON8UBLcs
         o1il0Dj3ICkSf3NCaS8ysSOGq+wf4IcIHa3Vt4SQ3BvdBsy7qYBHAcpZwNkvEMICejIy
         RCoOV/GgWQA8LazQK7akFQk38ik+KAcYUETl4Nv/4sO80mUBQNchEQ0llq0yDUrrM8ov
         M9m3CRxxCfc9V2E9JidMsvAZRGCdKXyccaIjJYDlGJSg4B68cDuMX8LeUL9HT7BznrY4
         AP2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ijZLDZJw1KASTV+buLMb199FCNBTdfkTCz9KSB1FFgE=;
        b=GJYY/PKay8NxaS3S2qqsi7rhY6C/aejVl3Ra0H1Kf5IO7T5RCNyVGjY06QjZAXU/b+
         SLDAJxwbQ1RC+FbV1oEmEEYX17FTazMUm9mqUphVrgcDuNvI0me1FLnoZ6wvYEWEw7Wv
         Bj+0FWA+KIvh4B+fxvWL4/ZJnu1zh7ECFEiK9ZWbctsjUHAEMmA/4eLwLMZzqwuaRaQ/
         bf0zjGppaAIuHg8h8qfIP/7gvnlBy3AD0GDq9XTp9D+7kwzwpzCn4WZMriQ2uPPVLNtT
         PrKLDbBtwEduSbUjBS9DWelAlPEaJKnoBkPoDrUsY4q2fyXUh0ByUw88w41bfE7AbK23
         /18g==
X-Gm-Message-State: AOAM532Z0qbYERd7AVr7YVKj8UcE01Ury8GfHB9P7TFGIQNqCm7mbcNi
        Q4xbFWKUdcFKBFET6oArC2M=
X-Google-Smtp-Source: ABdhPJzl+3X3q+zYOSqprw1vVv3t3rLmwr8TPPxCp7+d2ShV2l2AfvpD8fAy5xQr+kglN4svl1qaGQ==
X-Received: by 2002:a0c:f946:: with SMTP id i6mr6494817qvo.40.1616103490991;
        Thu, 18 Mar 2021 14:38:10 -0700 (PDT)
Received: from localhost.localdomain (c-73-60-226-25.hsd1.nh.comcast.net. [73.60.226.25])
        by smtp.gmail.com with ESMTPSA id 19sm2683770qkv.95.2021.03.18.14.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 14:38:10 -0700 (PDT)
Date:   Thu, 18 Mar 2021 17:38:08 -0400
From:   Eric Whitney <enwlinux@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Eric Whitney <enwlinux@gmail.com>, linux-ext4@vger.kernel.org,
        tytso@mit.edu
Subject: Re: generic/418 regression seen on 5.12-rc3
Message-ID: <20210318213808.GA26924@localhost.localdomain>
References: <20210318181613.GA13891@localhost.localdomain>
 <20210318201506.GU3420@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210318201506.GU3420@casper.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

* Matthew Wilcox <willy@infradead.org>:
> On Thu, Mar 18, 2021 at 02:16:13PM -0400, Eric Whitney wrote:
> > As mentioned in today's ext4 concall, I've seen generic/418 fail from time to
> > time when run on 5.12-rc3 and 5.12-rc1 kernels.  This first occurred when
> > running the 1k test case using kvm-xfstests.  I was then able to bisect the
> > failure to a patch landed in the -rc1 merge window:
> > 
> > (bd8a1f3655a7) mm/filemap: support readpage splitting a page
> 
> Thanks for letting me know.  This failure is new to me.

Sure - it's useful to know that it's new to you.  Ted said he's also going
to test XFS with a large number of generic/418 trials which would be a
useful comparison.  However, he's had no luck as yet reproducing what I've
seen on his Google compute engine test setup running ext4.

> 
> I don't understand it; this patch changes the behaviour of buffered reads
> from waiting on a page with a refcount held to waiting on a page without
> the refcount held, then starting the lookup from scratch once the page
> is unlocked.  I find it hard to believe this introduces a /new/ failure.
> Either it makes an existing failure easier to hit, or there's a subtle
> bug in the retry logic that I'm not seeing.
> 

For keeping Murphy at bay I'm rerunning the bisection from scratch just
to make sure I come out at the same patch.  The initial bisection looked
clean, but when dealing with a failure that occurs probabilistically it's
easy enough to get it wrong.  Is this patch revertable in -rc1 or -rc3?
Ordinarily I like to do that for confirmation.

And there's always the chance that a latent ext4 bug is being hit.

> > Typical test output resulting from a failure looks like:
> > 
> >      QA output created by 418
> >     +cmpbuf: offset 0: Expected: 0x1, got 0x0
> >     +[6:0] FAIL - comparison failed, offset 3072
> >     +diotest -w -b 512 -n 8 -i 4 failed at loop 0
> >      Silence is golden
> >     ...
> > 
> > I've also been able to reproduce the failure on -rc3 in the 4k test case as
> > well.  The failure frequency there was 10 out of 100 runs.  It was anywhere
> > from 2 to 8 failures out of 100 runs in the 1k case.
> > 
> > So, the failure isn't dependent upon block size less than page size.
> 
> That's a good data point.  I'll take a look at g/418 and see if i can
> figure out what race we're hitting.  Nice that it happens so often.
> I suppose I could get you to put some debugging in -- maybe dumping the
> page if we hit a contended case, then again if we're retrying?
> 
> I presume it doesn't always happen at the same offset or anything
> convenient like that.

I'd be very happy to run whatever debugging patches you might want, though
you might want to wait until I've reproduced the bisection result.  The
offsets vary, unfortunately - I've seen 1024, 2048, and 3072 reported when
running a file system with 4k blocks.

Thanks,
Eric
