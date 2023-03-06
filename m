Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DAB86AB7F4
	for <lists+linux-ext4@lfdr.de>; Mon,  6 Mar 2023 09:08:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjCFII0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 6 Mar 2023 03:08:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjCFIIV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 6 Mar 2023 03:08:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDFE6B765
        for <linux-ext4@vger.kernel.org>; Mon,  6 Mar 2023 00:08:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 77D0EB80CA2
        for <linux-ext4@vger.kernel.org>; Mon,  6 Mar 2023 08:08:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 38425C4339B
        for <linux-ext4@vger.kernel.org>; Mon,  6 Mar 2023 08:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678090097;
        bh=G/2JRUZMkILS7onuXw5GdVsJm4izrHEhldhdSpjLMbA=;
        h=From:To:Subject:Date:From;
        b=dGfyA5a87HVEJGBewZsnIdzKKb/vPTwh4RT38lBfzKwKu6TmgWDNQKARIgawkjKGJ
         WC6AkeAzYYRCTWTUp2jd3sW/emE4MsLVLesXTyVjsyQJ/0VBedxUTJ265FH/5JHpg7
         umNu/H+UJfxFvNtGBiVRLooyyeHU6ifjLnq0JEyPZp5gaOfElFxv6qaZV3h5O3vsHn
         JsStRrKWi+m2uuQQKNaV6iqGxHPeLPZSWNgQrFfNhVKZhC42I9DFfLmqGE9fAt33oX
         Fs93szIug5R7AscEHCALAZOMeIoxvT3qnbtBsG4cTCdZLx/RQhBs4jlX7D49SAiVbi
         gQCMydcw0DWdQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 2695EC43143; Mon,  6 Mar 2023 08:08:17 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 217145] New: Feature request: I need very long directory and
 file names
Date:   Mon, 06 Mar 2023 08:08:16 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: vyacheslav.sahno@yandex.ru
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-217145-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D217145

            Bug ID: 217145
           Summary: Feature request: I need very long directory and file
                    names
           Product: File System
           Version: 2.5
    Kernel Version: 5.15.34-un-def-alt1
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: ext4
          Assignee: fs_ext4@kernel-bugs.osdl.org
          Reporter: vyacheslav.sahno@yandex.ru
        Regression: No

I am a youtuber-linuxoid. I need to group videos in a directory by date(nam=
e)
and list of what seen on a videos at that date(1-3 Kilobytes).

Also torrent client cutting names needed in Linux because of limit of
filenames.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
