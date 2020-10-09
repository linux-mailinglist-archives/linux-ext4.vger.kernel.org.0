Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5554328800F
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Oct 2020 03:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730499AbgJIBmA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Oct 2020 21:42:00 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:38896 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727313AbgJIBmA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Oct 2020 21:42:00 -0400
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0991ffma023866
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 8 Oct 2020 21:41:42 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id D432B420107; Thu,  8 Oct 2020 21:41:40 -0400 (EDT)
Date:   Thu, 8 Oct 2020 21:41:40 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     "zhangyi (F)" <yi.zhang@huawei.com>
Cc:     linux-ext4@vger.kernel.org, jack@suse.com, adilger.kernel@dilger.ca
Subject: Re: [PATCH v2 1/7] ext4: clear buffer verified flag if read meta
 block from disk
Message-ID: <20201009014140.GA816148@mit.edu>
References: <20200924073337.861472-1-yi.zhang@huawei.com>
 <20200924073337.861472-2-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924073337.861472-2-yi.zhang@huawei.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Sep 24, 2020 at 03:33:31PM +0800, zhangyi (F) wrote:
> The metadata buffer is no longer trusted after we read it from disk
> again because it is not uptodate for some reasons (e.g. failed to write
> back). Otherwise we may get below memory corruption problem in
> ext4_ext_split()->memset() if we read stale data from the newly
> allocated extent block on disk which has been failed to async write
> out but miss verify again since the verified bit has already been set
> on the buffer.
> 
> [   29.774674] BUG: unable to handle kernel paging request at ffff88841949d000
> ...
> [   29.783317] Oops: 0002 [#2] SMP
> [   29.784219] R10: 00000000000f4240 R11: 0000000000002e28 R12: ffff88842fa1c800
> [   29.784627] CPU: 1 PID: 126 Comm: kworker/u4:3 Tainted: G      D W
> [   29.785546] R13: ffffffff9cddcc20 R14: ffffffff9cddd420 R15: ffff88842fa1c2f8
> [   29.786679] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),BIOS ?-20190727_0738364
> [   29.787588] FS:  0000000000000000(0000) GS:ffff88842fa00000(0000) knlGS:0000000000000000
> [   29.789288] Workqueue: writeback wb_workfn
> [   29.790319] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   29.790321]  (flush-8:0)
> [   29.790844] CR2: 0000000000000008 CR3: 00000004234f2000 CR4: 00000000000006f0
> [   29.791924] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   29.792839] RIP: 0010:__memset+0x24/0x30
> [   29.793739] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [   29.794256] Code: 90 90 90 90 90 90 0f 1f 44 00 00 49 89 f9 48 89 d1 83 e2 07 48 c1 e9 033
> [   29.795161] Kernel panic - not syncing: Fatal exception in interrupt
> ...
> [   29.808149] Call Trace:
> [   29.808475]  ext4_ext_insert_extent+0x102e/0x1be0
> [   29.809085]  ext4_ext_map_blocks+0xa89/0x1bb0
> [   29.809652]  ext4_map_blocks+0x290/0x8a0
> [   29.809085]  ext4_ext_map_blocks+0xa89/0x1bb0
> [   29.809652]  ext4_map_blocks+0x290/0x8a0
> [   29.810161]  ext4_writepages+0xc85/0x17c0
> ...
> 
> Fix this by clearing buffer's verified bit if we read meta block from
> disk again.
> 
> Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
> Cc: stable@vger.kernel.org

Thanks, applied.

						- Ted
