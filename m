Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E81487C966C
	for <lists+linux-ext4@lfdr.de>; Sat, 14 Oct 2023 22:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbjJNU6D (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 14 Oct 2023 16:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjJNU6C (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 14 Oct 2023 16:58:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4593ACE
        for <linux-ext4@vger.kernel.org>; Sat, 14 Oct 2023 13:58:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E1356C433C8
        for <linux-ext4@vger.kernel.org>; Sat, 14 Oct 2023 20:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697317080;
        bh=0uropvkmSq3xvHQLHd0vPdFWFAo6fVz432qwd9g7j0M=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=RBAhhRl1tsK5ZdjXLEXC3Fa8hDXXoq/OLof/EibxWUrBNVMyiqEeZw8UnVX7ZpJ9a
         6i7iXWbeutQJX/UZM66yg6f5driAynYdXEQ0YOxD8iqJEYTFZ1XVIju8GERUM0QMQD
         QiYUUW2TbRePfrljaXHdZsMk09fOWHzEGHzHHVqwIZSq/HHAjUN6LBCwT2wjd5qKy6
         aj64+aLP+pQaApuiM1edYJ9FAWOIZvtFiXYCW3Fr8XVyHYHiLaoyt2MUsb7dP2JoiX
         WFsdo+E4poyiQtTdwJ3QzU3wz8+rZbNlEyx/DtB8u3YeImEoKnIsfXnE7vddPyA3/L
         7+hZ4IX4cLgjg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id D2EF9C53BD5; Sat, 14 Oct 2023 20:58:00 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 218011] ext4 root filesystem related hangs on 6.5 kernels
Date:   Sat, 14 Oct 2023 20:58:00 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218011-13602-QM4A9orKfj@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218011-13602@https.bugzilla.kernel.org/>
References: <bug-218011-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218011

--- Comment #2 from Artem S. Tashkinov (aros@gmx.com) ---
To be precise:

sudo dumpe2fs -h /dev/nvme0n1p2

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
