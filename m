Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB2C963ACFD
	for <lists+linux-ext4@lfdr.de>; Mon, 28 Nov 2022 16:51:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232328AbiK1PvU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 28 Nov 2022 10:51:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232160AbiK1PvT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 28 Nov 2022 10:51:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9181721A8
        for <linux-ext4@vger.kernel.org>; Mon, 28 Nov 2022 07:51:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F33B6121B
        for <linux-ext4@vger.kernel.org>; Mon, 28 Nov 2022 15:51:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8C7E0C433C1
        for <linux-ext4@vger.kernel.org>; Mon, 28 Nov 2022 15:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669650677;
        bh=p6Ijp0HAPQdyygjfGoFEaOCUkyrIMsNaDtBRYY5kofc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=hYuXSqZi91UU+g7uX9POUmwJBgreDvNGeEzKfxl6r35Fa7uW8jWFvScamb7c5/UJ5
         5kD4I437blIGrNaLzvP/NTfLjdhJ/WFhdht8jODknSwe4zyyGrbwq3HqTSytiGp9BW
         jMwf/dHvcGUC3aKsgeqergGEc/dr6qRxe3M2guouh3wiangQnhXWt5a2TMAssio+vf
         smxKEKoyZOavhvorHLM8Gfks6P9pYjW10LEP0/AHU56lcVrXkVNpV419k8hzfVY0zE
         u+Gu5XseCoEr8RBz7yP1pHvRGBz3jg4KboUzQlexzNLAq0yc3aKSJmph3xEiVKbM/+
         9NCNjGYXI9KKg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 734B9C433E7; Mon, 28 Nov 2022 15:51:17 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 216714] Issue with file system image created with mke2fs
 parameter -E offset
Date:   Mon, 28 Nov 2022 15:51:17 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: tytso@mit.edu
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: INVALID
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-216714-13602-UHEoF1jjyZ@https.bugzilla.kernel.org/>
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

Theodore Tso (tytso@mit.edu) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |tytso@mit.edu

--- Comment #4 from Theodore Tso (tytso@mit.edu) ---
I'm curious --- *why* are you wanting to create file systems with an offset=
 to
begin with?    The original reason why this feature was added was in a high=
ly
specialized case where someone was creating a system image for some embedded
system or for a virtual machine.  In this use case, the image contained a
partition table, and the offset feature was used to create a filesystem at =
the
appropriate location as specified by the partition table.

A typical use case is as part of an automated build procedure where the sys=
tem
image (say, for an Android mobile device, or some ARM development board, su=
ch
as a Beaglebone, Arduino, etc., or some Virtual machine), using the mke2fs =
-d
option to pre-populate the file system with the root file system, or some d=
ata
partition, etc.   Since Best Practices for such automated build systems inv=
olve
creating a reproducible build, there is nothing precious on the file system
that can't be replicated by re-running the the automated build.   So if the
offset is wrong (which is to say, inconsistent with the partition table whi=
ch
was laid down using the same automated build system), the developer will ju=
st
curse to themselves, and can determine the offset by looking at the build i=
mage
creation script, and then adjust that offset to match with the offset that =
was
set in the partition table.

So I'm a bit perplexed about why you were using a random starting offset for
the file system, and why you can't seem to figure out the offset afterwards=
.=20
The typical approach is to RTFS (Read The Fine Shellscript) to determine the
offset, and then to fix the perhaps not-so-fine shell script.  :-)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
