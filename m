Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67F184E5BAC
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Mar 2022 00:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345408AbiCWXIJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 23 Mar 2022 19:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345522AbiCWXIH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 23 Mar 2022 19:08:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE4BC9027D
        for <linux-ext4@vger.kernel.org>; Wed, 23 Mar 2022 16:06:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 49274617F0
        for <linux-ext4@vger.kernel.org>; Wed, 23 Mar 2022 23:06:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B2D2EC340F2
        for <linux-ext4@vger.kernel.org>; Wed, 23 Mar 2022 23:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648076796;
        bh=fNBu8bVAqCYmw3IC5ZRPSBmhmf2XJfPuDTi8+CQyCmY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=oapdG1HH0/xVRVHporrAu/7eo8ZQsdfubSc5PyvawvHaQm0q9ctuAWn5wrdPgH+nc
         OWCI7V7TUx39cBBHztuKb+nEs1yn6bovTr9D26rXmvWGrF2WNVIAZmXz8MfZnEI+SY
         KcbbAZHIuxBNsI3MTPuTUhrtOjnxMAz3WVcfjT3Htegf0lTilwHacMweDv3T12cIVp
         +4CHvQXWEjUpBbuIANYSuYA422fqj9Qp0+/+OzNbbgwdtKufXkQEuxLD4Jfn9ucfHa
         DxsdXARK/fIEnE8ThcyDLGpqtfK6NbN5ttLyrOyRGaTN0OksfoZEfwq6tl9L+feMpo
         l4/1dbDRsZYBA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id A2281CC13AD; Wed, 23 Mar 2022 23:06:36 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 215712] kernel deadlocks while mounting the image
Date:   Wed, 23 Mar 2022 23:06:36 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: lists@nerdbynature.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-215712-13602-2iktX1lkDv@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215712-13602@https.bugzilla.kernel.org/>
References: <bug-215712-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215712

Christian Kujau (lists@nerdbynature.de) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |lists@nerdbynature.de

--- Comment #3 from Christian Kujau (lists@nerdbynature.de) ---
A 5.17 kernel *is* able to mount the image here, but it takes quite some ti=
me
to complete:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
$ time mount -v -t ext4 -o loop,ro,debug tmp.img /mnt/disk/
mount: /dev/loop0 mounted on /mnt/disk.

real    1m32.694s
user    0m0.008s
sys     1m32.665s
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

During that time the CPU is spinning like crazy, but I don't know how to de=
bug
this further as to why it's spinning. perf comes to mind, but maybe somethi=
ng
more ext4 specific is more useful here. dmesg shows, for this mount operati=
on:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  188.269405] [EXT4 FS bs=3D1024, gc=3D2, bpg=3D8192, ipg=3D2048, mo=3Da80=
2c818,
mo2=3D0002]
[  280.932637] EXT4-fs (loop0): mounted filesystem with ordered data mode.
Quota mode: disabled.
[  595.249319] EXT4-fs (loop0): error count since last fsck: 1
[  595.250559] EXT4-fs (loop0): initial error at time 1647888893:
ext4_mb_generate_buddy:756
[  595.253403] EXT4-fs (loop0): last error at time 1647888893:
ext4_mb_generate_buddy:756
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

@Ming, can you share details on how the image has been modified?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
