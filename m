Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7CD332C884
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Mar 2021 02:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238218AbhCDAun (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 3 Mar 2021 19:50:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:45284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1376608AbhCCRSx (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 3 Mar 2021 12:18:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 53C3F64EE4
        for <linux-ext4@vger.kernel.org>; Wed,  3 Mar 2021 17:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614791892;
        bh=EV90yZNb+PEE5UDVgQknziW6LIOUfmK+QxCqJI4u/rw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=nV8EJZVnC0X2UXasZoZt3V4vSilMEa201Reuf42LlwYU1G2AmoP2i70f99x07qEfZ
         +H82JrVrKxC0X1mJZgmNkHUaCQVjXZ7Pxeu0ffHJpkOvx6ZAeqThFfCMf8u1VpQ3iQ
         W6hhnpalc1AnTxXDR1eHV5W+QjYrhUwKVlJ3LGkDqmYdw93dlICG8meTLAw9czkXYC
         cKWkAkhq3PaWBMI704ofcx0cSU+L7LZo7Pejcf1NEcXrD37zbwL2fwkGrw4CG+43El
         6tcitvjQ6lBy56jb9erDT050vJYwDUMaOXqMWswTmN9HUoFYaIaQVxapc/2c62W4jR
         9nHWOuERqnu2g==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id 4F49B65372; Wed,  3 Mar 2021 17:18:12 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 211971] Incorrect fix by e2fsck for blocks_count corruption
Date:   Wed, 03 Mar 2021 17:18:12 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: tmahmud@iastate.edu
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-211971-13602-xXBc80wdE4@https.bugzilla.kernel.org/>
In-Reply-To: <bug-211971-13602@https.bugzilla.kernel.org/>
References: <bug-211971-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D211971

--- Comment #4 from tmahmud@iastate.edu ---
Created attachment 295609
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D295609&action=3Dedit
The before and after image after using debugfs

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
