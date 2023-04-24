Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C3E6EC909
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Apr 2023 11:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbjDXJdu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 24 Apr 2023 05:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbjDXJdo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 24 Apr 2023 05:33:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6BC2213B
        for <linux-ext4@vger.kernel.org>; Mon, 24 Apr 2023 02:33:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7AFAC61F63
        for <linux-ext4@vger.kernel.org>; Mon, 24 Apr 2023 09:33:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DD9A0C4339B
        for <linux-ext4@vger.kernel.org>; Mon, 24 Apr 2023 09:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682328794;
        bh=fIi4f+IdIPsiNuMNt4frAFkEQ0Tib4u1S62Z1thrfjo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=SWqNSkfuS4/u4VVjpJSUvfb4JTWmkVneTJbyQ1FRyC7NyafHgJ8SLkqnJBg2hSkPo
         DFt23S58gfj9QaoVKckr3h2vf7VuRbfgRyTVY5bvnAsa4/7rGLbh979HHmD6XZpsMQ
         DrrUi1t1ZwSkYF1fDzyyOhk8y7Ow4o62HG+xH7EVK7tZuFSBSg1unELdpTLSuYcUZN
         fgZWSUBqeXXAhp52RMgQniebf4ySV2Yp8zxX90CXy4NftTGWsxfWC6i9aaRpN7vJFD
         Dn0w6HA9xJz7F0fnlbEb/3513hRWJ+Sn2bCOGolepPnrcgZvAfSJB8BK6RkQ24orU7
         EaAnUYx6B6szg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id CE8C2C43143; Mon, 24 Apr 2023 09:33:14 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 217363] jbd2: Data missing when reusing bh which is ready to be
 submitted in checkpoint
Date:   Mon, 24 Apr 2023 09:33:14 +0000
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
Message-ID: <bug-217363-13602-kyMOf7mP3m@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217363-13602@https.bugzilla.kernel.org/>
References: <bug-217363-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217363

--- Comment #2 from Zhihao Cheng (chengzhihao1@huawei.com) ---
Created attachment 304182
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D304182&action=3Dedit
diff

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
