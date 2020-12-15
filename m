Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD1B32DA8BB
	for <lists+linux-ext4@lfdr.de>; Tue, 15 Dec 2020 08:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbgLOHoK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 15 Dec 2020 02:44:10 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:9889 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726588AbgLOHoH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 15 Dec 2020 02:44:07 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Cw9GJ1h5Tz7Gk5;
        Tue, 15 Dec 2020 15:42:48 +0800 (CST)
Received: from [10.174.177.71] (10.174.177.71) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.498.0; Tue, 15 Dec 2020 15:43:18 +0800
Subject: Re: [PATCH] e2fsck: Avoid changes on recovery flags when
 jbd2_journal_recover() failed
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        harshad shirwadkar <harshadshirwadkar@gmail.com>
CC:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "liuzhiqiang (I)" <liuzhiqiang26@huawei.com>,
        linfeilong <linfeilong@huawei.com>, <liangyun2@huawei.com>
References: <1bb3c556-4635-061b-c2dc-df10c15e6398@huawei.com>
 <CAD+ocbxAyyFqoD6AYQVjQyqFzZde3+QOnUhC-VikAq4A3_t8JA@mail.gmail.com>
 <3e3c18f6-9f45-da04-9e81-ebf1ae16747e@huawei.com>
 <CAD+ocbz=mp8k2Ruqiagq7ZDfhGui29X8Wz-_7698zaghzH4BXA@mail.gmail.com>
 <20201214202701.GI575698@mit.edu>
From:   Haotian Li <lihaotian9@huawei.com>
Message-ID: <1384512f-9c8b-d8d7-cb38-824a76b742fc@huawei.com>
Date:   Tue, 15 Dec 2020 15:43:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.1.0
MIME-Version: 1.0
In-Reply-To: <20201214202701.GI575698@mit.edu>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.71]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Thanks for your review. I agree with you that it's more important
to understand the errors found by e2fsck. we'll decribe the case
below about this problem.

The probelm we find actually in a remote storage case. It means
e2fsck's read or write may fail because of the network packet loss.
At first time, some packet loss errors happen during e2fsck's journal
recovery (using fsck -a), then recover failed. At second time, we
fix the network problem and run e2fsck again, but it still has errors
when we try to mount. Then we set jsb->s_start journal flags and retry
e2fsck, the problem is fixed. So we suspect something wrong on e2fsck's
journal recovery, probably the bug we've described on the patch.

Certainly, directly exit is not a good way to fix this problem.
just like what Harshad said, we need tell user what happen and listen
user's decision, continue e2fsck or not. If we want to safely use
e2fsck without human intervention (using fsck -a), I wonder if we need
provide a safe mechanism to complate the fast check but avoid changes
on journal or something else which may be fixed in feature (such
as jsb->s_start flag)?

Thanks
Haotian

ÔÚ 2020/12/15 4:27, Theodore Y. Ts'o Ð´µÀ:
> On Mon, Dec 14, 2020 at 10:44:29AM -0800, harshad shirwadkar wrote:
>> Hi Haotian,
>>
>> Yeah perhaps these are the only recoverable errors. I also think that
>> we can't surely say that these errors are recoverable always. That's
>> because in some setups, these errors may still be unrecoverable (for
>> example, if the machine is running under low memory). I still feel
>> that we should ask the user about whether they want to continue or
>> not. The reason is that firstly if we don't allow running e2fsck in
>> these cases, I wonder what would the user do with their file system -
>> they can't mount / can't run fsck, right? Secondly, not doing that
>> would be a regression. I wonder if some setups would have chosen to
>> ignore journal recovery if there are errors during journal recovery
>> and with this fix they may start seeing that their file systems aren't
>> getting repaired.
> 
> It may very well be that there are corrupted file system structures
> that could lead to ENOMEM.  If so, I'd consider that someone we should
> be explicitly checking for in e2fsck, and it's actually relatively
> unlikely in the jbd2 recovery code, since that's fairly straight
> forward --- except I'd be concerned about potential cases in your Fast
> Commit code, since there's quite a bit more complexity when parsing
> the fast commit journal.
> 
> This isn't a new concern; we've already talked a about the fact the
> fast commit needs to have a lot more sanity checks to look for
> maliciously --- or syzbot generated, which may be the same thing :-)
> --- inconsistent fields causing the e2fsck reply code to behave in
> unexpected way, which might include trying to allocate insane amounts
> of memory, array buffer overruns, etc.
> 
> But assuming that ENOMEM is always due to operational concerns, as
> opposed to file system corruption, may not always be a safe
> assumption.
> 
> Something else to consider is from the perspective of a naive system
> administrator, if there is an bad media sector in the journal, simply
> always aborting the e2fsck run may not allow them an easy way to
> recover.  Simply ignoring the journal and allowing the next write to
> occur, at which point the HDD or SSD will redirect the write to a bad
> sector spare spool, will allow for an automatic recovery.  Simply
> always causing e2fsck to fail, would actually result in a worse
> outcome in this particular case.
> 
> (This is especially true for a mobile device, where the owner is not
> likely to have access to the serial console to manually run e2fsck,
> and where if they can't automatically recover, they will have to take
> their phone to the local cell phone carrier store for repairs ---
> which is *not* something that a cellular provider will enjoy, and they
> will tend to choose other cell phone models to feature as
> supported/featured devices.  So an increased number of failures which
> cann't be automatically recovered cause the carrier to choose to
> feature, say, a Xiaomi phone over a ZTE phone.)
> 
>> I'm wondering if you saw any a situation in your setup where exiting
>> e2fsck helped? If possible, could you share what kind of errors were
>> seen in journal recovery and what was the expected behavior? Maybe
>> that would help us decide on the right behavior.
> 
> Seconded; I think we should try to understand why it is that e2fsck is
> failing with these sorts of errors.  It may be that there are better
> ways of solving the high-level problem.
> 
> For example, the new libext2fs bitmap backends were something that I
> added because when running a large number of e2fsck processes in
> parallel on a server machine with dozens of HDD spindles was causing
> e2fsck processes to run slowly due to memory contention.  We fixed it
> by making e2fsck more memory efficient, by improving the bitmap
> implementations --- but if that hadn't been sufficient, I had also
> considered adding support to make /sbin/fsck "smarter" by limiting the
> number of fsck.XXX processes that would get started simultaneously,
> since that could actually cause the file system check to run faster by
> reducing memory thrashing.  (The trick would have been how to make
> fsck smart enough to automatically tune the number of parallel fsck
> processes to allow, since asking the system administrator to manually
> tune the max number of processes would be annoying to the sysadmin,
> and would mean that the feature would never get used outside of $WORK
> in practice.)
> 
> So is the actual underlying problem that e2fsck is running out of
> memory?  If so, is it because there simply isn't enough physical
> memory available?  Is it being run in a cgroup container which is too
> small?  Or is it because too many file systems are being checked in
> parallel at the same time?  
> 
> Or is it I/O errors that you are concerned with?  And how do you know
> that they are not permanent errors; is thie caused by something like
> fibre channel connections being flaky?
> 
> Or is this a hypotethical worry, as opposed to something which is
> causing operational problems right now?
> 
> Cheers,
> 
> 					- Ted
> 					
> .
> 
