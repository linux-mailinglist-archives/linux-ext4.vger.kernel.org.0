Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74D015B2C27
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Sep 2022 04:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbiIICey (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Sep 2022 22:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbiIICeu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Sep 2022 22:34:50 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0144413FA8
        for <linux-ext4@vger.kernel.org>; Thu,  8 Sep 2022 19:34:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id BAF60CE2072
        for <linux-ext4@vger.kernel.org>; Fri,  9 Sep 2022 02:34:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 773C4C433D6
        for <linux-ext4@vger.kernel.org>; Fri,  9 Sep 2022 02:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662690884;
        bh=aB/hspIz0FAnoZIEcjJ8GL+SdiKT9giP8r74Ko4/BOE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=lRU8RXuq0WAnU5H9nX1adLqO39FtYQDzxQxknCHE7ALTiz1/9dvpgYNryXfG+Zj0J
         dlSlk+Ss+nAjAJV2CUfbbxjKWsITdBk87kd7AFBybET3iZLKfYdV4U74QmmsTt/zqL
         fWV6mKAquxPTPdAgKNVOincRGkBfcj63K2JU3VEzm7Q7CT35WIb0v/P1vqoeG0Jnr8
         mRTlukEh8DfIYz0eLGsLGezi/iA5RSo/Z1zcbjgRhe/dqpDesf/MN4m+fMhBrVUqDw
         jJ7nxbbcdcvOIJDCTXoLCBSOohKbGDzQ896YrSyB01kK69vFKMl11PlJ7s9wg1G8SU
         WBkQIcj3OMmmw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 68B02C433E7; Fri,  9 Sep 2022 02:34:44 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 216466] ext4: dir corruption when ext4_dx_add_entry() fails
Date:   Fri, 09 Sep 2022 02:34:44 +0000
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
Message-ID: <bug-216466-13602-bxdSnll7Gw@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216466-13602@https.bugzilla.kernel.org/>
References: <bug-216466-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D216466

--- Comment #3 from Zhihao Cheng (chengzhihao1@huawei.com) ---
Created attachment 301778
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D301778&action=3Dedit
test.sh

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
