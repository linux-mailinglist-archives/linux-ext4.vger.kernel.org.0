Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE3FC278E22
	for <lists+linux-ext4@lfdr.de>; Fri, 25 Sep 2020 18:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729493AbgIYQT5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 25 Sep 2020 12:19:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59632 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729487AbgIYQTn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 25 Sep 2020 12:19:43 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601050781;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+2hrKFRlzGfDBu5G+/DxvZSBH4wZ6Iui7mGe31XYBtE=;
        b=TXNgTyb21ZQUQIB620Us1ib44CV9NrSCJJgOm27MprPC8CRfsUS8L62gS9H78BKtET2LLv
        CkbO/2GD2Mfl3XKXXgfpVfFEtkbgMIjvARMJThUTUrCMgFDqmSMYcsxeu3scfiFOifmXkB
        jXRb+8qucmb8QiriEQxE71wHzbuvkf4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-b50Y-AANM8WoO32iUX_iqQ-1; Fri, 25 Sep 2020 12:19:36 -0400
X-MC-Unique: b50Y-AANM8WoO32iUX_iqQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 355D38712F6;
        Fri, 25 Sep 2020 16:19:34 +0000 (UTC)
Received: from T590 (ovpn-12-168.pek2.redhat.com [10.72.12.168])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B95CA19C78;
        Fri, 25 Sep 2020 16:19:23 +0000 (UTC)
Date:   Sat, 26 Sep 2020 00:19:18 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ext4@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeelb@google.com>
Subject: Re: REGRESSION: 37f4a24c2469: blk-mq: centralise related handling
 into blk_mq_get_driver_tag
Message-ID: <20200925161918.GD2388140@T590>
References: <20200915073303.GA754106@T590>
 <20200915224541.GB38283@mit.edu>
 <20200915230941.GA791425@T590>
 <20200916202026.GC38283@mit.edu>
 <20200917022051.GA1004828@T590>
 <20200917143012.GF38283@mit.edu>
 <20200924005901.GB1806978@T590>
 <20200924143345.GD482521@mit.edu>
 <20200925011311.GJ482521@mit.edu>
 <20200925073145.GC2388140@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200925073145.GC2388140@T590>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Sep 25, 2020 at 03:31:45PM +0800, Ming Lei wrote:
> On Thu, Sep 24, 2020 at 09:13:11PM -0400, Theodore Y. Ts'o wrote:
> > On Thu, Sep 24, 2020 at 10:33:45AM -0400, Theodore Y. Ts'o wrote:
> > > HOWEVER, thanks to a hint from a colleague at $WORK, and realizing
> > > that one of the stack traces had virtio balloon in the trace, I
> > > realized that when I switched the GCE VM type from e1-standard-2 to
> > > n1-standard-2 (where e1 VM's are cheaper because they use
> > > virtio-balloon to better manage host OS memory utilization), problem
> > > has become, much, *much* rarer (and possibly has gone away, although
> > > I'm going to want to run a lot more tests before I say that
> > > conclusively) on my test setup.  At the very least, using an n1 VM
> > > (which doesn't have virtio-balloon enabled in the hypervisor) is
> > > enough to unblock ext4 development.
> > 
> > .... and I spoke too soon.  A number of runs using -rc6 are now
> > failing even with the n1-standard-2 VM, so virtio-ballon may not be an
> > indicator.
> > 
> > This is why debugging this is frustrating; it is very much a heisenbug
> > --- although 5.8 seems to work completely reliably, as does commits
> > before 37f4a24c2469.  Anything after that point will show random
> > failures.  :-(
> 
> It does not make sense to mention 37f4a24c2469, which is reverted in
> 4e2f62e566b5. Later the patch in 37f4a24c2469 is fixed and re-commited
> as 568f27006577.
> 
> However, I can _not_ reproduce the issue by running the same test on
> kernel built from 568f27006577 directly.
> 
> Also you have confirmed that the issue can't be fixed after reverting
> 568f27006577 against v5.9-rc4.
> 
> Looks the real issue(slab list corruption) should be introduced between
> 568f27006577 and v5.9-rc4.

git bisect shows the first bad commit:

	[10befea91b61c4e2c2d1df06a2e978d182fcf792] mm: memcg/slab: use a single set of
		kmem_caches for all allocations

And I have double checked that the above commit is really the first bad
commit for the list corruption issue of 'list_del corruption, ffffe1c241b00408->next
is LIST_POISON1 (dead000000000100)', see the detailed stack trace and
kernel oops log in the following link:

	https://lore.kernel.org/lkml/20200916202026.GC38283@mit.edu/

And the kernel config is the one(without KASAN) used by Theodore in GCE VM, see
the following link:

	https://lore.kernel.org/lkml/20200917143012.GF38283@mit.edu/

The reproducer is xfstests generic/038. In my setting, test device is virtio-scsi, and
scratch device is virtio-blk.


[1] git bisect log:

git bisect start
# good: [568f2700657794b8258e72983ba508793a658942] blk-mq: centralise related handling into blk_mq_get_driver_tag
git bisect good 568f2700657794b8258e72983ba508793a658942
# bad: [f4d51dffc6c01a9e94650d95ce0104964f8ae822] Linux 5.9-rc4
git bisect bad f4d51dffc6c01a9e94650d95ce0104964f8ae822
# good: [8186749621ed6b8fc42644c399e8c755a2b6f630] Merge tag 'drm-next-2020-08-06' of git://anongit.freedesktop.org/drm/drm
git bisect good 8186749621ed6b8fc42644c399e8c755a2b6f630
# good: [60e76bb8a4e4c5398ea9053535e1fd0c9d6bb06e] Merge tag 'm68knommu-for-v5.9' of git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu
git bisect good 60e76bb8a4e4c5398ea9053535e1fd0c9d6bb06e
# bad: [57b077939287835b9396a1c3b40d35609cf2fcb8] Merge tag 'for_linus' of git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost
git bisect bad 57b077939287835b9396a1c3b40d35609cf2fcb8
# bad: [0f43283be7fec4a76cd4ed50dc37db30719bde05] Merge branch 'work.fdpic' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs
git bisect bad 0f43283be7fec4a76cd4ed50dc37db30719bde05
# good: [5631c5e0eb9035d92ceb20fcd9cdb7779a3f5cc7] Merge tag 'xfs-5.9-merge-7' of git://git.kernel.org/pub/scm/fs/xfs/xfs-linux
git bisect good 5631c5e0eb9035d92ceb20fcd9cdb7779a3f5cc7
# good: [e3083c3f369700cd1eec3de93b8d8ec0918ff778] media: cafe-driver: use generic power management
git bisect good e3083c3f369700cd1eec3de93b8d8ec0918ff778
# bad: [42742d9bde2a8e11ec932cb5821f720a40a7c2a9] mm: thp: replace HTTP links with HTTPS ones
git bisect bad 42742d9bde2a8e11ec932cb5821f720a40a7c2a9
# bad: [10befea91b61c4e2c2d1df06a2e978d182fcf792] mm: memcg/slab: use a single set of kmem_caches for all allocations
git bisect bad 10befea91b61c4e2c2d1df06a2e978d182fcf792
# good: [cfbe1636c3585c1e032bfac512fb8be903fbc913] mm, kcsan: instrument SLAB/SLUB free with "ASSERT_EXCLUSIVE_ACCESS"
git bisect good cfbe1636c3585c1e032bfac512fb8be903fbc913
# good: [0f190a7ab78878f9e6c6930fc0f5f92c1250b57d] mm/page_io.c: use blk_io_schedule() for avoiding task hung in sync io
git bisect good 0f190a7ab78878f9e6c6930fc0f5f92c1250b57d
# good: [286e04b8ed7a04279ae277f0f024430246ea5eec] mm: memcg/slab: allocate obj_cgroups for non-root slab pages
git bisect good 286e04b8ed7a04279ae277f0f024430246ea5eec
# good: [9855609bde03e2472b99a95e869d29ee1e78a751] mm: memcg/slab: use a single set of kmem_caches for all accounted allocations
git bisect good 9855609bde03e2472b99a95e869d29ee1e78a751
# good: [272911a4ad18c48f8bc449a5db945a54987dd687] mm: memcg/slab: remove memcg_kmem_get_cache()
git bisect good 272911a4ad18c48f8bc449a5db945a54987dd687
# good: [15999eef7f25e2ea6a1c33f026166f472c5714e9] mm: memcg/slab: remove redundant check in memcg_accumulate_slabinfo()
git bisect good 15999eef7f25e2ea6a1c33f026166f472c5714e9
# first bad commit: [10befea91b61c4e2c2d1df06a2e978d182fcf792] mm: memcg/slab: use a single set of kmem_caches for all allocations



Thanks,
Ming

