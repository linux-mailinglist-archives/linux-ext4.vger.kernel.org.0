Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 695A1712816
	for <lists+linux-ext4@lfdr.de>; Fri, 26 May 2023 16:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237312AbjEZOMP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 26 May 2023 10:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236978AbjEZOMO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 26 May 2023 10:12:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F31A7
        for <linux-ext4@vger.kernel.org>; Fri, 26 May 2023 07:12:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E57765010
        for <linux-ext4@vger.kernel.org>; Fri, 26 May 2023 14:12:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BAF1FC433D2
        for <linux-ext4@vger.kernel.org>; Fri, 26 May 2023 14:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685110331;
        bh=pwKLmhFl1WKPWaJM/9oInQTgpdFKaHeTbSjoBiNAWjI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=MUntzaKbEKzvb4DERCNFFWhwD0JU/91XqFckaL11g6yOGAIS23Xar/GZUK3NTu9OD
         PT29zgz/AYD61NFAJ9Izzm0c8DiNfesDZkwXx5NcI4MBlvwqV9kOuHDuUr+QJ0xRgj
         dGtYGZRwW1rKDoCRu3anO2T6uRZ4e4o5Ch2GnNtRoT70aXzpKh30fNkgXqaOFxOh2q
         QOfKxey8Qnza12A/qO9YRi6p8bT2w2UjsfWTPfjqjapgyVFnvomclMfXlN4CVPGv3s
         Z2qYaCbXudDiKZLQRpZuvm6vBFA+X4f9CBTH9270OFI6pY0CJDYsd9VubtK+A3bfw7
         Bh3zwdINvs1mQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id A83CFC43143; Fri, 26 May 2023 14:12:11 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 217490] Wrongly judgement for buffer head removing
Date:   Fri, 26 May 2023 14:12:11 +0000
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
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217490-13602-0xRNyrMskk@https.bugzilla.kernel.org/>
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

--- Comment #8 from Zhihao Cheng (chengzhihao1@huawei.com) ---
(In reply to Bagas Sanjaya from comment #7)
> Can you send your diffs as proper patches to linux-ext4@vger.kernel.org f=
or
> review? (Hint: see Documentation/process/submitting-patches.rst for how to
> contribute patches.)

These diffs are used to reproduce above problems, formal fix patches are un=
der
writing and being sent out soon.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
