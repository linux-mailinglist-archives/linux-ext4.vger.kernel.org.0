Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B186F63A1B4
	for <lists+linux-ext4@lfdr.de>; Mon, 28 Nov 2022 08:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbiK1HAY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 28 Nov 2022 02:00:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbiK1HAF (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 28 Nov 2022 02:00:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC9C8F1
        for <linux-ext4@vger.kernel.org>; Sun, 27 Nov 2022 22:59:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 00821B80B8E
        for <linux-ext4@vger.kernel.org>; Mon, 28 Nov 2022 06:59:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9D86CC433D7
        for <linux-ext4@vger.kernel.org>; Mon, 28 Nov 2022 06:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669618744;
        bh=wBshnehGRds8bfI/rVEglEFMobWHTMlZYpCVgedJYQs=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=PV2/lIXYGUfLFFvKO8wfOFZoJSI7VjM9dr45aZz5XI8lNeRV9VC+ryKcom+g4TY05
         5zHrf2eQ+OhlLliCCQvFOMMRWXbir/nMkbsOK2IgsB9UbJbkTEtuNr4FG7jPZtHDR9
         vznQNGkJx2Gtamel906Rks4oI3Ri6TLpDpi587Xe3CeYgY/fs3rvwPp7Twd4UoBs7m
         cYO1incCHt4ufI9B9NiYytiBBjbnqsfNwo2rZ5LGSos8GqMsbzNu5Auo9Xsy5Wn0Nq
         pLwhso5GOZBaKkLEQ7EUuOR30ExyqFZcNpDtMDQh3UKwRdGMr7gIwPT11TkQrG+rA5
         v+Ln9hVl07GvQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 8800DC433E6; Mon, 28 Nov 2022 06:59:04 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 216714] Issue with file system image created with mke2fs
 parameter -E offset
Date:   Mon, 28 Nov 2022 06:59:04 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: lczerner@redhat.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: INVALID
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216714-13602-DUV8LaRlRw@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216714-13602@https.bugzilla.kernel.org/>
References: <bug-216714-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D216714

--- Comment #3 from Lukas Czerner (lczerner@redhat.com) ---
Hi,

that's a good question. I don't know of any existing tool that could do the
scanning for you. You can either put something together yourself, or you co=
uld
use blkid with --offset argument and try to guess the offset. I don't think
there is any better way other than scan the beginning of the device looking=
 for
file system signature stored in superblock.

-Lukas

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
