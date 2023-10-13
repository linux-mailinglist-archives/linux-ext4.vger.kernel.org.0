Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97D7A7C906B
	for <lists+linux-ext4@lfdr.de>; Sat, 14 Oct 2023 00:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjJMWow (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 13 Oct 2023 18:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJMWov (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 13 Oct 2023 18:44:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B41B7
        for <linux-ext4@vger.kernel.org>; Fri, 13 Oct 2023 15:44:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DFBBAC433C7
        for <linux-ext4@vger.kernel.org>; Fri, 13 Oct 2023 22:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697237088;
        bh=mqHyxl1PUq/oSl8TEdjLc9ll99amRyBr4kytUWhFVos=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=lAQez2KXCLrR8AJeLrtwDHUptkAeKk8KhAxDPKm9hxGe/fnuJ4zo913pG694V2g3P
         ZJT/mTFLq/OUuQKvU7UQ3qRnOm9Te9PFG1EUCpaXjIcL86IqHkb3Cf0KDV+ypE27c0
         ydccYWuX6BzOE3D3ZSADKDeuFNRYFE2HRvwv8nilZd4GdYhifDEKoUcdCJdD4lmoAE
         lyb+wUQ+1IBfG4CspG10iUQF2kCtggP8spZLCr73ZPHFNfsHzuR7pGG29SYTtosP8i
         SCqhtOLyr+JZ+1Ex5zAF2w0bnKtEyrhlUiQvhx//ll2ZqbBMveVPFVoFgCmeA0i9yh
         uTdPN8ASa7eSw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id C7AF1C53BD4; Fri, 13 Oct 2023 22:44:48 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 218006] [ext4] system panic when ext4_writepages:2918: Journal
 has aborted
Date:   Fri, 13 Oct 2023 22:44:48 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: INVALID
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-218006-13602-xrlhFHsn90@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218006-13602@https.bugzilla.kernel.org/>
References: <bug-218006-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218006

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |INVALID

--- Comment #1 from Artem S. Tashkinov (aros@gmx.com) ---
Looks like your storage is faulty:

mmcblk0: error -110 sending status

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
