Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 408FA7B672B
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Oct 2023 13:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240015AbjJCLFE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 3 Oct 2023 07:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240002AbjJCLFD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 3 Oct 2023 07:05:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53226CE
        for <linux-ext4@vger.kernel.org>; Tue,  3 Oct 2023 04:05:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C6F87C433C8
        for <linux-ext4@vger.kernel.org>; Tue,  3 Oct 2023 11:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696331099;
        bh=6oZhfhwjyVW6dXw/pdw8QvsN8uQ0y1YkDJgIsj7Y0bI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=gFCz7NRSVnm1DMx7Wjlt/F/ZKDLZuORzQKqaQAjmqmAwpdRIlni/oxrZT5pG5ZlHW
         tDv+JtkmwDuZjIHw5BpDPYXYpLlgxsdu3SMqfO4roAiTeh2Cnxdl7NCFhY35NE8pKz
         F2NS19L4q57vx/LXtdkGH7DbALoK1SPN6hpo3h39Mzw+slWs3s8VQh2Bx0pXtEKqRf
         uRldRAc4siD7u4x834yV7PeviUjiovl2IcnHzBKbRPJh4R24K7kBCA91Vit+e1ZKUX
         EQbzk2oqlRtZNwgdoHnsey2Yjji+qWFBahbPnjYpTY/3m/zjBs6fuHx5MYzfEHtY1o
         AViQJeZwk26jA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id ACE07C53BCD; Tue,  3 Oct 2023 11:04:59 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 217965] ext4(?) regression since 6.5.0 on sata hdd
Date:   Tue, 03 Oct 2023 11:04:59 +0000
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
Message-ID: <bug-217965-13602-IC94DCtm4U@https.bugzilla.kernel.org/>
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

--- Comment #7 from Ivan Ivanich (iivanich@gmail.com) ---
Removed stripe with tune2fs -f -E stride=3D0 /dev/sdb2 and it fixed the iss=
ue.
Still have no clue why it was enabled.
Thanks

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
