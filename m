Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E80377CE94A
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Oct 2023 22:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbjJRUpb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Oct 2023 16:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232008AbjJRUp2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 Oct 2023 16:45:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E0618A
        for <linux-ext4@vger.kernel.org>; Wed, 18 Oct 2023 13:45:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3F316C433C9
        for <linux-ext4@vger.kernel.org>; Wed, 18 Oct 2023 20:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697661921;
        bh=5jKcwuYsxEDpOU006K199Mx9gnb6JygeMQh6ot9INvA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=BQjmwVV/u/iqrB1SVVgUzClVIwC7QCg8+OMR6MVk+HQgQKKE6w8Ybj74neDg2pppp
         KrwlnyDLTCalZUYSI6aMA1ClCWLEigzDD+PcKA9B1csptXgLG1QAkqmZKJVVDYY3WE
         kd/MSrC7xW3GR6aDW2pGXzQshmIoqMSUA2kjm9bnWGQw1v06dphcQFuv98tBFAnlNb
         9Oi/ffuJTpaVTrJmUP05PzHy6D8pnQ4lILlULGPOKb1Pk8Z0sKQNShkKHw/sFngw9u
         atqmvrTaTD0DVd1dlBbLzwI0Ctm8wf8CxGxP6O4BrlyMgwWyZt5OlITtEtysUZQy09
         9H5QIq++cqhFw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 27F0CC53BD2; Wed, 18 Oct 2023 20:45:21 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 218011] ext4 root filesystem related hangs on 6.5 kernels
Date:   Wed, 18 Oct 2023 20:45:20 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: jaak+bugzilla.kernel.org@ristioja.ee
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218011-13602-sMmGLzd1fa@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218011-13602@https.bugzilla.kernel.org/>
References: <bug-218011-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218011

--- Comment #7 from jaak+bugzilla.kernel.org@ristioja.ee ---
I'm not running anything special on the server, it is a KVM/libvirt host wi=
th
only a few VMS, none of which use the root filesystem for storage. Besides =
that
it is only the usual set of system services and ssh for admin access, so I
think most writes to the root filesystem are due to logging.

I compiled and rebooted to a new the 6.5.7 kernel with only
CONFIG_DEBUG_INFO=3Dy, CONFIG_DEBUG_INFO_DWARF5=3Dy and
CONFIG_DEBUG_INFO_COMPRESSED_NONE=3Dy added, but the issue has not yet
re-occurred during the almost 3-day uptime.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
