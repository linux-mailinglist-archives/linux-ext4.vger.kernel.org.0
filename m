Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8D848D570
	for <lists+linux-ext4@lfdr.de>; Wed, 14 Aug 2019 15:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbfHNNx6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 14 Aug 2019 09:53:58 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34275 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727965AbfHNNx6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 14 Aug 2019 09:53:58 -0400
Received: by mail-pf1-f195.google.com with SMTP id b24so3115996pfp.1
        for <linux-ext4@vger.kernel.org>; Wed, 14 Aug 2019 06:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=n++KcFD4V/b6zBcrsczOTyMNO8jb/xPsUB8LHz0KWls=;
        b=b04AglKvxQ5eDEWRWO6CxcfuRA8NK9xxVyKIVJlPRBQzDP0H96mQmDjbDsJABkRoMT
         SwkIogOXf/Nrrkmgna6L0612c8DArkdixIzW7pbjX9u+B0tzzFZ4iK7rLq9TfpGvA63I
         ocAuu7T3ee9N/nPxNiyb/PQVv67kREbw6vTFdv+bPs57XaDGX3H3XDFQBp9+CfKLxv3U
         zRJ/m/4Jh3QRL9P5/dGv8E5IsMGoqRV3C6pjKyMj0ZM/6OFKesuACZaExyPuRRxon5fz
         gu1DOOeMp5IfTMKH6iNuWwF98FoVffyNMdTwAWot/jHCmopG2UuFC6mBXIGCI2bRRiCg
         E/TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=n++KcFD4V/b6zBcrsczOTyMNO8jb/xPsUB8LHz0KWls=;
        b=lNtUBHvT90RMqXX5OWKwFuZpcZJh8KsPdemi6dSTQd81dUguKe0ju9gdx3bj7MRo0a
         Hvt9FzyIfhK/jCCxY8+uFlc6fBLxyzdbimrO87DrtL14il/tPPsLdWCV989FEbW4RopB
         flU1VlSKmiI1R+toqpvGznT18drN9J4A6EF92NBY+FS46n2ipsszp8c7cbmk+eX+kylo
         JQ6yWuSTblFBizb6WezpH4MmeoxCuLRARDZN1AdZv3pSpZz5S0rNYS0H5XfyposdjPFR
         /UkDF9NA7hHRuBQ5UiZklijQp+qApftlgQuYiFzx5cyuZHLmHSGATI3abIxN78eEp6WL
         gbCg==
X-Gm-Message-State: APjAAAVedLUCb/Du4XqApU4J89Q4WlhZS7rgMs2ihJVFmAxell2CGcPQ
        BhTABuk0EHHiTP0WOrzpV2YL4g==
X-Google-Smtp-Source: APXvYqzke17f6CA3f3O7qxwwkDjXbUQ2aD4jV4h6qBmPzp0njUgRl6QAvBH7pexmJAZbHgXac4VhyQ==
X-Received: by 2002:a65:52c5:: with SMTP id z5mr39237537pgp.118.1565790836994;
        Wed, 14 Aug 2019 06:53:56 -0700 (PDT)
Received: from localhost ([2620:10d:c090:180::cd07])
        by smtp.gmail.com with ESMTPSA id 203sm22454812pfz.107.2019.08.14.06.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2019 06:53:55 -0700 (PDT)
Date:   Wed, 14 Aug 2019 09:53:53 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] block: annotate refault stalls from IO submission
Message-ID: <20190814135353.GA30543@cmpxchg.org>
References: <20190808190300.GA9067@cmpxchg.org>
 <20190809221248.GK7689@dread.disaster.area>
 <20190813174625.GA21982@cmpxchg.org>
 <20190814025130.GI7777@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190814025130.GI7777@dread.disaster.area>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Aug 14, 2019 at 12:51:30PM +1000, Dave Chinner wrote:
> On Tue, Aug 13, 2019 at 01:46:25PM -0400, Johannes Weiner wrote:
> > On Sat, Aug 10, 2019 at 08:12:48AM +1000, Dave Chinner wrote:
> > > On Thu, Aug 08, 2019 at 03:03:00PM -0400, Johannes Weiner wrote:
> > > > psi tracks the time tasks wait for refaulting pages to become
> > > > uptodate, but it does not track the time spent submitting the IO. The
> > > > submission part can be significant if backing storage is contended or
> > > > when cgroup throttling (io.latency) is in effect - a lot of time is
> > > 
> > > Or the wbt is throttling.
> > > 
> > > > spent in submit_bio(). In that case, we underreport memory pressure.
> > > > 
> > > > Annotate submit_bio() to account submission time as memory stall when
> > > > the bio is reading userspace workingset pages.
> > > 
> > > PAtch looks fine to me, but it raises another question w.r.t. IO
> > > stalls and reclaim pressure feedback to the vm: how do we make use
> > > of the pressure stall infrastructure to track inode cache pressure
> > > and stalls?
> > > 
> > > With the congestion_wait() and wait_iff_congested() being entire
> > > non-functional for block devices since 5.0, there is no IO load
> > > based feedback going into memory reclaim from shrinkers that might
> > > require IO to free objects before they can be reclaimed. This is
> > > directly analogous to page reclaim writing back dirty pages from
> > > the LRU, and as I understand it one of things the PSI is supposed
> > > to be tracking.
> > >
> > > Lots of workloads create inode cache pressure and often it can
> > > dominate the time spent in memory reclaim, so it would seem to me
> > > that having PSI only track/calculate pressure and stalls from LRU
> > > pages misses a fair chunk of the memory pressure and reclaim stalls
> > > that can be occurring.
> > 
> > psi already tracks the entire reclaim operation. So if reclaim calls
> > into the shrinker and the shrinker scans inodes, initiates IO, or even
> > waits on IO, that time is accounted for as memory pressure stalling.
> 
> hmmmm - reclaim _scanning_ is considered a stall event? i.e. even if
> scanning does not block, it's still accounting that _time_ as a
> memory pressure stall?

Yes. Reclaim doesn't need to block, the entire operation itself is an
interruption of the workload that only happens due to a lack of RAM.

Of course, as long as kswapd is just picking up one-off cache, it does
not take a whole lot of time, and it will barely register as
pressure. But as memory demand mounts and we have to look harder for
unused pages, reclaim time can become significant, even without IO.

> I'm probably missing it, but I don't see anything in vmpressure()
> that actually accounts for time spent scanning.  AFAICT it accounts
> for LRU objects scanned and reclaimed from memcgs, and then the
> memory freed from the shrinkers is accounted only to the
> sc->target_mem_cgroup once all memcgs have been iterated.

vmpressure is an orthogonal feature that is based purely on reclaim
efficiency (reclaimed/scanned).

psi accounting begins when we first call into try_to_free_pages() and
friends. psi_memstall_enter() marks the task, and it's the scheduler
part of psi that aggregates task state time into pressure ratios.

> > If you can think of asynchronous events that are initiated from
> > reclaim but cause indirect stalls in other contexts, contexts which
> > can clearly link the stall back to reclaim activity, we can annotate
> > them using psi_memstall_enter() / psi_memstall_leave().
> 
> Well, I was more thinking that issuing/waiting on IOs is a stall
> event, not scanning.
> 
> The IO-less inode reclaim stuff for XFS really needs the main
> reclaim loop to back off under heavy IO load, but we cannot put the
> entire metadata writeback path under psi_memstall_enter/leave()
> because:
> 
> 	a) it's not linked to any user context - it's a
> 	per-superblock kernel thread; and
> 
> 	b) it's designed to always be stalled on IO when there is
> 	metadata writeback pressure. That pressure most often comes from
> 	running out of journal space rather than memory pressure, and
> 	really there is no way to distinguish between the two from
> 	the writeback context.
> 
> Hence I don't think the vmpressure mechanism does what the memory
> reclaim scanning loops really need because they do not feed back a
> clear picture of the load on the IO subsystem load into the reclaim
> loops.....

Memory pressure metrics really seem unrelated to this problem, and
that's not what vmpressure or psi try to solve in the first place.

When you say we need better IO pressure feedback / congestion
throttling in reclaim, I can believe it, even though it's not
something we necessarily observed in our fleet.
