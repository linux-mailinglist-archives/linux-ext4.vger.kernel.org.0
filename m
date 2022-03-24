Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC1B54E639C
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Mar 2022 13:47:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242658AbiCXMsI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 24 Mar 2022 08:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350337AbiCXMr7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 24 Mar 2022 08:47:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C62CEA9974
        for <linux-ext4@vger.kernel.org>; Thu, 24 Mar 2022 05:46:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 63C4760DE7
        for <linux-ext4@vger.kernel.org>; Thu, 24 Mar 2022 12:46:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C8F9EC340ED
        for <linux-ext4@vger.kernel.org>; Thu, 24 Mar 2022 12:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648125986;
        bh=XwgaoYQ/w/up7nrdIC0/7cdxHQUUdWdBpGYAGypbXhQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=rXxO7neKQjc1lGx68TvkxzGF6WMiUNcoEZaXKY7VYH/O6aSgda3oBdoOZ4b2OKFg3
         1nNmQhxFWVkc0p+UJKSd+jmWnGHAoOt2TB7lIqS6NiqQWI7wMsFFxCoqZ3b0tFiS8c
         r3I9C84tRUAa91RYVhZD7AsdXHC8OkJAYJLFcc/iJU+5sAzbutrg3XCJywbKvbbCNh
         vyJ8+WXHIhSp9Qu8wK3n0yfLHnJDqunE0Dj9BcXRvUIUujsAXWIF38pSH3L7KkIqF2
         yA4m5OsMbhd/E/xW275mpvCKZxLdA1llPdmwzABTAPnDXtZzRNSkJUaI+kTDD0KtQ4
         avu4E2RU6QwRw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id A642ACAC6E2; Thu, 24 Mar 2022 12:46:26 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 215712] kernel deadlocks while mounting the image
Date:   Thu, 24 Mar 2022 12:46:26 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
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
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215712-13602-T1Adr5sx8D@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215712-13602@https.bugzilla.kernel.org/>
References: <bug-215712-13602@https.bugzilla.kernel.org/>
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

--- Comment #6 from bughunter (yanming@tju.edu.cn) ---
Why does the 'mount' command take so long when using such a small image?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
