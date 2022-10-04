Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 766405F3F43
	for <lists+linux-ext4@lfdr.de>; Tue,  4 Oct 2022 11:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbiJDJPR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 4 Oct 2022 05:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbiJDJPO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 4 Oct 2022 05:15:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B2B1E71C
        for <linux-ext4@vger.kernel.org>; Tue,  4 Oct 2022 02:15:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 175EEB819A1
        for <linux-ext4@vger.kernel.org>; Tue,  4 Oct 2022 09:15:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C62DCC43144
        for <linux-ext4@vger.kernel.org>; Tue,  4 Oct 2022 09:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664874910;
        bh=2+n9vi2UuylBJ8NLVtNPY/YsiTLGUDBKoWL2FCw7viA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=NtcW8vqhCniiPphJSHJBuqL1Ug7x/dqlfDlGDppS0wa7ehSx1ocx6hgPc4mH5Xk8G
         zsrR17S/z+c7DRYzqIewuNHU/XFGuw3vL+BseAx5m2TC/cJ9LLQ7oQhRiEGHkxypa6
         PV8sO4HYisd2z6s0Ds5GqDNX5z/7gLHRkLajcvwWKvacRbw7WGx5qAh0SLa5I3b4OL
         7f7dFcw1qPIIYC/OYnE+qGqOmpLAHI5jBY2wwVxwNvD9b5HrYajYV+8Xa9N+7fKQNQ
         umGwh5xT23jSFXksbLbL2LTVaNBL6TU4aYLXDXw40vgb5jUcvi0k4ALQIguiRuF4d0
         j2f3ZgDbxu8Qw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id AF098C433E7; Tue,  4 Oct 2022 09:15:10 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 216283] FUZZ: BUG() triggered in
 fs/ext4/extent.c:ext4_ext_insert_extent() when mount and operate on crafted
 image
Date:   Tue, 04 Oct 2022 09:15:09 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: lhenriques@suse.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-216283-13602-Dl330luc61@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216283-13602@https.bugzilla.kernel.org/>
References: <bug-216283-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D216283

Luis Henriques (lhenriques@suse.de) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |lhenriques@suse.de

--- Comment #11 from Luis Henriques (lhenriques@suse.de) ---
I think that, with commit 29a5b8a137ac ("ext4: fix bug in extents parsing w=
hen
eh_entries =3D=3D 0 and eh_depth > 0") merged, this bug can be closed.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
