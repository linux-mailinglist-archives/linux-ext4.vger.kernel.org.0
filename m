Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEC9C69C35A
	for <lists+linux-ext4@lfdr.de>; Mon, 20 Feb 2023 00:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjBSXQR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 19 Feb 2023 18:16:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjBSXQQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 19 Feb 2023 18:16:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1FD41A941
        for <linux-ext4@vger.kernel.org>; Sun, 19 Feb 2023 15:16:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F57360C75
        for <linux-ext4@vger.kernel.org>; Sun, 19 Feb 2023 23:16:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DA983C433D2
        for <linux-ext4@vger.kernel.org>; Sun, 19 Feb 2023 23:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676848574;
        bh=u7zOc80YCIIZHkFKO+nVSRYhy2/n8V8uSs9dOWD+15s=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=AMj/fdrZI4CP++pNZI02BCFIN7jPLSA+QmPLdq92GJb5DIPgb+Nb0DPGWBzRpRvE2
         Ryz9mQq9haHYyjIjdwLTGueSxq5cT0cZUm/BY7ElnO3rz9uLuSG7A+DOTQorydN3pI
         FrtmeC0sO4jEPtNKIBPoN27XcL6eFMptvz8ioyys+OU5nmMai3aGk92rae2ISHDsZX
         JPWv+OIjhLRe6VbPqb8SM3+/UibYN2v6eSjBKpl2LnrRL3fKBy3mYPJoo3BcAEV1n/
         xHbQSRZwA6HDl0e/VR5zMAKBwuixxJuM7QTWq/YW/xGjHW8uj4gXRShpYZGQLZbA7+
         2SS8wqH1madFQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id C5EC4C43144; Sun, 19 Feb 2023 23:16:14 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 215879] EXT4-fs error - __ext4_find_entry:1612: inode #2: comm
 systemd: reading directory lblock 0
Date:   Sun, 19 Feb 2023 23:16:14 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: tytso@mit.edu
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: INVALID
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-215879-13602-OnrqXzrHTo@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215879-13602@https.bugzilla.kernel.org/>
References: <bug-215879-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D215879

Theodore Tso (tytso@mit.edu) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |INVALID

--- Comment #6 from Theodore Tso (tytso@mit.edu) ---
Note that what you found in your stack exchange search was from five years =
ago,
and described a workaround in a Linux kernel versiojn 4.10.   In addition to
manually disabling APST (a quirk for a very specific Samsung SSD which has
since been added to newer kernels), other suggestions in the stack exchange=
 or
linked web pages included " removing SDD, blowing air into M.2 connector and
reinserting it back" and "switching off the 'UEFI Secure Boot' setting in t=
he
BIOS"

All of which is to say that the symptom is caused by an I/O error, and there
are many potential causes for an I/O error --- everything from missing quir=
ks
(to work around broken firmware / hardware design) to bad connections to
misconfigured BIOS settings to just plain broken hardware.

This is why blindly web searching based on symptoms can often lead to
misleading results; an abdominal pain could mean anything from indigestion,=
 to
a pulled muscle, to an infected appendix, to a heart attack.  It's also why=
 I
am not fond of people finding bug reports on the web and assuming that anyt=
hing
that has the same symptom must have the same root cause.....

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
