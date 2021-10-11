Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 851C5429264
	for <lists+linux-ext4@lfdr.de>; Mon, 11 Oct 2021 16:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244393AbhJKOpe (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 11 Oct 2021 10:45:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:57684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243617AbhJKOp0 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 11 Oct 2021 10:45:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 3119960EE2
        for <linux-ext4@vger.kernel.org>; Mon, 11 Oct 2021 14:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633963406;
        bh=/vHGplDJeovj/GkVe/T7w5LpH1KXXOIYLmjYpT/fsLM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=MHKqZP/OLnSOnQrMpvRprW9KFBEHYyJhQU+ze+O3DolDjUBDQRLMeW8YnDaSmN01P
         o0LZBYHQtElffpDN1ozlk8zn9ELILQsNZl9fNFnrtDnckke8OBb7d1HJAoqWtkkg/E
         /2KO0G7sF6qAQtNxOCtxMU9chsiXPogtttUYgmiXSHTJInVZS2AiZrrigr/te//MAl
         T4H5zduRxVoiCSskTfOJIap0G3jcTV0Pm+TxNzCRpKwJ5nR/iWlV6ztXpJaU/PhSst
         IeTQEb2ZPjqprHrtdbL8hYREC9+Wo8JCQ2sqt80HNd8qo+DPkLn2InLj9/uQn1gG1/
         gCEk5mRC7Zf8g==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id 22CB360E13; Mon, 11 Oct 2021 14:43:26 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 214665] security bug:using "truncate" bypass disk quotas limit
Date:   Mon, 11 Oct 2021 14:43:25 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: tytso@mit.edu
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: INVALID
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-214665-13602-ba1ppNLsCv@https.bugzilla.kernel.org/>
In-Reply-To: <bug-214665-13602@https.bugzilla.kernel.org/>
References: <bug-214665-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D214665

Theodore Tso (tytso@mit.edu) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|REOPENED                    |RESOLVED
         Resolution|---                         |INVALID

--- Comment #4 from Theodore Tso (tytso@mit.edu) ---
As Lukas said, "truncate" is not the only way to create sparse files.  And
there are many Unix / Linux programs that depend on the ability to create
sparse files, since Unix support of sparse files goes back at roughly 50 ye=
ars
(half a century).

The fact that clueless users / sysadmins might not understand basic Unix/Li=
nux
behavior is not a bug in Linux.   There are plenty of other ways that an
experienced sysadmin might shoot themselves in the foot....

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
