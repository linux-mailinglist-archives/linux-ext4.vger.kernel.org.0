Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 375F952FEA6
	for <lists+linux-ext4@lfdr.de>; Sat, 21 May 2022 19:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245013AbiEURwq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 21 May 2022 13:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241739AbiEURwp (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 21 May 2022 13:52:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0AEC27CEE
        for <linux-ext4@vger.kernel.org>; Sat, 21 May 2022 10:52:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DEB4FB80945
        for <linux-ext4@vger.kernel.org>; Sat, 21 May 2022 17:52:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A6DC6C385A5
        for <linux-ext4@vger.kernel.org>; Sat, 21 May 2022 17:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653155561;
        bh=EL7vlilwKkZP+ev6301V5h8RvfrqpPRuzPXUvcAY6Sc=;
        h=From:To:Subject:Date:From;
        b=P33NYfw3aM83myF8iGQtCcsWVmmtRKYdCnK3L0yokOdUzT3q4eoyx9UihU2trGuZK
         PLORB0llC620sefnyquvLqW8osppmWUAVCq0gvlrOt02ds7uiWTx5xhQ2E0iDGJjxy
         3T8Z6UxWSEhgGjakWBA7DN9nFysOv48EdD4cK72hBVLyo+obPLvN1/tKRvGNYokLfa
         2g+s5srPgTPrl6GkLqyGrA6Nl0lL6Fal7rnv16oFAHXkB4m4921dKVJN17UScnjKHG
         /jFsTT87DM2yirhiiCHV5JljPCtwMBIEPIVVUL3r3aZbz4Xpxxkw4KO50K81yZZcaU
         nu+faYRudauBg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 894B5CC13B0; Sat, 21 May 2022 17:52:41 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 216012] New: Data loss on VirtualBox VMs
Date:   Sat, 21 May 2022 17:52:41 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: aathan_kernel@memeplex.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-216012-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216012

            Bug ID: 216012
           Summary: Data loss on VirtualBox VMs
           Product: File System
           Version: 2.5
    Kernel Version: Linux ubuntu 5.13.0-35-generic #40-Ubuntu SMP Mon Mar
                    7 08:03:10 UTC 2022 x86_64 x86_64 x86_64 GNU/Linux
          Hardware: Intel
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: high
          Priority: P1
         Component: ext4
          Assignee: fs_ext4@kernel-bugs.osdl.org
          Reporter: aathan_kernel@memeplex.com
        Regression: No

From recent kernel and/or vbox versions forward, I've started to experience
data loss and/or filesystem corruption on a regular enough basis that I've
enabled fsck on every reboot. Mac OSX hosted VM.

It's not clear to me what the source of the problem is, but it may not be e=
xt4
itself vs some element of the block device drivers and/or related hypervisor
facilities.


Message from syslogd@ubuntu at May 21 15:56:49 ...
 kernel:[1958392.548682] EXT4-fs (dm-0): failed to convert unwritten extent=
s to
written extents -- potential data loss!  (inode 259291, error -30)

Message from syslogd@ubuntu at May 21 15:56:50 ...
 kernel:[1958392.830326] EXT4-fs (dm-0): failed to convert unwritten extent=
s to
written extents -- potential data loss!  (inode 262111, error -30)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
