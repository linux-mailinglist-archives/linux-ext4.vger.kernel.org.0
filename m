Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE13E72F565
	for <lists+linux-ext4@lfdr.de>; Wed, 14 Jun 2023 09:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233912AbjFNHEe (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 14 Jun 2023 03:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231878AbjFNHEK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 14 Jun 2023 03:04:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A85A1FE7
        for <linux-ext4@vger.kernel.org>; Wed, 14 Jun 2023 00:03:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AEB12636EB
        for <linux-ext4@vger.kernel.org>; Wed, 14 Jun 2023 07:03:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0ECC9C433CC
        for <linux-ext4@vger.kernel.org>; Wed, 14 Jun 2023 07:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686726218;
        bh=xCXLLdypxoBgD9itVWI3WJkvuXDkr5uvmSOKmPq6xfY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=uYMSzdFY7lwUis4WPeGd3eZveDwzgO06xqkfnryDTvWrAZqEN84gaKtMZ+vXNQaGX
         d8q6Mpmc/mMWjLQqEkz/HA8K8Gx7kIvNXyKHdm1K4nfSA+tFpMduUrKUKgT2Uk3SOa
         rvDCB1FD9zq7714G0a+m0BHYqXDpqwUIZ9upCRli1ZEYD4KXjKtv3YIPFjYukuVnCv
         vLmQ36hO5R/TO2TN0WocOE1zHczju3vSCbq8qyZ5Wo1RYZhzeyZbzkxPW4GuEqXzT+
         j3SVXynG0XtMMU1/iJNKQeeKFQ6fDKjxpmOyAC2U15xkpN23j2CKJHbY8h6K5rZc4U
         BhPmcNlCJ3gaQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id E9B3FC53BD0; Wed, 14 Jun 2023 07:03:37 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 217551] Unable to umount block device
Date:   Wed, 14 Jun 2023 07:03:37 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: barhatesw09@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217551-13602-hc4KVydRk1@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217551-13602@https.bugzilla.kernel.org/>
References: <bug-217551-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D217551

--- Comment #1 from Sunil Barhate (barhatesw09@gmail.com) ---
OS - CentOS Linux release 7.6=20

uname -a=20

3.10.0-957.el7.x86_64 #1 SMP Thu Nov 8 23:39:32 UTC 2018 x86_64 x86_64 x86_=
64
GNU/Linux

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
