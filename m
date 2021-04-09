Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2983E359BCC
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Apr 2021 12:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234146AbhDIKTB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 9 Apr 2021 06:19:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:39488 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232395AbhDIKS0 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 9 Apr 2021 06:18:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D8F79AF3E;
        Fri,  9 Apr 2021 10:18:11 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 8AF8F1F2B59; Fri,  9 Apr 2021 12:18:11 +0200 (CEST)
Date:   Fri, 9 Apr 2021 12:18:11 +0200
From:   Jan Kara <jack@suse.cz>
To:     riteshh <riteshh@linux.ibm.com>
Cc:     Wen Yang <wenyang@linux.alibaba.com>, adilger@dilger.ca,
        tytso@mit.edu, linux-ext4@vger.kernel.org, jack@suse.cz,
        linux-kernel@vger.kernel.org, baoyou.xie@alibaba-inc.com
Subject: Re: [PATCH] ext4: add a configurable parameter to prevent endless
 loop in ext4_mb_discard_group_p
Message-ID: <20210409101811.GB20833@quack2.suse.cz>
References: <f16d7afa-3799-f523-3c19-9ceb9427ff6e@linux.alibaba.com>
 <20210409054733.avv3ofqpka4m6xe5@riteshh-domain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210409054733.avv3ofqpka4m6xe5@riteshh-domain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 09-04-21 11:17:33, riteshh wrote:
> On 21/04/09 02:50AM, Wen Yang wrote:
> > > On Apr 7, 2021, at 5:16 AM, riteshh <riteshh@linux.ibm.com> wrote:
> > >>
> > >> On 21/04/07 03:01PM, Wen Yang wrote:
> > >>> From: Wen Yang <simon.wy@alibaba-inc.com>
> > >>>
> > >>> The kworker has occupied 100% of the CPU for several days:
> > >>> PID USER  PR  NI VIRT RES SHR S  %CPU  %MEM TIME+  COMMAND
> > >>> 68086 root 20 0  0    0   0   R  100.0 0.0  9718:18 kworker/u64:11
> > >>>
> > >>> And the stack obtained through sysrq is as follows:
> > >>> [20613144.850426] task: ffff8800b5e08000 task.stack: ffffc9001342c000
> > >>> [20613144.850438] Call Trace:
> > >>> [20613144.850439] [<ffffffffa0244209>]ext4_mb_new_blocks+0x429/0x550
> > [ext4]
> > >>> [20613144.850439]  [<ffffffffa02389ae>] ext4_ext_map_blocks+0xb5e/0xf30
> > [ext4]
> > >>> [20613144.850441]  [<ffffffffa0204b52>] ext4_map_blocks+0x172/0x620
> > [ext4]
> > >>> [20613144.850442]  [<ffffffffa0208675>] ext4_writepages+0x7e5/0xf00
> > [ext4]
> > >>> [20613144.850443]  [<ffffffff811c487e>] do_writepages+0x1e/0x30
> > >>> [20613144.850444]  [<ffffffff81280265>]
> > __writeback_single_inode+0x45/0x320
> > >>> [20613144.850444]  [<ffffffff81280ab2>] writeback_sb_inodes+0x272/0x600
> > >>> [20613144.850445]  [<ffffffff81280ed2>] __writeback_inodes_wb+0x92/0xc0
> > >>> [20613144.850445]  [<ffffffff81281238>] wb_writeback+0x268/0x300
> > >>> [20613144.850446]  [<ffffffff812819f4>] wb_workfn+0xb4/0x380
> > >>> [20613144.850447]  [<ffffffff810a5dc9>] process_one_work+0x189/0x420
> > >>> [20613144.850447]  [<ffffffff810a60ae>] worker_thread+0x4e/0x4b0
> > >>>
> > >>> The cpu resources of the cloud server are precious, and the server
> > >>> cannot be restarted after running for a long time, so a configuration
> > >>> parameter is added to prevent this endless loop.
> > >>
> > >> Strange, if there is a endless loop here. Then I would definitely see
> > >> if there is any accounting problem in pa->pa_count. Otherwise busy=1
> > >> should not be set everytime. ext4_mb_show_pa() function may help debug
> > this.
> > >>
> > >> If yes, then that means there always exists either a file preallocation
> > >> or a group preallocation. Maybe it is possible, in some use case.
> > >> Others may know of such use case, if any.
> >
> > > If this code is broken, then it doesn't make sense to me that we would
> > > leave it in the "run forever" state after the patch, and require a sysfs
> > > tunable to be set to have a properly working system?
> >
> > > Is there anything particularly strange about the workload/system that
> > > might cause this?  Filesystem is very full, memory is very low, etc?
> >
> > Hi Ritesh and Andreas,
> >
> > Thank you for your reply. Since there is still a faulty machine, we have
> > analyzed it again and found it is indeed a very special case:
> >
> >
> > crash> struct ext4_group_info ffff8813bb5f72d0
> > struct ext4_group_info {
> >   bb_state = 0,
> >   bb_free_root = {
> >     rb_node = 0x0
> >   },
> >   bb_first_free = 1681,
> >   bb_free = 0,
> 
> Not related to this issue, but above two variables values doesn't looks
> consistent.
> 
> >   bb_fragments = 0,
> >   bb_largest_free_order = -1,
> >   bb_prealloc_list = {
> >     next = 0xffff880268291d78,
> >     prev = 0xffff880268291d78     ---> *** The list is empty
> >   },
> 
> Ok. So when you collected the dump this list was empty.

No, it is not empty. It has a single element. Note that the structure is at
ffff8813bb5f72d0 so the pointers would have to be like ffff8813bb5f7xxx.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
