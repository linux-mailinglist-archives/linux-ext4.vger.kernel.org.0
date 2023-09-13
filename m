Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9F279EBF6
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Sep 2023 17:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbjIMPDW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 13 Sep 2023 11:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239071AbjIMPDV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 13 Sep 2023 11:03:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4613B3
        for <linux-ext4@vger.kernel.org>; Wed, 13 Sep 2023 08:03:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6F023C433CA
        for <linux-ext4@vger.kernel.org>; Wed, 13 Sep 2023 15:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694617397;
        bh=7tAAnxBkl2DPzhoKBxb3YroBqdQHfjG6UVx/cRvhOgM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ImPsok3uBI+0HrkAjyPoGCyc9B+C+G8zOgOdcQo+1UcmKQJIShxcjtFsyn5uh56KK
         8EOYy/bZcAafpa1OmonVizPKqBpG/DlNvuP3BxD+7JY/HFPXUIY0HC8K8swnp6c+lW
         389Qzu20Piema08nArnjG/Z0himfa0QHOBX2gttJhBTYix181B/qANBzO+xaHzhV36
         BduU5e8u70iz2oklqvTQM+JAkzOzFVIpeM9HVhwvWJ5+JZDTaysSnDhbKkN/CI8x0R
         HSmQ3FtrzaRjAiudfgq4qNsIBUxl7huhHiynWXkpzZQJ74b5uzRFxWxNmsetyY6+ER
         HEh5If4sHj4Zg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 5D5D5C53BC6; Wed, 13 Sep 2023 15:03:17 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 216322] Freezing of tasks failed after 60.004 seconds (1 tasks
 refusing to freeze... task:fstrim  ext4_trim_fs - Dell XPS 13 9310
Date:   Wed, 13 Sep 2023 15:03:17 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: jack@suse.cz
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-216322-13602-aMTwLqvjgw@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216322-13602@https.bugzilla.kernel.org/>
References: <bug-216322-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216322

--- Comment #15 from Jan Kara (jack@suse.cz) ---
Created attachment 305103
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D305103&action=3Dedit
[PATCH 2/2] ext4: Do no let fstrim block system suspend

These two patches should fix the issue...

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
