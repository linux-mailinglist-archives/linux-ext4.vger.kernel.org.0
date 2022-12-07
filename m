Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F55B645266
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Dec 2022 04:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbiLGDGP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 6 Dec 2022 22:06:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiLGDGO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 6 Dec 2022 22:06:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396FF537E7
        for <linux-ext4@vger.kernel.org>; Tue,  6 Dec 2022 19:06:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E6314B81C22
        for <linux-ext4@vger.kernel.org>; Wed,  7 Dec 2022 03:06:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8FB51C433C1
        for <linux-ext4@vger.kernel.org>; Wed,  7 Dec 2022 03:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670382371;
        bh=oQ9nWqpiwWkilvnkjTeeHkz1dDnKcz1ROhdtZTzivQI=;
        h=From:To:Subject:Date:From;
        b=cl4cGxb4lCAIi+rglJ6NEBv7UjD+wTYkw4JIewyDiXlHYrLtgSpW3bga0drssDcAs
         kGNLwVWvedaypaqxu37XbUEcpAIFAz0mOaVYmiDa3zyASY0kzRANvudVfk6rCfG0sp
         yLLYGwdZTKTTApFeFtu27+uAzWPyBR5qeoehYMuDt3gUnkLCflxv4d/D1g/K5DlOfn
         baDtmPcbs/oN7AZm2WQKdYTUxCbFCfbzRz1d9QycMmH3SczYjJADJJQbzsqel7bGOh
         HG50ljrhlAg0VG07d76ywqQFrPgiCh6O2oF6SLKJO9nO936Ldq5uDzFgAxfKL75y+S
         ggExm86AOFl/A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 71FE6C433E7; Wed,  7 Dec 2022 03:06:11 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 216781] New: wrong check buffer_head in ext4_simulate_fail_bh
Date:   Wed, 07 Dec 2022 03:06:11 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: low
X-Bugzilla-Who: 1527030098@qq.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-216781-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D216781

            Bug ID: 216781
           Summary: wrong check buffer_head in ext4_simulate_fail_bh
           Product: File System
           Version: 2.5
    Kernel Version: 6.0
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: low
          Priority: P1
         Component: ext4
          Assignee: fs_ext4@kernel-bugs.osdl.org
          Reporter: 1527030098@qq.com
        Regression: No

ext4_simulate_fail_bh used at
https://elixir.bootlin.com/linux/latest/source/fs/ext4/inode.c#L4574
but it seems bh(buffer_head) can only be ptr or NULL, so it is wrong to use
IS_ERR in ext4_simulate_fail_bh at
https://elixir.bootlin.com/linux/latest/source/fs/ext4/ext4.h#L1855

replace IS_ERR with IS_ERR_OR_NULL here.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
