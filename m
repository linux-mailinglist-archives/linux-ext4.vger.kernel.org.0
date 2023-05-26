Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 792F77127D6
	for <lists+linux-ext4@lfdr.de>; Fri, 26 May 2023 15:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237308AbjEZN4W (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 26 May 2023 09:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbjEZN4V (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 26 May 2023 09:56:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3BCF3
        for <linux-ext4@vger.kernel.org>; Fri, 26 May 2023 06:56:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2731960D58
        for <linux-ext4@vger.kernel.org>; Fri, 26 May 2023 13:56:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6A535C4339E
        for <linux-ext4@vger.kernel.org>; Fri, 26 May 2023 13:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685109378;
        bh=sopAS+pJl3fMGhCEj0QQpqYKGPKfQfOaWvnsoRF5Tmw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Rol12D79zpPjBixuc51xVOkFdjJTlLF8NC29MZpq4+KXBmdNMT0aOSt7YhK+tEQJa
         nWW2Q1wb0aG0KN8uMrTQFOlKHXbA/jWDVsojUKcUfH00R3gPG1qwcbeMY2JTxJUEG8
         ZMa2jJJx7DwxgaFpH40cFRnn+OUr+CbU5eo//kIEBDrjsw5I4FtsVc29m86zAcJFL9
         CPp1R7IimJm3vHDdzbOGSPNxjZBe2C1eDSdV1qug/v0FZ93hiJ2avRSDgh7Bod+rHk
         GFxirG+XjA0uV7/8S+GVrhfoz0VI8IJnvDMI2CzSZ6WToLzWhteSe2WkjBQ+O/HUE5
         STn0g3HwnOp5w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 52E20C43142; Fri, 26 May 2023 13:56:18 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 217490] Wrongly judgement for buffer head removing
Date:   Fri, 26 May 2023 13:56:18 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: bagasdotme@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-217490-13602-thHdeV30va@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217490-13602@https.bugzilla.kernel.org/>
References: <bug-217490-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217490

Bagas Sanjaya (bagasdotme@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |bagasdotme@gmail.com

--- Comment #7 from Bagas Sanjaya (bagasdotme@gmail.com) ---
Can you send your diffs as proper patches to linux-ext4@vger.kernel.org for
review? (Hint: see Documentation/process/submitting-patches.rst for how to
contribute patches.)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
