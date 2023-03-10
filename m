Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0876B3F82
	for <lists+linux-ext4@lfdr.de>; Fri, 10 Mar 2023 13:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbjCJMjC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 10 Mar 2023 07:39:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbjCJMi7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 10 Mar 2023 07:38:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D86108C17
        for <linux-ext4@vger.kernel.org>; Fri, 10 Mar 2023 04:38:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D1CA61650
        for <linux-ext4@vger.kernel.org>; Fri, 10 Mar 2023 12:38:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CBF28C4339B
        for <linux-ext4@vger.kernel.org>; Fri, 10 Mar 2023 12:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678451937;
        bh=k2ROaZZKIoEySjO6yiSafGKihaBo17NLxGlMfJwFRug=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=sEezjNbrvqsZkUeyN9+q1dthHmI3hf11Xnjv6ZvWhB6SFQIZYTXnIhb6Nzf1eLrQB
         v+5BYwLuJFzk2EFb0RF4rIl2IS5Uq1ru2xJydARNhGzoROOsIQr4eiEs0X/VeXNz44
         eeaMRD8UxCuyGMC09lEi2DHpZybvjteRV8h798hvyEfYP0+dI7k6PteZ7bCbOol3mj
         gfJuPAuwKpMxXjmMkUfh8gmeQ9hQCCZke1hETr5GVTgf3qJUrM1PVBXE/Las+kooAD
         aUHOQ7Gdz/HKA2vTOioKnW0qIRdPOLQJyGKUIcUH9yqr+ku5Q4B4igWT1HoPt6F9Ja
         NM9KvkR+t6dcw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id BC8AAC43143; Fri, 10 Mar 2023 12:38:57 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 217171] ext4: stale buffer loading from last failed mounting
Date:   Fri, 10 Mar 2023 12:38:57 +0000
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
Message-ID: <bug-217171-13602-Fams4fQdwT@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217171-13602@https.bugzilla.kernel.org/>
References: <bug-217171-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D217171

--- Comment #3 from Zhihao Cheng (chengzhihao1@huawei.com) ---
Created attachment 303918
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D303918&action=3Dedit
main_diff

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
