Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 977B96BDE28
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Mar 2023 02:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjCQBdQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 16 Mar 2023 21:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjCQBdP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 16 Mar 2023 21:33:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B52F25C118
        for <linux-ext4@vger.kernel.org>; Thu, 16 Mar 2023 18:33:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B9DC6216D
        for <linux-ext4@vger.kernel.org>; Fri, 17 Mar 2023 01:33:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B3BF7C433D2
        for <linux-ext4@vger.kernel.org>; Fri, 17 Mar 2023 01:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679016793;
        bh=EprAlIyePPLVx+z2fZ6L3HiasFMh/piOeSXPdS0WhUQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=bX8ChPodCLjE52Z2BZhBs8pKz1YEMIaFO+hAem//m/hGo6bgD1FtXYhnODtdbC0Lz
         lljXOwHsRJ1gO/7kn7ozmwL59CpryMVZeYZo6gJ1Tu8n+2CPkzUbo+rwcdF7h6rwUY
         oH5WMhiuw3q6jJsPapFdKj0pjGLAZVzk77SwjyU6fguXX9aYYWnsVKKQ30gTqfAKE4
         wUyEt2n56vE9FZk3nhlo9RwAqziBdt+4CIOZRRyh4tzQvDLcsUq8l7qEm1Koq52qcC
         Z3oPXy2u0GuVCG3c5BEBcdjwzPayGTjeSkJ7CqNWx1pPUa3d1zpXEDub+tB0avYPMj
         y+WXRh9OZj7Hg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id A357AC43141; Fri, 17 Mar 2023 01:33:13 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 217209] ext4_da_write_end: i_disksize exceeds i_size in
 paritally written case
Date:   Fri, 17 Mar 2023 01:33:13 +0000
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
Message-ID: <bug-217209-13602-X38uiR3wv9@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217209-13602@https.bugzilla.kernel.org/>
References: <bug-217209-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D217209

--- Comment #2 from Zhihao Cheng (chengzhihao1@huawei.com) ---
Created attachment 303969
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D303969&action=3Dedit
a.c

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
