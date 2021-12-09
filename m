Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D282646E880
	for <lists+linux-ext4@lfdr.de>; Thu,  9 Dec 2021 13:30:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbhLIMe1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 9 Dec 2021 07:34:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbhLIMe1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 9 Dec 2021 07:34:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5DC3C061746
        for <linux-ext4@vger.kernel.org>; Thu,  9 Dec 2021 04:30:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AD631B82455
        for <linux-ext4@vger.kernel.org>; Thu,  9 Dec 2021 12:30:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6017AC341C8
        for <linux-ext4@vger.kernel.org>; Thu,  9 Dec 2021 12:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639053051;
        bh=dx+KsZGifzIUSm9Z7EssDcNPLsEJLD9m6lZYKU8Aaew=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=jNK8USi0A9gKcKQ7OWe8by/KcE3r5kBn8zfTFaSTjTS8IwNLuUO1boZhmGQJTINRz
         KZUy7ekSCzohIsdrqaxeAQgQxFU7Trqi1GMz+rLS90cy0HjePGgSQmhyu9XUnW5/at
         /znZvD+eQyhGuzhnaVmZ13/8xkc8SUvfHIjsIkDXdvbhVCqNB0IuWY0iTLLOpA70Sh
         e9j6uvpzz7QBPx9PM9lYgENFxOXo+6R0LDIaG650LE3kNdztOlOeD9F6/+FpjdFQzU
         9EmKulrpjwrVpg+DUr+LbxIA7jnw8uhm7NW8+2RqlEx3/UllGtjIR/N0aARxxgDoCY
         bEjZk9rJ3Lt8Q==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id 4B99560E8C; Thu,  9 Dec 2021 12:30:51 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 213357] chattr +e writes invalid checksum to extent block
Date:   Thu, 09 Dec 2021 12:30:50 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: lhenriques@suse.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc attachments.created
Message-ID: <bug-213357-13602-4F5pHDNNIN@https.bugzilla.kernel.org/>
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

Luis Henriques (lhenriques@suse.de) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |lhenriques@suse.de

--- Comment #3 from Luis Henriques (lhenriques@suse.de) ---
Created attachment 299969
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D299969&action=3Dedit
ext4: set csum seed in tmp inode while migrating to extents

I forgot to comment on this bug regarding the fix I've proposed on the
mailing-list[1] (although there are no replies yet).  For completeness, I'm
attaching the patch here too.

[1] https://lore.kernel.org/all/20211206143733.18918-1-lhenriques@suse.de/

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
