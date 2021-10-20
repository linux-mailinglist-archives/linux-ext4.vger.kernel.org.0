Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C711E435076
	for <lists+linux-ext4@lfdr.de>; Wed, 20 Oct 2021 18:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbhJTQpd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 20 Oct 2021 12:45:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:41496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230052AbhJTQpb (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 20 Oct 2021 12:45:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 15A6F61371
        for <linux-ext4@vger.kernel.org>; Wed, 20 Oct 2021 16:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634748197;
        bh=PrfdAaM/TTDBuBvo3UXT7HZIit9ZzOoYFj0I85lIbEU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=dk5y5gQ7c2JBJMC+qQZNNsUa06t7WCmGoy3KFqg/fwgxolylksLTAmE9KlGs2D+hq
         5z/op5TSstS9TxJaI+cdht6pPhA0L0Azvp5unKN0kvz7vRwU470e4r8tHxxFeh3c8F
         u7yhKYwxVpxYKXSOjKigdpS/I/VQc2u/8xUVLPMoFVqWZG9SUhLDECMjMps38vJEu2
         vvsibFv51lHtBdmu3vuHzcN9TmxACf3zurnTRQnlrzTF2r5xnjo50YkmOLK9QB4Wmw
         hS/K2foGFmI/BL2xaWvs1I9DNuNNStDqVQd2+jdj8ShjTZ4JX/Flylimn0wMKEI/ig
         0QYOilgcdTMrQ==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id 0A57560F9C; Wed, 20 Oct 2021 16:43:17 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 214655] BUG: unable to handle kernel paging request in
 __dquot_free_space
Date:   Wed, 20 Oct 2021 16:43:16 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: jack@suse.cz
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-214655-13602-lxcKc9r6vN@https.bugzilla.kernel.org/>
In-Reply-To: <bug-214655-13602@https.bugzilla.kernel.org/>
References: <bug-214655-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D214655

Jan Kara (jack@suse.cz) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |jack@suse.cz

--- Comment #1 from Jan Kara (jack@suse.cz) ---
Thanks for report. I'll try to reproduce this in my test VM. I have recently
merged some fixes for detecting corrupted quota files from Zhang Yi so maybe
this is already fixed but let's see...

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
