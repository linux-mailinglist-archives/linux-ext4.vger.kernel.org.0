Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3E66455D6
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Dec 2022 09:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbiLGI5N (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 7 Dec 2022 03:57:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiLGI4v (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 7 Dec 2022 03:56:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA883B1
        for <linux-ext4@vger.kernel.org>; Wed,  7 Dec 2022 00:56:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CCB1EB815D2
        for <linux-ext4@vger.kernel.org>; Wed,  7 Dec 2022 08:56:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7BB8FC433B5
        for <linux-ext4@vger.kernel.org>; Wed,  7 Dec 2022 08:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670403408;
        bh=53gVEC2Lc2SRHuKLLmtOeD8k6FSxeK/QFQWc6joiDRA=;
        h=From:To:Subject:Date:From;
        b=HXCh+dFuBs3EGOcp3HGTEzCmYDGjhvX0D4IFNUH2aDQyEtwTlHgBZUbP3hbaEi506
         RFW/QYBO8QMPI0nVcWYC/Bf3dNj/MsjAJFAZhcpsTY7GdB7Bn1+Bb5khgPPyQXZ5ED
         MACKpx4PUWxMbaPLicpp0Ev3iIb7HgYBe/sQS9rUeDLmDIO7Sq2s45WR9pEsZwC99E
         IW4foczvhBs5NJ47soQTo+Y7r5RqjYdpVeT1xLEz3ftot24ioUzWXmmYCP9YOOXjeD
         Ug6m1i8pdCmSoYquk8bMRuH8Ah/gLhgh7fbz1Gwxi3eIlwCKdCkGUhtZqsMjeyfrcn
         cBSFC4CA6rwfQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 618F9C433E7; Wed,  7 Dec 2022 08:56:48 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 216783] New: There is "ext4_xattr_block_set" WARNING in
 v6.1-rc8 guest kernel
Date:   Wed, 07 Dec 2022 08:56:48 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: pengfei.xu@intel.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-216783-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216783

            Bug ID: 216783
           Summary: There is "ext4_xattr_block_set" WARNING in v6.1-rc8
                    guest kernel
           Product: File System
           Version: 2.5
    Kernel Version: v6.1-rc8
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: ext4
          Assignee: fs_ext4@kernel-bugs.osdl.org
          Reporter: pengfei.xu@intel.com
        Regression: No

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
