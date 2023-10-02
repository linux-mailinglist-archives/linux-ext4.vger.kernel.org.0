Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06E207B4D9F
	for <lists+linux-ext4@lfdr.de>; Mon,  2 Oct 2023 10:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjJBIwI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 2 Oct 2023 04:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjJBIwH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 2 Oct 2023 04:52:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF58C91
        for <linux-ext4@vger.kernel.org>; Mon,  2 Oct 2023 01:52:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5BCD1C433C7
        for <linux-ext4@vger.kernel.org>; Mon,  2 Oct 2023 08:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696236725;
        bh=8O/EOnN9uk5IU4Vev2RBgwqBYP1vk8ffgsmSIAEohVs=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Fs8IJ6bGo7cg9WhW3duzqP4QPLia261VEG5ZFBhnS8kqOj39SytB0OOcoFeDmYLf0
         +3xmxsRiyezIVNs0xYTD9Cz7qLGnN+NXUqZxv892gUdU07U+1sziuRKU+ECmomliQz
         9oxTIt6TzSUOaLs1zeu2N4XjFsBljT6ox8sfei+VBjGiWrkrLh8BTnmWJm7/zBdGOF
         /xwtH5e/JiEpf6GGHSktA5NGZSV9rd2VVaxbWeZqwLj9ti4JVkKf5IIo/mEYxO3rQY
         ibVd174fFXy7FKU2Ib50Ie3z3vQJAjHWuNa0lTmtX2Tf4ylTv4+cIdXjs4/8umgq7n
         NnuWbR7dRG4KA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 47A28C53BCD; Mon,  2 Oct 2023 08:52:05 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 217965] ext4(?) regression since 6.5.0 on sata hdd
Date:   Mon, 02 Oct 2023 08:52:04 +0000
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
X-Bugzilla-Changed-Fields: cc cf_regression
Message-ID: <bug-217965-13602-iNkuwwcSvb@https.bugzilla.kernel.org/>
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

Ivan Ivanich (iivanich@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |iivanich@gmail.com
         Regression|No                          |Yes

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
