Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58608587CFF
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Aug 2022 15:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236126AbiHBNWz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 2 Aug 2022 09:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232425AbiHBNWy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 2 Aug 2022 09:22:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE2615FCE
        for <linux-ext4@vger.kernel.org>; Tue,  2 Aug 2022 06:22:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 92BB561213
        for <linux-ext4@vger.kernel.org>; Tue,  2 Aug 2022 13:22:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F3E2CC433D6
        for <linux-ext4@vger.kernel.org>; Tue,  2 Aug 2022 13:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659446572;
        bh=Zw0UfHZwIcAjOeM8g1Ri/pTUt0SZ2kwuMnGfMAiKQ3g=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=VPcoAQoJbn4pC13sqt0cOYwglYdrWms9kSrNKt28B3A8QVX7XgFgPb0IGUTKjYmUs
         UuWCd6GQxgjZPr750NP9cyOtT5nZyzVj/aZ5jctdH6UgdWtD7M+ePjPgcg7VDuIS4k
         nagEZJ/gXrxW8tfq4jQu/NMvX6Z6alUuLvHP2tpBFHEA0rgDztm3/O/kAl0PeXF6Eq
         gGHeWIgNQffpe6ePoz4wr4UCBGh1BCpiaaeccvO6b3K8oOVBpJzlVaNUI0fq+U0fWU
         XAsFV1flHp7XA6WNeub/QcAmDUZtUB914cZ+/HuDNxQc43CIh4qy4M/asLuuPKOFad
         7HhbAZIInB6wg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id DDF9FC433EA; Tue,  2 Aug 2022 13:22:51 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 56091] kernel oops when copying data to ext4 fs
Date:   Tue, 02 Aug 2022 13:22:51 +0000
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
Message-ID: <bug-56091-13602-VcB4s5IXjp@https.bugzilla.kernel.org/>
In-Reply-To: <bug-56091-13602@https.bugzilla.kernel.org/>
References: <bug-56091-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D56091

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |OBSOLETE

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
