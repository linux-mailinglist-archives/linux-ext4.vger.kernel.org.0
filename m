Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B95D7660D43
	for <lists+linux-ext4@lfdr.de>; Sat,  7 Jan 2023 10:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjAGJ0S (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 7 Jan 2023 04:26:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbjAGJ0R (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 7 Jan 2023 04:26:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E3660F7
        for <linux-ext4@vger.kernel.org>; Sat,  7 Jan 2023 01:26:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27D6A60A22
        for <linux-ext4@vger.kernel.org>; Sat,  7 Jan 2023 09:26:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 891DCC433F0
        for <linux-ext4@vger.kernel.org>; Sat,  7 Jan 2023 09:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673083574;
        bh=8GmV+fPvxiHAg1ZI1sGk42FtW0NrGWEoROROx5rBdR0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=XloWlqciVCGmVgv63WqRE12m6KbxStS3TJk23YabE5n2p6jckBF49eXhpyC1cu434
         j4zYOisFddkQ/GoZwEDGOkDtDSW9zYI3eiH+QGTUQEHrLEkTkyqE4E9bkL41OYNaM3
         yJf7bYTLD0DL4nMk3jFCBtdoA9xjQ0IEvXB3UnskpUXTsVusPwJPidociFmRw+Yu6M
         T0M0bt+Y88VjqaGfemr/QKN0RAgG9QajFm6NhdLuyPY3kKYmDJ6QvbOJrRT1pZX9Vz
         OZ4pbqOwbyV2a+XdNrFjEb3YywMHc+zbEuXkSqhzMb4xyptFT229EG5LFnYboFy58F
         HOTIZIg5WWalA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 78AB6C43143; Sat,  7 Jan 2023 09:26:14 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 216898] jbd2: Data missing when reusing bh which is ready to be
 checkpointed
Date:   Sat, 07 Jan 2023 09:26:14 +0000
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
Message-ID: <bug-216898-13602-JdZGM1YDOV@https.bugzilla.kernel.org/>
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

--- Comment #1 from Zhihao Cheng (chengzhihao1@huawei.com) ---
Created attachment 303544
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D303544&action=3Dedit
diff

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
