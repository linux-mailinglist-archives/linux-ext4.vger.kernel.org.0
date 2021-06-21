Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4A03AEC25
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Jun 2021 17:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbhFUPTp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 21 Jun 2021 11:19:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:51938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230047AbhFUPTp (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 21 Jun 2021 11:19:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id ED8126113E
        for <linux-ext4@vger.kernel.org>; Mon, 21 Jun 2021 15:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624288651;
        bh=xIwZQyt6C/swAwzhMiOvKULytJQ5U/a+MjFWp/HeK78=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ICd73jcaiB6ykLw2376z4+Z2K4AhaNgV0+C+d18pNeut0HkE/xqVck3LNKrvefMlw
         2TM+1v2Cqj3dQWKTNovQxNNhzfBpBp9ZJmTne0K4ulOYRhqO5UJ8wI8SsGdmSc1zbm
         7rKUxeGUSr0NOs33UdWrMe1s4mp/OaerPBo9RkwUuYO0PlvOu1+brF663LT5BFJUfd
         QP8V9XlJU08kAIfgTArVS5Uuo8zpe5I45EqTA+TCsY1kxUKIPX/7hoXANZFwCkSGCe
         8Wc11dEoiOjzsGGt1WGe8kNVQPVlXJy9Cmkkmtd+ZTENX/F+GB+5JLvHwPp3vfsDxA
         P9PxzF+yyxAxw==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id E893061264; Mon, 21 Jun 2021 15:17:30 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 213539] KASAN: use-after-free Write in ext4_put_super
Date:   Mon, 21 Jun 2021 15:17:30 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: 6201613047@stu.jiangnan.edu.cn
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-213539-13602-6yzmkrvnTV@https.bugzilla.kernel.org/>
In-Reply-To: <bug-213539-13602@https.bugzilla.kernel.org/>
References: <bug-213539-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D213539

--- Comment #1 from 6201613047@stu.jiangnan.edu.cn ---
Created attachment 297551
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D297551&action=3Dedit
report0

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
