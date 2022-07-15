Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7DB05760FB
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Jul 2022 13:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbiGOL7B (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 15 Jul 2022 07:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiGOL7B (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 15 Jul 2022 07:59:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 977DC1BE8F
        for <linux-ext4@vger.kernel.org>; Fri, 15 Jul 2022 04:59:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0163A6228C
        for <linux-ext4@vger.kernel.org>; Fri, 15 Jul 2022 11:59:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5ED10C3411E
        for <linux-ext4@vger.kernel.org>; Fri, 15 Jul 2022 11:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657886339;
        bh=708m2tMaKn15n6b4ZvzbNhPqR+KuYbH0+1Z3CHUHQjY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=jLxDiiZZOXkjaPMoTHdUg99paWBFgfh0fFstzSzpDnkJvkgY9B8/DA9Yd6yDBfQnW
         TidS2cRNOBoEtm+iOVSQ8ZH+srKuUYmD0XTGtxhnuL1/y29zyJn0qF29oPmSvONz+2
         8sjpkLDnrGDwZD84iySiJmYvqWiBKxF8Y+B8vpsV7/1C/PGfRz8Po9xrX0jBUKRuEd
         re+giwy8mXpTCx+4ovAFa+QVpTEzsYrv2vA92+146FXPT1sEEI2QSCwxaboek2ppgE
         rqbwpETB3hPCmJg9byEmwT1uF2ioENpSwqiqww0TBbfrHr88TWWlhkLn+/ilCDCnNX
         lLZ3oBNPAHQhA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 4C514C05FD6; Fri, 15 Jul 2022 11:58:59 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 216251] kernel BUG at fs/jbd2/transaction.c:1629
Date:   Fri, 15 Jul 2022 11:58:59 +0000
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
Message-ID: <bug-216251-13602-d6EIhrl459@https.bugzilla.kernel.org/>
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

--- Comment #1 from Zhihao Cheng (chengzhihao1@huawei.com) ---
Created attachment 301436
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D301436&action=3Dedit
a.c

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
