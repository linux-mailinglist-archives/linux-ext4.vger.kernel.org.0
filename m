Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0F956CB0E
	for <lists+linux-ext4@lfdr.de>; Sat,  9 Jul 2022 20:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbiGISW4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 9 Jul 2022 14:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGISW4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 9 Jul 2022 14:22:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A7DE1403F
        for <linux-ext4@vger.kernel.org>; Sat,  9 Jul 2022 11:22:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 095CFB802C8
        for <linux-ext4@vger.kernel.org>; Sat,  9 Jul 2022 18:22:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 962DFC341CB
        for <linux-ext4@vger.kernel.org>; Sat,  9 Jul 2022 18:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657390972;
        bh=B+LWzUarvz3PaexKyAi01TyD32wqS8zLOvInndhxb64=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=GOpSyx9Dw2zPDGRDewltFJXW08JL4aN2AUKVFAqLI5T9SIEgrAsXXpWNNtPXTmsr0
         OcforShtuR8JVVu90xyfiKLYp9yre/+Gl6OIQjLjni75xGXT/MNZaQKqCDZJNpEATM
         /drXwZhA9Tqt2EiREceNw8ZvEvpySTiUrZZUcxSns7oMH8iTb7bbYq6zie3soB92mh
         V/cDbnfrQbhqM9HdUR5FMdQjiViTDjPhwy7QEXIvT+s56sc7Lt5BUSgDUpV9wdMSDR
         PoTF+GMDbqpva4b6WudJZsWBBG687fO8wSQuMXxkHOFi8Hvz0epDjcbBI2K3Rnp1DW
         fuK8aQ8fBRfnQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 87644CC13B8; Sat,  9 Jul 2022 18:22:52 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 216229] Same content in two different files - strange problem,
 unsure if caused by kernel housekeeping
Date:   Sat, 09 Jul 2022 18:22:52 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext2@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext2
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: joerg.sigle@jsigle.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext2@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: rep_platform
Message-ID: <bug-216229-13602-4kCnQWCh7Y@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216229-13602@https.bugzilla.kernel.org/>
References: <bug-216229-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216229

Joerg M. Sigle (joerg.sigle@jsigle.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
           Hardware|IA-64                       |AMD

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
