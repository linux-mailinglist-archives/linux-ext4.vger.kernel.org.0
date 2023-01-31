Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1F4683171
	for <lists+linux-ext4@lfdr.de>; Tue, 31 Jan 2023 16:25:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233181AbjAaPZa (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 31 Jan 2023 10:25:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233185AbjAaPZE (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 31 Jan 2023 10:25:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E76E2ED57
        for <linux-ext4@vger.kernel.org>; Tue, 31 Jan 2023 07:23:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 25A04B81D63
        for <linux-ext4@vger.kernel.org>; Tue, 31 Jan 2023 15:23:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D1272C433EF
        for <linux-ext4@vger.kernel.org>; Tue, 31 Jan 2023 15:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675178612;
        bh=hg83WhGItxxLvZiNo0I3MszBAj0I01Y423Xj6pum88o=;
        h=From:To:Subject:Date:From;
        b=HUO7E5ZF/f3ouQuhpbPAvT5e2Du8cL20jPCy/pIEsOp3RRAsfgnH0JNFdp3fl2YQa
         en6kxGVOCsQTJ5C3jsmzelDQejbTAInUN2kQnNHFkc1slbhYPoV369AVDi3t3LHXBJ
         8D7giSEwtS91aATYgctI04QYv9J4eX64OHmO90rF931BgJ4EBhnMmY+Z2HlEFHmjEr
         6Xb/len+096awzy9eOruLfbf2fCBhAzT3aTtAuu6JUgiNdmwYj9RKDMaGPr1L/qWuB
         ZpGgm5oFYStvZ9r5j75n4gvZb9AoAUMIA/ClUSfRT3auMrgDxIptwf/nqI0IX/o7m4
         2mBK7GDXKrliQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id B81A4C43143; Tue, 31 Jan 2023 15:23:32 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 216981] New: Online resize of ext3 file system stuck
Date:   Tue, 31 Jan 2023 15:23:32 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo fs_ext3@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext3
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: barhatesw09@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext3@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-216981-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D216981

            Bug ID: 216981
           Summary: Online resize of ext3 file system stuck
           Product: File System
           Version: 2.5
    Kernel Version: 4.18.0-372.9.1.el8.x86_64
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: blocking
          Priority: P1
         Component: ext3
          Assignee: fs_ext3@kernel-bugs.osdl.org
          Reporter: barhatesw09@gmail.com
        Regression: No

Trying out kubernetes online volume resize feature with ext4 and ext3 file
system.

While the application using the volume tried to resize the volume.

For ext4 file system it worked. But it stuck with ext3 file system.




block level the device got resized.

nvme1n1                   259:0    0 642.6G  0 disk
/var/lib/kubelet/pods/6a184d50-341e-4412-9ffb-22574055d8a8/volumes/kubernet=
es.io~csi/pvc-c200984e-959a-424a-90cf-84a8498a61f0/


But, in dmesg can see these logs, It stuck resizing fs between block 168460=
288
to 168460800.

[Tue Jan 31 06:40:21 2023] EXT4-fs (nvme1n1): resizing filesystem from
168460288 to 168460800 blocks
[Tue Jan 31 06:40:21 2023] EXT4-fs (nvme1n1): resizing filesystem from
168460288 to 168460288 blocks
[Tue Jan 31 06:42:23 2023] EXT4-fs (nvme1n1): resizing filesystem from
168460288 to 168460800 blocks
[Tue Jan 31 06:42:23 2023] EXT4-fs (nvme1n1): resizing filesystem from
168460288 to 168460288 blocks
[Tue Jan 31 06:44:25 2023] EXT4-fs (nvme1n1): resizing filesystem from
168460288 to 168460800 blocks
[Tue Jan 31 06:44:25 2023] EXT4-fs (nvme1n1): resizing filesystem from
168460288 to 168460288 blocks
[Tue Jan 31 06:46:27 2023] EXT4-fs (nvme1n1): resizing filesystem from
168460288 to 168460800 blocks
[Tue Jan 31 06:46:27 2023] EXT4-fs (nvme1n1): resizing filesystem from
168460288 to 168460288 blocks
[Tue Jan 31 06:48:29 2023] EXT4-fs (nvme1n1): resizing filesystem from
168460288 to 168460800 blocks
[Tue Jan 31 06:48:29 2023] EXT4-fs (nvme1n1): resizing filesystem from
168460288 to 168460288 blocks
[Tue Jan 31 06:50:31 2023] EXT4-fs (nvme1n1): resizing filesystem from
168460288 to 168460800 blocks
[Tue Jan 31 06:50:31 2023] EXT4-fs (nvme1n1): resizing filesystem from
168460288 to 168460288 blocks

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
