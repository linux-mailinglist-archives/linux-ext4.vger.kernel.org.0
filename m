Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A79796AFD1F
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Mar 2023 03:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjCHC5P (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 7 Mar 2023 21:57:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjCHC5O (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 7 Mar 2023 21:57:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35EF4A335E
        for <linux-ext4@vger.kernel.org>; Tue,  7 Mar 2023 18:57:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE1136163C
        for <linux-ext4@vger.kernel.org>; Wed,  8 Mar 2023 02:57:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 32783C433EF
        for <linux-ext4@vger.kernel.org>; Wed,  8 Mar 2023 02:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678244233;
        bh=zGqTe6PKK7XIpUtQNsjdhSGePQfEjCC/ME9I8xNMB2E=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=rHAkz9JZTkXOXpD8eXWEJg1JVHF02UFMl1KBKRhjrcLs0UD3ceYh0DE1/7Sgy675N
         QAiSz/3feQteI9HgpgmbHlN1PfbGQjnc9vn04foVyBj+iZpnY/b6RBiD62tCsJJImT
         s6KOPWmiHNC1O1xOoGTVgiNMMly5lDoNq5m+3k8HoYIl59EymEwev+xm8d4gmow/3M
         c7EQel3rV2Sv8oOqtu8MoKf8QoeQuD8VyDpurlY5BnpauSe2WbaKvfoD7YAgR3RikP
         99udA/xaIL/ekjPgVQY1rX3W+/1VB6epXVONYSp/Do2U2MmbobT8wwA+2INV9wr90N
         c8o0jtLjYqyWA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 21F98C43143; Wed,  8 Mar 2023 02:57:13 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 217159] WARN in ext4_handle_inode_extension: i_size_read(inode)
 < EXT4_I(inode)->i_disksize
Date:   Wed, 08 Mar 2023 02:57:12 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: chengzhihao1@huawei.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-217159-13602-JW4W8erZ5D@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217159-13602@https.bugzilla.kernel.org/>
References: <bug-217159-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D217159

--- Comment #1 from Zhihao Cheng (chengzhihao1@huawei.com) ---
Created attachment 303897
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D303897&action=3Dedit
disk

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
