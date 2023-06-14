Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5A472F91C
	for <lists+linux-ext4@lfdr.de>; Wed, 14 Jun 2023 11:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244006AbjFNJ2k (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 14 Jun 2023 05:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244056AbjFNJ2S (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 14 Jun 2023 05:28:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F7C81FE4
        for <linux-ext4@vger.kernel.org>; Wed, 14 Jun 2023 02:28:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E91F7638D4
        for <linux-ext4@vger.kernel.org>; Wed, 14 Jun 2023 09:28:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 59678C433C0
        for <linux-ext4@vger.kernel.org>; Wed, 14 Jun 2023 09:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686734892;
        bh=Dyzf3Wv+/aBnfMN6vW3klVJuZLS2IEai/tEKwDAvlwg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=cwYZwMwUkeWIKAi/bEm1gNWqiKqXJH6KomJWlNkL18s5oLZIlq0VEI4FxvweOodyx
         6UYJh3MLDSgDfR1uVnudFt4eqxIH+nKYe2eeWPNHwLSaekysHvsMt9WNPujuIhYe0K
         wFzQr2vTcY+QfAyGp+EEtmGTgJdNrs50O9Fvjk0ipB0/W+7RU94yMp6/QbLf0iAyR1
         YqPZU6XMdGESK+vR4oS1zFVRmpg1Cr7irNGVN/Dezh8CmzFfRy+vDu9wE0JikX8l4H
         1YGF/NifZwCOyQy/awFVEpRK9zCOV2Q24MgMCZjnzxM8FVw8C7yRh7EvtLAh9drjMX
         qQFzlp2jU0wqQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 4186DC53BCD; Wed, 14 Jun 2023 09:28:12 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 217551] Unable to umount block device
Date:   Wed, 14 Jun 2023 09:28:12 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: WILL_NOT_FIX
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-217551-13602-Q7lWxKHlxy@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217551-13602@https.bugzilla.kernel.org/>
References: <bug-217551-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217551

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |WILL_NOT_FIX

--- Comment #3 from Artem S. Tashkinov (aros@gmx.com) ---
Please report it to the vendor.

This kernel release is not supported by the kernel dev team.

If this is reproducible using any supported kernel versions at
https://www.kernel.org/ please reopen this bug report.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
