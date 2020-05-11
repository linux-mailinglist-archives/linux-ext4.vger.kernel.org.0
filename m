Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2F091CE293
	for <lists+linux-ext4@lfdr.de>; Mon, 11 May 2020 20:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729719AbgEKS0Z convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Mon, 11 May 2020 14:26:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:58844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729673AbgEKS0Z (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 11 May 2020 14:26:25 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-ext4@vger.kernel.org
Subject: [Bug 207635] EXT4-fs error (device sda3): ext4_lookup:1701: inode
 #...: comm find: casefold flag without casefold feature; EXT4-fs (sda3):
 Remounting filesystem read-only
Date:   Mon, 11 May 2020 18:26:24 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: ebiggers3@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-207635-13602-NttAo3E9Wz@https.bugzilla.kernel.org/>
In-Reply-To: <bug-207635-13602@https.bugzilla.kernel.org/>
References: <bug-207635-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=207635

--- Comment #7 from Eric Biggers (ebiggers3@gmail.com) ---
> Someone might use a kernel with casefold or encryption support on Monday -
> and even use these features, causing a few of these flags to be set.
>
> The same person might run a kernel with casefold and/or encryption disabled
> on Tuesday. So, would it really be necessary to set their filesystem to ro -
> giving them a hard time, just because they like to use different kernels? I
> think not.

Casefold is an 'incompat' feature, because it changes the directory format.  So
if someone enables it (on-disk, which is different from merely using a kernel
that supports it), then old kernels can't use the filesystem at all.  That's
working as intended.

But that's *not* actually what this issue is about.  This issue is about how
the kernel treats inodes that got corrupted to have the casefold flag set when
the user didn't actually enable the casefold feature.  The ext4 feature flags
have clear behavior for how unexpected flags are handled, but the inode flags
don't.

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
