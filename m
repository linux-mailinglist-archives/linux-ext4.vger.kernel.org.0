Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55646587D01
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Aug 2022 15:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234397AbiHBNXi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 2 Aug 2022 09:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232425AbiHBNXi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 2 Aug 2022 09:23:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD42014036
        for <linux-ext4@vger.kernel.org>; Tue,  2 Aug 2022 06:23:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4855761213
        for <linux-ext4@vger.kernel.org>; Tue,  2 Aug 2022 13:23:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A53EDC433D7
        for <linux-ext4@vger.kernel.org>; Tue,  2 Aug 2022 13:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659446616;
        bh=uqoRaBNJOClmSS5mlHSYo3CnonDzNYdHna4Dtnt3dv8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=USUExHXO2WF56KEHGE6X/mNRv338w/SYxzZIo4Gg2eEA5PCUkKS2e78jIBRwdV8oJ
         S0jJ4JIrXAYJ9I3mQOeWFvJxnP+SA5DPafmQqfwmKhr6+ieLj0JxQ2xqv6HA4luaum
         XEGX92xF3zljX6INjo2gCZhKeq581y/oQcW1OMl11y9mXRTAHcNtRC/H2RG8RaGRe4
         qIMgwvP/WV2VZ7E1O8G3LQhMZCCpEjpfX9R8vq+1cVoqAbxjUfTBytn+u62xraKNQB
         AWkQulGPvHWiiZ2PSe4/8UZVvoOP7o6Cn+01dRx4gDYl0t6kZAiuIgYnrG/GvfdSXX
         8/SqQ+hdjgsEg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 983EFC433E7; Tue,  2 Aug 2022 13:23:36 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 41962] fs/jbd2/transaction.c:1113 and fs/buffer.c:2915
Date:   Tue, 02 Aug 2022 13:23:36 +0000
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
X-Bugzilla-Resolution: OBSOLETE
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-41962-13602-ziR5Fv0ypj@https.bugzilla.kernel.org/>
In-Reply-To: <bug-41962-13602@https.bugzilla.kernel.org/>
References: <bug-41962-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D41962

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |OBSOLETE

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
