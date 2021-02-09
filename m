Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABB993158DF
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Feb 2021 22:46:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233614AbhBIVoO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 9 Feb 2021 16:44:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:43594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233956AbhBIU4y (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 9 Feb 2021 15:56:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 0AC0B64DB2
        for <linux-ext4@vger.kernel.org>; Tue,  9 Feb 2021 20:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612904173;
        bh=mLqw0COmLL7JggXN1H4MDOCe4w3FjbJ5yPXLW0ALmbY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=uVFFtHRJY8p/ejUTqqMIOr+LHer9xdXFA+cFwGxC7oMH0DL6EQpC9O56lgZhf62c2
         JJsJ+n9mu18BpFDHSS/8y5/GgwpSvQdgtUTDKpZ7WgfFAbE1o/lz4cwWMzrFPgymod
         aPACY1KYLqxEYG2lXlFnsIu5c7lAR/6YeltNkwgWONUkA8jbcCOAVdIZKzw145y7SE
         5/MF7NoLRFve90I3nCfFQEbKEoQe69FwTYDDWEZ5aRVoZn5jX2zeNkqE1VUfF7gpix
         qzT5i+q3avvWfjKeKnOcXV1zIJTw8odoKDrxyNpUn/VXr4ZbC+L8crpSgcv3mJQXDH
         4e8PcqryryCDQ==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id 048C16533E; Tue,  9 Feb 2021 20:56:13 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 63471] Please add a "quit" command to the e2fsck interactive
 mode
Date:   Tue, 09 Feb 2021 20:56:12 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: enhancement
X-Bugzilla-Who: unforgettableid@gmail.com
X-Bugzilla-Status: CLOSED
X-Bugzilla-Resolution: MOVED
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: resolution
Message-ID: <bug-63471-13602-rqhfAy1jGh@https.bugzilla.kernel.org/>
In-Reply-To: <bug-63471-13602@https.bugzilla.kernel.org/>
References: <bug-63471-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D63471

unforgettableid@gmail.com changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
         Resolution|INVALID                     |MOVED

--- Comment #4 from unforgettableid@gmail.com ---
My mistake.  Resubmitted at:  https://github.com/tytso/e2fsprogs/issues/59

I appreciate your comment.  Also, I thank you for all your kernel-related w=
ork!

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
