Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0648576102
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Jul 2022 13:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233284AbiGOL7X (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 15 Jul 2022 07:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233385AbiGOL7S (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 15 Jul 2022 07:59:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D756F1CFF2
        for <linux-ext4@vger.kernel.org>; Fri, 15 Jul 2022 04:59:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D3179B82BB3
        for <linux-ext4@vger.kernel.org>; Fri, 15 Jul 2022 11:59:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 717A9C34115
        for <linux-ext4@vger.kernel.org>; Fri, 15 Jul 2022 11:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657886353;
        bh=w6HcPJeustY3wDocrKEhXJ54eqjpuO1qHRxEyu3j7I0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=b+4IRrECvJiEd44pRy7m9IAwXbro9XXmXDQnRqwiVmb+tf0ckTZdcVUJ6obAmHG/X
         1D8um3hdvAPo+uQPIHF/MiawhgX6kSY4O06UTZq0GoN8XWoBtRhAQ3SxaL6lCoglRC
         e2Cd8H+XjKKVUmGJnRIT081MnH5N5FfOrH27svPVEansNza6xqVq+esrh80tNWA74n
         i7o5BWdAzWHy8/pLRSDdEcZmDR6K7GTg8e+J/gooIKkBv1p45ELJmU7uKXM3b+/r5I
         Dd7oc9FNuA2rQHgqpVFc4putjSxr+GvMW+/jv/aeumdQDg6P9jcsRoO7bk7grR+O1n
         /xkQl4kTgb99w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 619F8CC13B0; Fri, 15 Jul 2022 11:59:13 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 216251] kernel BUG at fs/jbd2/transaction.c:1629
Date:   Fri, 15 Jul 2022 11:59:13 +0000
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
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-216251-13602-SJ3RUrw6IM@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216251-13602@https.bugzilla.kernel.org/>
References: <bug-216251-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216251

--- Comment #2 from Zhihao Cheng (chengzhihao1@huawei.com) ---
Created attachment 301437
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D301437&action=3Dedit
delay_diff

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
