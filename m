Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA8430BC77
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Feb 2021 12:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbhBBLBX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 2 Feb 2021 06:01:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:53348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229557AbhBBLBW (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 2 Feb 2021 06:01:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id C6D4E64EE2
        for <linux-ext4@vger.kernel.org>; Tue,  2 Feb 2021 11:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612263641;
        bh=59q+Il0IYTTIlyxiEQNbvrrTlJJY+tea7lAvoCJNt1g=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=JDUsfvGs1zAovOCr7im7lGCcWcURcyfemICOkK6tAOt3Io9fI8scca+bfYH4OjwwH
         6srAJwxcGZZD72nkAKS46GK9h3zDVKubgWbqS5ogZOKAj5mCSPJxqvBbeWvxYGgiKX
         6nRzUIj5ljmoTe1UzzDU7qNIE6Nt//4BD8bK3xPMiHgsvlya8sYGm2K010mfxp3xRC
         7Eg7xqFcxmc2yuwPzygzA2vU25tL02Q+FBqJycOYWV3XU0dCF2UObektICUyzBjYjB
         dS+MgRpYJujD1lvDaaWVaKPdKV5WdwUw+E2N0pm0Aa5IyG5NCTax+CtxO4MVrfNKWz
         d/SKZSp8RjLcA==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id A877F6530A; Tue,  2 Feb 2021 11:00:41 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 210185] kernel BUG at fs/ext4/page-io.c:126!
Date:   Tue, 02 Feb 2021 11:00:41 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: gernot.poerner@web.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-210185-13602-nqr6DqTaRm@https.bugzilla.kernel.org/>
In-Reply-To: <bug-210185-13602@https.bugzilla.kernel.org/>
References: <bug-210185-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D210185

gpo (gernot.poerner@web.de) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |gernot.poerner@web.de

--- Comment #11 from gpo (gernot.poerner@web.de) ---
Hi, any updates here lately?=20

Hitting the same bug on a completely different workload and setup. 5.9.x
crashes, 5.8.x works, this is all on Debian 10 Buster running as a VM

Currently we downgrade to 5.8.x because of this. I can provide further
information if interested.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
