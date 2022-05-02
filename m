Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB70516AD7
	for <lists+linux-ext4@lfdr.de>; Mon,  2 May 2022 08:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239541AbiEBG1w (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 2 May 2022 02:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233116AbiEBG1u (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 2 May 2022 02:27:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E851B2723
        for <linux-ext4@vger.kernel.org>; Sun,  1 May 2022 23:24:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D36160C23
        for <linux-ext4@vger.kernel.org>; Mon,  2 May 2022 06:24:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B78E5C385A4
        for <linux-ext4@vger.kernel.org>; Mon,  2 May 2022 06:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651472660;
        bh=33onz66lA39fD6ZGIaKpByMFmNgxmYblLokNwFUnze0=;
        h=From:To:Subject:Date:From;
        b=mbMAVQqrgOmsNg2Mtv5oOJNDjxWB5QOcLByVQmO/vEaeg0f6lQXP0Y4nWX53MxQFq
         r9dhvj+m+Ueuf5Au5HQ3Nn74aZ51qYdyH2hu/OWysVkbGMVkCSsSQEl66HaDgwrwAX
         C7EXvGSy2Byx+OEQgcPOx9HokdakYsUjyo8NxAH/Ibj7Lt++JadrtmYaASFWyImFaw
         MjHahhX0wRVicPJzMlPdSAf9la2EYNog0lCce0OVv92awwh+yBKE4ifiMJ5zd0/NMg
         tVCTa23zrRjEBrKWfsXehSmBwuwOIq5orBORyxTKrfvBeGniaHXlNmSbfL+YpVbADW
         1a85zKKM2VZPw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 9F2D6C05FD0; Mon,  2 May 2022 06:24:20 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 215932] New: kernel hangs after mounting the image
Date:   Mon, 02 May 2022 06:24:20 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: yanming@tju.edu.cn
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression attachments.created
Message-ID: <bug-215932-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215932

            Bug ID: 215932
           Summary: kernel hangs after mounting the image
           Product: File System
           Version: 2.5
    Kernel Version: 5.17.5
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: ext4
          Assignee: fs_ext4@kernel-bugs.osdl.org
          Reporter: yanming@tju.edu.cn
        Regression: No

Created attachment 300866
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D300866&action=3Dedit
compressed image

I have mounted a Ext4 image with several mount options. When I try to creat=
e a
file on the mount point, the kernel hangs. The process even cannot be kille=
d. I
am wondering whether there is a bug in the file system?

This issue can be reproduced by running the following commands:
losetup /dev/loop0 case.img
mount -o
"acl,oldalloc,user_xattr,jqfmt=3Dvfsv1,nojournal_checksum,nobarrier,inode_r=
eadahead_blks=3D8,journal_ioprio=3D7,auto_da_alloc,init_itable=3D0,noblock_=
validity,dioread_lock,minixdf,errors=3Dremount-ro"
/dev/loop0 /mnt/test/
touch /mnt/test/test

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
