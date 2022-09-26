Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E05A5EAD67
	for <lists+linux-ext4@lfdr.de>; Mon, 26 Sep 2022 18:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbiIZQ7q (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 26 Sep 2022 12:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbiIZQ71 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 26 Sep 2022 12:59:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22CCE5F9F
        for <linux-ext4@vger.kernel.org>; Mon, 26 Sep 2022 08:59:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B80C6B80B04
        for <linux-ext4@vger.kernel.org>; Mon, 26 Sep 2022 15:59:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8441EC433B5
        for <linux-ext4@vger.kernel.org>; Mon, 26 Sep 2022 15:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664207957;
        bh=jjgXkBHVqL9RR80MDmnmtwN6UjqlAX9TJHXGvWaL1Mw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=dG/TQw7Zy/YFykHXx/xBA2dieCxpt5Py7wPF/j+JjiTD/NA1VvgVRRig+4KQ9XRSA
         lFjOrSqhRDb6tbhRrTcNwBpNaN4NPdHp4ndE+ryMaihN4SeQ44z/7V7Hm3PNs0Dw/+
         HqZRMXHWdNyBwh2ovnFCwawQd7fUbhxEbHBkopLzOnKPIiqjPOb8/VNzhHsU4BAGox
         +e+wxAERcGnCr0R/E6zvzd23fOh8NcaSLVgiSnqT7jO277aomVYoJzf30cwVy0VhRB
         G59Dynf7qH0fIAcpxmD+P2PbrKUS7TQhgfOwO3AXE2T0QHO23UsLykNQAIo6PzUf8D
         0IPGp/juAWP6A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 69750C433E9; Mon, 26 Sep 2022 15:59:17 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 216322] Freezing of tasks failed after 60.004 seconds (1 tasks
 refusing to freeze... task:fstrim  ext4_trim_fs - Dell XPS 13 9310
Date:   Mon, 26 Sep 2022 15:59:17 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: jack@suse.cz
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-216322-13602-JR0scbBObd@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216322-13602@https.bugzilla.kernel.org/>
References: <bug-216322-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216322

Jan Kara (jack@suse.cz) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |jack@suse.cz

--- Comment #10 from Jan Kara (jack@suse.cz) ---
(In reply to brian.bascoy from comment #9)
> I have a similar (same?) issue with my XPS 13 but the failing tasks seem
> completely random. I think this started after upgrading my kernel from 5.=
13
> to 5.14.
>=20
> Len, can you confirm this only happens with fstrim?
>=20
> Here are a few examples from my current boot:
>=20
> Freezing of tasks failed after 20.002 seconds (1 tasks refusing to freeze,
> wq_busy=3D0):
> task:python3         state:D stack:    0 pid:120996 ppid:     1
> flags:0x00000006
> Call Trace:
>  <TASK>
>  __schedule+0x2ae/0x7c0
>  schedule+0x4e/0xb0
>  fanotify_handle_event+0x352/0x4d0
>  ? wait_woken+0x60/0x60
>  fsnotify+0x2ff/0x550
>  __fsnotify_parent+0xff/0x310
>  security_file_open+0xdd/0x150
>  ? security_file_open+0xdd/0x150
>  do_dentry_open+0xf2/0x380
>  vfs_open+0x2d/0x30
>  do_open.isra.0+0x224/0x420
>  path_openat+0x18e/0xc80
>  do_filp_open+0xb2/0x120
>  ? __check_object_size+0x13f/0x150
>  do_sys_openat2+0x245/0x310
>  do_sys_open+0x46/0x80
>  __x64_sys_openat+0x20/0x30
>  do_syscall_64+0x38/0xc0
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x7f2885d3c6eb
> RSP: 002b:00007fff68482670 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
> RAX: ffffffffffffffda RBX: 00007f2885c27140 RCX: 00007f2885d3c6eb
> RDX: 0000000000080000 RSI: 00007f28856a2870 RDI: 00000000ffffff9c
> RBP: 00007f28856a2870 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000080000
> R13: 00007f2885499990 R14: 0000000000080000 R15: 0000000000000001
>  </TASK>
>=20
> ---
>=20
> Freezing of tasks failed after 20.006 seconds (1 tasks refusing to freeze,
> wq_busy=3D0):
> task:git             state:D stack:    0 pid:121036 ppid: 16154
> flags:0x00000006
> Call Trace:
>  <TASK>
>  __schedule+0x2ae/0x7c0
>  schedule+0x4e/0xb0
>  fanotify_handle_event+0x352/0x4d0
>  ? wait_woken+0x60/0x60
>  fsnotify+0x2ff/0x550
>  __fsnotify_parent+0xff/0x310
>  ? get_acl+0x1d/0x170
>  security_file_open+0xdd/0x150
>  ? security_file_open+0xdd/0x150
>  do_dentry_open+0xf2/0x380
>  vfs_open+0x2d/0x30
>  do_open.isra.0+0x224/0x420
>  path_openat+0x18e/0xc80
>  ? filemap_map_pages+0x134/0x630
>  do_filp_open+0xb2/0x120
>  ? __check_object_size+0x13f/0x150
>  do_sys_openat2+0x245/0x310
>  do_sys_open+0x46/0x80
>  __x64_sys_openat+0x20/0x30
>  do_syscall_64+0x38/0xc0
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x7f3fead69bcc
> RSP: 002b:00007ffca0166ac0 EFLAGS: 00000287 ORIG_RAX: 0000000000000101
> RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007f3fead69bcc
> RDX: 0000000000080000 RSI: 00007f3feae31570 RDI: 00000000ffffff9c
> RBP: 00007ffca0166c80 R08: 0000000000080000 R09: 00007f3feae31570
> R10: 0000000000000000 R11: 0000000000000287 R12: 00007ffca0167cb8
> R13: 00007ffca0166b20 R14: 00005575094ba320 R15: 00007ffca0166b20
>  </TASK>
>=20
> ---
>=20
> Freezing of tasks failed after 20.007 seconds (1 tasks refusing to freeze,
> wq_busy=3D0):
> task:grub-editenv    state:D stack:    0 pid:125647 ppid:     1
> flags:0x00000004
> Call Trace:
>  <TASK>
>  __schedule+0x2ae/0x7c0
>  schedule+0x4e/0xb0
>  fanotify_handle_event+0x352/0x4d0
>  ? wait_woken+0x60/0x60
>  fsnotify+0x2ff/0x550
>  ? chacha_block_generic+0x6f/0xb0
>  __fsnotify_parent+0xff/0x310
>  security_file_open+0xdd/0x150
>  ? security_file_open+0xdd/0x150
>  do_dentry_open+0xf2/0x380
>  vfs_open+0x2d/0x30
>  do_open.isra.0+0x224/0x420
>  path_openat+0x18e/0xc80
>  do_filp_open+0xb2/0x120
>  ? __check_object_size+0x13f/0x150
>  do_sys_openat2+0x245/0x310
>  do_sys_open+0x46/0x80
>  __x64_sys_openat+0x20/0x30
>  do_syscall_64+0x38/0xc0
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x7f125633bb38
> RSP: 002b:00007ffd4004d148 EFLAGS: 00000287 ORIG_RAX: 0000000000000101
> RAX: ffffffffffffffda RBX: 00007f12563501f8 RCX: 00007f125633bb38
> RDX: 0000000000080000 RSI: 00007f125634321b RDI: 00000000ffffff9c
> RBP: 00007ffd4004d300 R08: 0000000000080000 R09: 00007f125634321b
> R10: 0000000000000000 R11: 0000000000000287 R12: ffffffffffffffff
> R13: 0000000000000001 R14: 000000000000000d R15: 000056394c0aa990
>  </TASK>

This is very different problem (although symptoms are similar). The kernel =
is
waiting for response to fanotify permission event. Apparently you have some
application that is using fanotify permission events (maybe some antivirus =
or
security solution). Sadly there is no easy way to gracefully handle suspend=
 in
such cases. Anyway there was no change in this code for a few years so if t=
his
started happening for you recently I think the userspace change is more lik=
ely.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
