Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CABB5747D0B
	for <lists+linux-ext4@lfdr.de>; Wed,  5 Jul 2023 08:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbjGEG2o (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 5 Jul 2023 02:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbjGEG2n (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 5 Jul 2023 02:28:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B57E010CF
        for <linux-ext4@vger.kernel.org>; Tue,  4 Jul 2023 23:28:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A01161448
        for <linux-ext4@vger.kernel.org>; Wed,  5 Jul 2023 06:28:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A7674C433C8
        for <linux-ext4@vger.kernel.org>; Wed,  5 Jul 2023 06:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688538521;
        bh=URR1M2fiC4LECN/31ZO0FA7Sq0XdD3srnGn05ZxRfMg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=BjNaW8b4suM3GPpFdLN0OtxO+rA3RlUmfyjn92HLdYZhC0x/BXbftlrPHieOygQUt
         FhsPeIZsHYeCHsf6JajYROlyFHjzrSgLYrE3nLk/yOOUMbtjNKvvhao4UBWeQm+oqO
         p2EpX6F/0xDeCaEL+K6fOljL58SDZpw4yFwO8reT+Oinn1EIWPs0dihpBOqfO3pwH7
         q2KWvAG9g8rCZ96viZoIJS/J2kFdngdeHo5Xe5Qa+lb24IryK6yGxdgfUkvAd4+ZMC
         ZlDdXTiMKv5frxt2eULiG6EzSOYGJSJogNdiJP3dOrx5DaihVlFgCgNSgnuo3KneMz
         cJrb/Ohk+tUzQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 91DEAC53BC6; Wed,  5 Jul 2023 06:28:41 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 217633] the insertion of disk  to  DVD make bad remout /dev/sda
Date:   Wed, 05 Jul 2023 06:28:41 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: rouckat@quick.cz
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217633-13602-mVO0LXNaAw@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217633-13602@https.bugzilla.kernel.org/>
References: <bug-217633-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D217633

--- Comment #3 from rouckat@quick.cz ---
Thank you for answer. only you information: if /dev/sda was the systemdisk =
or
not, problem was the same. After the remount, usually had to be shut down a=
nd
switch up. Now it looks like: problem, may be in the  cabeling. it looks li=
ke
connection the disk and dvd to another power cables solve? this problem? I'l
try this. I am so sorry and I will inform you, if it will necessary.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
