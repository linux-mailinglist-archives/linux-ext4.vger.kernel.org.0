Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5526147F4C8
	for <lists+linux-ext4@lfdr.de>; Sun, 26 Dec 2021 01:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233131AbhLZAAd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 25 Dec 2021 19:00:33 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:39912 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbhLZAAb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 25 Dec 2021 19:00:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C097460DB6
        for <linux-ext4@vger.kernel.org>; Sun, 26 Dec 2021 00:00:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 10B45C36AE9
        for <linux-ext4@vger.kernel.org>; Sun, 26 Dec 2021 00:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640476830;
        bh=OtIzW/e/n6Q8rIr9jycDjNthlIBD9gvFUneX1ovxENY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=PiZAZUdf1LhfxWoTfmvORFjgBPQXhXxDJ6f3fZgIFpsSwgm3RwJuL9fPhT/rhzhoN
         5rpjlRKmgxf4EZOHw6PdURnvRwln1me3yq6di+2/HLeyzTF1pgU8tXOHCo3I+ix+F2
         hwe+s7tmq2/ggyccfLiZxUVkumJSC8wY8LyVXvTGwrl+OlwvBvM/lh0CS4XxCt1V2c
         cuZu9VtjGW2E6JhbYhg4rfp08o6IpuFC1ToGndI03PR87MCxKdEYUTvyL0gL1ScoZ6
         CMIMKM1/II7lQk56I7iYH1xsJ1W3I83Gth+WG5rpyzaftDIu+U1BQ2Lw0o8QwnZCqp
         fWD0ePB7NoczQ==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id EEFB660FEF; Sun, 26 Dec 2021 00:00:29 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 215225] FUZZ: Page fault and infinite loop after mount and
 operate on crafted image
Date:   Sun, 26 Dec 2021 00:00:29 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: wenqingliu0120@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc attachments.created
Message-ID: <bug-215225-13602-vOPdehbmNy@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215225-13602@https.bugzilla.kernel.org/>
References: <bug-215225-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215225

Wenqing Liu (wenqingliu0120@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |wenqingliu0120@gmail.com

--- Comment #2 from Wenqing Liu (wenqingliu0120@gmail.com) ---
Created attachment 300157
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D300157&action=3Dedit
POC_script

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
