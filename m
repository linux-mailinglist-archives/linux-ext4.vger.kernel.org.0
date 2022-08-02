Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39C7B587703
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Aug 2022 08:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232576AbiHBGOR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 2 Aug 2022 02:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbiHBGOP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 2 Aug 2022 02:14:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE04BE12
        for <linux-ext4@vger.kernel.org>; Mon,  1 Aug 2022 23:14:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AEC92B816A3
        for <linux-ext4@vger.kernel.org>; Tue,  2 Aug 2022 06:14:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 64759C433D6
        for <linux-ext4@vger.kernel.org>; Tue,  2 Aug 2022 06:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659420852;
        bh=H9x/fqsppYqe4tldOvjfW6pJeeFyCWsFCI5jbECgJQs=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=HlG91rUnnLT16w9z/57vif78rIwus8WedzsNJKCeWCLg3tfR389oVnn2MXJYL7mka
         vkBY92PQ9ZGuTCR+JeAA31Hy5VT9HUYtRvKK5kNj5qXuQRpHutzJSv5KbJADoQlgnv
         ebtUVSgmWXx0+LXkln7HWwUkMb1P1ji5TFUlBy15w70ZeAcNdz6ZIIAhzwG4ewICEA
         BjvNzhyti3T9XCHsNNWAEFO19AjnmGfiEFZkygeyFd4kWN8GIQZM/EjNa0JZaBWD5i
         pHLsltJp0DObS0ke5p2eOEcn3xvApcS/Xb6XqaP608LGg/7h/bBzQeqkF7kW4/cRgi
         uWohncSIiVGrw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 52256C433E7; Tue,  2 Aug 2022 06:14:12 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 216317] "ext4: lblock 0 mapped to illegal pblock" after
 upgrading to 5.19.0
Date:   Tue, 02 Aug 2022 06:14:12 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: gerbilsoft@gerbilsoft.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216317-13602-7HItArPNRt@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216317-13602@https.bugzilla.kernel.org/>
References: <bug-216317-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216317

--- Comment #3 from David Korth (gerbilsoft@gerbilsoft.com) ---
Reading the various commits, it seems that ext4's inline_data option previo=
usly
supported inlining symlinks, but as of v5.19.0, that's no longer supported.=
 The
patch restores read-only compatibility, but new symlinks will not be inline=
d.
Is there any particular reason why symlink inlining was removed, and/or does
the new method work better than inlining?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
