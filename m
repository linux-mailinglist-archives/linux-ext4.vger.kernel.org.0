Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76200531D57
	for <lists+linux-ext4@lfdr.de>; Mon, 23 May 2022 23:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbiEWVFl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 23 May 2022 17:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiEWVFk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 23 May 2022 17:05:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F6F6D84D
        for <linux-ext4@vger.kernel.org>; Mon, 23 May 2022 14:05:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 53563B81109
        for <linux-ext4@vger.kernel.org>; Mon, 23 May 2022 21:05:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 10FE3C34115
        for <linux-ext4@vger.kernel.org>; Mon, 23 May 2022 21:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653339937;
        bh=kV5VMbXILZ55Nr9ubZ07y/fS1QfnyNw57rVK00tkK8E=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=qRZq/eTTuHOTJ/8/vbKFCvV5Lvo+JoXYVZSQduO61FRsnaNFI5xSsz1JZ3vjT0qZq
         ImAbg1PAbnZpE+vIuzoOpOYN73w5OHB9dSguWZJHFgXGEP3mmlShWSeH6/IlPrtBT6
         0iuU8zwIT/jL7mQ5jgAV8iFifVg4tnLQSmnDqb+SDpuMAZdwyP6ywiE3/skeekpQ/x
         d+ZY222CPdzo+w/Fo2PMHFJdXqf8ifPMKQ50r7ZOaObmUG8x+ZerYTshSks4NqeHfa
         7Do/9S5PVmvmbg51O1gsRTC3ZojUIbcizh3yfPpkxvGsz6T/wyTOZx/W+LGzxtwsPi
         GOkFVOWVRnCLw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id E814DC05FF5; Mon, 23 May 2022 21:05:36 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 216012] Data loss on VirtualBox VMs
Date:   Mon, 23 May 2022 21:05:36 +0000
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
X-Bugzilla-Resolution: INSUFFICIENT_DATA
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status cc resolution
Message-ID: <bug-216012-13602-6Nksm42GVX@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216012-13602@https.bugzilla.kernel.org/>
References: <bug-216012-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216012

Theodore Tso (tytso@mit.edu) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|REOPENED                    |RESOLVED
                 CC|                            |tytso@mit.edu
         Resolution|---                         |INSUFFICIENT_DATA

--- Comment #3 from Theodore Tso (tytso@mit.edu) ---
Error -30 is EROFS in this message:

EXT4-fs (dm-0): failed to convert unwritten extents to written extents --
potential data loss!  (inode 259291, error -30)

This typically means that *before* this point, the ext4 file system detecte=
d an
inconsistency, and the file system was set up to remount the file system
read-only when an Ext4.  So there would be an "EXT4-fs error" message.  For
example, you can trigger this behaviour like this:

root@kvm-xfstests:~# tune2fs -e remount-ro /dev/vdc
tune2fs 1.46.4-orphan-file-02827d06 (4-Nov-2021)
Setting error behavior to 2
root@kvm-xfstests:~# mount /dev/vdc /vdc
[   83.142333] EXT4-fs (vdc): mounted filesystem with ordered data mode. Qu=
ota
mode: none.
root@kvm-xfstests:~# echo test-corruption-handling >
/sys/fs/ext4/vdc/trigger_fs_error=20
[   91.189272] EXT4-fs error (device vdc): trigger_test_error:126: comm bas=
h:
test-corruption-handling
[   91.190375] Aborting journal on device vdc-8.
[   91.193756] EXT4-fs (vdc): Remounting filesystem read-only
root@kvm-xfstests:~#=20

Typically, when this happens, in 99.9999% of the time, it's caused by an I/O
error.   In a hypervisor situation, that includes a potential hypervisor bu=
g.=20=20
In any case, without any other evidence to the contrary, it's probably not =
an
ext4 bug.  And even if it was, unless you can replicate the bug on an upstr=
eam
kernel, the proper place to report it is with Canonical.    After all, that=
's
why you've paid $$$ for a support contract with Canonical for Ubuntu, right=
?=20
:-)    And depending on Canonical's support contract, they might or might n=
ot
be willing to track down a Virtualbox bug unless you've paid for a more
comprehensive support contract.   In any case, upstream developers don't ha=
ve
time to chase down something like this, especially since the probabilities =
are
extremely high that it's not an upstream kernel issue.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
