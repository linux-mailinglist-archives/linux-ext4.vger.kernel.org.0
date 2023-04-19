Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9034E6E7D84
	for <lists+linux-ext4@lfdr.de>; Wed, 19 Apr 2023 16:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbjDSO6L (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 19 Apr 2023 10:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbjDSO6L (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 19 Apr 2023 10:58:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682501BF4
        for <linux-ext4@vger.kernel.org>; Wed, 19 Apr 2023 07:58:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 050E0635CC
        for <linux-ext4@vger.kernel.org>; Wed, 19 Apr 2023 14:58:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 61176C433EF
        for <linux-ext4@vger.kernel.org>; Wed, 19 Apr 2023 14:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681916289;
        bh=kycfpik/2z342zHeM7KF7g0ll9vade4JiXVfnaOObyw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=sCp2YKz4ASaAMUB10l1B1jrnZxAWBW90LKFIygFKv25C171e1xzlqP9PuQSph7AIu
         uJp3JbUd/OnO5V3J6zfVoGFaUcaeyft2bzojSDksGJCvzont4H19tTVRNRDuaydG9i
         JMfVS6ZdYBYm2O3NBJS8mUSdJ/Y3JhRLd+V3XK7y8xxZfW/qMq8cbnW5O0YlLRhwBu
         OG4Z8ut+gv99+TJJcQLDPtdIVF+jUjHEKaKrPAGR+KuwddvKX+nHj3FzvkkdVFX9zZ
         xJONCEsH7JfhEp5XDWN6GHuIup8a+hhUGOpAZGcMSCosUHoaY4JFwoN5k21RBwL4V8
         Irou7sykpukKw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 43715C43141; Wed, 19 Apr 2023 14:58:09 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 216322] Freezing of tasks failed after 60.004 seconds (1 tasks
 refusing to freeze... task:fstrim  ext4_trim_fs - Dell XPS 13 9310
Date:   Wed, 19 Apr 2023 14:58:09 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: lenb@kernel.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: blocked
Message-ID: <bug-216322-13602-ffCGBO1cbS@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216322-13602@https.bugzilla.kernel.org/>
References: <bug-216322-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D216322

Len Brown (lenb@kernel.org) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Blocks|                            |178231


Referenced Bugs:

https://bugzilla.kernel.org/show_bug.cgi?id=3D178231
[Bug 178231] Meta-bug: Linux suspend-to-mem and freeze performance optimiza=
tion
--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
