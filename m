Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9B7A7983CB
	for <lists+linux-ext4@lfdr.de>; Fri,  8 Sep 2023 10:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232924AbjIHINc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 8 Sep 2023 04:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbjIHINc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 8 Sep 2023 04:13:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8DE91BD3
        for <linux-ext4@vger.kernel.org>; Fri,  8 Sep 2023 01:13:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 71E8BC433CA
        for <linux-ext4@vger.kernel.org>; Fri,  8 Sep 2023 08:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694160808;
        bh=LMceoypSJiCGPw9QmJrzBJUpxTFn14EhvNGkDqVhINM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=piDGdUBcGCWzYMbPzEcHpN1z6GyqAQs3qjCdU1akBh+0sHHlrdGKHwypf5xP8hNTQ
         mTgUcEzJjdPo7js+dPfq+tD0U3YdjMasaFnPiF/XPaKdeqRMKhkQEEwayROifY3LKH
         cT8JbC1wWyGVtlrm4gZ/zMqMErwAoNyCxWgpo1GVsxJd5Vx11UmLwnFiRW1gKsIz0d
         6thORGtfD09zvDfP8pOzuD3AoDuOhBgfJX0ZYAPXPbSte3CMxMqijRewfTnxdDl/Up
         yr7ztvL3bcFVFvSyvb9agYsUr4bY87aTiZD1zk5qV4CaxvAxiEQVKVDfg14SiZzFHI
         r/mTGSkBssyUw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 604E7C53BD0; Fri,  8 Sep 2023 08:13:28 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 217888] jbd2: potential data lost in recovering journal raced
 with synchronizing fs bdev
Date:   Fri, 08 Sep 2023 08:13:28 +0000
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
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-217888-13602-Gg1cmGEyw1@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217888-13602@https.bugzilla.kernel.org/>
References: <bug-217888-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217888

--- Comment #1 from Zhihao Cheng (chengzhihao1@huawei.com) ---
Created attachment 305067
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D305067&action=3Dedit
diff

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
