Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F40D3741222
	for <lists+linux-ext4@lfdr.de>; Wed, 28 Jun 2023 15:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbjF1NTW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 28 Jun 2023 09:19:22 -0400
Received: from dfw.source.kernel.org ([139.178.84.217]:35454 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231745AbjF1NTD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 28 Jun 2023 09:19:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F6186126B
        for <linux-ext4@vger.kernel.org>; Wed, 28 Jun 2023 13:19:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 97D95C433C9
        for <linux-ext4@vger.kernel.org>; Wed, 28 Jun 2023 13:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687958342;
        bh=IjJ+XsVEhhgIAIsUqALEeUds64nrJlrWIkmq87j7iy0=;
        h=From:To:Subject:Date:From;
        b=Vrk+PayUCuwt890L5fbU6OtR4z0XY3nqnewGcVkT46F0ZeXAvEP//40ADJZb3hh1d
         RHPCswAr+v3+JjWwyOCMlmGYpg/zjMUo9113JcGVEcb6OIgCplq+oM5j+L4ZSGMMnU
         fWpVnxJLLiwmMt9xIb6Vi8Ux6RhhcoGN6x6guqDlET3s6f3vdLH8ck8hBAefW/QIbm
         ebuhm3F1Z5IUTTdfmRYYIsJ8+dVNvG730bQGXE8Y60chy16JuqIKLYGCjH2detTXor
         Oa0eolm9YJ6zYeQLS8zu++qMjJXMmZJXE2y1YZ8rfnYoOid4UsnDNo5RPa6DdLuorh
         jsAwLN+OBmKBQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 7F68AC53BD0; Wed, 28 Jun 2023 13:19:02 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 217605] New: unttached inode after power cut with orphan file
 feature enabled
Date:   Wed, 28 Jun 2023 13:19:02 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: chengzhihao1@huawei.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-217605-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217605

            Bug ID: 217605
           Summary: unttached inode after power cut with orphan file
                    feature enabled
           Product: File System
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: ext4
          Assignee: fs_ext4@kernel-bugs.osdl.org
          Reporter: chengzhihao1@huawei.com
        Regression: No

Running generic/475(filesystem consistent tests after power cut) could
    easily trigger unattached inode error while doing fsck:
      Unattached zero-length inode 39405.  Clear? no

      Unattached inode 39405
      Connect to /lost+found? no

    Above inconsistence is caused by following process:
           P1                       P2
    ext4_create
     inode =3D ext4_new_inode_start_handle  // itable records nlink=3D1
     ext4_add_nondir
       err =3D ext4_add_entry  // ENOSPC
        ext4_append
         ext4_bread
          ext4_getblk
           ext4_map_blocks // returns ENOSPC
       drop_nlink(inode) // won't be updated into disk inode
       ext4_orphan_add(handle, inode)
        ext4_orphan_file_add
     ext4_journal_stop(handle)
                          jbd2_journal_commit_transaction // commit success
                  >> power cut <<
    ext4_fill_super
     ext4_load_and_init_journal   // itable records nlink=3D1
     ext4_orphan_cleanup
      ext4_process_orphan
       if (inode->i_nlink)        // true, inode won't be deleted

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
