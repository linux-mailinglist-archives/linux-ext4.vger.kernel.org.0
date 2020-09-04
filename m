Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A46625D011
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Sep 2020 05:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729667AbgIDDzg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 3 Sep 2020 23:55:36 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:35112 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729582AbgIDDzf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 3 Sep 2020 23:55:35 -0400
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0843tTfN017405
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 3 Sep 2020 23:55:29 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id F3C99420128; Thu,  3 Sep 2020 23:55:28 -0400 (EDT)
Date:   Thu, 3 Sep 2020 23:55:28 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-ext4@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ext4: flag as supporting buffered async reads
Message-ID: <20200904035528.GE558530@mit.edu>
References: <fb90cc2d-b12c-738f-21a4-dd7a8ae0556a@kernel.dk>
 <20200818181117.GA34125@mit.edu>
 <990cc101-d4a1-f346-fe78-0fb5b963b406@kernel.dk>
 <20c844c8-b649-3250-ff5b-b7420f72ff38@kernel.dk>
 <20200822143326.GC199705@mit.edu>
 <aff250ad-4c31-15c2-fa1d-3f3945cb7aa5@kernel.dk>
 <7f0e2d99-5da2-237e-a894-0afddc0ace1e@kernel.dk>
 <049a97db-c362-bcfb-59e5-4b1d2df59383@kernel.dk>
 <5140ba6c-779c-2a71-b7f2-3c3220cdf19c@kernel.dk>
 <68510957-c887-8e26-4a1a-a7a93488586a@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68510957-c887-8e26-4a1a-a7a93488586a@kernel.dk>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Jens,

Sorry, the past few months have been *crazy* insane.  Between Linux
Plumbers Conference organizing, having to deal with some interns at
$WORK, performance reviews, etc.., etc., it's been a perfect storm.
As a result, I was late getting the primary ext4 pull request to
Linus, and he's already yelled at me for a late pull request.

As a result, I'm being super paranoid about asking Linus for anything,
even a one-time change, if it's not a bug fix.  And what you are
asking for isn't a bug fix, but enabling a new feature.

Worse, right now, -rc1 and -rc2 is causing random crashes in my
gce-xfstests framework.  Sometimes it happens before we've run even a
single xfstests; sometimes it happens after we have successfully
completed all of the tests, and we're doing a shutdown of the VM under
test.  Other times it happens in the middle of a test run.  Given that
I'm seeing this at -rc1, which is before my late ext4 pull request to
Linus, it's probably not an ext4 related bug.  But it also means that
I'm partially blind in terms of my kernel testing at the moment.  So I
can't even tell Linus that I've run lots of tests and I'm 100%
confident your one-line change is 100% safe.

Next week after Labor Day, I should be completely done with the
performance review writeups that are on my plate, and I will hopefully
have a bit more time to try to debug these mysterious failures.  Or
maybe someone else will be able to figure out what the heck is going
wrong, and perhaps -rc3 will make all of these failures go away.

I'm sorry your frustrated; I'm frustrated too!  But until I can find
the time to do a full bisect (v5.8 works just fine.  v5.9-rc1 is
flakey as hell when booting my test config in a GCE VM), I'm not in a
position to send anything to Linus.

Sorry,

						- Ted

[ 3326.130032] BUG: unable to handle page fault for address: ffff949e7c958e3f
[ 3326.137056] #PF: supervisor write access in kernel mode
[ 3326.142497] #PF: error_code(0x0002) - not-present page
[ 3326.147776] PGD 23fe01067 P4D 23fe01067 PUD 0 
[ 3326.154384] Oops: 0002 [#1] SMP PTI
[ 3326.157995] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.9.0-rc2-xfstests #1886
[ 3326.165337] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
[ 3326.174695] RIP: 0010:free_block+0x14b/0x260
[ 3326.180083] Code: af f1 0f b6 4d 1c 48 c1 ee 20 29 f0 d3 e8 0f b6 4d 1d 01 f0 49 8b 75 20 d3 e8 8d 4f ff 48 85 f6 41 89 4d 30 0f 84 f8 00 00 00 <88> 04 0e 41 8b 45 30 85 c0 0f 84 f9 fe ff ff 4d 8b 67 50 49 8d 57
[ 3326.199667] RSP: 0018:ffffb11c80003ab8 EFLAGS: 00010082
[ 3326.205015] RAX: 0000000000000027 RBX: ffffd11c7fa007b0 RCX: 00000000ffffffff
[ 3326.212282] RDX: fffffab945f25608 RSI: ffff949d7c958e40 RDI: 0000000000000000
[ 3326.219537] RBP: ffff949dd8041180 R08: fffffab9458bdf88 R09: 00000000000c201d
[ 3326.226791] R10: 0000000000000000 R11: 0000000000080000 R12: ffff949d7c9589c0
[ 3326.234151] R13: fffffab945f25600 R14: fffffab945f25608 R15: ffff949dd8042240
[ 3326.241512] FS:  0000000000000000(0000) GS:ffff949dd9000000(0000) knlGS:0000000000000000
[ 3326.249725] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 3326.255590] CR2: ffff949e7c958e3f CR3: 00000001cf5b4003 CR4: 00000000003706f0
[ 3326.262863] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 3326.270214] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 3326.277481] Call Trace:
[ 3326.280046]  <IRQ>
[ 3326.282182]  cache_flusharray+0x90/0x110
[ 3326.286239]  ___cache_free+0x2e0/0x390
[ 3326.290130]  kfree+0xc9/0x1d0
[ 3326.293222]  kmem_freepages+0xa0/0xf0
[ 3326.297014]  slabs_destroy+0x8e/0xd0
[ 3326.300717]  cache_flusharray+0xa5/0x110
[ 3326.304761]  ___cache_free+0x2e0/0x390
[ 3326.308634]  kfree+0xc9/0x1d0
[ 3326.311722]  kmem_freepages+0xa0/0xf0
[ 3326.315508]  slabs_destroy+0x8e/0xd0
[ 3326.319235]  cache_flusharray+0xa5/0x110
[ 3326.323305]  ___cache_free+0x2e0/0x390
[ 3326.328915]  kfree+0xc9/0x1d0
[ 3326.332028]  kmem_freepages+0xa0/0xf0
[ 3326.336531]  slabs_destroy+0x8e/0xd0
[ 3326.340251]  cache_flusharray+0xa5/0x110
[ 3326.344318]  ___cache_free+0x2e0/0x390
[ 3326.348209]  ? rcu_do_batch+0x14e/0x780
[ 3326.352167]  kmem_cache_free.part.0+0x34/0x110
[ 3326.356766]  rcu_do_batch+0x19e/0x780
[ 3326.360569]  rcu_core+0xef/0x190
[ 3326.363920]  __do_softirq+0xc9/0x425
[ 3326.367644]  asm_call_on_stack+0x12/0x20
[ 3326.371685]  </IRQ>
[ 3326.373906]  do_softirq_own_stack+0x4e/0x60
[ 3326.378583]  irq_exit_rcu+0x96/0xd0
[ 3326.382198]  sysvec_apic_timer_interrupt+0x43/0x90
[ 3326.387129]  asm_sysvec_apic_timer_interrupt+0x12/0x20
[ 3326.392405] RIP: 0010:acpi_safe_halt+0x29/0x30
[ 3326.397056] Code: cc 0f 1f 44 00 00 65 48 8b 04 25 00 6e 01 00 48 8b 00 a8 08 74 01 c3 e8 25 96 5c ff e9 07 00 00 00 0f 00 2d b3 80 4f 00 fb f4 <fa> e9 e1 97 5c ff cc 0f 1f 44 00 00 41 56 49 89 f6 41 55 41 89 d5
[ 3326.415945] RSP: 0018:ffffffffade03e20 EFLAGS: 00000202
[ 3326.421293] RAX: 000000000199dedf RBX: 0000000000000001 RCX: 00000000ffffffff
[ 3326.428656] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffffad5e433b
[ 3326.435910] RBP: ffff949dd7a29800 R08: 0000000000000001 R09: 0000000000000001
[ 3326.443169] R10: ffff949dd91ea724 R11: 00000000000008ee R12: ffff949dd7a29864
[ 3326.450420] R13: 0000000000000001 R14: 0000000000000001 R15: 0000000000000000
[ 3326.457690]  ? acpi_safe_halt+0x1b/0x30
[ 3326.461647]  acpi_idle_enter+0x1d0/0x260
[ 3326.465704]  cpuidle_enter_state+0x6e/0x3a0
[ 3326.470019]  cpuidle_enter+0x29/0x40
[ 3326.473726]  cpuidle_idle_call+0xf8/0x160
[ 3326.477854]  do_idle+0x72/0xc0
[ 3326.481036]  cpu_startup_entry+0x19/0x20
[ 3326.485079]  start_kernel+0x433/0x452
[ 3326.488899]  secondary_startup_64+0xb6/0xc0
[ 3326.493204] CR2: ffff949e7c958e3f
[ 3326.496757] ---[ end trace 464b5b002bebb81c ]---



On Thu, Sep 03, 2020 at 06:10:19PM -0600, Jens Axboe wrote:
> On 8/26/20 7:54 PM, Jens Axboe wrote:
> > On 8/25/20 8:18 AM, Jens Axboe wrote:
> >> On 8/24/20 4:56 AM, Jens Axboe wrote:
> >>> On 8/22/20 9:48 AM, Jens Axboe wrote:
> >>>> On 8/22/20 8:33 AM, Theodore Y. Ts'o wrote:
> >>>>> On Fri, Aug 21, 2020 at 03:26:35PM -0600, Jens Axboe wrote:
> >>>>>>>>> Resending this one, as I've been carrying it privately since May. The
> >>>>>>>>> necessary bits are now upstream (and XFS/btrfs equiv changes as well),
> >>>>>>>>> please consider this one for 5.9. Thanks!
> >>>>>>>>
> >>>>>>>> The necessary commit only hit upstream as of 5.9-rc1, unless I'm
> >>>>>>>> missing something?  It's on my queue to send to Linus once I get my
> >>>>>>>> (late) ext4 primary pull request for 5.9.
> >>>>>>>
> >>>>>>> Right, it went in at the start of the merge window for 5.9. Thanks Ted!
> >>>>>>
> >>>>>> Didn't see it in the queue that just sent in, is it still queued up?
> >>>>>
> >>>>> It wasn't in the queue which I queued up because that was based on
> >>>>> 5.8-rc4.  Linus was a bit grumpy (fairly so) because it was late, and
> >>>>> that's totally on me.
> >>>>>
> >>>>> He has said that he's going to start ignoring pull requests that
> >>>>> aren't fixes only if this becomes a pattern, so while I can send him
> >>>>> another pull request which will just have that one change, there are
> >>>>> no guarantees he's going to take it at this late date.
> >>>>>
> >>>>> Sorry, when you sent me the commit saying that the changes that were
> >>>>> needed were already upstream on August 3rd, I thought that meant that
> >>>>> they were aready in Linus's tree.  I should have checked and noticed
> >>>>> that that in fact "ext4: flag as supporting buffered async reads"
> >>>>> wasn't compiling against Linus's upstream tree, so I didn't realize
> >>>>> this needed to be handled as a special case during the merge window.
> >>>>
> >>>> Well to be honest, this kind of sucks. I've been posting it since May,
> >>>> and the ideal approach would have been to just ack it and I could have
> >>>> carried it in my tree. That's what we did for btrfs and XFS, both of
> >>>> which have it.
> >>>>
> >>>> The required patches *were* upstreamed on August 3rd, which is why I
> >>>> mentioned that. But yes, not in 5.8 or earlier, of course.
> >>>>
> >>>> So I suggest that you either include it for the next pull request for
> >>>> Linus, or that I put it in with your ack. Either is fine with me. I'd
> >>>> consider this a "dropping the ball" kind of thing, it's not like the
> >>>> patch hasn't been in linux-next or hasn't been ready for months. This
> >>>> isn't some "oh I wrote this feature after the merge window" event. It'd
> >>>> be a real shame to ship 5.9 and ext4 not have support for the more
> >>>> efficient async buffered reads, imho, especially since the two other
> >>>> major local file systems already have it.
> >>>>
> >>>> Let me know what you think.
> >>>
> >>> Ted, can you make a call on this, please? It's now post -rc2. Let's
> >>> get this settled and included, one way or another.
> >>
> >> Daily ping on this one...
> > 
> > And again. Ted, not sure how to make any progress with this, to be
> > honest, it's like pounding sand.
> 
> And 8 days later...
> 
> -- 
> Jens Axboe
> 
