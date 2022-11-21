Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5021631C26
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Nov 2022 09:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbiKUI4m (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 21 Nov 2022 03:56:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiKUI4m (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 21 Nov 2022 03:56:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995901EF
        for <linux-ext4@vger.kernel.org>; Mon, 21 Nov 2022 00:56:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 364DA60F43
        for <linux-ext4@vger.kernel.org>; Mon, 21 Nov 2022 08:56:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 95B97C43470
        for <linux-ext4@vger.kernel.org>; Mon, 21 Nov 2022 08:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669021000;
        bh=NJ7jnyqo07mFR9aduk5WqNkWSJssj2vK2EPITiEX73Y=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=HqifmTsEbBCO9BiBldVpLkv9/o/3s8w2Dzo5c2NAOfs2xJ1pMsQERpi3L9fdMqjQf
         vVduXYl3t+pEd2xgNTP0oqHyQivVD/TqUvfjlzhnplwCuasLTotgGXDPWzBYC+EWTu
         upFnbIQuBmdMRC8Qac+ThJLfZIyiyl8nOM+7NYZBdLK317zjonQN9SaliaRdobxf8u
         fYAws3oKK4U9ZIlZSKlju2rd5J2nHKUZ1ZK95boPCiDghJ4UzJSREuzmFr8OcejsqV
         EFdm6dGvQNstRxdzcRt97zwXNTxHfiG0sP5HehtBwH1aLH9BsjijG6GazjiCsuhjL5
         InnyWTniK92CQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 81C6CC433E7; Mon, 21 Nov 2022 08:56:40 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 216714] Issue with file system image created with mke2fs
 parameter -E offset
Date:   Mon, 21 Nov 2022 08:56:40 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: lczerner@redhat.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-216714-13602-noe4b8eF4L@https.bugzilla.kernel.org/>
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

Lukas Czerner (lczerner@redhat.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |lczerner@redhat.com

--- Comment #1 from Lukas Czerner (lczerner@redhat.com) ---
Hi,

the -E offset=3D10 creates a file system that is offset by 10 bytes from the
beginning of the device or a file (as is written in the man page). It is no
wonder then that the tools can't recognize the file system on the device or=
 a
file because the super block is not where it should be - it is offset by 10
bytes.

If you want to use such a file system you have to present it to the other
tools, or even kernel, with the correct offset. It is not going to be
automatic.

So for example this works:

mke2fs -q -t ext4 -E offset=3D10 image 500M
sudo losetup -o 10 --show -f image
/dev/loop0
sudo e2fsck -f /dev/loop0
e2fsck 1.46.6-rc1 (12-Sep-2022)
Pass 1: Checking inodes, blocks, and sizes
Pass 2: Checking directory structure
Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Pass 5: Checking group summary information
/dev/loop0: 11/128016 files (0.0% non-contiguous), 26684/512000 blocks

I hope it helps.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
