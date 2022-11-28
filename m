Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F96B63B4BF
	for <lists+linux-ext4@lfdr.de>; Mon, 28 Nov 2022 23:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233919AbiK1WUe (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 28 Nov 2022 17:20:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234148AbiK1WUd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 28 Nov 2022 17:20:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D7A3122B
        for <linux-ext4@vger.kernel.org>; Mon, 28 Nov 2022 14:20:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 027E1614AC
        for <linux-ext4@vger.kernel.org>; Mon, 28 Nov 2022 22:20:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 66E0FC433C1
        for <linux-ext4@vger.kernel.org>; Mon, 28 Nov 2022 22:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669674031;
        bh=wGL+PpmBTLz+Bcdaf+g38b7JzfxOEuNxoZOoq5poqAE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=doe1rNoq+/cb2WzLcz8d3CX5ZqLb7+9kXA8CaJqW+nC0pzaA/kddYuw1tTKtqrOvS
         M6A8BfK0mjVVZKvo4O5qZ9FNzxwLbSApFUR9JZzVQvclBLfUYVLBJ+8aliv6gYbtrY
         Xntun8R1znd0Y9QregueAWqQhENRrfdrGC+Itm4Yh5lzBLmVRiGrcJavYA/a7KJ078
         PNO34iFdG7HRBzTYZ5zP2Zd6eVdKIB0iPjP0tQktsO5bSVf8iPGtYdKeLwtjXCG0f+
         QhIcYqvv5ZC9C67rTG6NZSurnnFx5G9iqhPSGhuWz0j92OQ4BIFLas+Im7FSEpdaqU
         kQJYsgbe7Rj9w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 49ACBC433E6; Mon, 28 Nov 2022 22:20:31 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 216541] FUZZ: general protection fault, KASAN: null-ptr-deref
 at fs/ext4/ialloc.c:ext4_read_inode_bitmap() when mount a corrupted image
Date:   Mon, 28 Nov 2022 22:20:31 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: tytso@mit.edu
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-216541-13602-xpOUNw0B8F@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216541-13602@https.bugzilla.kernel.org/>
References: <bug-216541-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216541

Theodore Tso (tytso@mit.edu) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |tytso@mit.edu

--- Comment #1 from Theodore Tso (tytso@mit.edu) ---
I've done some analysis on this failure and what is going on is the followi=
ng.

1)   The journal inode in the fuzzed image is the normal journal inode, #8.=
=20
HOWEVER, after the journal is replayed, the journal overwrites the superblo=
ck
with new one where the journal inode is different; it is now #32.

2)  Next, we set up the set of static metadata blocks ("the system zone") t=
hat
should never be used by any data blocks in fs/ext4/block_validity.c.    This
includes the blocks used by the journal inode (which never change while the
file system is mounted).  In order to reserve those blocks in the system zo=
ne,
ext4_protect_reserved_inode() fetches the journal inode using ext4_iget(), =
and
then later releases it using iput().

3)  This would be fine for a valid file system journal, but after the journ=
al
replay, the s_journal_inum now has 32.  And inode 32 has an i_links_count o=
f 0.
  That's a problem, because now when we call iput(), since the VFS layers s=
ees
that the links count is zero, it calls evict() so that the inode can be
deallocated.   And at this point in the file system mount operation, we're =
not
set up to deallocate any blocks or inodes.  And this is what triggers the N=
ULL
pointer dereference.


Fixes:

FIX A)  In ext4_iget(), if we are getting a special inode, the links count =
must
be > 0.  If not, when that special inode (whether it is the root directory,=
 the
journal inode, or the quota inode) is finally released using iput, the syst=
em
will attempt to deallocate the special inode, with the resulting hilarity
ensuing.   So if i_links_count is 0, we should set the returned inode to be=
 the
bad inode, and return -EFSCORRUPTED.

FIX B)   In ext4_check_blockref(), we skip all of the checks if the inode in
question is the journal inode.   We shouldn't check to see if the journal's
blocks overlaps with the metadata blocks (which include the journal inode, =
so
it will always overlap with itself) --- but we should check to make sure the
block number is valid and does not exceed the file system limits.   This is=
 not
critical for fixing the bug shown here, but it does add a missing check whi=
ch
was unnecessarily exempted by commit 170417c8c7bb2 ("ext4: fix block validi=
ty
checks for journal inodes using indirect blocks").

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
