Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 747E33B668C
	for <lists+linux-ext4@lfdr.de>; Mon, 28 Jun 2021 18:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233030AbhF1QTe (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 28 Jun 2021 12:19:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:40710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233108AbhF1QTc (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 28 Jun 2021 12:19:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id E8D3A61C65
        for <linux-ext4@vger.kernel.org>; Mon, 28 Jun 2021 16:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624897026;
        bh=iknkyqR+UZ+V6MO3uQdN+ethKZca5NfQuUw8LuzzB00=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=nGh+ZU+xHjbcb0rlRK2+IZHLlVLNrPzsCn1g6OnsDXk3val1NJt6fCjIdsN3oqpZ4
         izUsYEIfVrpn44FsD+XPWULkX2oZjXfosSKEgzInfATMejmDcwfStBiSheRPmO1sjw
         pS2qeUnMpyS6LUNPG+UoaLY54+lWSY1rJCb0rLgmegsXWDp2xSU2aMiNgSkqzrYiyL
         QhrddEzgupKR2CunGJsKsDtcKsg81ZzVqDHaflBrrrX4hFy9q/jyFY1b0CHjDRG4Vp
         dSGKZaWXmEp2Y6InM8XigmFr8XDWcuaOY9w6IvblYHdmCd41D87BJDFVYrGJen+hRo
         bNNj22BAUdreA==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id DF5FC61247; Mon, 28 Jun 2021 16:17:06 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 211951] WARNING: CPU: 1 PID: 304 at fs/ext4/xattr.c:1643
 ext4_xattr_set_entry+0x30e2/0x3830
Date:   Mon, 28 Jun 2021 16:17:06 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: ammar@ammaraskar.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-211951-13602-bUkqNG9ig1@https.bugzilla.kernel.org/>
In-Reply-To: <bug-211951-13602@https.bugzilla.kernel.org/>
References: <bug-211951-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D211951

Ammar Askar (ammar@ammaraskar.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |ammar@ammaraskar.com

--- Comment #1 from Ammar Askar (ammar@ammaraskar.com) ---
Note: Can't recreate this on 5.12 but it does seem to occur on both 5.11 and
5.10

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
