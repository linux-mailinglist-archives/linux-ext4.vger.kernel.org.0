Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC9C67C58DB
	for <lists+linux-ext4@lfdr.de>; Wed, 11 Oct 2023 18:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232894AbjJKQHv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 11 Oct 2023 12:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234929AbjJKQHu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 11 Oct 2023 12:07:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F30E8F
        for <linux-ext4@vger.kernel.org>; Wed, 11 Oct 2023 09:07:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 88CBAC433C8
        for <linux-ext4@vger.kernel.org>; Wed, 11 Oct 2023 16:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697040468;
        bh=MQe0wNpeZRMAIk/qn033xUgWNVhCR4SKBmksQJPMgRw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=YTQK836EtEh7dbmZrqLRLUTbRQwHPCI/Pfdx4ghgJ4sAy0IF4FCmKwd8tpuG91YTh
         LeK/TH3mL0WedJjojqEVTJefAY8CQbY1GO3p5U5xLaP9RY3N7QskkQH2KP3JVU1Uzc
         J6cKExTy/WxV81GjGp/INGz5XbX1z9SWAHFmn2+jVMgmo/zTRNHE8onWQ0saZ2vw9E
         7UmFBI4ZCILQgW4M+ausMUWxgdjXj6N790sqtmLWWUdpXYpo9SeoSCbBWxk/VKmx+b
         Kle6uu0BSGMjIJBacjvWFk+Hf152pDVqZb1AK2QfSbH9bqbUVp+NRUFRT1+X67Caxi
         FIOGuKw2DKvKw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 685C2C53BD4; Wed, 11 Oct 2023 16:07:48 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 217965] ext4(?) regression since 6.5.0 on sata hdd
Date:   Wed, 11 Oct 2023 16:07:48 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: iivanich@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217965-13602-dvpLP5qPnk@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217965-13602@https.bugzilla.kernel.org/>
References: <bug-217965-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217965

--- Comment #13 from Ivan Ivanich (iivanich@gmail.com) ---
Affected one:
iostat: https://pastebin.com/mau5VYnV
perf:
https://drive.google.com/file/d/15FO5YsvYrFnKtJI9hfl8qPG7oI8SgLeI/view?usp=
=3Dsharing
backtrace: https://pastebin.com/AgjYXhjR
uname -a:
Linux gentoo-desktop 6.5.7-gentoo-x86_64 #1 SMP PREEMPT_DYNAMIC Wed Oct 11
14:40:24 EEST 2023 x86_64 Intel(R) Core(TM) i7-4790K CPU @ 4.00GHz GenuineI=
ntel
GNU/Linux

I don't have 6.4.16 kernel at the moment, will compile it later and provide
relevant info.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
