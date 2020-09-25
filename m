Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F320277DFB
	for <lists+linux-ext4@lfdr.de>; Fri, 25 Sep 2020 04:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726919AbgIYCeq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 24 Sep 2020 22:34:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58912 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726694AbgIYCeq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 24 Sep 2020 22:34:46 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601001283;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p4Otes/aB3TptUk2VNMI14FEqR4kwIN9vrjWhaUuPz4=;
        b=dx0GTrtDHRCK4tPK7QorLAz3HIYR4WlFqLNf7nVGf2wyg34qe0xop9cRmKTuPL5zDCxrNQ
        sgAzHgBPrQ/Yx+HI8i7wNrBiagGWyuk2RsjvIu34KKPhnig3fRRRmJBsNJ5vVsH+ZnSpgI
        rS+lJzHF6NgCBGJ3rUfsSuv+FsquPYo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-z03vvjgJOA6uFNhqF5EzAg-1; Thu, 24 Sep 2020 22:34:40 -0400
X-MC-Unique: z03vvjgJOA6uFNhqF5EzAg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BECBA80734F;
        Fri, 25 Sep 2020 02:34:38 +0000 (UTC)
Received: from T590 (ovpn-12-168.pek2.redhat.com [10.72.12.168])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5B5F22634D;
        Fri, 25 Sep 2020 02:34:32 +0000 (UTC)
Date:   Fri, 25 Sep 2020 10:34:27 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ext4@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: REGRESSION: 37f4a24c2469: blk-mq: centralise related handling
 into blk_mq_get_driver_tag
Message-ID: <20200925023427.GB2388140@T590>
References: <20200915044519.GA38283@mit.edu>
 <20200915073303.GA754106@T590>
 <20200915224541.GB38283@mit.edu>
 <20200915230941.GA791425@T590>
 <20200916202026.GC38283@mit.edu>
 <20200917022051.GA1004828@T590>
 <20200917143012.GF38283@mit.edu>
 <20200924005901.GB1806978@T590>
 <20200924143345.GD482521@mit.edu>
 <20200925011416.GA2388140@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200925011416.GA2388140@T590>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Sep 25, 2020 at 09:14:16AM +0800, Ming Lei wrote:
> On Thu, Sep 24, 2020 at 10:33:45AM -0400, Theodore Y. Ts'o wrote:
> > On Thu, Sep 24, 2020 at 08:59:01AM +0800, Ming Lei wrote:
> > > 
> > > The list corruption issue can be reproduced on kvm/qumu guest too when
> > > running xfstests(ext4) generic/038.
> > > 
> > > However, the issue may become not reproduced when adding or removing memory
> > > debug options, such as adding KASAN.
> > 
> > Can you reliably reprodue this crash?  And if so, with what config and
> > what kernel version.
> 
> Yeah, it can be reproduced reliably by running xfstests(ext4)
> generic/038 over virtio-scsi(test device)/virtio-blk(scratch device).
> 
> The kernel is -rc4, and not test -rc5 yet.
> 
> It is exactly the config you provided, and I just enabled CDROM & ISOFS
> against your config for passing cloud-init data via cdrom to VM.
> 
> > One of the reasons why I had gone silent on this bug is that I've been
> > trying many, many configurations and configurations which reliably
> > reproduced on say, -rc4 would not reproduce on -rc5, and then I would
> > get a completely different set of results on -rc6.  So I've been
> > trying to run a lot of different experiments to try to understand what
> > might be going on, since it seems pretty clear this must be a very
> > timing-sensitive failure.
> > 
> > I also found that the re-occrance went down significantly if I enabled
> > KASAN, and while it didn't go away, I wasn't able to get a KASAN
> > failure to trigger, either.  Turning off CONFIG_PROVE_LOCKING and a
> > *lot* of other debugging configs made the problem vanish in -rc4, but
> > that trick didn't work with -rc5 or -rc6.
> 
> The issue can be reproduced reliably in my environment after
> disabling LOCKDEP only for disabling KMEMLEAK only.
> 
> But after disabling DEBUG_OBJECTS, it becomes hard to trigger.
> 
> > 
> > Each time I discovered one of these things, I was about to post to the
> > e-mail thread, only to have a confirmation test run on a different
> > kernel version make the problem go away.  In particular, your revert
> > helped with -rc4 and -rc6 IIRC, but it didn't help in -rc5.....
> > 
> > HOWEVER, thanks to a hint from a colleague at $WORK, and realizing
> > that one of the stack traces had virtio balloon in the trace, I
> > realized that when I switched the GCE VM type from e1-standard-2 to
> > n1-standard-2 (where e1 VM's are cheaper because they use
> > virtio-balloon to better manage host OS memory utilization), problem
> > has become, much, *much* rarer (and possibly has gone away, although
> > I'm going to want to run a lot more tests before I say that
> > conclusively) on my test setup.  At the very least, using an n1 VM
> > (which doesn't have virtio-balloon enabled in the hypervisor) is
> > enough to unblock ext4 development.
> > 
> > Any chance your kvm/qemu configuration might have been using
> > virtio-ballon?  Because other ext4 developers who have been using
> > kvm-xftests have not had any problems....
> 
> I don't setup virtio-ballon, see the attached script for setting the VM.
> 
> > 
> > > When I enable PAGE_POISONING, double free on kmalloc(192) is captured:
> > > 
> > > [ 1198.317139] slab: double free detected in cache 'kmalloc-192', objp ffff89ada7584300^M
> > > [ 1198.326651] ------------[ cut here ]------------^M
> > > [ 1198.327969] kernel BUG at mm/slab.c:2535!^M
> > > [ 1198.329129] invalid opcode: 0000 [#1] SMP PTI^M
> > > [ 1198.333776] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.9.0-rc4_quiesce_srcu-xfstests #102^M
> > > [ 1198.336085] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-48-gd9c812dda519-prebuilt.qemu.org 04/01/2014^M
> > > [ 1198.339826] RIP: 0010:free_block.cold.92+0x13/0x15^M
> > > [ 1198.341472] Code: 8d 44 05 f0 eb d0 48 63 83 e0 00 00 00 48 8d 54 05 f8 e9 4b 81 ff ff 48 8b 73 58 48 89 ea 48 c7 c7 98 e7 4a 9c e8 20 c3 eb ff <0f> 0b 48 8b 73 58 48 c7 c2 20 e8 4a 9c 48 c7 c7 70 32 22 9c e8 19^M
> > > [ 1198.347331] RSP: 0018:ffff982e40710be8 EFLAGS: 00010046^M
> > > [ 1198.349091] RAX: 0000000000000048 RBX: ffff89adb6441400 RCX: 0000000000000000^M
> > > [ 1198.351839] RDX: 0000000000000000 RSI: ffff89adbaa97800 RDI: ffff89adbaa97800^M
> > > [ 1198.354572] RBP: ffff89ada7584300 R08: 0000000000000417 R09: 0000000000000057^M
> > > [ 1198.357150] R10: 0000000000000001 R11: ffff982e40710aa5 R12: ffff89adbaaae598^M
> > > [ 1198.359067] R13: ffffe7bc819d6108 R14: ffffe7bc819d6100 R15: ffff89adb6442280^M
> > > [ 1198.360975] FS:  0000000000000000(0000) GS:ffff89adbaa80000(0000) knlGS:0000000000000000^M
> > > [ 1198.363202] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033^M
> > > [ 1198.365986] CR2: 000055f6a3811318 CR3: 000000017adca005 CR4: 0000000000770ee0^M
> > > [ 1198.368679] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000^M
> > > [ 1198.371386] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400^M
> > > [ 1198.374203] PKRU: 55555554^M
> > > [ 1198.375174] Call Trace:^M
> > > [ 1198.376165]  <IRQ>^M
> > > [ 1198.376908]  ___cache_free+0x56d/0x770^M
> > > [ 1198.378355]  ? kmem_freepages+0xa0/0xf0^M
> > > [ 1198.379814]  kfree+0x91/0x120^M
> > > [ 1198.382121]  kmem_freepages+0xa0/0xf0^M
> > > [ 1198.383474]  slab_destroy+0x9f/0x120^M
> > > [ 1198.384779]  slabs_destroy+0x6d/0x90^M
> > > [ 1198.386110]  ___cache_free+0x632/0x770^M
> > > [ 1198.387547]  ? kmem_freepages+0xa0/0xf0^M
> > > [ 1198.389016]  kfree+0x91/0x120^M
> > > [ 1198.390160]  kmem_freepages+0xa0/0xf0^M
> > > [ 1198.391551]  slab_destroy+0x9f/0x120^M
> > > [ 1198.392964]  slabs_destroy+0x6d/0x90^M
> > > [ 1198.394439]  ___cache_free+0x632/0x770^M
> > > [ 1198.395896]  kmem_cache_free.part.75+0x19/0x70^M
> > > [ 1198.397791]  rcu_core+0x1eb/0x6b0^M
> > > [ 1198.399829]  ? ktime_get+0x37/0xa0^M
> > > [ 1198.401343]  __do_softirq+0xdf/0x2c5^M
> > > [ 1198.403010]  asm_call_on_stack+0x12/0x20^M
> > > [ 1198.404847]  </IRQ>^M
> > > [ 1198.405799]  do_softirq_own_stack+0x39/0x50^M
> > > [ 1198.407621]  irq_exit_rcu+0x97/0xa0^M
> > > [ 1198.409127]  sysvec_apic_timer_interrupt+0x2c/0x80^M
> > > [ 1198.410608]  asm_sysvec_apic_timer_interrupt+0x12/0x20^M
> > > [ 1198.411883] RIP: 0010:default_idle+0x13/0x20^M
> > > [ 1198.412994] Code: 89 44 24 20 48 83 c0 22 48 89 44 24 28 eb c7 e8 03 93 ff ff cc cc cc 0f 1f 44 00 00 e9 07 00 00 00 0f 00 2d 11 ec 55 00 fb f4 <c3> 66 66 2e 0f 1f 84 00 00 00 00 00 90 0f 1f 44 00 00 65 48 8b 04^M
> > 
> > Hmm, so that this looks like some kind of RCU involvement?  Some kind
> > of object that had been scheduled to be freed via RCU, but then got
> > freed before RCU cleanup happened?
> > 
> > The question then is what subsystem the object involved came from.
> 
> Right now, I don't get time to investigate further. It shouldn't be
> hard to locate where the 192 slab allocation is from, together with RCU
> involved.
> 
> BTW, the double free is triggered by the following change on your
> config:
> 
> - disable lockdep
> - disable kmemleak
> - enable PAGE_POISONING

oops, double free is captured by enabling CONFIG_DEBUG_SLAB instead of
PAGE_POISONING, looks it is triggered reliably too.

Thanks,
Ming

