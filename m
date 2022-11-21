Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0D4763292E
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Nov 2022 17:15:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbiKUQPz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 21 Nov 2022 11:15:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbiKUQPy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 21 Nov 2022 11:15:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4679D3395
        for <linux-ext4@vger.kernel.org>; Mon, 21 Nov 2022 08:15:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 62B0EB810F1
        for <linux-ext4@vger.kernel.org>; Mon, 21 Nov 2022 16:15:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0EBF2C433D7
        for <linux-ext4@vger.kernel.org>; Mon, 21 Nov 2022 16:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669047351;
        bh=WCn5hKIizRIhsIlfVDV1PuDlpSxRV79pn6J+t3IXMXA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=h+SSwmoLzgFQhPr1V3GeQcKu/2I0A4rWi4+o1PW6anKi4vAoAzS34BP+kLMQUGbMV
         j3I3+OdRFyhoPvrkD4Cr4ijOQngiWOThjLOSTQ9wgGAEhkhyL/rMuTMsxc50N1o+lm
         5Vr4Oq8lFbmYT8RfqXolhBFh32VTAHFjsvZSJJyqh54qMhvHLaJpGT/csUITSMLeYV
         ZY0gtgoN42c7MnrJ+Kj6mc0MCNMBL+1EQjF15+CkAZDP7s1QdS3BXvMOJkJofNHT1S
         UVOM9DHeAPfxFK8TbBgQiGaAD3Ph4AMrNSGzAAXvtPzoORPiaScEd9zh8Bp+RgDLVL
         TgOZL++MuzO2g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id F1DE9C433E7; Mon, 21 Nov 2022 16:15:50 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 216714] Issue with file system image created with mke2fs
 parameter -E offset
Date:   Mon, 21 Nov 2022 16:15:50 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: INVALID
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-216714-13602-BafpLJ2bhY@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216714-13602@https.bugzilla.kernel.org/>
References: <bug-216714-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D216714

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |INVALID

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
