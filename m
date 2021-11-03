Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D91E5443FD7
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Nov 2021 11:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbhKCKI4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 3 Nov 2021 06:08:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:35528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231338AbhKCKI4 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 3 Nov 2021 06:08:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id D3B6A60F58
        for <linux-ext4@vger.kernel.org>; Wed,  3 Nov 2021 10:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635933979;
        bh=26Nv9eXstJj5Gl9Fa4iaOSCgPeeuJDnDaW6MJCERKaE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=MXnNe6E0csn7MXj1nx9fX1vUO1hj3qymigLMEKLn/m9QevOOKs60j/5X0DWbN5R6v
         UBR4wnt8sr3EHs+/Ii6Z5W+rWY2oMUE5TR6EmT7GA1mkRQehIncbT3bmGCqICFw8lO
         zxcZPjPkkFTQ/gAUSQCfMX4noUvE//1j2GxCjCSByxGf+wABecH2oNPCY6qChJ0wcT
         Pz0s3lrOlffadRDQ9KN31WRC0qOciBdibjnM1MBQ1t65oHyUOvdbStwmWfopTLDNxY
         DuhcX0n6It5tyMR/zWBWoS5eF0DzJdpp6fWRV7FPmoNu2LKyhdLCFiuW2/VoTW7Wyt
         u/oFGqVbzAo9w==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id C8D2F60FF3; Wed,  3 Nov 2021 10:06:19 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 214927] re-mount read-write (mount -oremount,rw) of read-only
 filesystem rejected with EROFS, but block device is not read-only
Date:   Wed, 03 Nov 2021 10:06:19 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext3@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext3
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: Ulrich.Windl@rz.uni-regensburg.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext3@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-214927-13602-jdSDZcum15@https.bugzilla.kernel.org/>
In-Reply-To: <bug-214927-13602@https.bugzilla.kernel.org/>
References: <bug-214927-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D214927

--- Comment #2 from Ulrich.Windl (Ulrich.Windl@rz.uni-regensburg.de) ---
Having a second look, it seems the first error was concurrently with fstrim=
, so
possibly fstrim can play a role in the scenario:
kernel: print_req_error: I/O error, dev xvdb, sector 29730024
fstrim[8864]: fstrim: /var: FITRIM ioctl failed: Input/output error
fstrim[8864]: fstrim: /tmp: FITRIM ioctl failed: Input/output error
...
(the final message was like 13 minutes after those above)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
