Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4C31683211
	for <lists+linux-ext4@lfdr.de>; Tue, 31 Jan 2023 17:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbjAaQBp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 31 Jan 2023 11:01:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjAaQBp (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 31 Jan 2023 11:01:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B1747EC3
        for <linux-ext4@vger.kernel.org>; Tue, 31 Jan 2023 08:01:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8E3FAB81D6E
        for <linux-ext4@vger.kernel.org>; Tue, 31 Jan 2023 16:01:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 43531C4339B
        for <linux-ext4@vger.kernel.org>; Tue, 31 Jan 2023 16:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675180902;
        bh=Dnla4srWPYQOquzKDPc+fjlyFd/TyE7Ugi+DK531t9U=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=f5ceYXYUK3LU6b2ggMzSqdXLD1tdtrxFP9Ad23WXIJYrlKUPJptuTc5bxy8t9g0/S
         wjBjnXs+EidbPr2xlh+ah/OBObDFpqmP7pFnaeHxwvLVUNyc/+ya2Y7zzI5EQZIgcY
         PrBSDfmM4istPKFsKbV1J8FBkAxpK3P2ZzAEEpm/NIf9/KnFUbB1X5Gbl5fd20QmqQ
         H/18oG2Y18YDRd3hbBB0kG+QJ4ei3Hdf4mgjTXTtGpSvBl5F2rkZa/APjyZ4fd8xdV
         tU806xvxbeu+ppb0DWxjEjUyi6FXUuUFSipEsaQAi6S2zHMh7LH4pKvJJby9jfbdcj
         ZaP1J1UxhR/XA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 265FCC43144; Tue, 31 Jan 2023 16:01:42 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 216981] Online file system resize stuck for ext3
Date:   Tue, 31 Jan 2023 16:01:41 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext3@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext3
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: trivial
X-Bugzilla-Severity: high
X-Bugzilla-Who: tytso@mit.edu
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: INVALID
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext3@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status cf_tree cc resolution
Message-ID: <bug-216981-13602-ChatvmM31I@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216981-13602@https.bugzilla.kernel.org/>
References: <bug-216981-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D216981

Theodore Tso (tytso@mit.edu) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
               Tree|Mainline                    |Fedora
                 CC|                            |tytso@mit.edu
         Resolution|---                         |INVALID

--- Comment #1 from Theodore Tso (tytso@mit.edu) ---
This is a bug report for a Red Hat kernel, not mainstream.  It's also as a
result, an absolutely antique, antedeluvian kernel from an upstream kernel.=
=20
Please report this problem to Red Hat, and they will provide support --- not
upstream maintainers.

Alternatively, please try to see if the problem can be replicated on the la=
test
upstream kernel.  If it can be, feel free to open a new bug and specify an
upstream kernel version in the bug report.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
