Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0BB92FE758
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Jan 2021 11:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729059AbhAUKRV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 21 Jan 2021 05:17:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728798AbhAUKQ4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 21 Jan 2021 05:16:56 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E4B5C061575
        for <linux-ext4@vger.kernel.org>; Thu, 21 Jan 2021 02:15:56 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id x18so1022676pln.6
        for <linux-ext4@vger.kernel.org>; Thu, 21 Jan 2021 02:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=wYV7R8qR27MnGkec4x2sHqQjzrvRujQL/ANQ0rNLbx0=;
        b=S3SDdEnMK6DjGXVM0s+9y0VTXRPiXkxORkGJ6QtdogvDBB8hlIRzg/uI1taldhvvcG
         AMykv2nLZV0FLvVDYh2i5krV8+FT/N3+JAYsLTz7k27gTawHFufdpeQ0vG4oUtXVBDat
         w4cUa9YJn68DxuP88clCfKOd19ynOJZWUYBmzMslOrsCMcKBQoyuAO01lDcRoiiWOaPt
         ekTHO9io8Gc/wKdDLpGH3l5AZqDTuxE2Wvuz5n1bcnJIYonexc4hL97RAHx3HHrr8jGD
         tNGfcLovPMeSzoOtURGZVm51xzxOst7xhnLdq2N71WuOvWQICe2tjZxZ8T+SZCdKKW21
         LkEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=wYV7R8qR27MnGkec4x2sHqQjzrvRujQL/ANQ0rNLbx0=;
        b=KDES9lmrrCWWhgVtjmOth/WpMypkmH1F19NXsVujm5xdyfhGTAIR14sCm73R0jr0dj
         0j8YgufOJE/U8meaXFBqfsOrYalYBhkIhi0f1SS56+pbVh589tQMwLBGN+i3OhCCjccX
         +YANIcCBR8WMsfcnxUhcRkWs/kCRtxhThyN1uXuiEOL00HeaX8Lcb2kf9GZufeE83oQT
         j9KOja2kaPfkTusuWWaQGxVpUTKN7U/IikFwWI/QhOVBLNXtd2qZuzagYtcy91i0FS4I
         1jGWuk4hZeDLiL6cl/2u1cqecvEt3hReWt/9rAwVvdXDa5HZXv2ebcIOqH9g6lQHHuV+
         pXHQ==
X-Gm-Message-State: AOAM531sZLsk0hMK1os2Qj/SVfMW1eKpOlpGIciIz5pgXHY2mt0pvHEH
        wylj22hPsfgTqg4+3y3zPVY=
X-Google-Smtp-Source: ABdhPJz4ihwiffvWZpSUniE41njQBqsGAIPXi9I9Uw8G+tfPh9/vgDi4comxuXmIUsm3pUVfLXrPwA==
X-Received: by 2002:a17:90a:7d08:: with SMTP id g8mr11144219pjl.180.1611224156100;
        Thu, 21 Jan 2021 02:15:56 -0800 (PST)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id w20sm5746162pga.90.2021.01.21.02.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 02:15:55 -0800 (PST)
Date:   Thu, 21 Jan 2021 18:15:47 +0800
From:   Murphy Zhou <jencce.kernel@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
Subject: ext4 regression panic
Message-ID: <20210121101547.fwh35hov3hshogbz@xzhoux.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Jack,

A panic was introduced by this commit. It's easy and reliable to
reproduce.

commit 2d01ddc86606564fb08c56e3bc93a0693895f710
Author: Jan Kara <jack@suse.cz>
Date:   Wed Dec 16 11:18:40 2020 +0100

    ext4: save error info to sb through journal if available


--- Call trace ------------

[44.391771] EXT4-fs error (device loop0): ext4_fill_super:4943: inode #2: comm mount: iget: root inode unallocated
[44.401842] BUG: kernel NULL pointer dereference, address: 0000000000000034
[44.406155] #PF: supervisor read access in kernel mode
[44.409317] #PF: error_code(0x0000) - not-present page
[44.412482] PGD 0 P4D 0
[44.414085] Oops: 0000 [#1] SMP PTI
[44.416256] CPU: 1 PID: 944 Comm: mount Tainted: G            E     5.11.0-rc4-master-19c329f68089 #46
[44.422030] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-1.fc33 04/01/2014
[44.427323] RIP: 0010:ext4_process_freed_data+0x74/0x590 [ext4]
[44.431312] Code: 24 a8 02 00 00 49 8d 8c 24 a8 02 00 00 49 39 c8 74 7f 4c 89 c2 4c 89 c0 31 f6 eb 0e 48 8b 00 48 89 d6 48 39 c8 74 08 48 89 c2 <39> 68 34 74 ed 48 85 f6 74 5d 49 8b 84 24 a8 02 00 00 48 39 c8 74
[44.442810] RSP: 0018:ffffaeaf00b2ba50 EFLAGS: 00010246
[44.446185] RAX: 0000000000000000 RBX: ffffaeaf00b2ba78 RCX: ffff9390013ca2a8
[44.450598] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff9390013ca288
[44.454723] RBP: 0000000000000006 R08: 0000000000000000 R09: ffff93900443c5b0
[44.458619] R10: 0000000000000002 R11: 0000000000000000 R12: ffff9390013ca000
[44.462510] R13: ffff9390013ca288 R14: ffff9390013c8000 R15: ffff939016387fd0
[44.466103] FS:  00007fe3f7b99c40(0000) GS:ffff9390a7040000(0000) knlGS:0000000000000000
[44.470061] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[44.472896] CR2: 0000000000000034 CR3: 00000003c305a005 CR4: 0000000000020ee0
[44.476306] Call Trace:
[44.477494]  ? __mod_timer+0x25c/0x3d0
[44.479223]  ext4_journal_commit_callback+0x4a/0xd0 [ext4]
[44.481807]  jbd2_journal_commit_transaction+0x1a3b/0x1cc0 [jbd2]
[44.484476]  ? jbd2_journal_destroy+0xc3/0x280 [jbd2]
[44.486445]  jbd2_journal_destroy+0xc3/0x280 [jbd2]
[44.488355]  ? finish_wait+0x80/0x80
[44.489758]  ext4_fill_super+0x2250/0x3bc0 [ext4]
[44.491651]  ? mount_bdev+0x185/0x1b0
[44.493083]  ? ext4_calculate_overhead+0x4d0/0x4d0 [ext4]
[44.495112]  mount_bdev+0x185/0x1b0
[44.496312]  ? ext4_calculate_overhead+0x4d0/0x4d0 [ext4]
[44.498173]  legacy_get_tree+0x27/0x40
[44.499599]  vfs_get_tree+0x25/0xb0
[44.500786]  path_mount+0x423/0xa40
[44.501974]  __x64_sys_mount+0xe3/0x120
[44.503275]  do_syscall_64+0x33/0x40
[44.504512]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[44.506208] RIP: 0033:0x7fe3f7dcc5de

--- Call trace End ------------

# One step Reproducer

https://bugzilla.kernel.org/show_bug.cgi?id=199179 (reproducer #1)
https://bugzilla.kernel.org/show_bug.cgi?id=199275 (reproducer #2)

  mount -o loop 88.img /mnt

# git bisect log

  git bisect start
  # good: [235ecd36c7a93e4d6c73ac71137b8f1fa31148dd] MAINTAINERS: Update my email address
  git bisect good 235ecd36c7a93e4d6c73ac71137b8f1fa31148dd
  # bad: [19c329f6808995b142b3966301f217c831e7cf31] Linux 5.11-rc4
  git bisect bad 19c329f6808995b142b3966301f217c831e7cf31
  # good: [f97844f9c518172f813b7ece18a9956b1f70c1bb] dt-bindings: net: renesas,etheravb: RZ/G2H needs tx-internal-delay-ps
  git bisect good f97844f9c518172f813b7ece18a9956b1f70c1bb
  # good: [ea49c88f4071e2bdd55e78987f251ea54aa11004] Merge tag 'mkp-scsi-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi
  git bisect good ea49c88f4071e2bdd55e78987f251ea54aa11004
  # good: [5ee88057889bbca5f5bb96031b62b3756b33e164] Merge tag 'drm-fixes-2021-01-15' of git://anongit.freedesktop.org/drm/drm
  git bisect good 5ee88057889bbca5f5bb96031b62b3756b33e164
  # bad: [b45e2da6e444280f8661dca439c1e377761b2877] Merge branch 'akpm' (patches from Andrew)
  git bisect bad b45e2da6e444280f8661dca439c1e377761b2877
  # good: [82821be8a2e14bdf359be577400be88b2f1eb8a7] Merge tag 'arm64-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux
  git bisect good 82821be8a2e14bdf359be577400be88b2f1eb8a7
  # bad: [0bc9bc1d8b2fa0d5a7e2132e89c540099ea63172] Merge tag 'ext4_for_linus_stable' of git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4
  git bisect bad 0bc9bc1d8b2fa0d5a7e2132e89c540099ea63172
  # bad: [23dd561ad9eae02b4d51bb502fe4e1a0666e9567] ext4: use IS_ERR instead of IS_ERR_OR_NULL and set inode null when IS_ERR
  git bisect bad 23dd561ad9eae02b4d51bb502fe4e1a0666e9567
  # bad: [2d01ddc86606564fb08c56e3bc93a0693895f710] ext4: save error info to sb through journal if available
  git bisect bad 2d01ddc86606564fb08c56e3bc93a0693895f710
  # good: [4392fbc4bab57db3760f0fb61258cb7089b37665] ext4: drop sync argument of ext4_commit_super()
  git bisect good 4392fbc4bab57db3760f0fb61258cb7089b37665
  # good: [05c2c00f3769abb9e323fcaca70d2de0b48af7ba] ext4: protect superblock modifications with a buffer lock
  git bisect good 05c2c00f3769abb9e323fcaca70d2de0b48af7ba
  # first bad commit: [2d01ddc86606564fb08c56e3bc93a0693895f710] ext4: save error info to sb through journal if available

Thanks,
-- 
Murphy
