Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68B4A7B566D
	for <lists+linux-ext4@lfdr.de>; Mon,  2 Oct 2023 17:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237881AbjJBPWs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 2 Oct 2023 11:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238014AbjJBPWr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 2 Oct 2023 11:22:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB37A6
        for <linux-ext4@vger.kernel.org>; Mon,  2 Oct 2023 08:22:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D5D0BC433C7
        for <linux-ext4@vger.kernel.org>; Mon,  2 Oct 2023 15:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696260163;
        bh=3KJhKBuP/vZccSFTlOhbJYlJLqX0CJNj3DEzipjPDao=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=fQS1midvDjjTpWDqZOilq4VzTfqj0iPxB9zRY5ofFH/LHiQi20UoYB52fvRQnillK
         KNmzsPTqDMqH6FwAQ3OAy9siYv6exRGz+DD4xIAHR8pgbMmiiwGFoqsFuG9Bvq0J6g
         ltIj+MgGK9Qaj3djP7/7PUhDD4/QAJJRicvbZuwW1ITOng1+6Jaie0QcynSSXQPtLM
         SpmsK4zll6VivMd91rSkl/PHmXyTCXsUPWvw7IBtcI3vgET4Mbv3dUsxmeMas6wBYd
         gpuUWy1kKLkkkBuqjYc3pw9CWCx4vOAR7uZvY2bOutqiSDJsUB6iRsycgzFS7BcKIT
         J65TFtvZB9zfg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id BCF1EC53BD4; Mon,  2 Oct 2023 15:22:43 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 217965] ext4(?) regression since 6.5.0 on sata hdd
Date:   Mon, 02 Oct 2023 15:22:43 +0000
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
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-217965-13602-IASMLk9NuT@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217965-13602@https.bugzilla.kernel.org/>
References: <bug-217965-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217965

Theodore Tso (tytso@mit.edu) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |tytso@mit.edu

--- Comment #3 from Theodore Tso (tytso@mit.edu) ---
What sort of information can you give about the ext4 file system where this=
 is
happening?  How much free space is there?   Can you run "df" and "dumpe2fs =
-h"
on the system so we can see which file system features were enabled?   Also,
can you specify the kind of the block device?

Differential debugging would be useful.  For example, can you try is to copy
the file system image to a hardware, and see if you can reproduce the behav=
ior
using the same kernel build workload?   What if you copy to the file system
image to a USB attached SSD, and see if you can reproduce the behavior?   W=
hat
you attach the USB attached SSD, and use a freshly formatted ext4 file syst=
em?=20
 Does it reproduce then?   If the file system is nearly full, what if you
delete a lot of unused space, to provide a lot more free space, and see if =
it
reproduces then?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
