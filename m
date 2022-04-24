Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C20E750D2CE
	for <lists+linux-ext4@lfdr.de>; Sun, 24 Apr 2022 17:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233587AbiDXPiC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 24 Apr 2022 11:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240142AbiDXPfA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 24 Apr 2022 11:35:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC56170E3F
        for <linux-ext4@vger.kernel.org>; Sun, 24 Apr 2022 08:31:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2CEA561014
        for <linux-ext4@vger.kernel.org>; Sun, 24 Apr 2022 15:31:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 898ECC385A9
        for <linux-ext4@vger.kernel.org>; Sun, 24 Apr 2022 15:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650814318;
        bh=unQ0QExWORU4JrIcqdkqZdwO69fs2AaObddecH7yrSo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=PpDX3GrKFOSA5zwEdbxGzhVOIeTjnXZPACK9eKHMKGMo5Q99GvPsbwN2WusxHd6RG
         wTVCVgRczE+KYRDN6Ba80mQI7HV2rL1Jbv8o0gEDAJMMWzftQleYFyVfykLzfROQtG
         TQHT66FZjKIr+BNv/pClU51j91AZwMLplH1+tBk1fSQ3ZsokHk2dO2I7ZbTnUOl243
         OmWUm37GEUNYfX6gJ7fAW7ArMrR5qJhkCGCyCaT1+Tg+KEyzvR4dBL+hvWEmTUQkEs
         iKycj+qOvvaBTOCMpkzRK0D3PfRB/02bjN5PcZapHK04iMOrZItT6MPBmXG7FMjzSV
         WzTNyynTIgAZQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 713A1C05FD6; Sun, 24 Apr 2022 15:31:58 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 215879] EXT4-fs error - __ext4_find_entry:1612: inode #2: comm
 systemd: reading directory lblock 0
Date:   Sun, 24 Apr 2022 15:31:58 +0000
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
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-215879-13602-CFoIpUrRYA@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215879-13602@https.bugzilla.kernel.org/>
References: <bug-215879-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D215879

--- Comment #2 from sander44 (ionut_n2001@yahoo.com) ---
Created attachment 300796
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D300796&action=3Dedit
photo bug

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
