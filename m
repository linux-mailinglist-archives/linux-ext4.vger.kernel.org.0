Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 969B5676C4D
	for <lists+linux-ext4@lfdr.de>; Sun, 22 Jan 2023 12:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjAVLXG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 22 Jan 2023 06:23:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjAVLXF (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 22 Jan 2023 06:23:05 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B6D7B76D
        for <linux-ext4@vger.kernel.org>; Sun, 22 Jan 2023 03:23:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 11C8CCE0DAB
        for <linux-ext4@vger.kernel.org>; Sun, 22 Jan 2023 11:23:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 29C0BC433EF
        for <linux-ext4@vger.kernel.org>; Sun, 22 Jan 2023 11:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674386581;
        bh=yxomfnG35GwwxP/179b2vyiQzqDOlP+Ly91B4LaMAmY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=iVH9tcDVIMSthzgPvMbtO2i1FUblQsiFem0VW+Cf0gW0JXLZ1Qx8tJUWSJyCCRNA6
         jLN+rrAl3WSwv1KQNuo/ah/T3djHbq/89rq7hVjPp5XGR3ttXR4vKUUPxw9aoSOaaG
         kFXYJfW/mFMdhWc3jznh13BKi7Nl4Tcv+x9nf5vdYcEbshQz2Y7Mf8VWD5Vr09ydWk
         3xjcb5rIaRd0VdY50PvNgqQntuJpAFV1g6N4mk2JunhXpGdjHeuW80kWpx4F5SILkr
         7i8Vpl7NZo6OJRlucQBaghUdlcmkAVgvUalaXgkG/GEw/YcImfTkJ9quG5zVl/aeO3
         H1Ndu+aRLfwlw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 1C2FAC43141; Sun, 22 Jan 2023 11:23:01 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 216953] BUG: kernel NULL pointer dereference, address:
 0000000000000008
Date:   Sun, 22 Jan 2023 11:23:00 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: Other
X-Bugzilla-Component: Loadable Security Modules (LSM)
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: other_lsm@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc component assigned_to product
Message-ID: <bug-216953-13602-XkKxuvEL21@https.bugzilla.kernel.org/>
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

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |aros@gmx.com
          Component|ext4                        |Loadable Security Modules
                   |                            |(LSM)
           Assignee|fs_ext4@kernel-bugs.osdl.or |other_lsm@kernel-bugs.osdl.
                   |g                           |org
            Product|File System                 |Other

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
