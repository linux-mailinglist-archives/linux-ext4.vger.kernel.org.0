Return-Path: <linux-ext4+bounces-19-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E42887EDA93
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Nov 2023 05:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E37A1C20993
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Nov 2023 04:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC35C2DF;
	Thu, 16 Nov 2023 04:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LpHNYzbE"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B99C2CC
	for <linux-ext4@vger.kernel.org>; Thu, 16 Nov 2023 04:05:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AFA47C433CB
	for <linux-ext4@vger.kernel.org>; Thu, 16 Nov 2023 04:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700107500;
	bh=FDS4DjDAG2aYZV1d73ON4rc23P2MhmqHR5szrYqu5EE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=LpHNYzbEg8E/zBc0Z4ehzEdHeNIzzD1blq8+a5TztVLLLlxiQUorCc9glBG7WJ2hr
	 rwt+/pcaDclBG8vilKrCBEtgQe5q+cpjKsrAwYR4zBUnAcdFaK+OikR2joVT65V+Dx
	 lLCcu5tj1PE6QJSgeuupzaV0pZe4zDnpWOoW9xHhV/BR2bOXcJjIOJzqUeTQNF6QjM
	 ++mO5KcCcLMtCLLcGM2roDHyR1CkYgAps8JywvSFEJWfjglkkzUCYQnB1bgKDMWgLX
	 g+ryiWNIOqkWoHB2f9OT/v9wdHVoUzDty6cBh6LsU9chEkWoA4GRfqQvgnb3YYWBP4
	 8fy6F4qj4Q2aA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 9EC79C4332E; Thu, 16 Nov 2023 04:05:00 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 217965] ext4(?) regression since 6.5.0 on sata hdd
Date: Thu, 16 Nov 2023 04:05:00 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: bugzilla@eyal.emu.id.au
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217965-13602-Fz0nJTVkVf@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217965-13602@https.bugzilla.kernel.org/>
References: <bug-217965-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

https://bugzilla.kernel.org/show_bug.cgi?id=3D217965

--- Comment #28 from Eyal Lebedinsky (bugzilla@eyal.emu.id.au) ---
$ sudo perf record -p 1531839 -g sleep 60
[ perf record: Woken up 191 times to write data ]
[ perf record: Captured and wrote 47.856 MB perf.data (238391 samples) ]

$ sudo perf report --no-children --stdio -i perf.data
# To display the perf.data header info, please use --header/--header-only
options.
#
#
# Total Lost Samples: 0
#
# Samples: 238K of event 'cycles:P'
# Event count (approx.): 262920477580
#
# Overhead  Command          Shared Object      Symbol=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
# ........  ...............  .................=20
..........................................
#
    58.48%  kworker/u16:5+f  [kernel.kallsyms]  [k] ext4_mb_good_group
            |=20=20=20=20=20=20=20=20=20=20
            |--56.07%--ext4_mb_good_group
            |          |=20=20=20=20=20=20=20=20=20=20
            |           --55.85%--ext4_mb_find_good_group_avg_frag_lists
            |                     ext4_mb_regular_allocator
            |                     ext4_mb_new_blocks
            |                     ext4_ext_map_blocks
            |                     ext4_map_blocks
            |                     ext4_do_writepages
            |                     ext4_writepages
            |                     do_writepages
            |                     __writeback_single_inode
            |                     writeback_sb_inodes
            |                     __writeback_inodes_wb
            |                     wb_writeback
            |                     wb_workfn
            |                     process_one_work
            |                     worker_thread
            |                     kthread
            |                     ret_from_fork
            |                     ret_from_fork_asm
            |=20=20=20=20=20=20=20=20=20=20
             --2.16%--ext4_get_group_info
                       ext4_mb_good_group
                       |=20=20=20=20=20=20=20=20=20=20
                        --2.16%--ext4_mb_find_good_group_avg_frag_lists
                                  ext4_mb_regular_allocator
                                  ext4_mb_new_blocks
                                  ext4_ext_map_blocks
                                  ext4_map_blocks
                                  ext4_do_writepages
                                  ext4_writepages
                                  do_writepages
                                  __writeback_single_inode
                                  writeback_sb_inodes
                                  __writeback_inodes_wb
                                  wb_writeback
                                  wb_workfn
                                  process_one_work
                                  worker_thread
                                  kthread
                                  ret_from_fork
                                  ret_from_fork_asm

    15.69%  kworker/u16:5+f  [kernel.kallsyms]  [k] ext4_get_group_info
            |=20=20=20=20=20=20=20=20=20=20
             --15.10%--ext4_get_group_info
                       |=20=20=20=20=20=20=20=20=20=20
                        --15.05%--ext4_mb_good_group
                                  |=20=20=20=20=20=20=20=20=20=20
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20
--15.01%--ext4_mb_find_good_group_avg_frag_lists
                                             ext4_mb_regular_allocator
                                             ext4_mb_new_blocks
                                             ext4_ext_map_blocks
                                             ext4_map_blocks
                                             ext4_do_writepages
                                             ext4_writepages
                                             do_writepages
                                             __writeback_single_inode
                                             writeback_sb_inodes
                                             __writeback_inodes_wb
                                             wb_writeback
                                             wb_workfn
                                             process_one_work
                                             worker_thread
                                             kthread
                                             ret_from_fork
                                             ret_from_fork_asm

     9.51%  kworker/u16:5+f  [kernel.kallsyms]  [k]
ext4_mb_find_good_group_avg_frag_lists
            |=20=20=20=20=20=20=20=20=20=20
             --9.26%--ext4_mb_find_good_group_avg_frag_lists
                       ext4_mb_regular_allocator
                       ext4_mb_new_blocks
                       ext4_ext_map_blocks
                       ext4_map_blocks
                       ext4_do_writepages
                       ext4_writepages
                       do_writepages
                       __writeback_single_inode
                       writeback_sb_inodes
                       __writeback_inodes_wb
                       wb_writeback
                       wb_workfn
                       process_one_work
                       worker_thread
                       kthread
                       ret_from_fork
                       ret_from_fork_asm

     6.63%  kworker/u16:5+f  [kernel.kallsyms]  [k] __rcu_read_unlock
            |=20=20=20=20=20=20=20=20=20=20
            |--4.56%--__rcu_read_unlock
            |          |=20=20=20=20=20=20=20=20=20=20
            |           --4.54%--ext4_get_group_info
            |                     |=20=20=20=20=20=20=20=20=20=20
            |                      --4.53%--ext4_mb_good_group
            |                                |=20=20=20=20=20=20=20=20=20=20
            |=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20
--4.51%--ext4_mb_find_good_group_avg_frag_lists
            |=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
ext4_mb_regular_allocator
            |                                           ext4_mb_new_blocks
            |                                           ext4_ext_map_blocks
            |                                           ext4_map_blocks
            |                                           ext4_do_writepages
            |                                           ext4_writepages
            |                                           do_writepages
            |=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
__writeback_single_inode
            |                                           writeback_sb_inodes
            |                                           __writeback_inodes_=
wb
            |                                           wb_writeback
            |                                           wb_workfn
            |                                           process_one_work
            |                                           worker_thread
            |                                           kthread
            |                                           ret_from_fork
            |                                           ret_from_fork_asm
            |=20=20=20=20=20=20=20=20=20=20
             --2.08%--ext4_get_group_info
                       ext4_mb_good_group
                       |=20=20=20=20=20=20=20=20=20=20
                        --2.07%--ext4_mb_find_good_group_avg_frag_lists
                                  ext4_mb_regular_allocator
                                  ext4_mb_new_blocks
                                  ext4_ext_map_blocks
                                  ext4_map_blocks
                                  ext4_do_writepages
                                  ext4_writepages
                                  do_writepages
                                  __writeback_single_inode
                                  writeback_sb_inodes
                                  __writeback_inodes_wb
                                  wb_writeback
                                  wb_workfn
                                  process_one_work
                                  worker_thread
                                  kthread
                                  ret_from_fork
                                  ret_from_fork_asm
     4.32%  kworker/u16:5+f  [kernel.kallsyms]  [k] __rcu_read_lock
            |=20=20=20=20=20=20=20=20=20=20
             --4.30%--__rcu_read_lock
                       |=20=20=20=20=20=20=20=20=20=20
                        --4.29%--ext4_get_group_info
                                  |=20=20=20=20=20=20=20=20=20=20
                                   --4.27%--ext4_mb_good_group
                                             |=20=20=20=20=20=20=20=20=20=20
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
--4.26%--ext4_mb_find_good_group_avg_frag_lists
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20
ext4_mb_regular_allocator
                                                        ext4_mb_new_blocks
                                                        ext4_ext_map_blocks
                                                        ext4_map_blocks
                                                        ext4_do_writepages
                                                        ext4_writepages
                                                        do_writepages
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20
__writeback_single_inode
                                                        writeback_sb_inodes
                                                        __writeback_inodes_=
wb
                                                        wb_writeback
                                                        wb_workfn
                                                        process_one_work
                                                        worker_thread
                                                        kthread
                                                        ret_from_fork
                                                        ret_from_fork_asm

     1.98%  kworker/u16:5+f  [kernel.kallsyms]  [k] ext4_mb_scan_aligned
            |=20=20=20=20=20=20=20=20=20=20
             --1.98%--ext4_mb_scan_aligned
                       ext4_mb_regular_allocator
                       ext4_mb_new_blocks
                       ext4_ext_map_blocks
                       ext4_map_blocks
                       ext4_do_writepages
                       ext4_writepages
                       do_writepages
                       __writeback_single_inode
                       writeback_sb_inodes
                       __writeback_inodes_wb
                       wb_writeback
                       wb_workfn
                       process_one_work
                       worker_thread
                       kthread
                       ret_from_fork
                       ret_from_fork_asm

     0.50%  kworker/u16:5+f  [kernel.kallsyms]  [k] mb_find_order_for_block
     0.44%  kworker/u16:5+f  [kernel.kallsyms]  [k] ext4_mb_load_buddy_gfp
     0.38%  kworker/u16:5+f  [kernel.kallsyms]  [k] xas_descend
     0.33%  kworker/u16:5+f  [kernel.kallsyms]  [k] ext4_mb_regular_allocat=
or
     0.30%  kworker/u16:5+f  [kernel.kallsyms]  [k] filemap_get_entry
     0.24%  kworker/u16:5+f  [kernel.kallsyms]  [k] xas_load
     0.18%  kworker/u16:5+f  [kernel.kallsyms]  [k] ext4_mb_unload_buddy
     0.16%  kworker/u16:5+f  [kernel.kallsyms]  [k] mb_find_extent
     0.15%  kworker/u16:5+f  [kernel.kallsyms]  [k] _raw_spin_trylock
     0.14%  kworker/u16:5+f  [kernel.kallsyms]  [k] _raw_read_unlock
     0.10%  kworker/u16:5+f  [kernel.kallsyms]  [k] _raw_read_lock
     0.08%  kworker/u16:5+f  [kernel.kallsyms]  [k] __filemap_get_folio
     0.07%  kworker/u16:5+f  [kernel.kallsyms]  [k] mb_find_buddy
     0.05%  kworker/u16:5+f  [kernel.kallsyms]  [k] xas_start
     0.03%  kworker/u16:5+f  [kernel.kallsyms]  [k] pagecache_get_page
     0.03%  kworker/u16:5+f  [kernel.kallsyms]  [k] _raw_spin_unlock
     0.02%  kworker/u16:5+f  [kernel.kallsyms]  [k]
perf_adjust_freq_unthr_context
     0.02%  kworker/u16:5+f  [kernel.kallsyms]  [k] folio_mark_accessed
     0.02%  kworker/u16:5+f  [kernel.kallsyms]  [k] folio_test_hugetlb
     0.01%  kworker/u16:5+f  [kernel.kallsyms]  [k] native_write_msr
     0.01%  kworker/u16:5+f  [kernel.kallsyms]  [k] _raw_spin_lock
     0.01%  kworker/u16:5+f  [kernel.kallsyms]  [k] __cond_resched
     0.01%  kworker/u16:5+f  [kernel.kallsyms]  [k] timekeeping_advance
     0.01%  kworker/u16:5+f  [kernel.kallsyms]  [k] native_irq_return_iret
     0.00%  kworker/u16:5+f  [kernel.kallsyms]  [k] gen8_irq_handler

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

