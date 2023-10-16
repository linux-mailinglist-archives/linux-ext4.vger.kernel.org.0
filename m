Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 212087CADCE
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Oct 2023 17:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbjJPPlz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 16 Oct 2023 11:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232802AbjJPPly (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 16 Oct 2023 11:41:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24DFCE6
        for <linux-ext4@vger.kernel.org>; Mon, 16 Oct 2023 08:41:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AE823C433C9
        for <linux-ext4@vger.kernel.org>; Mon, 16 Oct 2023 15:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697470912;
        bh=ZsX80heBbysEVNGJ+OQ1NuOA0ui7IX7oek66jN5msXw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=NWb4JVBwBdJW/bmcjxpTlUUBwza19YNvt+X52c00sbE0XmrLSZ3IDptsDWWQWYuNx
         PpNIarYCs9+NW7kxvZYS+WSKopo5C7R4Uhlh3gW0OkH9+1tISzehMPO3UB8UtcHRlf
         GXxlpEIGmzolmplUOTlUUoBOIDX0vZuo6/mG9s5g1DkdDOFwBgJm/kvSSKUCBIVjpk
         A/PU5k0u3u3wVGpeWOAuY2x34KiTAHfDTVxowlVAVKnJeP7v717PbLOP9rd8MJ9iPx
         2/1UMzApdpXnvIAltZP0JUsT0emVYuhb/jdHpHx+PyORMuGkOEVMCju66OBTavfxOE
         bg6+O6Nmy/Gjw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 96C53C4332E; Mon, 16 Oct 2023 15:41:52 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 218006] [ext4] system panic when ext4_writepages:2918: Journal
 has aborted
Date:   Mon, 16 Oct 2023 15:41:52 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: tytso@mit.edu
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: INVALID
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218006-13602-nUfOMrHVPE@https.bugzilla.kernel.org/>
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

--- Comment #6 from Theodore Tso (tytso@mit.edu) ---
Unfortunately the 4.14 kernel was released in 2017, which is over six years
ago.   Most companies where you can pay $$$ to get support for Linux
distributions based on 4.14 are EOL'ing products based on 4.14.   As far
upstream kernel developers who are essentially volunteers when people ask t=
hem
for free help, in general, upstream kernel developers do not support LTS
kernels, and certainly not an LTS kernel as old as 4.14.

If there is someone is willing to be the ext4 upstream stable backports
maintainer, then that person might be willing to provide limited support for
LTS kernels --- but the 4.14 LTS upstream kernel is planned to be EOL'ed in
January 2024, and I had stopped running gce-xfstests on 4.14 LTS kernels ab=
out
a year or so ago.  I barely have time to run gce-xfststs on LTS kernels for
6.1, 5.15 and 5.10 every quarter or two, and if someone were to volunteer to
become ext4 stable backports maintainer, I'd encourage them to focus on 6.6=
 and
6.1 LTS kernels, with 5.10 and 5.15 LTS kernels as a lower priority (because
most commercial companies are going to be moving off of 5.10 LTS in the near
future).   But volunteer support for 4.14 LTS?  TO be honest, that's extrem=
ely
unlikely.

*If* there is a company that has a misguided business reason to support the
4.14 LTS kernel, then of course an employee of that company can certainly f=
und
an engineer to to do all of the support that they need.  But quite frankly,=
 I'd
be encouraging that company to rethink their business case for supporting t=
he
4.14 kernel.   It would be probably far more cost effective to migrate their
customers to a non-pre-historic kernel such as the 6.6 LTS kernel.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
