Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C66A964259E
	for <lists+linux-ext4@lfdr.de>; Mon,  5 Dec 2022 10:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbiLEJTa (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 5 Dec 2022 04:19:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbiLEJTN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 5 Dec 2022 04:19:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3311B18360
        for <linux-ext4@vger.kernel.org>; Mon,  5 Dec 2022 01:19:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A41F4B80D8A
        for <linux-ext4@vger.kernel.org>; Mon,  5 Dec 2022 09:18:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6FFFEC433D6
        for <linux-ext4@vger.kernel.org>; Mon,  5 Dec 2022 09:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670231938;
        bh=8cWDFkTegKUy+pkpLgYMhiuViuZmvYdtwqB3XfUGDmQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=klC1MuMNxlKnfT617SKl0xi74K48ClpZyUDzZs/Vv7zEGaqh7Relj3HBeX6XNd0TA
         47siwjO7kpR4/L2B+RX9F3izZt1hDXq3NdLjj8+ZtHLh0RRXZjXZfb/kcp1hEFGe9B
         k0ckG4UWUVqPPuVSoCguTuI14EHLcuGahhzDAfrAYpCRTse/AYPVweKLRIk3CTkcK+
         GYX8NaMsLWHEGoLhr6vAp3iW/IjtS1QhI0prIPk+tswJWNpJHNZXX9oZQbS9iiMhgC
         8a0ssCpE4qOBVb9gqhr4FInV3TDuu11VXJ5PtHvy08VQnAEM0701sKLzBGBTM80u3O
         cn7ns0Ko92QJA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 5EC97C433E7; Mon,  5 Dec 2022 09:18:58 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 216775] fanotify reports parent PPID insted of PID for
 FAN_MODIFY events
Date:   Mon, 05 Dec 2022 09:18:58 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: saikiran.gummaraj@icloud.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216775-13602-uhiBjFq8vI@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216775-13602@https.bugzilla.kernel.org/>
References: <bug-216775-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D216775

--- Comment #2 from opcoder0 (saikiran.gummaraj@icloud.com) ---
Sorry missed that. Thanks a lot!

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
