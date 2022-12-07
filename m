Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD31645FFD
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Dec 2022 18:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbiLGRTt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 7 Dec 2022 12:19:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiLGRTU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 7 Dec 2022 12:19:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7881E51C11
        for <linux-ext4@vger.kernel.org>; Wed,  7 Dec 2022 09:19:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1551361AC6
        for <linux-ext4@vger.kernel.org>; Wed,  7 Dec 2022 17:19:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 69A0BC433B5
        for <linux-ext4@vger.kernel.org>; Wed,  7 Dec 2022 17:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670433544;
        bh=wq//02kNCLYZaQl1q7mEsw6IcFn9jicYqRQTWaJ0lgw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Z9dLTAli7HMqGf3YWXm82GMI7SSQoBIDulRDwmmassqpKt74BsFy4ttsEVq3Ok+NO
         VeR8hJrl7qa47bmjw6zjP0xxOZgPcn6sm4MUJkxYSiAWFAGMY3eANNg6X4ximfMugv
         +bTwRtCkQPzApDwacQUweduc6Z/DT/7EXJ+elq4k06UiHYvFp/fScSQ2zctQzavgh2
         sNbSr5wCjamQoZc2DX+zmSPPxoL4+2FPpSNXQCX1UBlb2ga+gwZbriVJOrq1WL171j
         QfQA210LuK6NFoSg28nxeEH07BWdSxro/3R0XKS+xZWCNq98QS8Ns+Pwl04FZP4Yui
         Cp/eet+3EekjQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 469F3C433E4; Wed,  7 Dec 2022 17:19:04 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 216784] There is "ext4_xattr_block_set" WARNING in v6.1-rc8
 guest kernel
Date:   Wed, 07 Dec 2022 17:19:03 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: tytso@mit.edu
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-216784-13602-HgiuvxqHDI@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216784-13602@https.bugzilla.kernel.org/>
References: <bug-216784-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D216784

Theodore Tso (tytso@mit.edu) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |tytso@mit.edu

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
