Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD86450D2D1
	for <lists+linux-ext4@lfdr.de>; Sun, 24 Apr 2022 17:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232086AbiDXPiE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 24 Apr 2022 11:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238322AbiDXP0n (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 24 Apr 2022 11:26:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E1A11F60D
        for <linux-ext4@vger.kernel.org>; Sun, 24 Apr 2022 08:23:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 49EDFB80E13
        for <linux-ext4@vger.kernel.org>; Sun, 24 Apr 2022 15:23:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 016F5C385A7
        for <linux-ext4@vger.kernel.org>; Sun, 24 Apr 2022 15:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650813820;
        bh=vEx6xfS/KnLQdpBhm//UGhfMRYr8Lyt1i1p3j0ZoXzc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=CV/cghfYetHBvSR0Tx18+Jeuf0QkMwGMf6B3azH2vKfa8/eZIXQe9ttd6d69KEGqX
         9EShkWz8MoTWmXjWf/7oXXWeOjNCgJen5ww03YzEwyZiVTww7XCWPQSXiITcd4QRnf
         xHIHbdnA5wpJlw+ncTMaKed0T6HlpKnD8+qz5SOluDtkW/Ax7ATP9dli98sGpWI2cC
         RgkH1AH5SWoZTivDoFe4z3PI4oQuTkHKt9jC+i1hzw7W6rlyEmxIDAgbJS/P6Le2RM
         175TYmnbAnplBc/0Y4skjb4TX1G4r0Nkgu05X9OS67o8tvuNtxl7/sv7cUes3txUFJ
         K/otX6OqfjTPA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id D02D1C05FD6; Sun, 24 Apr 2022 15:23:39 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 215879] EXT4-fs error - __ext4_find_entry:1612: inode #2: comm
 systemd: reading directory lblock 0
Date:   Sun, 24 Apr 2022 15:23:39 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: ionut_n2001@yahoo.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-215879-13602-xCPkgBQh6d@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215879-13602@https.bugzilla.kernel.org/>
References: <bug-215879-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215879

--- Comment #1 from sander44 (ionut_n2001@yahoo.com) ---
Created attachment 300795
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D300795&action=3Dedit
config kernel

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
