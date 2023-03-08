Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DBE06AFDC9
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Mar 2023 05:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjCHETg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 7 Mar 2023 23:19:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjCHETf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 7 Mar 2023 23:19:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 228839CFE8
        for <linux-ext4@vger.kernel.org>; Tue,  7 Mar 2023 20:19:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D518DB81BA3
        for <linux-ext4@vger.kernel.org>; Wed,  8 Mar 2023 04:19:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 70325C4339C
        for <linux-ext4@vger.kernel.org>; Wed,  8 Mar 2023 04:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678249171;
        bh=NIWjhRwoTFTzBOwH9THSXPJLNOZJKtZseVaZ2Rno1DE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=USVYabSlUh9dAva2Y0FyTARi3v/qXiJbvY4hccTbMN1VXo9Tk5ZQ8Lzpqsa3NIz24
         2dUV5R/t0SjyCYD5anHvEb9mOrn3EroI7xC9HzTi6vCiupiBIhoJ7l4vfQjpDhV0KP
         lqES7r646c/dxQ+THQllhgTXJT8hVQg7aNbdlOBMkBZHIS/f5K+OEZct1mhICDq/Dv
         UdETqxN3pIyAkqYq6fcpoKzNAJtsw971xc7wYh4zmBFRcKpDtGpGMleVwZGaa3kFzl
         ps8ZIsUeJXrZGCSY97KOWfC0k7zno0RvpVXXFe+GZrBFeoQsOpJsNpDpfGxm/4N9Ig
         GIBaCxIQ22Tdg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 570A0C43141; Wed,  8 Mar 2023 04:19:31 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 217159] WARN in ext4_handle_inode_extension: i_size_read(inode)
 < EXT4_I(inode)->i_disksize
Date:   Wed, 08 Mar 2023 04:19:31 +0000
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
Message-ID: <bug-217159-13602-2FFlZdwzkg@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217159-13602@https.bugzilla.kernel.org/>
References: <bug-217159-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D217159

Theodore Tso (tytso@mit.edu) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |tytso@mit.edu

--- Comment #3 from Theodore Tso (tytso@mit.edu) ---
I guess if you edit the subject line, bugzilla won't be able to thread the
reply.   It could use the in-reply-to header, but apparently.... it doesn't.

Reply and fix here:
https://lore.kernel.org/all/20230308041252.GC860405@mit.edu/

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
