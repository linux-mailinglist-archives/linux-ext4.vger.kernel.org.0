Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F98A645270
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Dec 2022 04:12:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbiLGDMS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 6 Dec 2022 22:12:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiLGDMR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 6 Dec 2022 22:12:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B17528BF
        for <linux-ext4@vger.kernel.org>; Tue,  6 Dec 2022 19:12:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1377BB81C9B
        for <linux-ext4@vger.kernel.org>; Wed,  7 Dec 2022 03:12:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A80F8C433D7
        for <linux-ext4@vger.kernel.org>; Wed,  7 Dec 2022 03:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670382733;
        bh=ia3Vi0NO8exygVV8Loa549R5NSftma7/KjGyuF7S1YU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=YqsggusMPmEizo4nwZh87ryf2j3vzcgjX2Sg/T23BegKuXuFpGTsQF0EbCmgbqUc1
         QD/mykRahMHNOVTnb7Equ+qGHACU9iEGFIBSlR0mNePGoFLbsJed0XHyvupBZRdIs1
         LTAK/dDuGgtbt8AqmF05iF6m1nW96MPE4/AFZFQe+SSdB6OBEgqyGS7jbUzvLLrwiR
         80RFIl+lGuE8ZbsjxzDgPLnrNmwd79XvG+xSUgDmbWdHrR6TVt8O3UXIWZHtCffedi
         NDEDeYUtlVoxUzKEgksT7RkLjoz9ZUqrg6yDpFtf2L8s4o6D0xVNeXwvaPl4d7LuHZ
         me7yzCANCUUDg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 960F2C433E7; Wed,  7 Dec 2022 03:12:13 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 216781] wrong check buffer_head in ext4_simulate_fail_bh
Date:   Wed, 07 Dec 2022 03:12:13 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: low
X-Bugzilla-Who: 1527030098@qq.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: INVALID
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-216781-13602-jmDjQa0jgu@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216781-13602@https.bugzilla.kernel.org/>
References: <bug-216781-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D216781

eriri (1527030098@qq.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |INVALID

--- Comment #1 from eriri (1527030098@qq.com) ---
Oops=EF=BC=8Cit's my mistake.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
