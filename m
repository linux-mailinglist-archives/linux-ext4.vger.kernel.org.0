Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D21772B4F1
	for <lists+linux-ext4@lfdr.de>; Mon, 12 Jun 2023 02:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjFLATb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 11 Jun 2023 20:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjFLATa (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 11 Jun 2023 20:19:30 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A25410C
        for <linux-ext4@vger.kernel.org>; Sun, 11 Jun 2023 17:19:28 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-82-39.bstnma.fios.verizon.net [173.48.82.39])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 35C0JLnZ015939
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 11 Jun 2023 20:19:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1686529163; bh=QEtWINoWRbHFVp2D9f1C/19/XGPp06PO5qbsneWUErs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=ZlhBFIJouPalrVuE1Jd8SVDPaikKmf/BZqb9JYmg73D3v8K2Y/RyDhAkF6nY4DQ86
         FlyhY3h3dNrNyypcfL3um0heuTphP/SnN4LW0NrD7iRRlLU7UF10hcL1R/PQdx/AX5
         c+io0IAbArqXNWTyJtWE7B/1frPvWk3JtBxtXB6wSWDqD39zeXfwARXhqpCygKuTHL
         5h+RXoce0MFzObU5RMCpI5QXrgM0RaDRToaHucWx4QMeyB6FG7fdJ7VMT+CWf0iANd
         Ut9B5SLeEb23S4Mat1MiesVWkgsGIOP5rKbJjTi89hwIisf3Kg79TidpAfmV4/8fvK
         jsRsLNIIDXViA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 7BF2515C00B0; Sun, 11 Jun 2023 20:19:21 -0400 (EDT)
Date:   Sun, 11 Jun 2023 20:19:21 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+4acc7d910e617b360859@syzkaller.appspotmail.com>
Subject: Re: [syzbot] [ext4?] BUG: sleeping function called from invalid
 context in ext4_update_super
Message-ID: <20230612001921.GG1436857@mit.edu>
References: <20230611131829.GA1584772@mit.edu>
 <7741416.gsGJI6kyIV@suse>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7741416.gsGJI6kyIV@suse>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, Jun 11, 2023 at 09:15:56PM +0200, Fabio M. De Francesco wrote:
> 
> Thanks!
> 
> Let me summarize, just to be sure we don't misunderstand each other... 
> 
> To start off, I'll send out _only_ the patch for the bug reported by Syzbot, 
> the one about dropping the call to ext_error() in ext4_get_group_info(). 
> 
> I'll do this by Tuesday. (Sorry, I cannot do it by Monday because I must pass 
> an exam and an interview for a job).

Sure, that'll be fine.

> However, on the other problems with ext4_grp_locked_error() that you noticed 
> in the final part of your first message in this thread I'll need some days 
> more to better understand the context I'm working in.

Um, I'm not sure what problems you're referring to.  What I said is
that it works, but you just have to be careful in how you use it (and
the current callers in mballoc.c are careful).

And similarly, I don't think it's a problem that you need to be
careful not to call ext4_error() from an atomic context.  You need to
be careful, and sometimes we screw up.  But in this particular case,
it's pretty obvious how to fix it, and we don't even need a syzkaller
reproduccer.  :-)

> 
> > I would strongly recommend that you use gce-xfstests or kvm-xfstests
> > before submitting ext4 patches.  In this particular case, it's a
> > relatively simple patch, but it's a good habit to get into.  See [1]
> > for more details.
> > 
> > [1] https://thunk.org/gce-xfstests
> 
> Thanks also for these information. 
> 
> In the last year I have been sending several patches patches for filesystems, 
> several little things that comprise conversions (sometimes with additional 
> related work, like a series of 5 patches to fs/sysv). 
> 
> The only tools I've ever needed were running (x)fstests on a QEMU/KVM x86_32 
> VM, 6GB RAM, booting a Kernel with HIGHMEM64G enabled (for PAE).
> 
> Never heard about {kvm,gce}-xfstests. I'll have a look at the link and try 
> these tests. I can afford $2, but at the moment I don't want to assemble a 
> dedicated hardware for tests.
> 
> What's the problem with running those tests in QEMU/KVM VMs???

kvm-xfstests is essentially running the tests using qemu.  It's
advantage is that it's a pre-packaged test appliance, so people don't
need to go through extra effort to set it up.  Also, there are pre-set
configurations which are useful for thoroughly testing a particular
file system, with multiple configurations (e.g., 4k block size, 1k
block size, with fsencrypt enabled, with bigalloc enabled, etc., etc.)
There are dozen configs that I run by default, which is what "-c
ext4/all" does.  From test-appliance/files/root/fs/ext4/cfg/all.list,
you'll see that the following configs are run:

    4k, 1k, ext3, encrypt, nojournal, ext3conv, adv, dioread_nolock,
    data_journal, bigalloc_4k, bigalloc_1k, dax

"kvm-xfstests smoke" is syntactic sugar for "kvm-xfstests -c ext4/4k -g quick".

The advantage of using gce-xfstests is that when you give a list of
configs to run, such as "gce-xfstests -c ext4/all -g auto", it will
start up separate VM's for each configuration, and so the test runs
for these configs are run in parallel.  This takes about an hour and
45 minutes (which is the long pole time for running the ext4/1k
config).  If you use kvm-xfstests it will run the tests sequentially
and so "kvm-xfstests -c ext4/all -g auto" will take about 24 hours,
plus or minue.

The other advantage of gce-xfstests is that you can also do test runs
on arm64 platforms.  Leah, one of the XFS stable backports
maintainers, uses gce-xfstests to test backports of various xfs bug
fixes to the LTS kernels, and it's handy to be able to test on both
x86_64 and arm64 to find potential bugs that might work on Intel/AMD
platforms, but which might be problematic on say arm64.  You can
actually use kvm-xfstests to test an arm64 kernel, but it will have to
use qemu to emulate the arm64 platforms, and so this can be slow.

(You can also use kvm-xfstests to test i386 kernels, if you care about
testing compat API's on 32-bit kernels.  I used to do xfstests runs
using 32-bit x86, but I've gotten too busy, so I've stopped doing
that.)

There are also some useful bits for automatically configuring a
kernel, using the install-kconfig script, and to build the kernel for
use with kvm- and gce-xfstests automatically, using the kbuild script.
There's nothing "magic" about the script, but the fact that you can do
things like "install-kconfig --lockdep", or "install-kconfig --kasan",
etc., and you can also build for arm64 automatically using "kbuild
--arch arm64" is handy.

Basically, these have all be done to optimize for developer velocity,
since I use them every day in my developer workflow.

> Ah, I just recalled that in December 2022 I sent you three conversion from the 
> old kmap{,_atomic} that went reviewed by Jan K. and Ira W.. It was tested with 
> fstests as I explained above. That patch got lost, in fact I still see at 
> least a kmap_atomic() call site in ext4. One call site is no more in ext4. The 
> third today uses kmap_local_folio(). 
> 
> Well, everybody dislike to see their patches completely ignored (https://
> lore.kernel.org/lkml/20221231174439.8557-1-fmdefrancesco@gmail.com/). If you 
> wanted you could at least apply the part regarding the kmap_atomic() 
> conversion in ext4_journalled_write_inline_data().

Sorry, I can get pretty overloaded.  (For example, I've spent most of
my free time this weekend hunting down bugs in other people's patch
set because they hadn't run "gce-xfstests -c ext4/all -g auto" :-).
In this particular case, you sent it while I was on a Panama Canal
cruise, and while I did see the commit, it was lower priority because
kmap_atomic, kmap_local_page(), etc., are all no-op's on 64-bit
systems, and quite frankly, issues which are i386-specific are the
first to get load-shed when I have high priority tasks on my plate.

As it turns out, there is a patch in the dev branch (the dev branch
contains those changtes that will be sent to Linux at the next merge
window, assuming I can flush out all of the bugs that were missed
during code review), that completely gets rid of
ext4_journalled_write_inline_data(), and a quick check of the dev
branch at the moment shows that we don't have any kmap_atomic() calls
in the tree.

> > but it will only work
> > if LOCKDEP is enabled, 
> 
> I don't know what others do. I always enable LOCKDEP, also in production 
> systems.

Enabling LOCKDEP doubles the run time for running "gce-xfstests -c
ext4/all -g auto".  It *TRIPLES* the run time for running
"gce-xfstests -c xfs/all -g auto".  This is why production kernels
generally don't enable lockdep.  Most people (especially the finance
folks who are trying to optimize costs for either bare metal hardware
or cloud VM's) don't like giving away 50% of their performance (or
potentially even more) on their production servers....

> I fully agree. I'm still in search of a reliable way to let atomic context run 
> idle waiting for a status change. I am talking about atomic code in paths that 
> we don't mind if they loop for few seconds (like the case at hand - we don't 
> care to panic immediately or within a sec or two. Do we care???

The problem is that you might be holding a spinlock that is needed for
the workqueue function to complete.  In that case, you could deadlock
**forever**, so it's not a matter of a second or two, but waiting
until the heat death of the universe.  :-)

It's probably safe given that the workqueue function doesn't need to
take the group local, so for this particular case, it probably OK.
But as a general solution, if you happened to be holding the j_state
lock when you called ext4_error(), then when the workqueue function
tried to commit the superblock change, it would need the j_state lock,
and it would wait forever, while your mdelay() loop would waiting for
the workqueue function to complete... and deadlock.

Worse, lockdep won't actually detect this problem, which is why I
called it inherently fragile.  Moreover, using mdelay() loops to
"solve" this kind of locking problem is considered "in poor taste".
For an experienced developer, this sort of thing will make them throw
up in their mouth a little, because it's not terribly clean, even when
it works.  So when Linus says that he wants maintainers to have "good
taste", that's the sort of thing that he's talking about.

Remember, spinlocks are supposed to be held for a very short amount of
time.  If you are waiting for something to complete while holding a
spinlock, even if it's a "legal" way (for example, by trying to get
another spinlock) this may case a lot of other CPU's running on behalf
of other threasd to also block waiting for the spinlock to be
released.  Consider that modern cores can have 128 or 256 or more
cores.  If you have a large number of threads just twiddling their
thumbs, spinning waiting on a spinlock, while an mdelay loop is
waiting hundreds of milliseconds for I/O to complete... your computer
will be more like a space heater than a device which allows users to
get their work done.

So the question is not how to find a "reliable way to let atomic
context run > idle waiting for a status change".  That's the wrong
question.  The better question is: "how do you restructure code
running in an attomic context so it doesn't need to wait for a status
change"?

Cheers,

					- Ted
