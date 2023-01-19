Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11CB86740E2
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Jan 2023 19:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjASS1E (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 19 Jan 2023 13:27:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbjASS1B (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 19 Jan 2023 13:27:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 220E594321
        for <linux-ext4@vger.kernel.org>; Thu, 19 Jan 2023 10:26:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A1BBA61D12
        for <linux-ext4@vger.kernel.org>; Thu, 19 Jan 2023 18:26:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 122DCC433F1
        for <linux-ext4@vger.kernel.org>; Thu, 19 Jan 2023 18:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674152818;
        bh=W0tu0+iOuCsuJ7EfMHfViJKpIy0ZUeO0zu3r8cwEaGs=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=B+cQXf4Cqc6qUg378mL1sxzXyM1wicBmAo5zQan4r0Yp0oeBw9qDdLmDZJ+/Bbf3x
         8Ll4hBwdqVJ7j0bbJvXw39PcIPTFtQckrthj3P4kajXDT08TGkbcdlt3YZkAQjBPKH
         YNSxMorb60v9BQEnNHL/baVr2Nfg0lf0w/cBJe0sNxiH/aNmzZEI+HffTJ2cJkFbHv
         hbDk6jFHofFf64ilmh1ZiZ9OxP/unwSGN9jGR6deWIJW8PFBTZcTLVDqupGs/Ik/t9
         Lpj67XHYPkNyM7QABzLhsCNHZhuexCyDAmrz5/Zk+47vECIgzNF5VI4DxhSYck/I76
         CcDCYzfb+oF0g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 0127FC43143; Thu, 19 Jan 2023 18:26:58 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 216953] BUG: kernel NULL pointer dereference, address:
 0000000000000008
Date:   Thu, 19 Jan 2023 18:26:57 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: gjunk2@sapience.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-216953-13602-6QrPx3oMmC@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216953-13602@https.bugzilla.kernel.org/>
References: <bug-216953-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D216953

--- Comment #3 from Gene (gjunk2@sapience.com) ---
Created attachment 303630
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D303630&action=3Dedit
log run rhought decode_stacktrace

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
