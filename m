Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71CE572DD1E
	for <lists+linux-ext4@lfdr.de>; Tue, 13 Jun 2023 10:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233874AbjFMI5T (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 13 Jun 2023 04:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239114AbjFMI5R (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 13 Jun 2023 04:57:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66689AA
        for <linux-ext4@vger.kernel.org>; Tue, 13 Jun 2023 01:57:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F00BF61757
        for <linux-ext4@vger.kernel.org>; Tue, 13 Jun 2023 08:57:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6164CC4339C
        for <linux-ext4@vger.kernel.org>; Tue, 13 Jun 2023 08:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686646633;
        bh=3u1boClXkTuku6FyvYPBpIkbT911WXe02Y2+/lzYwKk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=fXb7DvK00ua6b55xA0W6C5vdqz/aBijM61OhytRcs2uxBjH1LM31ETg7NE18CjZ/I
         9BR4uNHILGRpDx8wNbqqHquPtIaMqnwEvGELng34mHw5pwlAEjRtBktk/LO5lsHGW3
         BkhkEVTVgxupaEXAqw2WjNg+fKLMRBEanLkGIuG+fBIsRQ0X8P/dIbCESdY11KdBw6
         1pg9UrVKH6Db/mUkxEAZQKYwpRQphnv34oQcaEBtg1KqztUgSC1jyjC31ZDNZKxwiR
         rp/HzSH724x/Zwou0mdNLOeNJWPiNnR6O+0gCwEqVl/uDZzOXdybqytYesHDvF2Csf
         98aEhgB/zPzOw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 4CDE0C43145; Tue, 13 Jun 2023 08:57:13 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 217529] Remounting ext4 filesystem from ro to rw fails when
 quotas are enabled
Date:   Tue, 13 Jun 2023 08:57:12 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: nikolas.kraetzschmar@sap.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-217529-13602-Dl6LYi9BWf@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217529-13602@https.bugzilla.kernel.org/>
References: <bug-217529-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217529

Nikolas Kraetzschmar (nikolas.kraetzschmar@sap.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |CODE_FIX

--- Comment #2 from Nikolas Kraetzschmar (nikolas.kraetzschmar@sap.com) ---
Thanks for the update, yes these fixes work fine.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
