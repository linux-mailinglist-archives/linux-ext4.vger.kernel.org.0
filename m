Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D14E6ABB80
	for <lists+linux-ext4@lfdr.de>; Mon,  6 Mar 2023 11:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbjCFKQc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 6 Mar 2023 05:16:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbjCFKP5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 6 Mar 2023 05:15:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C589F25B81
        for <linux-ext4@vger.kernel.org>; Mon,  6 Mar 2023 02:15:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EE71DB80D7A
        for <linux-ext4@vger.kernel.org>; Mon,  6 Mar 2023 10:15:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A4EB2C43446
        for <linux-ext4@vger.kernel.org>; Mon,  6 Mar 2023 10:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678097725;
        bh=VeHRse/mm59vdaNXb/w7eApkpE9KyvX701oRkjvARmA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Y6PcXYHwQ3fWi0LWAOGn4iF3Ks+hPwwAhOEYvTlCaCsTb91U1h1h0c6Mer7X/xnBk
         g0K3tlA4CLbcJc2EchWVd/n/+FbQrTT5ar9ZeWAQjjB0hFK2OQn7RTB7RQ3Mi8YRXB
         HFk89pkhMo09wPI1BZGzh7ZOCBkP9gCbxPh0Y81pxOaBjrzH3EaFc6pCxpPiqESBcC
         BmsFzSbR42M5LRBjbh2ICXrQFjMAsKsA47BKg+J48caG3T5JSm/Q9E0V4T0IAWpRGg
         NUc4BChrUxplRiZDJg19KXfOG0LxXYIxOQhGNVODMQRRLotP3ZYdL0o33IAZ998h6b
         68YJYxCfpFB0Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 8D169C43145; Mon,  6 Mar 2023 10:15:25 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 217145] Feature request: I need very long directory and file
 names
Date:   Mon, 06 Mar 2023 10:15:25 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: kernel@nerdbynature.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-217145-13602-xUjOe0PCqO@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217145-13602@https.bugzilla.kernel.org/>
References: <bug-217145-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D217145

Christian Kujau (kernel@nerdbynature.de) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |kernel@nerdbynature.de

--- Comment #1 from Christian Kujau (kernel@nerdbynature.de) ---
Ext4 (and Btrfs and XFS too) supports file names up to 255 bytes long. How =
long
do you need a file name to be? That 1-3 KB refers to....a list of files, or=
 the
actual file name length? I'm interested in the actual use cases for this. A=
lso,
what's that name of the torrent client that magically truncates file names
here?

$ mkdir -p $(perl -e 'print "a"x255')/$(perl -e 'print "b"x255')
$ touch $(perl -e 'print "a"x255')/$(perl -e 'print "b"x255')/$(perl -e 'pr=
int
"c"x255')
$ find a*
aaaaaaaaaaaaa[...] well, you get the idea :-)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
