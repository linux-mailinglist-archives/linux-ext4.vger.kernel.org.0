Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF2872F570
	for <lists+linux-ext4@lfdr.de>; Wed, 14 Jun 2023 09:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243347AbjFNHFx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 14 Jun 2023 03:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243160AbjFNHF1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 14 Jun 2023 03:05:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C241FD8
        for <linux-ext4@vger.kernel.org>; Wed, 14 Jun 2023 00:05:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 49C70633E5
        for <linux-ext4@vger.kernel.org>; Wed, 14 Jun 2023 07:05:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AC529C433C8
        for <linux-ext4@vger.kernel.org>; Wed, 14 Jun 2023 07:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686726303;
        bh=5l53xIeetLvZ2AeXihaWwW9IUzd8SnYYjx+EDp4MtFs=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=A8PVYOIkIjPg6T5As4q/9ndKIwblM1bm9oBtwewu5TQ8IVLqNAen9yD5osBE0OjhD
         LDR6yBZogmUTYtDmCXE74vfSINRzBcAde5rdzaILDRXJfcwtV5NsslPx/w2QvZT2Ar
         rPQhhwEFj7zlA3gL+Ss/bfifA2NNNPv/XNZdL4eXjX4EytGt38duCng827jjXZpiPV
         RxLYNrsUuVfy+seymbaX11iIIqA6KpsAVlton33458iHsxq9RJy6XpSfZmcPnNAPPT
         NaJlRNfBrDQEj2pBThMAcpSST4DhK+v/LS159/9MrmB7g4XnxIyyOwuBh8hdIt9pmm
         2Zq1p6I8OiRJQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 9C450C53BD0; Wed, 14 Jun 2023 07:05:03 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 217551] Unable to umount block device
Date:   Wed, 14 Jun 2023 07:05:03 +0000
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
Message-ID: <bug-217551-13602-PyCKfKkpGu@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217551-13602@https.bugzilla.kernel.org/>
References: <bug-217551-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217551

--- Comment #2 from Sunil Barhate (barhatesw09@gmail.com) ---
There was no error in /var/log/messages.
Also did not see any stack in dmesg.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
