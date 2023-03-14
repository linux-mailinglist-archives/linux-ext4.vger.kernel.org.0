Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03ED56B9502
	for <lists+linux-ext4@lfdr.de>; Tue, 14 Mar 2023 13:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232475AbjCNM5p (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 14 Mar 2023 08:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231350AbjCNM5a (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 14 Mar 2023 08:57:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A2CA8C75
        for <linux-ext4@vger.kernel.org>; Tue, 14 Mar 2023 05:52:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 350AB61761
        for <linux-ext4@vger.kernel.org>; Tue, 14 Mar 2023 12:51:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9063FC433D2
        for <linux-ext4@vger.kernel.org>; Tue, 14 Mar 2023 12:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678798315;
        bh=Dqip2iNX0CwvA2Ev/D/MlkkXqGS8oIOP43g6vx2mH/4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=b/gmg0kcDKL1OLxR5KcpKZpfdyFjzwdN0N+ur7ShEwMKS6Wsifde4Yw08XNS8RCol
         YPSea7aMg/xO6MC8tNvlU3JI2V4wup2gq3dhRsprlyq62HOkBxk/1qnLyvFqAAu/XO
         9DN5JesMoeyx58bToAb2Fe2Rhc9tiPXgqRoZargdTT0Mf0NyWZC+5EqJz7fzZgVClY
         DnPEiMU1Kb+1rUVsPrZpEnY0zy8bbCpgyGd/fSs2mXv68I6ZP8uuVbzWdoVvaulLdL
         4MgPv2Zl+nK1oSER6x50g6jAVQ49khDPqJxtC3H7WJcWWET83KVwnx5jVa+VqoH8tQ
         gujKlj1jbAPMw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 77A7CC43144; Tue, 14 Mar 2023 12:51:55 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 217189] SATA HDD not detected
Date:   Tue, 14 Mar 2023 12:51:55 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEEDINFO
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status
Message-ID: <bug-217189-13602-cdvTLzuVin@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217189-13602@https.bugzilla.kernel.org/>
References: <bug-217189-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D217189

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |NEEDINFO

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
