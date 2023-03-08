Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 857B06AFD20
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Mar 2023 03:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjCHC52 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 7 Mar 2023 21:57:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbjCHC51 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 7 Mar 2023 21:57:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB0C9EF7D
        for <linux-ext4@vger.kernel.org>; Tue,  7 Mar 2023 18:57:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 370EFB81B81
        for <linux-ext4@vger.kernel.org>; Wed,  8 Mar 2023 02:57:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A27D6C4339B
        for <linux-ext4@vger.kernel.org>; Wed,  8 Mar 2023 02:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678244243;
        bh=m4BNLZNJJzRq/p3L4dkUJeY5dRPYrfDQTF+LQTz2Y5Y=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=fiLmu+o6MPBpV6CDvto03Zf/8hm6kuisyuqowytjZ0VxatxaGjm39jrQq2d7hI6G0
         tUhfXC0tgZVJ0YKSdpOMLOzvVeLAm5r5O2GEk/ZL0rpVDSuUWIpzHxp0OuqcaQF2Sh
         dXVPmE3Vrwuy+aEj3RyKftNsu6HcitvDamGMrtOf+fzlb6wmYgPh3C2D4VCMsiC3hZ
         QaU/epHH1ylI5LEUSElqEOyjqw/tnesTbrn02V2XOEML8w/9MTzos5nuwFC0aR1k7t
         IAd2DV39KUG9cCavyKweM0EBnsYb/Xrp3SYX7bvNZTRTMTw3zSVkYpNVLHAn9mXnQ2
         UEUDRxEKUjfOA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 91E64C43142; Wed,  8 Mar 2023 02:57:23 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 217159] WARN in ext4_handle_inode_extension: i_size_read(inode)
 < EXT4_I(inode)->i_disksize
Date:   Wed, 08 Mar 2023 02:57:23 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: chengzhihao1@huawei.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-217159-13602-BE3LDOwNA7@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217159-13602@https.bugzilla.kernel.org/>
References: <bug-217159-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D217159

--- Comment #2 from Zhihao Cheng (chengzhihao1@huawei.com) ---
Created attachment 303898
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D303898&action=3Dedit
b.c

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
