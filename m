Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4655876EB
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Aug 2022 07:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232875AbiHBF6X (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 2 Aug 2022 01:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbiHBF6V (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 2 Aug 2022 01:58:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642211BEBE
        for <linux-ext4@vger.kernel.org>; Mon,  1 Aug 2022 22:58:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1888EB816A3
        for <linux-ext4@vger.kernel.org>; Tue,  2 Aug 2022 05:58:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B55E2C433C1
        for <linux-ext4@vger.kernel.org>; Tue,  2 Aug 2022 05:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659419897;
        bh=wXrM0KD8xLL43A0PZdsxwyl5uppWrjEp9TCqV0kLotA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=t++iT/1n+7qfHq1dOXll9cPCbaenLmeQwvceIKMAV9KLXon06TSysOanz61AIpnuq
         510TKUeF32rvj7M/4BxxhU2OyfFjf/6HWh+kRdYqhqduxszvtUAh1b/RKvSXbuLJNk
         K20sCJ2zv8y4Ph6Q9bjCYPbBJmvkR0sl+wSt92MKR+n/YyYR0n8M8hzaQDV2kFu6hx
         w5EYGGQoIqShLTDzUngXIjjGGVsFVDNAzr5TjpH81hOOlA8GtKLgTWQcXz+WIRmXc3
         iZNga8Vc/ub64PclKIZ6+BxAUSeHzt9XjosITFBSo6UksV2Nq/h+yOr4aIMdK+cjwa
         TO60Oq1NzL51A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 9EB01C433E6; Tue,  2 Aug 2022 05:58:17 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 216317] "ext4: lblock 0 mapped to illegal pblock" after
 upgrading to 5.19.0
Date:   Tue, 02 Aug 2022 05:58:17 +0000
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
Message-ID: <bug-216317-13602-jUk5Lj2ShS@https.bugzilla.kernel.org/>
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

--- Comment #2 from David Korth (gerbilsoft@gerbilsoft.com) ---
After doing some searching, it looks like this commit may fix the issue:

https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git/commit/?h=3D=
dev&id=3Df50f5a5eac8092fb9b3365ca4b1d7407cdab8427

ext4: fix reading leftover inlined symlinks
Since commit 6493792d3299 ("ext4: convert symlink external data block
mapping to bdev"), create new symlink with inline_data is not supported,
but it missing to handle the leftover inlined symlinks, which could
cause below error message and fail to read symlink.

 ls: cannot read symbolic link 'foo': Structure needs cleaning

 EXT4-fs error (device sda): ext4_map_blocks:605: inode #12: block
 2021161080: comm ls: lblock 0 mapped to illegal pblock 2021161080
 (length 1)

Fix this regression by adding ext4_read_inline_link(), which read the
inline data directly and convert it through a kmalloced buffer.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
