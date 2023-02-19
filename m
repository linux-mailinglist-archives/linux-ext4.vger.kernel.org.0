Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 354A369C0AC
	for <lists+linux-ext4@lfdr.de>; Sun, 19 Feb 2023 15:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbjBSOaO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 19 Feb 2023 09:30:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbjBSOaN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 19 Feb 2023 09:30:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C314310A87
        for <linux-ext4@vger.kernel.org>; Sun, 19 Feb 2023 06:30:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 73322B80943
        for <linux-ext4@vger.kernel.org>; Sun, 19 Feb 2023 14:30:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0DAB4C4339B
        for <linux-ext4@vger.kernel.org>; Sun, 19 Feb 2023 14:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676817010;
        bh=cidZt6Dmb5T4K4/EjZ0Y0kPeXuy9X0OXmkl9eshq+0M=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=fV0A/SFF28y6h+lHUpkBckh88n8aJ00eyZZS88EI94SFORZQUmg/1FwafZZjl38dJ
         2bZ8OWrm23O6SC0ZD0y1jIRhqaTxGP+LSeF3W9WVsrc526pQilNFsZ5Jnxbn95YlBu
         paG2hNAYVF0DKVldBa4MURSXnZF9vzMZMi4iIBIVA4CgveUce0jQSwcUxDQvtCyK7d
         fju1INMVk85H04ze5KSjhDMNyb3DIy4zJTxj4HQew4TwomDgy6kjAwfvDeyfdxtZH6
         MIRw8xK3WiQHn4lhWVTJmKcFPLoySsR3JOxS4dQ+9OdD9scK3yNuv69hIvyGzE64q1
         TrVdTonEdV96Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id E3F7AC43143; Sun, 19 Feb 2023 14:30:09 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 215879] EXT4-fs error - __ext4_find_entry:1612: inode #2: comm
 systemd: reading directory lblock 0
Date:   Sun, 19 Feb 2023 14:30:09 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: ionut_n2001@yahoo.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215879-13602-BHbUUrIQPI@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215879-13602@https.bugzilla.kernel.org/>
References: <bug-215879-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D215879

--- Comment #5 from sander44 (ionut_n2001@yahoo.com) ---
Hi,

I notice today this issue with 6.1.12 kernel version.

On Ubuntu Team, i view this:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1993205

But with my search i view workaround:=20
https://unix.stackexchange.com/questions/375450/random-ssd-turn-off-ext4-fi=
nd-entry-reading-directory-lblock0
https://askubuntu.com/questions/905710/ext4-fs-error-after-ubuntu-17-04-upg=
rade

Will try with this: nvme_core.default_ps_max_latency_us=3D200 for testing t=
his
issue and to see if it reproduces.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
