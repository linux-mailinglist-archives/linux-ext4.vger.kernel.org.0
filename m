Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76A5756CB0D
	for <lists+linux-ext4@lfdr.de>; Sat,  9 Jul 2022 20:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbiGISW2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 9 Jul 2022 14:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGISW1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 9 Jul 2022 14:22:27 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4081403F
        for <linux-ext4@vger.kernel.org>; Sat,  9 Jul 2022 11:22:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2EBD5CE0A21
        for <linux-ext4@vger.kernel.org>; Sat,  9 Jul 2022 18:22:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6413FC341CB
        for <linux-ext4@vger.kernel.org>; Sat,  9 Jul 2022 18:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657390943;
        bh=IaeBcvBoPXvHTknMApNZzQMJPkT+redmupk5Rhq47mA=;
        h=From:To:Subject:Date:From;
        b=G7WK6tPkDDm+EkTgcffH6agkBcKsHyi0iFpKH0MKFI46RAc5Ex97jm/aIawh0KSsj
         JClS+QlFWRbH8QiL241nUC80ltca28FsiSk8kCMIWI0qS4u9ALNZuZF2lXVHnb0AxQ
         xIyWsQmThOwO65+YmlS61oxHGESgyzuqE0YPWv5B26dmHeV67CJhSBhgF3/hTyLsMC
         bp2ktpUdLSg2LYKL4gTVM7EV2jBG2HW2GLfRoaBB1vb8vecrKEK0MAzsC50MDslu41
         BwFD2bADLq8fPQ4P71FgPiNnaMkUqJ2ikjrPevo3kBdFtUMZucGSn+x4Gi5hNlZOSZ
         wD44UWyupfH7w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 4E6CCCC13B8; Sat,  9 Jul 2022 18:22:23 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 216229] New: Same content in two different files - strange
 problem, unsure if caused by kernel housekeeping
Date:   Sat, 09 Jul 2022 18:22:23 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo fs_ext2@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext2
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: joerg.sigle@jsigle.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext2@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression attachments.created
Message-ID: <bug-216229-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216229

            Bug ID: 216229
           Summary: Same content in two different files - strange problem,
                    unsure if caused by kernel housekeeping
           Product: File System
           Version: 2.5
    Kernel Version: Linux version 5.15.51-i7 (root@think3) (gcc (Debian
                    8.3.0-6) 8.3.0, GNU ld (GNU Binutils for Debian)
                    2.31.1) #1 SMP PREEMPT Thu Jun 30 09:55:14 CEST 2022
          Hardware: IA-64
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: high
          Priority: P1
         Component: ext2
          Assignee: fs_ext2@kernel-bugs.osdl.org
          Reporter: joerg.sigle@jsigle.com
        Regression: No

Created attachment 301382
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D301382&action=3Dedit
two consecutively written files on ext2 (by ext4) end up with the same cont=
ent
when written from the same bash script and ls is not called afterwards from
therein, too

I might have found a problem where two consecutively written files on ext2 =
(by
ext4) end up with the same content when written from the same bash script -=
 but
NOT if ls is called right thereafter before that same script ends. --- Soun=
ds
strange and possibly scary to me. Might still be a problem of my own, but I
observed it on ext2, and not on ntfs-3g in the same system, and never in ma=
ny
years before. --- Please see the attached plain text (but better formatted)
description for further information. Thank you.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
