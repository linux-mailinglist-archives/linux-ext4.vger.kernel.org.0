Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C211D47F4C9
	for <lists+linux-ext4@lfdr.de>; Sun, 26 Dec 2021 01:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233134AbhLZADY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 25 Dec 2021 19:03:24 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:41076 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233057AbhLZADX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 25 Dec 2021 19:03:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A58660DB6
        for <linux-ext4@vger.kernel.org>; Sun, 26 Dec 2021 00:03:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BCFA6C36AEB
        for <linux-ext4@vger.kernel.org>; Sun, 26 Dec 2021 00:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640477002;
        bh=mJBz1ScMCroT8NSYW8m1xTrOKLtANTFoE3Pl5b9U5vo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=AGpDbBGAY/QMLYWI4wJ0TjKMjQwX1Ky1V/oXFJE1aNVPDVhQA2UjrbIlQWKueXYiB
         Umrjemaq9iQr1qu50hPdd5BlEcAAor+smw6repx9c8j8c9V53i9kufsGZ/2BtpWfh7
         zXnAAZ/K03pwnrZ5nLJkrRkHYVw9WpQEJsnU02R4ETRjsM7vLEuJV+Kpl5wzmBZue4
         PbmydqilL9nH5TOjpeKwdlSnkr13zGGvvkyzy9kxU/s3T/VCJVnUFJ5xiNhp/AxrDH
         DSKe5GryFpPnPJ9ub3QwOWfSrI2dabZAYbNKuZZz96d7MJRQv3JyqsK23C3Dq7lKKh
         IRbQjYdrsjUmQ==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id 8821B60FC0; Sun, 26 Dec 2021 00:03:22 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 215225] FUZZ: Page fault and infinite loop after mount and
 operate on crafted image
Date:   Sun, 26 Dec 2021 00:03:22 +0000
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
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215225-13602-WJs38kN1oK@https.bugzilla.kernel.org/>
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

--- Comment #3 from Wenqing Liu (wenqingliu0120@gmail.com) ---
The bug is triggered when mount and operate on the corrupted image. I can s=
till
reproduce it on 5.16.0-rc6 when run

$unzip tmp38.zip
$su
#./single.sh ext4 38

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
