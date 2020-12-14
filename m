Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3F92DA183
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Dec 2020 21:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503135AbgLNU2O (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 14 Dec 2020 15:28:14 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:34055 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2503226AbgLNU2C (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 14 Dec 2020 15:28:02 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0BEKR1Ss004945
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Dec 2020 15:27:02 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 7DCE8420136; Mon, 14 Dec 2020 15:27:01 -0500 (EST)
Date:   Mon, 14 Dec 2020 15:27:01 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     harshad shirwadkar <harshadshirwadkar@gmail.com>
Cc:     Haotian Li <lihaotian9@huawei.com>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "liuzhiqiang (I)" <liuzhiqiang26@huawei.com>,
        linfeilong <linfeilong@huawei.com>, liangyun2@huawei.com
Subject: Re: [PATCH] e2fsck: Avoid changes on recovery flags when
 jbd2_journal_recover() failed
Message-ID: <20201214202701.GI575698@mit.edu>
References: <1bb3c556-4635-061b-c2dc-df10c15e6398@huawei.com>
 <CAD+ocbxAyyFqoD6AYQVjQyqFzZde3+QOnUhC-VikAq4A3_t8JA@mail.gmail.com>
 <3e3c18f6-9f45-da04-9e81-ebf1ae16747e@huawei.com>
 <CAD+ocbz=mp8k2Ruqiagq7ZDfhGui29X8Wz-_7698zaghzH4BXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD+ocbz=mp8k2Ruqiagq7ZDfhGui29X8Wz-_7698zaghzH4BXA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Dec 14, 2020 at 10:44:29AM -0800, harshad shirwadkar wrote:
> Hi Haotian,
> 
> Yeah perhaps these are the only recoverable errors. I also think that
> we can't surely say that these errors are recoverable always. That's
> because in some setups, these errors may still be unrecoverable (for
> example, if the machine is running under low memory). I still feel
> that we should ask the user about whether they want to continue or
> not. The reason is that firstly if we don't allow running e2fsck in
> these cases, I wonder what would the user do with their file system -
> they can't mount / can't run fsck, right? Secondly, not doing that
> would be a regression. I wonder if some setups would have chosen to
> ignore journal recovery if there are errors during journal recovery
> and with this fix they may start seeing that their file systems aren't
> getting repaired.

It may very well be that there are corrupted file system structures
that could lead to ENOMEM.  If so, I'd consider that someone we should
be explicitly checking for in e2fsck, and it's actually relatively
unlikely in the jbd2 recovery code, since that's fairly straight
forward --- except I'd be concerned about potential cases in your Fast
Commit code, since there's quite a bit more complexity when parsing
the fast commit journal.

This isn't a new concern; we've already talked a about the fact the
fast commit needs to have a lot more sanity checks to look for
maliciously --- or syzbot generated, which may be the same thing :-)
--- inconsistent fields causing the e2fsck reply code to behave in
unexpected way, which might include trying to allocate insane amounts
of memory, array buffer overruns, etc.

But assuming that ENOMEM is always due to operational concerns, as
opposed to file system corruption, may not always be a safe
assumption.

Something else to consider is from the perspective of a naive system
administrator, if there is an bad media sector in the journal, simply
always aborting the e2fsck run may not allow them an easy way to
recover.  Simply ignoring the journal and allowing the next write to
occur, at which point the HDD or SSD will redirect the write to a bad
sector spare spool, will allow for an automatic recovery.  Simply
always causing e2fsck to fail, would actually result in a worse
outcome in this particular case.

(This is especially true for a mobile device, where the owner is not
likely to have access to the serial console to manually run e2fsck,
and where if they can't automatically recover, they will have to take
their phone to the local cell phone carrier store for repairs ---
which is *not* something that a cellular provider will enjoy, and they
will tend to choose other cell phone models to feature as
supported/featured devices.  So an increased number of failures which
cann't be automatically recovered cause the carrier to choose to
feature, say, a Xiaomi phone over a ZTE phone.)

> I'm wondering if you saw any a situation in your setup where exiting
> e2fsck helped? If possible, could you share what kind of errors were
> seen in journal recovery and what was the expected behavior? Maybe
> that would help us decide on the right behavior.

Seconded; I think we should try to understand why it is that e2fsck is
failing with these sorts of errors.  It may be that there are better
ways of solving the high-level problem.

For example, the new libext2fs bitmap backends were something that I
added because when running a large number of e2fsck processes in
parallel on a server machine with dozens of HDD spindles was causing
e2fsck processes to run slowly due to memory contention.  We fixed it
by making e2fsck more memory efficient, by improving the bitmap
implementations --- but if that hadn't been sufficient, I had also
considered adding support to make /sbin/fsck "smarter" by limiting the
number of fsck.XXX processes that would get started simultaneously,
since that could actually cause the file system check to run faster by
reducing memory thrashing.  (The trick would have been how to make
fsck smart enough to automatically tune the number of parallel fsck
processes to allow, since asking the system administrator to manually
tune the max number of processes would be annoying to the sysadmin,
and would mean that the feature would never get used outside of $WORK
in practice.)

So is the actual underlying problem that e2fsck is running out of
memory?  If so, is it because there simply isn't enough physical
memory available?  Is it being run in a cgroup container which is too
small?  Or is it because too many file systems are being checked in
parallel at the same time?  

Or is it I/O errors that you are concerned with?  And how do you know
that they are not permanent errors; is thie caused by something like
fibre channel connections being flaky?

Or is this a hypotethical worry, as opposed to something which is
causing operational problems right now?

Cheers,

					- Ted
					
