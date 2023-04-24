Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A816EC906
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Apr 2023 11:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbjDXJdS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 24 Apr 2023 05:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbjDXJdM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 24 Apr 2023 05:33:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F10E4A
        for <linux-ext4@vger.kernel.org>; Mon, 24 Apr 2023 02:33:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E895E61F5E
        for <linux-ext4@vger.kernel.org>; Mon, 24 Apr 2023 09:33:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5946BC433D2
        for <linux-ext4@vger.kernel.org>; Mon, 24 Apr 2023 09:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682328784;
        bh=MOVv5FwMN9Mgw+dP7BIVoJQy1pX+UKteFUuUS4Ob0mg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=qKTojMw4LQS4cpPwOinM2Fnssv6arXmz17sH6k6lN+yCM/PyZyq24gdqrpUsk4OMS
         f1bPD5F8AwTTwh1PvA26SgbdvQsgd41NIp/KyNFx1eDfpfUcESBIhIIugJ+p29CEJd
         FIBlp0AWPeE9+FWuhyRNqAxG1tDDiTgaJlNSmnpit6YPKT9kE6X3c16FUYYTJ5kAnB
         lMV41SfOwCVBErxHUkjsPLMbozm23bdUgOEmvdE48kys4UXBfeJHeIyinq2qPnOqnK
         FTYUpPlJ/sAllcDPWwgibmxEyMkN0L0cO7/FpnnueI0z3Urj55D3tPtGphS0wEol6p
         oD/zY5W4YyaJQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 4A436C43142; Mon, 24 Apr 2023 09:33:04 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 217363] jbd2: Data missing when reusing bh which is ready to be
 submitted in checkpoint
Date:   Mon, 24 Apr 2023 09:33:04 +0000
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
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-217363-13602-f7HxvXpSW1@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217363-13602@https.bugzilla.kernel.org/>
References: <bug-217363-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217363

--- Comment #1 from Zhihao Cheng (chengzhihao1@huawei.com) ---
Created attachment 304181
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D304181&action=3Dedit
a.c

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
