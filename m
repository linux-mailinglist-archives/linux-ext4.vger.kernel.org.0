Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A02AD7D0D09
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Oct 2023 12:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376596AbjJTKYV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 20 Oct 2023 06:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376811AbjJTKYU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 20 Oct 2023 06:24:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E16D5A
        for <linux-ext4@vger.kernel.org>; Fri, 20 Oct 2023 03:24:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 507AAC433C7
        for <linux-ext4@vger.kernel.org>; Fri, 20 Oct 2023 10:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697797458;
        bh=jgEPKusJ0jfUT9vlVSIUTiOudO/i758gM5XBTpUEKxw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=po3ZO+2BSMyfdo+TtxM0BxfDt2yfQriJk/DthPdutK43PExBakuRtIEvb+uYmKtSi
         hpgpq4C3b/XZfYJvJQ98avpdNMXuRhVPs+YD4EytlnWFYQmh98NWLORzGnog8QqPhj
         9uPaTteZiJCUKVVwFVkZe3umi2rrO0Ib28TZZVEF6JITeQu5gS+km5GcvJPy/zvDjw
         L/Kd7tvvn1/sRSjlleMna4tQPn2RHivznHTdFZezahr3CoioqB+4jXaanqa+kcIC9M
         dBlh9cpPgvD6WLrJQS523CPYvdRkHNLhyWdQFKoTnd91qEtlP7ZmayJi/CssmVyXRQ
         wf99UpToC1zXw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 3C8C3C53BD3; Fri, 20 Oct 2023 10:24:18 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 217965] ext4(?) regression since 6.5.0 on sata hdd
Date:   Fri, 20 Oct 2023 10:24:17 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: ojaswin.mujoo@ibm.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217965-13602-CZj4kvwVAZ@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217965-13602@https.bugzilla.kernel.org/>
References: <bug-217965-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217965

--- Comment #17 from Ojaswin Mujoo (ojaswin.mujoo@ibm.com) ---
Hey Ivan, Eduard,

Thanks for all the data. The iostat suggests that we are breaking up the wr=
ites
much more as seen in the wareq-sz  field, which is much lower in the regres=
sed
kernel. Further, since the issue is only when striping is used (ie in raid
scenarios) it seems like it has something to do with raiding.

Eduard's replicator seems much easier to try so let me see if I'm able to
replicate this over a raid setup of HDDs.

Regards,
ojaswin

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
