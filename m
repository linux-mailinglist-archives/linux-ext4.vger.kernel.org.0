Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46DEC7C9AE9
	for <lists+linux-ext4@lfdr.de>; Sun, 15 Oct 2023 21:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjJOTGf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 15 Oct 2023 15:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjJOTGe (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 15 Oct 2023 15:06:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 934E9C5
        for <linux-ext4@vger.kernel.org>; Sun, 15 Oct 2023 12:06:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3FD77C433CB
        for <linux-ext4@vger.kernel.org>; Sun, 15 Oct 2023 19:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697396792;
        bh=3+hqk5hn4BpMotv9H/yuIHv2sIcrLzkaHVdVIqdAR30=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=T+vOMS4i5/HZp909pfFfUuAA+CI/5CwF/+GO4w6X3+IGch2/k28/pjOj8MMQrQBPR
         pHyhjwfbU+8hwXgZAAFpc54q7HGzdShTFMKRbU/1zXBSVhH4yuaNs7Ll819qHQ8QOz
         eKnoBCO75C9mcZwWmuSkl7jzNwB7Lukt9C9v1zRejOfb8Zp5HiXBWelQYB6kG0iUIx
         rLAVhLXVAAKCry0AB/tJ5GjR0csI4P0VS9aTfgsC5tk3y29pLFOAlamLb9iXNWmZjk
         siob2/Up7qcCbU4PLZilEcogv+yPW4PEARxBzdbSk2kNtQ4Z45lsi0RtiFN1vbpayx
         +a3UN0tRaWpvQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 25C4DC53BD2; Sun, 15 Oct 2023 19:06:32 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 218011] ext4 root filesystem related hangs on 6.5 kernels
Date:   Sun, 15 Oct 2023 19:06:31 +0000
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
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-218011-13602-6XbB1nqgps@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218011-13602@https.bugzilla.kernel.org/>
References: <bug-218011-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D218011

Theodore Tso (tytso@mit.edu) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |tytso@mit.edu

--- Comment #6 from Theodore Tso (tytso@mit.edu) ---
It would be really nice to get a translation from the stack trace offsets to
line numbers, but what appears to be happening is that we're starting a jou=
rnal
commit, and to complete the journal, since we are in the default data=3Dord=
ered
mode, we call ext4_journalled_submit_inode_data_buffers(), which in turn ca=
lls
write_cache_pages() to flush out modified data blocks associated with an in=
ode
which had newly allocated blocks (so that we don't accidentally expose stale
data blocks if there is a crash, which is a guarantee of data=3Dordered mod=
e).

The write_cache_pages() function is then calling some function in mm/filema=
p.c
(this is where a line number translation would be happy), which calls
folio_wait_bit_common(), which presumably is waiting for some memory folio
which is undergoing writeback, or otherwise busy, to complete.   This then
calls io_schedule() --- because we're waiting for some I/O to complete, and
this apparently never completes, thus stalling the jbd2 commit operation, a=
nd
then all of the other processes which are trying to make changes to the file
system are waiting for the commit complete, leading to all of the other sta=
ck
traces.

The question is why is this happening on your system?    It could be becaus=
e of
some kind of missed I/O completion interrupt, or some other problem in the
block device layer or NVMe driver ---but normally if that were the case, th=
ere
should have been some kind of kernel log messages from those parts of the I=
/O
stack.   Were there any that you could see (that perhaps were excerpted out=
 in
the bug report, since "obviously" it was assumed this was an ext4 problem, =
as
opposed to ext4 simply being an innocent victim of problems lower down on t=
he
storage stack?

The other question that might be worth asking is what sort of workload does
your server run, and how might this be different from what other users migh=
t be
doing, or what we exercise with out regression tests?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
