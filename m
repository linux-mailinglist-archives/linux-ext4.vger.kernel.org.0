Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A633E5B2E69
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Sep 2022 08:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiIIGDE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 9 Sep 2022 02:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbiIIGDC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 9 Sep 2022 02:03:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3F6ED386
        for <linux-ext4@vger.kernel.org>; Thu,  8 Sep 2022 23:03:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 07A1161236
        for <linux-ext4@vger.kernel.org>; Fri,  9 Sep 2022 06:03:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5FB7AC433B5
        for <linux-ext4@vger.kernel.org>; Fri,  9 Sep 2022 06:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662703380;
        bh=unN8QxxvJeELCF8nqkRhNSj05IJhg2nVTboxggP8DME=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=fehMwxL7SeVuJKsV7gNG0Owv2L5yTr0YOg1VU5iaOa4b+ZaLDa8pmIld5RQq2Ior0
         5WKN9Vt+MHi9Pnd/JNUgirCssS5Ukk5FriR/QwzZOvtG872Vu6JFPaerOCGHmwRxFP
         vPwsOb6D1BqkaHDdAON+ZV3ZStMPWDmRDJ7/pO1+Gtx2DvYJ3LBB1zhWtVe+n8YtyI
         8XPcE3k4ciYsPpLktB7AvKLSwfHeXVxPcisc+u7z81wD6QbB8GCwfZqc7VZ80zDmC4
         uiPVpoTSCUk/FzE8jkBgW69GYHl63l+q8dsAHPVViKWEYACqnRcrLWudL7UerBRKZm
         z1rvIVVgY/GCA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 4308BC433E9; Fri,  9 Sep 2022 06:03:00 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 216322] Freezing of tasks failed after 60.004 seconds (1 tasks
 refusing to freeze... task:fstrim  ext4_trim_fs - Dell XPS 13 9310
Date:   Fri, 09 Sep 2022 06:02:59 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: brian.bascoy@kaluza.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-216322-13602-j4bU7zkqhs@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216322-13602@https.bugzilla.kernel.org/>
References: <bug-216322-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216322

brian.bascoy@kaluza.com changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |brian.bascoy@kaluza.com

--- Comment #9 from brian.bascoy@kaluza.com ---
I have a similar (same?) issue with my XPS 13 but the failing tasks seem
completely random. I think this started after upgrading my kernel from 5.13=
 to
5.14.

Len, can you confirm this only happens with fstrim?

Here are a few examples from my current boot:

Freezing of tasks failed after 20.002 seconds (1 tasks refusing to freeze,
wq_busy=3D0):
task:python3         state:D stack:    0 pid:120996 ppid:     1
flags:0x00000006
Call Trace:
 <TASK>
 __schedule+0x2ae/0x7c0
 schedule+0x4e/0xb0
 fanotify_handle_event+0x352/0x4d0
 ? wait_woken+0x60/0x60
 fsnotify+0x2ff/0x550
 __fsnotify_parent+0xff/0x310
 security_file_open+0xdd/0x150
 ? security_file_open+0xdd/0x150
 do_dentry_open+0xf2/0x380
 vfs_open+0x2d/0x30
 do_open.isra.0+0x224/0x420
 path_openat+0x18e/0xc80
 do_filp_open+0xb2/0x120
 ? __check_object_size+0x13f/0x150
 do_sys_openat2+0x245/0x310
 do_sys_open+0x46/0x80
 __x64_sys_openat+0x20/0x30
 do_syscall_64+0x38/0xc0
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f2885d3c6eb
RSP: 002b:00007fff68482670 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007f2885c27140 RCX: 00007f2885d3c6eb
RDX: 0000000000080000 RSI: 00007f28856a2870 RDI: 00000000ffffff9c
RBP: 00007f28856a2870 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000080000
R13: 00007f2885499990 R14: 0000000000080000 R15: 0000000000000001
 </TASK>

---

Freezing of tasks failed after 20.006 seconds (1 tasks refusing to freeze,
wq_busy=3D0):
task:git             state:D stack:    0 pid:121036 ppid: 16154
flags:0x00000006
Call Trace:
 <TASK>
 __schedule+0x2ae/0x7c0
 schedule+0x4e/0xb0
 fanotify_handle_event+0x352/0x4d0
 ? wait_woken+0x60/0x60
 fsnotify+0x2ff/0x550
 __fsnotify_parent+0xff/0x310
 ? get_acl+0x1d/0x170
 security_file_open+0xdd/0x150
 ? security_file_open+0xdd/0x150
 do_dentry_open+0xf2/0x380
 vfs_open+0x2d/0x30
 do_open.isra.0+0x224/0x420
 path_openat+0x18e/0xc80
 ? filemap_map_pages+0x134/0x630
 do_filp_open+0xb2/0x120
 ? __check_object_size+0x13f/0x150
 do_sys_openat2+0x245/0x310
 do_sys_open+0x46/0x80
 __x64_sys_openat+0x20/0x30
 do_syscall_64+0x38/0xc0
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f3fead69bcc
RSP: 002b:00007ffca0166ac0 EFLAGS: 00000287 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007f3fead69bcc
RDX: 0000000000080000 RSI: 00007f3feae31570 RDI: 00000000ffffff9c
RBP: 00007ffca0166c80 R08: 0000000000080000 R09: 00007f3feae31570
R10: 0000000000000000 R11: 0000000000000287 R12: 00007ffca0167cb8
R13: 00007ffca0166b20 R14: 00005575094ba320 R15: 00007ffca0166b20
 </TASK>

---

Freezing of tasks failed after 20.007 seconds (1 tasks refusing to freeze,
wq_busy=3D0):
task:grub-editenv    state:D stack:    0 pid:125647 ppid:     1
flags:0x00000004
Call Trace:
 <TASK>
 __schedule+0x2ae/0x7c0
 schedule+0x4e/0xb0
 fanotify_handle_event+0x352/0x4d0
 ? wait_woken+0x60/0x60
 fsnotify+0x2ff/0x550
 ? chacha_block_generic+0x6f/0xb0
 __fsnotify_parent+0xff/0x310
 security_file_open+0xdd/0x150
 ? security_file_open+0xdd/0x150
 do_dentry_open+0xf2/0x380
 vfs_open+0x2d/0x30
 do_open.isra.0+0x224/0x420
 path_openat+0x18e/0xc80
 do_filp_open+0xb2/0x120
 ? __check_object_size+0x13f/0x150
 do_sys_openat2+0x245/0x310
 do_sys_open+0x46/0x80
 __x64_sys_openat+0x20/0x30
 do_syscall_64+0x38/0xc0
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f125633bb38
RSP: 002b:00007ffd4004d148 EFLAGS: 00000287 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007f12563501f8 RCX: 00007f125633bb38
RDX: 0000000000080000 RSI: 00007f125634321b RDI: 00000000ffffff9c
RBP: 00007ffd4004d300 R08: 0000000000080000 R09: 00007f125634321b
R10: 0000000000000000 R11: 0000000000000287 R12: ffffffffffffffff
R13: 0000000000000001 R14: 000000000000000d R15: 000056394c0aa990
 </TASK>

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
