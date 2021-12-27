Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 175CA47FA5B
	for <lists+linux-ext4@lfdr.de>; Mon, 27 Dec 2021 06:35:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233364AbhL0Ff0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 27 Dec 2021 00:35:26 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:35780 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231508AbhL0FfW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 27 Dec 2021 00:35:22 -0500
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1BR5YjS8027878
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Dec 2021 00:34:46 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 84C8515C3444; Mon, 27 Dec 2021 00:34:45 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        Ye Bin <yebin10@huawei.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        jack@suse.cz, lczerner@redhat.com
Subject: Re: [PATCH -next] ext4: Fix null-ptr-deref in '__ext4_journal_ensure_credits'
Date:   Mon, 27 Dec 2021 00:34:43 -0500
Message-Id: <164058326343.3172825.16437833457845956898.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20211224100341.3299128-1-yebin10@huawei.com>
References: <20211224100341.3299128-1-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, 24 Dec 2021 18:03:41 +0800, Ye Bin wrote:
> We got issue as follows when run syzkaller test:
> [ 1901.130043] EXT4-fs error (device vda): ext4_remount:5624: comm syz-executor.5: Abort forced by user
> [ 1901.130901] Aborting journal on device vda-8.
> [ 1901.131437] EXT4-fs error (device vda): ext4_journal_check_start:61: comm syz-executor.16: Detected aborted journal
> [ 1901.131566] EXT4-fs error (device vda): ext4_journal_check_start:61: comm syz-executor.11: Detected aborted journal
> [ 1901.132586] EXT4-fs error (device vda): ext4_journal_check_start:61: comm syz-executor.18: Detected aborted journal
> [ 1901.132751] EXT4-fs error (device vda): ext4_journal_check_start:61: comm syz-executor.9: Detected aborted journal
> [ 1901.136149] EXT4-fs error (device vda) in ext4_reserve_inode_write:6035: Journal has aborted
> [ 1901.136837] EXT4-fs error (device vda): ext4_journal_check_start:61: comm syz-fuzzer: Detected aborted journal
> [ 1901.136915] ==================================================================
> [ 1901.138175] BUG: KASAN: null-ptr-deref in __ext4_journal_ensure_credits+0x74/0x140 [ext4]
> [ 1901.138343] EXT4-fs error (device vda): ext4_journal_check_start:61: comm syz-executor.13: Detected aborted journal
> [ 1901.138398] EXT4-fs error (device vda): ext4_journal_check_start:61: comm syz-executor.1: Detected aborted journal
> [ 1901.138808] Read of size 8 at addr 0000000000000000 by task syz-executor.17/968
> [ 1901.138817]
> [ 1901.138852] EXT4-fs error (device vda): ext4_journal_check_start:61: comm syz-executor.30: Detected aborted journal
> [ 1901.144779] CPU: 1 PID: 968 Comm: syz-executor.17 Not tainted 4.19.90-vhulk2111.1.0.h893.eulerosv2r10.aarch64+ #1
> [ 1901.146479] Hardware name: linux,dummy-virt (DT)
> [ 1901.147317] Call trace:
> [ 1901.147552]  dump_backtrace+0x0/0x2d8
> [ 1901.147898]  show_stack+0x28/0x38
> [ 1901.148215]  dump_stack+0xec/0x15c
> [ 1901.148746]  kasan_report+0x108/0x338
> [ 1901.149207]  __asan_load8+0x58/0xb0
> [ 1901.149753]  __ext4_journal_ensure_credits+0x74/0x140 [ext4]
> [ 1901.150579]  ext4_xattr_delete_inode+0xe4/0x700 [ext4]
> [ 1901.151316]  ext4_evict_inode+0x524/0xba8 [ext4]
> [ 1901.151985]  evict+0x1a4/0x378
> [ 1901.152353]  iput+0x310/0x428
> [ 1901.152733]  do_unlinkat+0x260/0x428
> [ 1901.153056]  __arm64_sys_unlinkat+0x6c/0xc0
> [ 1901.153455]  el0_svc_common+0xc8/0x320
> [ 1901.153799]  el0_svc_handler+0xf8/0x160
> [ 1901.154265]  el0_svc+0x10/0x218
> [ 1901.154682] ==================================================================
> 
> [...]

Applied, thanks!

[1/1] ext4: Fix null-ptr-deref in '__ext4_journal_ensure_credits'
      commit: 5bceadc3d3ed3d12a1cf72d80df98cad7f66b1a9

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
