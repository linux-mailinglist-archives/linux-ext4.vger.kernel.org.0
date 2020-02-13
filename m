Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23FA815C359
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Feb 2020 16:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387786AbgBMPk0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 13 Feb 2020 10:40:26 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:54668 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387776AbgBMPkZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 13 Feb 2020 10:40:25 -0500
Received: from callcc.thunk.org (guestnat-104-133-0-101.corp.google.com [104.133.0.101] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 01DFe3sU018178
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Feb 2020 10:40:04 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 7204642032C; Thu, 13 Feb 2020 10:40:03 -0500 (EST)
Date:   Thu, 13 Feb 2020 10:40:03 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Shijie Luo <luoshijie1@huawei.com>
Cc:     linux-ext4@vger.kernel.org, jack@suse.cz, yi.zhang@huawei.com,
        lutianxiong@huawei.com
Subject: Re: [PATCH v2] ext4: add cond_resched() to
 ext4_protect_reserved_inode
Message-ID: <20200213154003.GE239974@mit.edu>
References: <20200211011752.29242-1-luoshijie1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211011752.29242-1-luoshijie1@huawei.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Feb 10, 2020 at 08:17:52PM -0500, Shijie Luo wrote:
> When journal size is set too big by "mkfs.ext4 -J size=", or when
> we mount a crafted image to make journal inode->i_size too big,
> the loop, "while (i < num)", holds cpu too long. This could cause
> soft lockup.
> 
> [  529.357541] Call trace:
> [  529.357551]  dump_backtrace+0x0/0x198
> [  529.357555]  show_stack+0x24/0x30
> [  529.357562]  dump_stack+0xa4/0xcc
> [  529.357568]  watchdog_timer_fn+0x300/0x3e8
> [  529.357574]  __hrtimer_run_queues+0x114/0x358
> [  529.357576]  hrtimer_interrupt+0x104/0x2d8
> [  529.357580]  arch_timer_handler_virt+0x38/0x58
> [  529.357584]  handle_percpu_devid_irq+0x90/0x248
> [  529.357588]  generic_handle_irq+0x34/0x50
> [  529.357590]  __handle_domain_irq+0x68/0xc0
> [  529.357593]  gic_handle_irq+0x6c/0x150
> [  529.357595]  el1_irq+0xb8/0x140
> [  529.357599]  __ll_sc_atomic_add_return_acquire+0x14/0x20
> [  529.357668]  ext4_map_blocks+0x64/0x5c0 [ext4]
> [  529.357693]  ext4_setup_system_zone+0x330/0x458 [ext4]
> [  529.357717]  ext4_fill_super+0x2170/0x2ba8 [ext4]
> [  529.357722]  mount_bdev+0x1a8/0x1e8
> [  529.357746]  ext4_mount+0x44/0x58 [ext4]
> [  529.357748]  mount_fs+0x50/0x170
> [  529.357752]  vfs_kern_mount.part.9+0x54/0x188
> [  529.357755]  do_mount+0x5ac/0xd78
> [  529.357758]  ksys_mount+0x9c/0x118
> [  529.357760]  __arm64_sys_mount+0x28/0x38
> [  529.357764]  el0_svc_common+0x78/0x130
> [  529.357766]  el0_svc_handler+0x38/0x78
> [  529.357769]  el0_svc+0x8/0xc
> [  541.356516] watchdog: BUG: soft lockup - CPU#0 stuck for 23s! [mount:18674]
> 
> Signed-off-by: Shijie Luo <luoshijie1@huawei.com>
> Reviewed-by: Jan Kara <jack@suse.cz>

Applied, thanks.

					- Ted
