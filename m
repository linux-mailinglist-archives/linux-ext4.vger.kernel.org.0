Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D49B150D829
	for <lists+linux-ext4@lfdr.de>; Mon, 25 Apr 2022 06:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238561AbiDYEPX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 25 Apr 2022 00:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241015AbiDYEPH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 25 Apr 2022 00:15:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E464E6E
        for <linux-ext4@vger.kernel.org>; Sun, 24 Apr 2022 21:12:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1269E6100A
        for <linux-ext4@vger.kernel.org>; Mon, 25 Apr 2022 04:12:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 708DCC385AD
        for <linux-ext4@vger.kernel.org>; Mon, 25 Apr 2022 04:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650859923;
        bh=G8LVGWOshUroQS+5AQRyCd2PifSquO7wdNh5MPIXWKc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=vIjuj5d+sXuN/dxQlIsF6psmrskDOzCGaQkrq8UDgJlqB0u+Mknz9eQQI1uFP6GZj
         Qlzo1L//PMyDm/7X/r5sdKmYlNWmrJ5Bqz6rcs5k9xhrwff75HRpkUu74zfmWs8frA
         3jJZ5GLT3aF48nT9Vb3emQDouKEbMws53usJtDLDzUiL2A5Drov0AoKS7c96TLtpAx
         wd09j6PDac0vdFrUIqBtWqZBRyWtdf3hI8mppsyhkl/hKTyFBtP5whBuWyn2zYgFi7
         7eannFKX+pnbc98ZCmB7H004yROEmfxUTb1xuDnF+IAVwroaRz+/FV0dgukexv+EWm
         WQwPvpU7yD3Iw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 501C5C05FCE; Mon, 25 Apr 2022 04:12:03 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 215879] EXT4-fs error - __ext4_find_entry:1612: inode #2: comm
 systemd: reading directory lblock 0
Date:   Mon, 25 Apr 2022 04:12:03 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: tytso@mit.edu
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-215879-13602-hayy4Pm3Jk@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215879-13602@https.bugzilla.kernel.org/>
References: <bug-215879-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
                 CC|                            |tytso@mit.edu

--- Comment #3 from Theodore Tso (tytso@mit.edu) ---
We should really improve the error message; what this indicates is that whi=
le
trying to read from a directory, ext4 received an I/O error from the storage
device:

                wait_on_buffer(bh);
                if (!buffer_uptodate(bh)) {
                        EXT4_ERROR_INODE_ERR(dir, EIO,
                                             "reading directory lblock %lu",
                                             (unsigned long) block);
                        brelse(bh);
                        ret =3D ERR_PTR(-EIO);
                        goto cleanup_and_exit;
                }

I'm not sure why systemd is trying to read so many directories, and why you
aren't seeing any I/O error messages logged on the console.  At a guess, the
block device has completely failed, and there were messages about the unfol=
ding
disaster that has since scrolled off your screen.

Bottom line, this is very likely an hardware problem of some sort.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
