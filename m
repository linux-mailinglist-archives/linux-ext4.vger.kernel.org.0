Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D359443F9A
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Nov 2021 10:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbhKCJwZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 3 Nov 2021 05:52:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:60136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230097AbhKCJwZ (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 3 Nov 2021 05:52:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id F2EE160720
        for <linux-ext4@vger.kernel.org>; Wed,  3 Nov 2021 09:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635932989;
        bh=tLB7qLK2LSqQZQ2y20RZu84B1vLBPZi2Fn2sc3GIKFs=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=mayC/TvDQm0fpsHFUc1yLiG/wzEYnt6zjs+0eeluBbH+b2iurSXxTc2RaRdEncHxP
         XPpcn/niV4lbKjqa3altkT5+YuSd6FxS1iixCkKBsOIt2vxOq+GN3LY9IF4R5ajzea
         mhMW+6D9ygjnQ24qQrSw2kYusaU0p03FPHZk9VyA86buz4EFg3L+wO2pftpbGfPcSZ
         NXxM4mTSD0oRsmd7G6A1S9UgHTGIRmV/Xf334Ila9NPJJEv2Z8FO0MaOUwArXYVbPg
         hbbHw3X2OfCEBc6O0ygJi9YamfYH2UJUTBS9zFU/xNwrivFoLIoZ4hhgg69y/ggQLo
         qBssDzQ12EDug==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id EF6DD60FF3; Wed,  3 Nov 2021 09:49:48 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 214927] re-mount read-write (mount -oremount,rw) of read-only
 filesystem rejected with EROFS, but block device is not read-only
Date:   Wed, 03 Nov 2021 09:49:48 +0000
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
X-Bugzilla-Changed-Fields: short_desc
Message-ID: <bug-214927-13602-GVLCmhFATx@https.bugzilla.kernel.org/>
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

Ulrich.Windl (Ulrich.Windl@rz.uni-regensburg.de) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
            Summary|re-mount read-write (mount  |re-mount read-write (mount
                   |-oremount,rw) of read-only  |-oremount,rw) of read-only
                   |filesystem rejected with    |filesystem rejected with
                   |EROFS, but block device is  |EROFS, but block device is
                   |nor read-only               |not read-only

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
