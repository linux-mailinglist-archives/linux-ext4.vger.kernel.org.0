Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C18676B876D
	for <lists+linux-ext4@lfdr.de>; Tue, 14 Mar 2023 02:08:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjCNBH4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 13 Mar 2023 21:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjCNBHa (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 13 Mar 2023 21:07:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7757D8C539
        for <linux-ext4@vger.kernel.org>; Mon, 13 Mar 2023 18:07:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A1C461572
        for <linux-ext4@vger.kernel.org>; Tue, 14 Mar 2023 01:07:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 787C6C433D2
        for <linux-ext4@vger.kernel.org>; Tue, 14 Mar 2023 01:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678756048;
        bh=RDt96OlNAKYrd19MpxzVf1NUrWLDbC4x0MA0NFaZ6fs=;
        h=From:To:Subject:Date:From;
        b=ErZybtmgUlofTO+LKvzVQ1JNqfWnNfs1t835iAgdhp7mEw2KwzXltwpQYuw2bVVkd
         CrkXEEAx4kGiRFBGOKfyU2JKIIlFZG2AldUH0rCy0YfDfaoC5rzBHF2hQvEsfvpqic
         97AzpYkA4NjLPD36KqQ9JFor0LbrDu/C/oXl8uV+gTyGdF3hWXjf7f/siW4f0JLXk8
         ueSxM84aNAZUSPXqTPHZl2KCuvSKxqVbDWErWE5X228NpGz0Yv7cI9Vzpz0N+EheQ7
         /qhXaZpLdFW01kDQVzKY7OXy64KJaDayp2koRLwZKn6+r9Mvn9gM6tFmHNHKGfQ5ZB
         X6RLZNbyh3I1g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 5CEE5C43142; Tue, 14 Mar 2023 01:07:28 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 217189] New: SATA HDD not detected
Date:   Tue, 14 Mar 2023 01:07:28 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: coder.abhijit90@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-217189-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D217189

            Bug ID: 217189
           Summary: SATA HDD not detected
           Product: File System
           Version: 2.5
    Kernel Version: 6.2.0-76060200-generic
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: ext4
          Assignee: fs_ext4@kernel-bugs.osdl.org
          Reporter: coder.abhijit90@gmail.com
        Regression: No

Hello, In my laptop I have two hard drives one is SATA HDD and another one =
is
nvme m.2 ssd. I have installed linux in nvme drive but after upgrading kern=
el
to 6.2.0-76060200-generic my SATA HDD not detected. I have used lsblk comma=
nd
to check the storage devices but the hdd is also not showing there.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
