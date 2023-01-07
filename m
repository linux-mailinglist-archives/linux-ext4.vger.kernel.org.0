Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 582E7660D45
	for <lists+linux-ext4@lfdr.de>; Sat,  7 Jan 2023 10:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbjAGJ1m (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 7 Jan 2023 04:27:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbjAGJ1l (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 7 Jan 2023 04:27:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29582E9
        for <linux-ext4@vger.kernel.org>; Sat,  7 Jan 2023 01:27:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6A7B2B81EEC
        for <linux-ext4@vger.kernel.org>; Sat,  7 Jan 2023 09:27:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1FB61C433EF
        for <linux-ext4@vger.kernel.org>; Sat,  7 Jan 2023 09:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673083658;
        bh=LgVXeBGOvzLuSUPSEv2O6Z3rA/uimu4Lt2ycGTOetGg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=cTSdvtxi3OGad2Zaw69ARXH49a3aJ1V7ZnwLQw+WsRSyrxXhGvLeqTgZe1mHLadS6
         mdsGkHpwVeEBrJIjJlSAMgeuioQzub3neI5xjb0id/btmtYrtcCfRFMV1R+6QE3+9f
         y6s2Lzre6+r5hCi8Vz6wZwYMOWoiiaNXr631IYkWusuZOYNcZIJPVdihpMqmYiAh3a
         WHxiLk9+GlHsVKMrgbRSfALyWCDemFgZiuxCzXZpOE5sSDlrZ7NLa0dKKSMw4QkD+G
         Eb5KNwK2jWil3gEmEolowfHcnrkWAr1cHcfQljvmcTtQSg25dpvLfAywywdmlZsBu4
         G45/gRH2hMdYA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 0FD47C43142; Sat,  7 Jan 2023 09:27:38 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 216898] jbd2: Data missing when reusing bh which is ready to be
 checkpointed
Date:   Sat, 07 Jan 2023 09:27:37 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: chengzhihao1@huawei.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-216898-13602-qrNtOjj9rx@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216898-13602@https.bugzilla.kernel.org/>
References: <bug-216898-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D216898

--- Comment #3 from Zhihao Cheng (chengzhihao1@huawei.com) ---
Created attachment 303546
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D303546&action=3Dedit
test.sh

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
