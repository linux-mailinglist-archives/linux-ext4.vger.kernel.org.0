Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC8D7B4D1E
	for <lists+linux-ext4@lfdr.de>; Mon,  2 Oct 2023 10:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235805AbjJBIKZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 2 Oct 2023 04:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235773AbjJBIKY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 2 Oct 2023 04:10:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35ABBBC
        for <linux-ext4@vger.kernel.org>; Mon,  2 Oct 2023 01:10:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 886A2C433C8
        for <linux-ext4@vger.kernel.org>; Mon,  2 Oct 2023 08:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696234221;
        bh=mFTxSvWKyyju5dTnOPbaXI7TspflrHiWvORUdO4g7Zo=;
        h=From:To:Subject:Date:From;
        b=O5Dw9R/fg/bkdziK40TfsSjsNGHgBUe293kwUim1XE6lHJliHpNPlvTsLuox46VKb
         qv5kXtn5QPjQashbYTZhIy0/FggYzV26Dz6nAQGM96xMe65oRXO/zXgNdoNclNNzd0
         Gb+mzHP5s6x7uTS8MUwl2WwYPMyfNtwP2ctuCRf2qUbMBrIPj/dpwMMVS5oGOLlAeI
         2wL3hOTMQa287PQeLbzBpcJuKGSValowoYjQRzrHkO34mtF5DIepRC8IucvxMVSAPT
         mhIIKOFGJUIoIf7jEfUNHuSYL1TnO4rkh1a1UfT4+SKoR55tNO6dqmdp5RTfz4M3UW
         RtByznySELNhg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 6772BC53BCD; Mon,  2 Oct 2023 08:10:21 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 217965] New: ext4(?) regression since 6.5.0 on sata hdd
Date:   Mon, 02 Oct 2023 08:10:21 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: iivanich@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-217965-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217965

            Bug ID: 217965
           Summary: ext4(?) regression since 6.5.0 on sata hdd
           Product: File System
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: ext4
          Assignee: fs_ext4@kernel-bugs.osdl.org
          Reporter: iivanich@gmail.com
        Regression: No

Since kernel 6.5.x and 6.6-rc* I'm getting weird kworker flush activity when
building openwrt from sources.
91 root      20   0       0      0      0 R  99,7   0,0  18:06.57
kworker/u16:4+flush-8:16

Openwrt sources resides on the sata hdd drive with ext4 fs,I'm using this s=
etup
for a last 5 years, the problem is that since 6.5 kernels after the openwrt
kernel patch make
step(https://git.openwrt.org/?p=3Dopenwrt/openwrt.git;a=3Dblob;f=3Dscripts/=
patch-kernel.sh;h=3Dc2b7e7204952f93946a6075d546cbeae32c2627f;hb=3DHEAD
which probably involves a lot of copy and write operations)
kworker/u16:4+flush-8:16 uses 100% of one core for a while(5-15 minutes) ev=
en
after I canceling openwrt build.

I tried to move this openwrt sources folder to an ssd drive where my system=
 is
resides and run openwrt build from there and getting no issues with kworker
flush  cpu usage. Also I have no such behavior with 6.4.x and older kernels=
 so
it looks like regression to me, not sure if this is a fs, vfs or even block
subsystem issue.

This is how it looks in perf
Samples: 320K of event 'cycles:P', Event count (approx.): 363448649248
  Children      Self  Command          Shared Object=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
Symbol
+   12,40%     0,00%  kworker/u16:2+f  [kernel.vmlinux]                    =
 [k]
ret_from_fork_asm
+   12,40%     0,00%  kworker/u16:2+f  [kernel.vmlinux]                    =
 [k]
ret_from_fork
+   12,40%     0,00%  kworker/u16:2+f  [kernel.vmlinux]                    =
 [k]
kthread
+   12,40%     0,00%  kworker/u16:2+f  [kernel.vmlinux]                    =
 [k]
worker_thread
+   12,40%     0,00%  kworker/u16:2+f  [kernel.vmlinux]                    =
 [k]
process_one_work
+   12,40%     0,00%  kworker/u16:2+f  [kernel.vmlinux]                    =
 [k]
wb_workfn
+   12,40%     0,00%  kworker/u16:2+f  [kernel.vmlinux]                    =
 [k]
wb_writeback
+   12,40%     0,00%  kworker/u16:2+f  [kernel.vmlinux]                    =
 [k]
__writeback_inodes_wb
+   12,40%     0,00%  kworker/u16:2+f  [kernel.vmlinux]                    =
 [k]
writeback_sb_inodes
+   12,40%     0,00%  kworker/u16:2+f  [kernel.vmlinux]                    =
 [k]
__writeback_single_inode
+   12,40%     0,00%  kworker/u16:2+f  [kernel.vmlinux]                    =
 [k]
do_writepages
+   12,40%     0,00%  kworker/u16:2+f  [kernel.vmlinux]                    =
 [k]
ext4_writepages
+   12,40%     0,00%  kworker/u16:2+f  [kernel.vmlinux]                    =
 [k]
ext4_do_writepages
+   12,39%     0,00%  kworker/u16:2+f  [kernel.vmlinux]                    =
 [k]
ext4_map_blocks
+   12,39%     0,00%  kworker/u16:2+f  [kernel.vmlinux]                    =
 [k]
ext4_ext_map_blocks
+   12,38%     0,00%  kworker/u16:2+f  [kernel.vmlinux]                    =
 [k]
ext4_mb_new_blocks
+   12,38%     0,93%  kworker/u16:2+f  [kernel.vmlinux]                    =
 [k]
ext4_mb_regular_allocator
+    9,42%     0,00%  cc1              [unknown]                           =
 [.]
0000000000000000
+    5,42%     0,53%  kworker/u16:2+f  [kernel.vmlinux]                    =
 [k]
ext4_mb_scan_aligned
+    4,88%     0,69%  kworker/u16:2+f  [kernel.vmlinux]                    =
 [k]
mb_find_extent
+    3,99%     3,95%  kworker/u16:2+f  [kernel.vmlinux]                    =
 [k]
mb_find_order_for_block
+    3,51%     0,61%  kworker/u16:2+f  [kernel.vmlinux]                    =
 [k]
ext4_mb_load_buddy_gfp
+    2,95%     0,01%  cc1              [kernel.vmlinux]                    =
 [k]
asm_exc_page_fault
+    2,67%     0,18%  kworker/u16:2+f  [kernel.vmlinux]                    =
 [k]
pagecache_get_page
+    2,41%     0,40%  kworker/u16:2+f  [kernel.vmlinux]                    =
 [k]
__filemap_get_folio
+    2,33%     2,10%  cc1              cc1                                 =
 [.]
cpp_get_token_1
+    2,12%     0,05%  cc1              [kernel.vmlinux]                    =
 [k]
exc_page_fault
+    2,07%     0,04%  cc1              [kernel.vmlinux]                    =
 [k]
do_user_addr_fault
+    1,81%     0,52%  kworker/u16:2+f  [kernel.vmlinux]                    =
 [k]
filemap_get_entry
     1,80%     1,71%  cc1              cc1                                 =
 [.]
ht_lookup_with_hash
+    1,77%     0,08%  cc1              [kernel.vmlinux]                    =
 [k]
handle_mm_fault
+    1,65%     0,14%  cc1              [kernel.vmlinux]                    =
 [k]
__handle_mm_fault
     1,60%     1,49%  cc1              cc1                                 =
 [.]
_cpp_lex_direct
+    1,54%     0,73%  kworker/u16:2+f  [kernel.vmlinux]                    =
 [k]
ext4_mb_good_group
+    1,49%     1,46%  cc1              cc1                                 =
 [.]
ggc_internal_alloc
+    1,28%     0,05%  cc1              [kernel.vmlinux]                    =
 [k]
do_anonymous_page
+    1,28%     0,04%  cc1              [kernel.vmlinux]                    =
 [k]
entry_SYSCALL_64

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
