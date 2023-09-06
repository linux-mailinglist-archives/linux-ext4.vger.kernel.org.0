Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63C74794184
	for <lists+linux-ext4@lfdr.de>; Wed,  6 Sep 2023 18:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243256AbjIFQ3X (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 6 Sep 2023 12:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243244AbjIFQ3V (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 6 Sep 2023 12:29:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D24C1BDC
        for <linux-ext4@vger.kernel.org>; Wed,  6 Sep 2023 09:28:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A637EC433C9
        for <linux-ext4@vger.kernel.org>; Wed,  6 Sep 2023 16:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694017691;
        bh=2kkyuDas9arB0GD9tTnK1FqvbE2YEr31o3Ipsxb/cQs=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=i1gozQOmV8IL7VBhPVxrcreQm7daAD+7IBapwyyjMxQpefSII0K4+T8lgyuL1uypZ
         FiH5YSyt9ImL6a96FtRiL5/+w4BLVje7JXiu+oQNj/Qwh46bVKJKVE6qwZMNnhISzh
         /PEABkn5b4UOAmExPEYHygAKpOm9v2IbzXcydw92BvhypiFQRGq4gNEoihaJ4Kr39a
         TNkdybBNsYAeNUOqbcI6cse45m6bCXVEU6WOIOiwuDgWky2t0Q5rZ3vW1DbdbY5GLB
         notLztTix7RiSt3mq+6TguoZMFg+w82sRAJSWBGONfYZzqppkx0w4XojXyVSL/CKok
         WGbXSW0yP7m5g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 916A9C53BCD; Wed,  6 Sep 2023 16:28:11 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 216322] Freezing of tasks failed after 60.004 seconds (1 tasks
 refusing to freeze... task:fstrim  ext4_trim_fs - Dell XPS 13 9310
Date:   Wed, 06 Sep 2023 16:28:11 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: todd.e.brandt@intel.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216322-13602-jAsKZh1EV2@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216322-13602@https.bugzilla.kernel.org/>
References: <bug-216322-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216322

--- Comment #13 from Todd Brandt (todd.e.brandt@intel.com) ---
Here's a method to easily reproduce this issue. The fstrim timer usually tr=
ips
at Midnight Monday mornings on ubuntu, so when testing happens during this =
time
we get this issue. Here's a way to trigger fstrim any time you want over
suspend/resume:

--------------
#!/bin/sh

/sbin/fstrim --listed-in /etc/fstab:/proc/self/mountinfo --verbose
--quiet-unsupported &
sudo sleepgraph -m mem -rtcwake 5
--------------

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
