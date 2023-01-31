Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF7968317D
	for <lists+linux-ext4@lfdr.de>; Tue, 31 Jan 2023 16:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbjAaP1l (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 31 Jan 2023 10:27:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbjAaP1j (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 31 Jan 2023 10:27:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8748F10E
        for <linux-ext4@vger.kernel.org>; Tue, 31 Jan 2023 07:27:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 28208B81D6C
        for <linux-ext4@vger.kernel.org>; Tue, 31 Jan 2023 15:27:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C0053C4339B
        for <linux-ext4@vger.kernel.org>; Tue, 31 Jan 2023 15:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675178850;
        bh=SojHaKoi1fb7UHayqXzTRorXmUBlLKxXDMAo0tjXvF0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=AmyIwZCvezjrEz3qgQm8oIkEdh0+6RMMZDQHo10Xv7r3/si62lInAMiElnUWjA+8S
         6NzxP9bQi9Wh7uGkQYfHF2CPDZKFVp4dKrfWefsP4dDCiXv+LA2fhFLi4dPqTshOXK
         ApqKG071vigK4JMhSmPQQ4IrDvrZvJvEPGyNFBvZZuPr1JoACcnY4XxftfCIqGTQ2t
         f8Uco3SJRgO//fx3VCHtPVc722wF14JXDE78j19dtUIPmV+TFbvF5Xy36/P0XdPNHg
         92GHPfkd1JFpsFJme0tUf+5HZ0Km/2TNtQHQO8dZcT84a4DW4n+C4fPCrzl0ZoYu3p
         iMpxqaAJJidvA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 990E4C43142; Tue, 31 Jan 2023 15:27:30 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 216981] Online file system resize stuck for ext3
Date:   Tue, 31 Jan 2023 15:27:30 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext3@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext3
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: trivial
X-Bugzilla-Severity: high
X-Bugzilla-Who: barhatesw09@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext3@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: keywords cc short_desc bug_severity
Message-ID: <bug-216981-13602-1nYJKO3TFF@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216981-13602@https.bugzilla.kernel.org/>
References: <bug-216981-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D216981

Sunil Barhate (barhatesw09@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
           Keywords|                            |trivial
                 CC|                            |barhatesw09@gmail.com
            Summary|Online resize of ext3 file  |Online file system resize
                   |system stuck                |stuck for ext3
           Severity|blocking                    |high

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
