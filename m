Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57A186B8C6B
	for <lists+linux-ext4@lfdr.de>; Tue, 14 Mar 2023 09:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbjCNIEm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 14 Mar 2023 04:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjCNIEk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 14 Mar 2023 04:04:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D01CB67730
        for <linux-ext4@vger.kernel.org>; Tue, 14 Mar 2023 01:04:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 67955B818BA
        for <linux-ext4@vger.kernel.org>; Tue, 14 Mar 2023 08:04:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 16F96C4339C
        for <linux-ext4@vger.kernel.org>; Tue, 14 Mar 2023 08:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678781076;
        bh=a3IxNn6QTIG/bjGnNZ5RFeA8C3WHNvIEAFy+z9EKitk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=itnX19gp/JU/XJtmTNNK0JexkLfs7BYnRKuAhlIuA4UXTMagRkaTiV5pNMjimS8l6
         3Rf9VPJVh1VJDk0Q1Ks+nOFWlCNcLqUcRZbkh+jNS87XlHeiF4fkDsbAaq4skO3Y2W
         rEg59Na1JQYgqPyhoG71T3j/WURk6RDFOesLNflgGbK8N1oaGVzSq0TDRtQasYP02U
         bBIiPuTPOWDi9XW3FXdOAP5c15dmKCPfVmAmG9KKJ6uLLq4kZ2p0X0LdJSyaEnhkFc
         b21l68j7R/JIxP+tRbtRXjUdsLA1Tjx8uGtcsHQ//uvbyZRKXvcweHOe3EHA0YG28R
         N0LN/mu5jh7zA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id F262CC43141; Tue, 14 Mar 2023 08:04:35 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 217189] SATA HDD not detected
Date:   Tue, 14 Mar 2023 08:04:35 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: regressions@leemhuis.info
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217189-13602-3ZeCYBvXwC@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217189-13602@https.bugzilla.kernel.org/>
References: <bug-217189-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217189

--- Comment #3 from The Linux kernel's regression tracker (Thorsten Leemhui=
s) (regressions@leemhuis.info) ---
(In reply to Floki from comment #2)

> I am using pop os, so I guess the kernel is distro kernel.

So likely patched -- and in your case also tainted due to Nvidia's driver.
There are a few odd things here (why are there no ehci msg in the 6.2 log?)
that might or might not be due to config changes. Therefore I'd say it's
something you should report to your kernel vendor, e.g. PopOS. Alternatively
recheck with vanilla kernels (where the newer one uses a configuration deri=
ved
from the older one using "make olddefconfig"!) and report back here.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
