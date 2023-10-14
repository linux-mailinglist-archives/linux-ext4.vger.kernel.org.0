Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99A387C966B
	for <lists+linux-ext4@lfdr.de>; Sat, 14 Oct 2023 22:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbjJNU4r (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 14 Oct 2023 16:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjJNU4q (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 14 Oct 2023 16:56:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEAE4CE
        for <linux-ext4@vger.kernel.org>; Sat, 14 Oct 2023 13:56:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6974CC433C7
        for <linux-ext4@vger.kernel.org>; Sat, 14 Oct 2023 20:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697317005;
        bh=xfCJ+Kbc0u9GF/JTx/rPsCJtWsJOe5o483zBFXJmxIg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=IBy+UrTyORhyOAZy4fsi+a+Efc59Bhe9nqeMJLpvcOsMw4z+P9RSZWd08GVtFNaeS
         i0GMPtiHGKz5CJIsjZ8K/uSY4rSv2Jgdk/aYVRktnGaghRWyYiNQ4pm3KcgV/g6/Xf
         Ls2tFruil3ODLj8YuiIjiFnuWlCGhvkBLQk9DxwINxChCnK+asRGLVGw2U4O4qyfP5
         zCrBI9GeAOzQ8MRky0Q2DioeLpjWkMGroaHZtHT1WqDBkN+FA0HZ6G7NhVPPseGo16
         4nCK6P7iQACYmIUa+KuefqGk7iBUe5qjVqtkaWCrLstdKUrCUOmwMx6gOMqO4f77l0
         k9rLTwDrCJQHQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 51591C53BCD; Sat, 14 Oct 2023 20:56:45 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 218011] ext4 root filesystem related hangs on 6.5 kernels
Date:   Sat, 14 Oct 2023 20:56:45 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218011-13602-NsJli3rh4t@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218011-13602@https.bugzilla.kernel.org/>
References: <bug-218011-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D218011

--- Comment #1 from Artem S. Tashkinov (aros@gmx.com) ---
Please provide the output of=20

mount | grep ext4

And

sudo dumpe2fs -h /dev/partition

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
