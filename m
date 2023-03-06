Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0FE6ACCCC
	for <lists+linux-ext4@lfdr.de>; Mon,  6 Mar 2023 19:38:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjCFSiz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 6 Mar 2023 13:38:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjCFSiy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 6 Mar 2023 13:38:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69AA738015
        for <linux-ext4@vger.kernel.org>; Mon,  6 Mar 2023 10:38:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0DF766108D
        for <linux-ext4@vger.kernel.org>; Mon,  6 Mar 2023 18:38:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6640EC4339C
        for <linux-ext4@vger.kernel.org>; Mon,  6 Mar 2023 18:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678127928;
        bh=AK6/3o0wE+MvKwEMz0Nbb9jn5HutIG/9h4xYWnMYy1s=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=FAlr9dzaTS7SrkVShHmfEKWbZp8V5dtxiBGCzgGBkxDDevByGpZMr5dkeQGA4uof3
         n6g+X5S95CDhniExFCkODBVbXjMh+jKODbuAcyC5O7Dj/5+G8VYvjd1Lfi9+T0UaS4
         A8IcXcDQ1jJfxwVJ4EVf/vWqHWAoMwh738sbag03iYSgr7Vra1qMMZSHJmbKW0v96H
         1Tb2L66ss8o9yP8n/S37945T9mCfjdMgTZSOkBT/52+Z5m47oVVwwWCFYYeJp1PyI5
         7vD1Vjf3QBKjfzMATXr7ilTyc9JOA5rsiuQr7bvwsb/tvG02M5I4Egb87zNCq0Ukqe
         eA54/2wvRn9mw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 4F1D0C43141; Mon,  6 Mar 2023 18:38:48 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 217145] Feature request: I need very long directory and file
 names
Date:   Mon, 06 Mar 2023 18:38:47 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: adilger.kernelbugzilla@dilger.ca
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-217145-13602-ES9F83zYrS@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217145-13602@https.bugzilla.kernel.org/>
References: <bug-217145-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D217145

Andreas Dilger (adilger.kernelbugzilla@dilger.ca) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |adilger.kernelbugzilla@dilg
                   |                            |er.ca

--- Comment #4 from Andreas Dilger (adilger.kernelbugzilla@dilger.ca) ---
The problem with "long filename is a description of the video" is that 1-3K=
iB
today may grow to 4KiB or 16KiB in the future, so fixing the filename lengt=
h to
allow 1KiB or 3KiB names (out of a full 4KiB PATH_MAX) is only a short term
solution.  Changing ext4 or XFS to support 3KiB or 4KiB *filenames* would b=
e a
lot of effort for very marginal benefit.=20

I think the right solution is to put the "full description" into a separate
xattr on the file (which can be up to 64KiB in modern ext4) and then restri=
ct
filenames to 255 bytes. That allows very long descriptions without impacting
interoperability.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
