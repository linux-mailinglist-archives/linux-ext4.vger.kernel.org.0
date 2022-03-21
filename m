Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E66F4E25C5
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Mar 2022 12:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346940AbiCUL5g (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 21 Mar 2022 07:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241718AbiCUL5f (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 21 Mar 2022 07:57:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 987CA2AFB
        for <linux-ext4@vger.kernel.org>; Mon, 21 Mar 2022 04:56:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 07864B81261
        for <linux-ext4@vger.kernel.org>; Mon, 21 Mar 2022 11:56:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B1034C340ED
        for <linux-ext4@vger.kernel.org>; Mon, 21 Mar 2022 11:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647863765;
        bh=SwcsMARHkIGc8j9ZOL8qcwoZjGjWG0BU9wrdAVJc4qk=;
        h=From:To:Subject:Date:From;
        b=rxo3IJLbrfstW5czKh4rka0wwOCW3icFeljTRx3b3S9SFtOabtr717xLazultWezI
         7G9vuHI9UjldUUVbWFaded2TVHS+vqv4OjvqhWYvwHib7PTuvwuNLhisUIiUhlTyXz
         PRavD7LsRJwFX1UDrLrKIV1ToL0soHoMqL9yRfY1jcOcAIYsgkfIJBhmEtd0Bm5F+N
         SO762TtAfRzpZ8hLJkyfYSTOSZ2PyXhiuBuNSXG8Up7IcWeHXTXI0zPIiEHlFiLzQa
         XsjZaEIznpiGfkC13pTYTr+0pX1AjtMOBtbRX4D/N6yAIjpwOGCWFxIcnSYafoFykn
         yuBuICTNU02og==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id A1304C05FD4; Mon, 21 Mar 2022 11:56:05 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 215712] New: kernel deadlocks while mounting the image
Date:   Mon, 21 Mar 2022 11:56:05 +0000
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
 priority component assigned_to reporter cf_regression
Message-ID: <bug-215712-13602@https.bugzilla.kernel.org/>
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

            Bug ID: 215712
           Summary: kernel deadlocks while mounting the image
           Product: File System
           Version: 2.5
    Kernel Version: 5.15.4
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

I have created an image with mkfs.ext4, and modified some of the metadata of
the image. Unfortunately, when I tried to mount the image with a loop devic=
e,
the kernel deadlocked. I have attempted many ways to stop the mount process,
even executed a 'kill' command, but they are failed, only what I can do is =
to
reboot the system. Can anyone tell me why the kernel deadlocked, and how ca=
n I
fix this problem?

I have upload the image to the Google Drive
(https://drive.google.com/file/d/1NjUKdMufpoiyMscpFMdbiwOzyOios-aa/view?usp=
=3Dsharing).
Looking forward to getting a reply :)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
