Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 449145876E4
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Aug 2022 07:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235711AbiHBFuf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 2 Aug 2022 01:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232951AbiHBFuf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 2 Aug 2022 01:50:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40DC1D300
        for <linux-ext4@vger.kernel.org>; Mon,  1 Aug 2022 22:50:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 80981B8190C
        for <linux-ext4@vger.kernel.org>; Tue,  2 Aug 2022 05:50:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 24B5EC433D6
        for <linux-ext4@vger.kernel.org>; Tue,  2 Aug 2022 05:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659419431;
        bh=eQyt5Sgogg7wABHQo6Dm2q583IiBJRlBIXUs8vdP6yA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=DxKRU8HiS7DixpHdsnJOJF4xvxcmxOQ+r+CQzwie0Yr2JtqUGc0RVuMIsvuJdJPjX
         Pm/XMJ9VkXYa91by2YIp6AxfmUuyd4nBw8Bj2uE0Zz9+f5w2QUkvPDAeink5tZ4AFR
         JWXZ8vNFBviFwgpJMtJgM9qN2JRZyAg+KWXUQ9coVCgiA7gSoZrNzLYPB77d0hrwYp
         IGwhc8sh9DL0hIXRDQ5h3bpdxin13kYjJiHkuJZ39jUmVZ0T8/SK4/GPpLj3BfG//J
         fc6K1Pdd5N3sVbYuqfMrL6xKyA+b1rQN8ZvkmqsENbwQlC0lX6OZur8JnWrTQMYMF5
         Wj6nGhoasl+vA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 16057C433E7; Tue,  2 Aug 2022 05:50:31 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 216317] "ext4: lblock 0 mapped to illegal pblock" after
 upgrading to 5.19.0
Date:   Tue, 02 Aug 2022 05:50:30 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: gerbilsoft@gerbilsoft.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216317-13602-ydfSdbxvo3@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216317-13602@https.bugzilla.kernel.org/>
References: <bug-216317-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216317

--- Comment #1 from David Korth (gerbilsoft@gerbilsoft.com) ---
Distribution is Gentoo Linux amd64, 17.1 hardened profile.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
