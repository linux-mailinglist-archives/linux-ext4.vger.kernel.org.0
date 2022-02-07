Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 365FD4AB817
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Feb 2022 11:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239245AbiBGJsv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Feb 2022 04:48:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237290AbiBGJen (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Feb 2022 04:34:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B38C043181
        for <linux-ext4@vger.kernel.org>; Mon,  7 Feb 2022 01:34:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EDECDB810E5
        for <linux-ext4@vger.kernel.org>; Mon,  7 Feb 2022 09:34:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 95AD3C340F2
        for <linux-ext4@vger.kernel.org>; Mon,  7 Feb 2022 09:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644226480;
        bh=aeO6m8wvgjFjrJ7b7pMqUYhSwUU+UqPEF3GDngZc0ss=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=o3ENsXkJBhM8iR2ti6CZUdZdDy0a5dpKR9FxdCGS2dQ2DOc9wu2Em4O9S+bxIWwX4
         Wj0f2frtC4OEglSSn7tzGzLi/atQqGu3yZqjhV+skp5d1p/cPoJvTX0IPnug1I8F1Y
         T9iMxOmuw980Br/FiQvqQ6Sw5lFM6+gkgCSCQ06wgWiaWKM0Cy3gA2hexo4Sha5nSt
         emQFW2iouTmIOckgL4YvgLSRjoufdBJC1KjgRA66oa3a164y16UHUWwTPPrw2jfR+u
         yGt3O3ts2qX4K+6ZiGGZscOmUkDfDBL/3ZkRcrbxd+573L5j70nWknawq+8zexQ3In
         mNdyLDKtaisZQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 7C7E0C05FE2; Mon,  7 Feb 2022 09:34:40 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 89621] EXT4-fs error (device dm-1):
 ext4_mb_release_inode_pa:3773: group 24089, free 34, pa_free 32
Date:   Mon, 07 Feb 2022 09:34:40 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: kernel.org-115@groovy-skills.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-89621-13602-tyKhQSxl4N@https.bugzilla.kernel.org/>
In-Reply-To: <bug-89621-13602@https.bugzilla.kernel.org/>
References: <bug-89621-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D89621

--- Comment #21 from GSI (kernel.org-115@groovy-skills.com) ---
"This" in my last comment referring to the following output, which I had be=
en
omitting unintentionally:

kvm [12151]: vcpu0, guest rIP: 0xffffffff010410a8 disabled perfctr wrmsr: 0=
xc1
data 0xabcd
kvm [14901]: vcpu0, guest rIP: 0xffffffff010410a8 disabled perfctr wrmsr: 0=
xc1
data 0xabcd
blk_update_request: critical medium error, dev sda, sector 1736391592 op
0x1:(WRITE) flags 0x800 phys_seg 1 prio class 0
Aborting journal on device sda4-8.
EXT4-fs error (device sda4): ext4_journal_check_start:83: comm worker: Dete=
cted
aborted journal
EXT4-fs (sda4): Remounting filesystem read-only

The first two lines may not be related, but at least some (all?) bug report=
s on
the topic mentioned the machine in question being used as hypervisor.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
