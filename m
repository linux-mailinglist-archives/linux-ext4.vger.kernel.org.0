Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFEC674134
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Jan 2023 19:46:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjASSqG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 19 Jan 2023 13:46:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbjASSpk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 19 Jan 2023 13:45:40 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B516394320
        for <linux-ext4@vger.kernel.org>; Thu, 19 Jan 2023 10:45:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id BC322CE2597
        for <linux-ext4@vger.kernel.org>; Thu, 19 Jan 2023 18:45:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 07705C433EF
        for <linux-ext4@vger.kernel.org>; Thu, 19 Jan 2023 18:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674153934;
        bh=j7YP0Y0lUAOPseW6r1GzyWxelNV5e948LDu7FLKBEp0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=eOsD1fdbWwhOAHFDv3q/Bcv0gEYuwI5Vuqd6tCIb5gHVeZHvEVlVhuILhNSQCZMYe
         2FRgu7o4saRRXFtYzmnOIuiGUEeWbVA5eK7r2hwVIPYsIdgB/J61UVMkzCpdFyAm+D
         EUR+v5gnAVkEykInwimgTWhsUHiuZzRI4jNZ4jfvUCHvFmiALb5YSnPF0Za9kcS7Mf
         JKXMYarUOIaBbN72Z4UgwOsDPmDnrgsfv5GlzNYFxe37Ln5zdRwYeKlx411kI5rukb
         ubzHnJLx3z/0Aw3jl8jCA/nJZMfQ9xNGi6pqN0gJYfyIPtossR6fWMxiEkmtyc6M5M
         s+IK39Cd/JyPw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id EB51CC43142; Thu, 19 Jan 2023 18:45:33 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 216953] BUG: kernel NULL pointer dereference, address:
 0000000000000008
Date:   Thu, 19 Jan 2023 18:45:33 +0000
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
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216953-13602-aOUzGyBDvv@https.bugzilla.kernel.org/>
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

--- Comment #4 from Gene (gjunk2@sapience.com) ---
system also has 2 x 8TB usb drives using btrfs - but last read/write on that
filesystem was 7 or more hours before the crash.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
