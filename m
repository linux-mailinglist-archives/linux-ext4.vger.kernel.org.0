Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C797F4D6E62
	for <lists+linux-ext4@lfdr.de>; Sat, 12 Mar 2022 12:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbiCLLUZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 12 Mar 2022 06:20:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbiCLLUY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 12 Mar 2022 06:20:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4AE621130B
        for <linux-ext4@vger.kernel.org>; Sat, 12 Mar 2022 03:19:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 77C41B82DE1
        for <linux-ext4@vger.kernel.org>; Sat, 12 Mar 2022 11:19:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 44E9AC340F3
        for <linux-ext4@vger.kernel.org>; Sat, 12 Mar 2022 11:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647083957;
        bh=zcvOpSBpEVWsqcmXNT2o+cR+OUNab4hXeCXvGlb85UY=;
        h=From:To:Subject:Date:From;
        b=V8pvzTF9UcDK7vAzvC9Qz4YyKWhSuZBnzR4jAuIpbw8rs7IXLCENLtAhZVASe7yAK
         oQqoR1Wvy1STRyMJqxWMBK2d3h+8LzzhIttb0Bn1zJpEC6F8i1hK3Tl+kRO7Ugo9k9
         bFEOr72JLHBkFfQEYZVBXreHjdsoKP3vXE/Nod236FfD3bFSTB8uqrJo2KCBFhhfVI
         iyylVwo5zDUpjm/zdgoRATZ2fOjWEwAVd2GObNjtVgtrhIGFwIqgGiHBXjR5Z0JoFw
         +vW2sDLq9OB1BlY6Yu8rSfNH5vGL6ggJOXS/pa3L69LN4C9Pa6sgbW+53PPjh5TqsF
         KZ0XbT0XAro+g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 33F30C05FD2; Sat, 12 Mar 2022 11:19:17 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 215676] New: fanotify Ignoring/Excluding a Directory not
 working with FAN_MARK_MOUNT
Date:   Sat, 12 Mar 2022 11:19:16 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: talkwithsrinivas@yahoo.co.in
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression attachments.created
Message-ID: <bug-215676-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215676

            Bug ID: 215676
           Summary: fanotify Ignoring/Excluding a Directory not working
                    with FAN_MARK_MOUNT
           Product: File System
           Version: 2.5
    Kernel Version: 5.11.0-27
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: high
          Priority: P1
         Component: ext4
          Assignee: fs_ext4@kernel-bugs.osdl.org
          Reporter: talkwithsrinivas@yahoo.co.in
        Regression: No

Created attachment 300557
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D300557&action=3Dedit
Test program to show directory exclusion not working

If a  process calls fanotify_mark(fd, FAN_MARK_ADD | FAN_MARK_MOUNT,
FAN_OPEN_PERM, 0, "/mountpoint") no other directory exclusions can be appli=
ed.

However a path (file) exclusion can still be applied using=20

fanotify_mark(fd, FAN_MARK_ADD | FAN_MARK_IGNORED_MASK |
FAN_MARK_IGNORED_SURV_MODIFY, FAN_OPEN_PERM | FAN_CLOSE_WRITE, AT_FDCWD,
"/tmp/fio/abc");  =3D=3D=3D> path exclusion that works.


I think the directory exclusion not working is a bug as otherwise AV soluti=
ons
cant exclude directories when using FAN_MARK_MOUNT.

I believe the change should be simple since we are already supporting path
exclusions. So we should be able to add the same for the directory inode.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
