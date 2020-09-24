Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D39D276582
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Sep 2020 02:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgIXA7X (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 23 Sep 2020 20:59:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52040 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726709AbgIXA7U (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 23 Sep 2020 20:59:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600909157;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ar08pVOoqug0+EnaX+b1kkxaXXVgPZwFs+5TBbd4RXk=;
        b=d8F6s5196zoZOCHRHJHIVnQUjPhEULwTGp9w4LagGs62i0PagmUPOpAg4s1UhU/ulMCnXm
        M2oFLGjftq4T6ciw5iiR3T5xBAdoUY4Ucr/JVEBmXjABw2WtNkJWQX6Y30WKhXzZrQU4GB
        mjQ6Fl5p1OT+SfTvkKP6j2IdPHz4dH4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-wflU13xwOPedjArH8DJ6ZQ-1; Wed, 23 Sep 2020 20:59:14 -0400
X-MC-Unique: wflU13xwOPedjArH8DJ6ZQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C6446186DD28;
        Thu, 24 Sep 2020 00:59:12 +0000 (UTC)
Received: from T590 (ovpn-12-168.pek2.redhat.com [10.72.12.168])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CEB4760BEC;
        Thu, 24 Sep 2020 00:59:05 +0000 (UTC)
Date:   Thu, 24 Sep 2020 08:59:01 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ext4@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: REGRESSION: 37f4a24c2469: blk-mq: centralise related handling
 into blk_mq_get_driver_tag
Message-ID: <20200924005901.GB1806978@T590>
References: <5140ba6c-779c-2a71-b7f2-3c3220cdf19c@kernel.dk>
 <68510957-c887-8e26-4a1a-a7a93488586a@kernel.dk>
 <20200904035528.GE558530@mit.edu>
 <20200915044519.GA38283@mit.edu>
 <20200915073303.GA754106@T590>
 <20200915224541.GB38283@mit.edu>
 <20200915230941.GA791425@T590>
 <20200916202026.GC38283@mit.edu>
 <20200917022051.GA1004828@T590>
 <20200917143012.GF38283@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917143012.GF38283@mit.edu>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Sep 17, 2020 at 10:30:12AM -0400, Theodore Y. Ts'o wrote:
> On Thu, Sep 17, 2020 at 10:20:51AM +0800, Ming Lei wrote:
> > 
> > Obviously there is other more serious issue, since 568f27006577 is
> > completely reverted in your test, and you still see list corruption
> > issue.
> > 
> > So I'd suggest to find the big issue first. Once it is fixed, maybe
> > everything becomes fine.
> > ...
> > Looks it is more like a memory corruption issue, is there any helpful log
> > dumped when running kernel with kasan?
> 
> Last night, I ran six VM's using -rc4 with and without KASAN; without
> Kasan, half of them hung.  With KASAN enabled, all of the test VM's
> ran to completion.
> 
> This strongly suggests whatever the problem is, it's timing related.
> I'll run a larger set of test runs to see if this pattern is confirmed
> today.
> 
> > BTW, I have kvm/qumu auto test which runs blktest/xfstest over virtio-blk/virito-scsi/loop/nvme
> > with xfs/ext4 every two days, and not see such failure recently, but the kernel config is based
> > rhel8's config.
> 
> Here is the configs I'm using, with and without KASAN.  (With KASAN is
> enabled is sent as a diff to avoid running into LKML's e-mail size
> restrictrions.)
>

The list corruption issue can be reproduced on kvm/qumu guest too when
running xfstests(ext4) generic/038.

However, the issue may become not reproduced when adding or removing memory
debug options, such as adding KASAN.

When I enable PAGE_POISONING, double free on kmalloc(192) is captured:

[ 1198.317139] slab: double free detected in cache 'kmalloc-192', objp ffff89ada7584300^M
[ 1198.326651] ------------[ cut here ]------------^M
[ 1198.327969] kernel BUG at mm/slab.c:2535!^M
[ 1198.329129] invalid opcode: 0000 [#1] SMP PTI^M
[ 1198.333776] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.9.0-rc4_quiesce_srcu-xfstests #102^M
[ 1198.336085] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-48-gd9c812dda519-prebuilt.qemu.org 04/01/2014^M
[ 1198.339826] RIP: 0010:free_block.cold.92+0x13/0x15^M
[ 1198.341472] Code: 8d 44 05 f0 eb d0 48 63 83 e0 00 00 00 48 8d 54 05 f8 e9 4b 81 ff ff 48 8b 73 58 48 89 ea 48 c7 c7 98 e7 4a 9c e8 20 c3 eb ff <0f> 0b 48 8b 73 58 48 c7 c2 20 e8 4a 9c 48 c7 c7 70 32 22 9c e8 19^M
[ 1198.347331] RSP: 0018:ffff982e40710be8 EFLAGS: 00010046^M
[ 1198.349091] RAX: 0000000000000048 RBX: ffff89adb6441400 RCX: 0000000000000000^M
[ 1198.351839] RDX: 0000000000000000 RSI: ffff89adbaa97800 RDI: ffff89adbaa97800^M
[ 1198.354572] RBP: ffff89ada7584300 R08: 0000000000000417 R09: 0000000000000057^M
[ 1198.357150] R10: 0000000000000001 R11: ffff982e40710aa5 R12: ffff89adbaaae598^M
[ 1198.359067] R13: ffffe7bc819d6108 R14: ffffe7bc819d6100 R15: ffff89adb6442280^M
[ 1198.360975] FS:  0000000000000000(0000) GS:ffff89adbaa80000(0000) knlGS:0000000000000000^M
[ 1198.363202] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033^M
[ 1198.365986] CR2: 000055f6a3811318 CR3: 000000017adca005 CR4: 0000000000770ee0^M
[ 1198.368679] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000^M
[ 1198.371386] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400^M
[ 1198.374203] PKRU: 55555554^M
[ 1198.375174] Call Trace:^M
[ 1198.376165]  <IRQ>^M
[ 1198.376908]  ___cache_free+0x56d/0x770^M
[ 1198.378355]  ? kmem_freepages+0xa0/0xf0^M
[ 1198.379814]  kfree+0x91/0x120^M
[ 1198.382121]  kmem_freepages+0xa0/0xf0^M
[ 1198.383474]  slab_destroy+0x9f/0x120^M
[ 1198.384779]  slabs_destroy+0x6d/0x90^M
[ 1198.386110]  ___cache_free+0x632/0x770^M
[ 1198.387547]  ? kmem_freepages+0xa0/0xf0^M
[ 1198.389016]  kfree+0x91/0x120^M
[ 1198.390160]  kmem_freepages+0xa0/0xf0^M
[ 1198.391551]  slab_destroy+0x9f/0x120^M
[ 1198.392964]  slabs_destroy+0x6d/0x90^M
[ 1198.394439]  ___cache_free+0x632/0x770^M
[ 1198.395896]  kmem_cache_free.part.75+0x19/0x70^M
[ 1198.397791]  rcu_core+0x1eb/0x6b0^M
[ 1198.399829]  ? ktime_get+0x37/0xa0^M
[ 1198.401343]  __do_softirq+0xdf/0x2c5^M
[ 1198.403010]  asm_call_on_stack+0x12/0x20^M
[ 1198.404847]  </IRQ>^M
[ 1198.405799]  do_softirq_own_stack+0x39/0x50^M
[ 1198.407621]  irq_exit_rcu+0x97/0xa0^M
[ 1198.409127]  sysvec_apic_timer_interrupt+0x2c/0x80^M
[ 1198.410608]  asm_sysvec_apic_timer_interrupt+0x12/0x20^M
[ 1198.411883] RIP: 0010:default_idle+0x13/0x20^M
[ 1198.412994] Code: 89 44 24 20 48 83 c0 22 48 89 44 24 28 eb c7 e8 03 93 ff ff cc cc cc 0f 1f 44 00 00 e9 07 00 00 00 0f 00 2d 11 ec 55 00 fb f4 <c3> 66 66 2e 0f 1f 84 00 00 00 00 00 90 0f 1f 44 00 00 65 48 8b 04^M
[ 1198.418791] RSP: 0018:ffff982e406abec8 EFLAGS: 00000246^M
[ 1198.420529] RAX: ffffffff9bca6ea0 RBX: 0000000000000001 RCX: ffff89aeafa69648^M
[ 1198.422884] RDX: ffff89adbaaaa9c0 RSI: 0000000000000000 RDI: 00000116f5b68899^M
[ 1198.425283] RBP: 0000000000000001 R08: 0000012531639bb4 R09: 0000000000000000^M
[ 1198.427804] R10: ffff89adb5e1f600 R11: 0000000000000000 R12: 0000000000000000^M
[ 1198.430532] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000^M
[ 1198.433025]  ? __sched_text_end+0x3/0x3^M
[ 1198.434264]  ? __sched_text_end+0x3/0x3^M
[ 1198.435727]  default_idle_call+0x3a/0xe0^M
[ 1198.437250]  do_idle+0x1d8/0x1f0^M
[ 1198.438476]  cpu_startup_entry+0x19/0x20^M
[ 1198.439973]  start_secondary+0x10a/0x150^M
[ 1198.440912]  secondary_startup_64+0xb6/0xc0^M
[ 1198.441924] Dumping ftrace buffer:^M
[ 1198.442872]    (ftrace buffer empty)^M
[ 1198.443839] ---[ end trace a133037ccc3cf29e ]---^M




Thanks,
Ming

