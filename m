Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 963D216566B
	for <lists+linux-ext4@lfdr.de>; Thu, 20 Feb 2020 05:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbgBTEz1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 19 Feb 2020 23:55:27 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:41932 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727576AbgBTEz1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 19 Feb 2020 23:55:27 -0500
Received: from callcc.thunk.org (guestnat-104-133-8-109.corp.google.com [104.133.8.109] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 01K4tEIg025137
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Feb 2020 23:55:15 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 03B064211EF; Wed, 19 Feb 2020 23:55:13 -0500 (EST)
Date:   Wed, 19 Feb 2020 23:55:13 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Shijie Luo <luoshijie1@huawei.com>
Cc:     linux-ext4@vger.kernel.org, jack@suse.cz, lutianxiong@huawei.com
Subject: Re: [PATCH] ext4: add cond_resched() to __ext4_find_entry()
Message-ID: <20200220045513.GD476845@mit.edu>
References: <20200215080206.13293-1-luoshijie1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200215080206.13293-1-luoshijie1@huawei.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Feb 15, 2020 at 03:02:06AM -0500, Shijie Luo wrote:
> We tested a soft lockup problem in linux 4.19 which could also
> be found in linux 5.x.
> 
> When dir inode takes up a large number of blocks, and if the
> directory is growing when we are searching, it's possible the
> restart branch could be called many times, and the do while loop
> could hold cpu a long time.
> 
> Here is the call trace in linux 4.19.
> 
> [  473.756186] Call trace:
> [  473.756196]  dump_backtrace+0x0/0x198
> [  473.756199]  show_stack+0x24/0x30
> [  473.756205]  dump_stack+0xa4/0xcc
> [  473.756210]  watchdog_timer_fn+0x300/0x3e8
> [  473.756215]  __hrtimer_run_queues+0x114/0x358
> [  473.756217]  hrtimer_interrupt+0x104/0x2d8
> [  473.756222]  arch_timer_handler_virt+0x38/0x58
> [  473.756226]  handle_percpu_devid_irq+0x90/0x248
> [  473.756231]  generic_handle_irq+0x34/0x50
> [  473.756234]  __handle_domain_irq+0x68/0xc0
> [  473.756236]  gic_handle_irq+0x6c/0x150
> [  473.756238]  el1_irq+0xb8/0x140
> [  473.756286]  ext4_es_lookup_extent+0xdc/0x258 [ext4]
> [  473.756310]  ext4_map_blocks+0x64/0x5c0 [ext4]
> [  473.756333]  ext4_getblk+0x6c/0x1d0 [ext4]
> [  473.756356]  ext4_bread_batch+0x7c/0x1f8 [ext4]
> [  473.756379]  ext4_find_entry+0x124/0x3f8 [ext4]
> [  473.756402]  ext4_lookup+0x8c/0x258 [ext4]
> [  473.756407]  __lookup_hash+0x8c/0xe8
> [  473.756411]  filename_create+0xa0/0x170
> [  473.756413]  do_mkdirat+0x6c/0x140
> [  473.756415]  __arm64_sys_mkdirat+0x28/0x38
> [  473.756419]  el0_svc_common+0x78/0x130
> [  473.756421]  el0_svc_handler+0x38/0x78
> [  473.756423]  el0_svc+0x8/0xc
> [  485.755156] watchdog: BUG: soft lockup - CPU#2 stuck for 22s! [tmp:5149]
> 
> Add cond_resched() to avoid soft lockup and to provide a better
> system responding.
> 
> Signed-off-by: Shijie Luo <luoshijie1@huawei.com>

Thanks, applied.

					- Ted
