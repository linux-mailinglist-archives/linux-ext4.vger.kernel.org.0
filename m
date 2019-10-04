Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12B77CC372
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Oct 2019 21:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730313AbfJDTMx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 4 Oct 2019 15:12:53 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:55189 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728360AbfJDTMx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 4 Oct 2019 15:12:53 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-98.corp.google.com [104.133.0.98] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x94JCmsL011818
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 4 Oct 2019 15:12:49 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id E58EE42088C; Fri,  4 Oct 2019 15:12:47 -0400 (EDT)
Date:   Fri, 4 Oct 2019 15:12:47 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH v3 00/13] ext4: add fast commit support
Message-ID: <20191004191247.GA12012@mit.edu>
References: <20191001074101.256523-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191001074101.256523-1-harshadshirwadkar@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Oct 01, 2019 at 12:40:49AM -0700, Harshad Shirwadkar wrote:
> 
> Testing
> -------
> 
> e2fsprogs was updated to set fast commit feature flag and to ignore
> fast commit blocks during e2fsck.
> 
> https://github.com/harshadjs/e2fsprogs.git
> 
> After applying all the patches in this series, following runs of
> xfstests were performed:
> 
> - kvm-xfstest.sh -g log -c 4k
> - kvm-xfstests.sh smoke
> 
> All the log tests were successful and smoke tests didn't introduce any
> additional failures.

You should probably also try running the shutdown tests, and
eventually, run all of the auto group.  I've added a fast_commit group
to {kvm,gce}-xfstests, although to use it a modified e2fsprogs which
understands the fast_commit feature.  I can make kvm-xfstests and
gce-xfstests image using an e2fsprogs package from debian/experimental
which has fast_commit enabled.

When I tried running all of the auto group tests, the following
failure was found in generic/047 (which is a shutdown group test).

						- Ted

BEGIN TEST fast_commit (1 test): Ext4 4k block w/fast_commit Fri Oct  4 13:44:45 EDT 2019
DEVICE: /dev/vdd
EXT_MKFS_OPTIONS: -I 256 -O fast_commit,64bit
EXT_MOUNT_OPTIONS: -o block_validity
FSTYP         -- ext4
PLATFORM      -- Linux/x86_64 kvm-xfstests 5.3.0-rc4-xfstests-00012-gedca88337ca9 #1202 SMP Thu Oct 3 17:27:50 EDT 2019
MKFS_OPTIONS  -- -q -I 256 -O fast_commit,64bit /dev/vdc
MOUNT_OPTIONS -- -o acl,user_xattr -o block_validity /dev/vdc /vdc

generic/047		[13:44:46][   24.671344] run fstests generic/047 at 2019-10-04 13:44:46
[   24.951140] EXT4-fs (vdc): shut down requested (1)
[   24.952280] Aborting journal on device vdc-8.
[   28.012724] EXT4-fs (vdc): shut down requested (2)
[   28.013639] Aborting journal on device vdc-8.
[   28.014486] 
[   28.014845] ============================================
[   28.015996] WARNING: possible recursive locking detected
[   28.017072] 5.3.0-rc4-xfstests-00012-gedca88337ca9 #1202 Not tainted
[   28.018374] --------------------------------------------
[   28.019693] jbd2/vdc-8/1476 is trying to acquire lock:
[   28.020635] 000000005ce13aef (&(&sbi->s_fc_lock)->rlock){+.+.}, at: ext4_journal_fc_cleanup_cb+0x2f/0xa0
[   28.022387] 
[   28.022387] but task is already holding lock:
[   28.023414] 000000005ce13aef (&(&sbi->s_fc_lock)->rlock){+.+.}, at: ext4_journal_fc_commit_cb+0x83/0xa90
[   28.025237] 
[   28.025237] other info that might help us debug this:
[   28.026350]  Possible unsafe locking scenario:
[   28.026350] 
[   28.027336]        CPU0
[   28.027758]        ----
[   28.028240]   lock(&(&sbi->s_fc_lock)->rlock);
[   28.029105]   lock(&(&sbi->s_fc_lock)->rlock);
[   28.029937] 
[   28.029937]  *** DEADLOCK ***
[   28.029937] 
[   28.031154]  May be due to missing lock nesting notation
[   28.031154] 
[   28.032780] 1 lock held by jbd2/vdc-8/1476:
[   28.033760]  #0: 000000005ce13aef (&(&sbi->s_fc_lock)->rlock){+.+.}, at: ext4_journal_fc_commit_cb+0x83/0xa90
[   28.035436] 
[   28.035436] stack backtrace:
[   28.036197] CPU: 1 PID: 1476 Comm: jbd2/vdc-8 Not tainted 5.3.0-rc4-xfstests-00012-gedca88337ca9 #1202
[   28.037868] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[   28.039289] Call Trace:
[   28.039772]  dump_stack+0x67/0x90
[   28.040427]  validate_chain.cold+0x1be/0x21b
[   28.041305]  __lock_acquire+0x447/0x7c0
[   28.042069]  lock_acquire+0x9a/0x180
[   28.042738]  ? ext4_journal_fc_cleanup_cb+0x2f/0xa0
[   28.043663]  _raw_spin_lock+0x31/0x80
[   28.044346]  ? ext4_journal_fc_cleanup_cb+0x2f/0xa0
[   28.045264]  ext4_journal_fc_cleanup_cb+0x2f/0xa0
[   28.046154]  jbd2_journal_commit_transaction+0x243/0x24bb
[   28.047156]  ? sched_clock_cpu+0xc/0xc0
[   28.048099]  ? lock_timer_base+0x10/0x80
[   28.048935]  ? kvm_sched_clock_read+0x14/0x30
[   28.050022]  ? sched_clock+0x5/0x10
[   28.050853]  ? sched_clock_cpu+0xc/0xc0
[   28.051793]  ? kjournald2+0x143/0x3f0
[   28.052606]  kjournald2+0x143/0x3f0
[   28.053311]  ? __wake_up_common_lock+0xc0/0xc0
[   28.054935]  kthread+0x108/0x140
[   28.055975]  ? __jbd2_debug+0x50/0x50
[   28.057105]  ? __kthread_create_on_node+0x1a0/0x1a0
[   28.058346]  ret_from_fork+0x3a/0x50
