Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 016B16B8ADD
	for <lists+linux-ext4@lfdr.de>; Tue, 14 Mar 2023 06:55:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbjCNFzL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 14 Mar 2023 01:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjCNFzK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 14 Mar 2023 01:55:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F18719129
        for <linux-ext4@vger.kernel.org>; Mon, 13 Mar 2023 22:55:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D6622615DD
        for <linux-ext4@vger.kernel.org>; Tue, 14 Mar 2023 05:55:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 40BA7C4339E
        for <linux-ext4@vger.kernel.org>; Tue, 14 Mar 2023 05:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678773304;
        bh=+Ji1HHFs2mY7slprCv55ZHvgK3gOzfNSLKq8kMB2p98=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Gx77mGF1axgK1V8Z0eqVT7+tem/0Fxk13IKZTkGVHz+MpSCh4OA2GPwc8aLV7nFce
         +1RmT5oqBpYIVBo3+Lsy8bVzwEKPIuMVPl5jGgxb9iKKX4UzAoAfVomTAo48eAYchG
         boenI686fD1turdVGky3I6dZXgnOEUh2eob0d0rs/Vo6ahFmsWClS/VMNNlrkDSoaL
         Oe4vx3hci24tiMNOW3tiLZHqk0d7VVOi5eCgobTBhHLW5of3TEdlKjeM3FwxY/LpLg
         eg4YLsN//2j2bBHEXbc+4TxGvbfN58cdNQiGYwq13d/24NC74NU9Z1QmG+UL5x+k59
         nbC+9/MtCuzww==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 32E00C43143; Tue, 14 Mar 2023 05:55:04 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 217189] SATA HDD not detected
Date:   Tue, 14 Mar 2023 05:55:04 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: coder.abhijit90@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217189-13602-KePUPo040d@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217189-13602@https.bugzilla.kernel.org/>
References: <bug-217189-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217189

--- Comment #2 from Floki (coder.abhijit90@gmail.com) ---
Here is dmesg outputs
6.0.12 -> https://pastebin.com/d6mYMVcR
6.2.0 -> https://pastebin.com/2kgrxkse

I am using pop os, so I guess the kernel is distro kernel.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
