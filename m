Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26D6F58D982
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Aug 2022 15:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243777AbiHINki (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 9 Aug 2022 09:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243891AbiHINki (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 9 Aug 2022 09:40:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8902415FE6
        for <linux-ext4@vger.kernel.org>; Tue,  9 Aug 2022 06:40:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1266B6114D
        for <linux-ext4@vger.kernel.org>; Tue,  9 Aug 2022 13:40:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 71AAEC433C1
        for <linux-ext4@vger.kernel.org>; Tue,  9 Aug 2022 13:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660052436;
        bh=GsqDUB7pAYPJRokt0b8zNi6tKQREim5dtEzDGelKZi0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=TrTxU/PYNKJxLIH6WMvRHd2Ahdfs++m5tfJfg++CPoyzN5mrMPKxnprXTnciy210v
         bMjJQzwNYp/cEEGBu99odXzTfSCoOAZPjoAWaQYH2pR0hxNlpc0kPRTkYF+XGJZKtk
         pylTkhv4c2O5esaiNVkPyE2GrgJCp43ja4hOeYHRM0UPx6pVfI+Oqty9zK54nzuwqt
         T7tkij2Rnx4Nk5xuRA+Ot2t1PlANqdzLV7pjhQYGaTvh/U2aau9XVTQY2MHmFEiKTZ
         RV7m6wD579z7oaJCCsrlMIqCvAOFMI7BEPmDEvQd27EyQDMJnZT6HPazDklwYsIh/z
         LzPRRshWDNztw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 5EF75C433E9; Tue,  9 Aug 2022 13:40:36 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 216322] Freezing of tasks failed after 60.004 seconds (1 tasks
 refusing to freeze... task:fstrim  ext4_trim_fs - Dell XPS 13 9310
Date:   Tue, 09 Aug 2022 13:40:36 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: lenb@kernel.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216322-13602-rmOCrl6vUG@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216322-13602@https.bugzilla.kernel.org/>
References: <bug-216322-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216322

--- Comment #6 from Len Brown (lenb@kernel.org) ---
Is there an simple recipe to reproduce this failure?

Note that upon this 60-second timeout, the kernel aborts the suspend
and un-freezes user-space.  Well, what is running in user space
is the sleepgraph program with --multi, which saves the record
of the failure and immediately provokes the next suspend -- which works.

Did the act of unfreezing user-space result in progress,
or were we just lucky that the operation completed before the
subsequent suspend request?

Note that Rafael thought that the kernel timeout was 20 seconds,
not 60 seconds, and he's inclined to make it shorter, not longer.
(are we sure that this process is actually making progress,
 and not in some kind of deadlock that would persist no matter
 now long the timeout?)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
