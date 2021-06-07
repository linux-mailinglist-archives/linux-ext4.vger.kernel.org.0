Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C25C39E177
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Jun 2021 18:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbhFGQHs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Jun 2021 12:07:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:40770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230267AbhFGQHq (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 7 Jun 2021 12:07:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 4885161107
        for <linux-ext4@vger.kernel.org>; Mon,  7 Jun 2021 16:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623081955;
        bh=6y3fc2DCgu9/5Khmip4g1YQizBPl78mQAF3/6q3hMRk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=hBVfzfV8Gd8CWCgPKO1lWjnT5nDsGhiQDYMR0q3TNSCx0VpCqAr0lxd9NSl8LhGJA
         tR0Hm1CMHl4MX9in1+OoPaT6zLcbExSWf7RUfdBp41fUr5Bm8BvZsgjQeXwq7YAR2V
         Enf9WZAZ14LveEPsHl8q52EYuUa/eIM3FtY/EzmQDYQqkToRj21XYuPluQDgBxdmRl
         LvnDh3f0szaRCilIQx6YB3j7BUa43GFKKaZ8qj5a3/51gANCZLDwIiFkIKVhRv3SoY
         UPnG0VL2JShmPAu6wCKkNjKa67gA1+t+7HSozn0QDZ27Btdfv7iq7WVI4djhFoUZU9
         BsDahtfCJDw2g==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id 456E861175; Mon,  7 Jun 2021 16:05:55 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 213357] chattr +e writes invalid checksum to extent block
Date:   Mon, 07 Jun 2021 16:05:55 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: jeroen@wolffelaar.nl
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-213357-13602-as7RG8Do6M@https.bugzilla.kernel.org/>
In-Reply-To: <bug-213357-13602@https.bugzilla.kernel.org/>
References: <bug-213357-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D213357

--- Comment #2 from Jeroen van Wolffelaar (jeroen@wolffelaar.nl) ---
Created attachment 297211
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D297211&action=3Dedit
Kernel log

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
