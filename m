Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 696F67B6AC4
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Oct 2023 15:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235170AbjJCNmI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 3 Oct 2023 09:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbjJCNmH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 3 Oct 2023 09:42:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49FEBA9
        for <linux-ext4@vger.kernel.org>; Tue,  3 Oct 2023 06:42:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DBAE3C433CB
        for <linux-ext4@vger.kernel.org>; Tue,  3 Oct 2023 13:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696340524;
        bh=cDlN3y4DTyCh2jAB7P0etLAThZIcEgcoycoIXzadSjo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=CxT45/ck+nNh+O0CpvJoUazY+j4wjVoAe4HD6Rt+I+WRuGpYsw9wjrUMdjqopV/o3
         r41SDxZGHBTnQtUaw5KUje0tukwK4i1D+MLGK2TsKNLllrjvlI3Y0Wl+D7QsIaCIKM
         88NuIxsUBN5CS9OE0nnFB04qt7gQs4+8vRaf7gtlEBV+3hqYqTHD5EJdBLyM+AqlV1
         v/sCBxvpcYNFkwVjzxzE+iswizfxOVcpZRCcddBMkYaOUzPZUmwvNaKI/G0J4u8jha
         uqwaUrMzlBco5wNH8a1OS64q3pia0FeaVl7VYTTxOLkAgU+h0nVWd4cnCbi4PkwVkS
         oZBY2v/dna/2w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id C0045C53BCD; Tue,  3 Oct 2023 13:42:04 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 217965] ext4(?) regression since 6.5.0 on sata hdd
Date:   Tue, 03 Oct 2023 13:42:04 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: ojaswin.mujoo@ibm.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217965-13602-ojYEQ4z9yT@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217965-13602@https.bugzilla.kernel.org/>
References: <bug-217965-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217965

--- Comment #8 from Ojaswin Mujoo (ojaswin.mujoo@ibm.com) ---
Hey Ivan, thanks!=20

Seems like stripe mount option is automatically added if the filesystem is =
made
using stride or stripe-width options during mkfs time.=20

Can you kindly perform the below steps as well to further help narrow this
issue down:

1. Mount FS with the usual options (including using stripe=3D32752).=20
2. Once mounted, run:

$ echo "0" > /sys/fs/ext4/sdb2/mb_best_avail_max_trim_order

This might need sudo. Basically this disables one of the allocator feature =
that
was added in 6.5.

3. Run the workload again and see if the issue is still visible.

Regards,
ojaswin

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
