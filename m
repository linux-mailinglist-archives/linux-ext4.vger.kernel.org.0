Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD5258958D
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Aug 2022 03:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236271AbiHDBBz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 3 Aug 2022 21:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbiHDBBy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 3 Aug 2022 21:01:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 735D918E1C
        for <linux-ext4@vger.kernel.org>; Wed,  3 Aug 2022 18:01:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 294C6B82446
        for <linux-ext4@vger.kernel.org>; Thu,  4 Aug 2022 01:01:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B1258C433B5
        for <linux-ext4@vger.kernel.org>; Thu,  4 Aug 2022 01:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659574910;
        bh=PyuVeDJruUSrMqhTj7AID5adFshDol1HiPFMO15ob6k=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=LzfCotcPSbPK0kDLPUpWLAzkz6ZhVuYxYXrqC57kR9pCrTO3DovgHc4E8fTmR8+cb
         XBw6/wCdZ9fSr2rQf0tyhVdDZx/mSjn6sjp6+8QRrO3ScUErfehuOFQKzzZ6RF7BCt
         mHlicFPqgpI39aTxUihiujlZdXQ3CN/SBBDDCPXMHYNjXv5/ojOebAm/fhTnmHWG+X
         4WKikSystgXzUyqBkqfnl/oulqt6CfWgmgEXr5mz8FyDXG+SCBht9tlPeAQzoiH5de
         AKQI+KcbXnhczeBJ8ZxkbRLabRUdIcxbDop4pV0+wTkKEpUzlvtT+rIVAfzqLTCRUA
         2bif66QAaGWzA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 9CDF2C433E4; Thu,  4 Aug 2022 01:01:50 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 216322] Freezing of tasks failed after 60.004 seconds (1 tasks
 refusing to freeze... task:fstrim  ext4_trim_fs - Dell XPS 13 9310
Date:   Thu, 04 Aug 2022 01:01:50 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: tytso@mit.edu
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216322-13602-DlPqmAtHxt@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216322-13602@https.bugzilla.kernel.org/>
References: <bug-216322-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D216322

--- Comment #3 from Theodore Tso (tytso@mit.edu) ---
The other consideration is if there is some other userspace application oth=
er
than util-linux which is using the FITRIM ioctl --- for example, what if
systemd decided it needed to reimplement fstrim the way it's reimplemented
syslogd, ntpd, etc., etc., etc.?     In which case, if we change FITRIM so =
that
if it gets a signal or if the system tries to suspend itself, it will return
EAGAIN and fstrim_range.len will have the number of bytes trimmed so far ---
this might cause the systemd-reimplementation (or any other hypothetical us=
ers
of FITRIM) to break if there is a suspend-to-ram happening at an inopportune
time.

So which is worse?=20=20=20

1)   Leaving suspend-to-ram broken if the user is unlucky enough to try to
suspend their laptop while fstrim is run automatically by systemd or out of
crontab?=20=20=20

2)   Breaking random userspace programs that use FITRIM so they doesn't
complete the requested file system/SSD maintenance if the user tries to sus=
pend
their laptop while that program happens to be running?   (We can fix the
userspace programs which use FITRIM so they handle the EAGAIN error return =
as
we find them, of course.   At the moment, it's only util-linux as far as I
know.)

In the long term, #2 seems like the best approach, IMHO.  OTOH, it could be
argued that we've lived with this for years and years and years, and no one=
 has
noticed up until now.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
