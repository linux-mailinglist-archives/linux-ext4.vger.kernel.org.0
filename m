Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0E067B6B5D
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Oct 2023 16:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239693AbjJCOXz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 3 Oct 2023 10:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239511AbjJCOXy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 3 Oct 2023 10:23:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7976B9E
        for <linux-ext4@vger.kernel.org>; Tue,  3 Oct 2023 07:23:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1D0A2C433CC
        for <linux-ext4@vger.kernel.org>; Tue,  3 Oct 2023 14:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696343031;
        bh=1GvanN9jn72KeE/pmyGyYUKlCMVaX/YrJYnn3cpkS18=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=BGN64eazcbz+1YfPeSTE5Z0hl828P3gfKZRcsLwFhlbsckEx6wZTdB5fRieZgkuBe
         qipDh7ZyDS/WkC9ne76GOlwaTlAmidHHjmJltRrRvqcR36e3NtklN48T4kTA7xCMeB
         H6jr8jTZKMrn6+P0VFfOHKSwRvJmurxb7aRMq/Mfgwns0ylEHNQZxPaxffEXz64FZw
         DdIRNpmK0nZNAr1Hdhtgz4xUGojA1xMUOpsdl6Ufr8mIkevXiIOrmeOBeBV1yaubp0
         GoZNieTSWxJFJ49jeYNjK8f9fH0hkh29JLP9xUSZHw4ttA9WbX+DimxPByBgq5ouwV
         581622ScrFupA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id C8E21C53BD4; Tue,  3 Oct 2023 14:23:50 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 217965] ext4(?) regression since 6.5.0 on sata hdd
Date:   Tue, 03 Oct 2023 14:23:49 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: iivanich@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217965-13602-hLLBqNvmq3@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217965-13602@https.bugzilla.kernel.org/>
References: <bug-217965-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D217965

--- Comment #9 from Ivan Ivanich (iivanich@gmail.com) ---
With mount option stripe=3D32752 and disabled mb_best_avail_max_trim_order =
issue
is still visible.

cat /sys/fs/ext4/sdb2/mb_best_avail_max_trim_order
0

mount|grep sdb2
/dev/sdb2 on /mnt/sdb2 type ext4 (rw,relatime,stripe=3D32752)

4687 root      20   0       0      0      0 R 100,0   0,0   0:25.73
kworker/u16:1+flush-8:16

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
