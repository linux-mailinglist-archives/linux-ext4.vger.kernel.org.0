Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9E975A7B25
	for <lists+linux-ext4@lfdr.de>; Wed, 31 Aug 2022 12:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbiHaKQS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 31 Aug 2022 06:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbiHaKQO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 31 Aug 2022 06:16:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4141020BEF
        for <linux-ext4@vger.kernel.org>; Wed, 31 Aug 2022 03:15:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D1A80614AF
        for <linux-ext4@vger.kernel.org>; Wed, 31 Aug 2022 10:15:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 37E23C433D7
        for <linux-ext4@vger.kernel.org>; Wed, 31 Aug 2022 10:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661940911;
        bh=0WkFRQ3PRuxlCHSlsm+K9ih5GqMf6IL/XHT6s0mL06s=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=U/hSn2ddTbM/90nDZ2mKb8y1NFRy1deoJTA1hzP0Z4hNyHBSyx1U5gLJ3byZZwVpa
         aRsra34s/6dPBiyU1cbEYYRTCWaAb3ziuzVMHLAdveeCPEZhIzGMox8C+HZ3Emr996
         apuH2+N0KoJH3u6fPmDtgvV3C8Ff/PdrFrU/HpWP9+EsRLU7vpppMtCgVRdDCjnye4
         vvmdRDMyjLqXOuq6GCE5BRbtAWfIQ5HwXedJHr1hmSG9l3QG4gw7lk6XOd3+hxsV5x
         neMQ6WC+aUZlrAVrvhASfX9O8lBjKEiBfbEIb6xxFojSNeiLwxZ/40lqFpzFJ00nA0
         Hrw04g6jA6XDg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 0855AC433E7; Wed, 31 Aug 2022 10:15:11 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 216430] mdtest may pause for 5-10 mins on ext4
Date:   Wed, 31 Aug 2022 10:15:10 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: sunjunchao2870@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216430-13602-ovvzOUjxdN@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216430-13602@https.bugzilla.kernel.org/>
References: <bug-216430-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D216430

--- Comment #1 from JunChao Sun (sunjunchao2870@gmail.com) ---
Memory info abouht machine:
[root@client2 ~]# free -g
              total        used        free      shared  buff/cache   avail=
able
Mem:            251           3         244           0           3        =
 246
Swap:             0           0           0

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
