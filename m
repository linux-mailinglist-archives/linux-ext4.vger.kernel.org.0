Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF170265658
	for <lists+linux-ext4@lfdr.de>; Fri, 11 Sep 2020 03:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725300AbgIKBHs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 10 Sep 2020 21:07:48 -0400
Received: from rome.phoronix.com ([192.211.48.82]:18226 "EHLO
        rome.phoronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725280AbgIKBHq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 10 Sep 2020 21:07:46 -0400
X-Greylist: delayed 1119 seconds by postgrey-1.27 at vger.kernel.org; Thu, 10 Sep 2020 21:07:45 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=michaellarabel.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=AuHM6codIEWxc6h3MJGpE6K/Lc2+r8i3NGXZHeUpCBI=; b=rJ/EvZ3MuFhd9kIR8W9fochg8x
        dsSrSeu3f8ExJGXmPdrvZRl1Yk6V5svP4b+ZgH0MFh+MsPpQnDYy7GnHLs6/pWwrYly8X1koBoHch
        ciaP3j2yK5B1JWZPvPFojQSQj5IZq1aLG6ryvaXeVGOMULzbdhYhIwSn7wCMQt1dSXAhXrxSbqZyd
        4QfVkcUjeIph8Af01SNj53VW0z6N1Y1GXXdEz4sdsEuEUWU615YYDgoGKZWqSF0lRyFfD2VNEzX79
        GvHdyOP1z7LqSJSV92pMa0vJEF7jfejpChDAfYloR5WrWrafKYArYxLerS1NoBvHjJHO2AlQmGjt7
        bZq5hSFw==;
Received: from c-73-176-63-28.hsd1.il.comcast.net ([73.176.63.28]:46444 helo=[192.168.86.21])
        by rome.phoronix.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <Michael@MichaelLarabel.com>)
        id 1kGXFP-0006MS-Bd; Thu, 10 Sep 2020 20:49:03 -0400
Subject: Re: Kernel Benchmarking
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ted Ts'o <tytso@google.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>
References: <CAHk-=wiZnE409WkTOG6fbF_eV1LgrHBvMtyKkpTqM9zT5hpf9A@mail.gmail.com>
 <4ced9401-de3d-b7c9-9976-2739e837fafc@MichaelLarabel.com>
 <CAHk-=wj+Qj=wXByMrAx3T8jmw=soUetioRrbz6dQaECx+zjMtg@mail.gmail.com>
 <CAHk-=wgOPjbJsj-LeLc-JMx9Sz9DjGF66Q+jQFJROt9X9utdBg@mail.gmail.com>
 <CAHk-=wjjK7PTnDZNi039yBxSHtAqusFoRrZzgMNTiYkJYdNopw@mail.gmail.com>
 <aa90f272-1186-f9e1-8fdb-eefd332fdae8@MichaelLarabel.com>
 <CAHk-=wh_31_XBNHbdF7EUJceLpEpwRxVF+_1TONzyBUym6Pw4w@mail.gmail.com>
 <e24ef34d-7b1d-dd99-082d-28ca285a79ff@MichaelLarabel.com>
 <CAHk-=wgEE4GuNjcRaaAvaS97tW+239-+tjcPjTq2FGhEuM8HYg@mail.gmail.com>
 <6e1d8740-2594-c58b-ff02-a04df453d53c@MichaelLarabel.com>
 <CAHk-=wgJ3-cEkU-5zXFPvRCHKkCCuKxVauYWGphjePEhJJgtgQ@mail.gmail.com>
 <d2023f4c-ef14-b877-b5bb-e4f8af332abc@MichaelLarabel.com>
 <CAHk-=wiz=J=8mJ=zRG93nuJ9GtQAm5bSRAbWJbWZuN4Br38+EQ@mail.gmail.com>
 <CAHk-=wimM2kckaYj7spUJwehZkSYxK9RQqu3G392BE=73dyKtg@mail.gmail.com>
From:   Michael Larabel <Michael@MichaelLarabel.com>
Message-ID: <8bb582d2-2841-94eb-8862-91d1225d5ebc@MichaelLarabel.com>
Date:   Thu, 10 Sep 2020 19:49:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wimM2kckaYj7spUJwehZkSYxK9RQqu3G392BE=73dyKtg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - rome.phoronix.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - MichaelLarabel.com
X-Get-Message-Sender-Via: rome.phoronix.com: authenticated_id: michael@michaellarabel.com
X-Authenticated-Sender: rome.phoronix.com: michael@michaellarabel.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

I should be able to fire up some benchmarks of the patch overnight to 
see what they show, but guessing something more might be at play. While 
it's plausible this might help the Apache and Nginx web server results 
as they do touch the disk, Hackbench for instance shouldn't really be 
interacting with the file-system. Was the Hackbench perf data useful at 
all or should I generate a longer run of that for more events?

Michael


On 9/10/20 7:05 PM, Linus Torvalds wrote:
> [ Ted / Andreas - Michael bisected a nasty regression to the new fair
> page lock, and I think at least part of the reason is the ext4 page
> locking patterns ]
>
> On Thu, Sep 10, 2020 at 1:57 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>> I can already from a quick look see that one of the major
>> "interesting" paths here is a "writev()" system call that takes a page
>> fault when it copies data from user space.
> I think the page fault is incidental and not important.
>
> No, I think the issue is that ext4_write_begin() does some fairly crazy things.
>
> It does
>
>          page = grab_cache_page_write_begin(mapping, index, flags);
>          if (!page)
>                  return -ENOMEM;
>          unlock_page(page);
>
> which is all kinds of bad, because where grab_cache_page_write_begin()
> will get the page lock, and wait for it to not be under writeback any
> more.
>
> And then we unlock it right away.
>
> Only to do the journal start, and after that immediately do
>
>          lock_page(page);
>          ... check that the mapping hasn't changed ..
>          /* In case writeback began while the page was unlocked */
>          wait_for_stable_page(page);
>
> so it does that again.
>
> And I think this is exactly the pattern where the old unfair page
> locking worked very well, because the second "lock_page()" will
> probably happen while the previous "unlock_page()" had kept it
> unlocked. So 99% of the time, the second lock_page() was free.
>
> But with the new fair page locking, the previous unlock_page() will
> have given the page away to whoever was waiting for it, and now when
> we do the second lock_page(), we'll block and wait for that user - and
> every other possible one. Because that's fair - everybody gets the
> page lock in order.
>
> This may not be *the* reason, but it's exactly the kind of pessimal
> pattern where the old unfair model worked very well (where "well"
> means "good average performance, but then occasionally you get
> watchdogs firing because there's no forward progress"), and the new
> fair code will really stutter, because the lock/unlock/lock pattern is
> basically *exactly* the wrong thing to do and only causes a complete
> serialization in case there are other waiters, because fairness means
> that the second lock will always be done after *all* other queued
> waiters have been handled.
>
> And the sad part is that the code doesn't even *want* the lock for
> that initial case, and immediately drops it.
>
> The main reason the code seems to want to use that
> grab_cache_page_write_begin() that lkocks the page is that it wants to
> create the page if it didn't exist, and that creation creates a locked
> page.
>
> But the code *could* use FGP_FOR_MMAP instead, which only locks that
> initial page case.
>
> So something like this might at least work around this particular
> case. But it's *entirely* untested.
>
> Ted, Andreas, comments? The old unfair lock_page() made this a
> non-issue, but we really do have years of reports of odd watchdog
> errors that seem to be due to that almost infinite unfairness under
> bad loads..
>
> Michael: it's entirely possible that the two cases in fs/ext4/inode.c
> that I noticed are not that important. But I found them from following
> your profile data down to lock_page() cases, so they seem to be at
> least _part_ of the issue.
>
> Again: the patch is ENTIRELY untested. It compiles for me, and it
> looks superficially right, but that's all I'm going to say about it..
>
>                      Linus
