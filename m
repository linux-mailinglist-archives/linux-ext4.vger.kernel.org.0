Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03AA67984CF
	for <lists+linux-ext4@lfdr.de>; Fri,  8 Sep 2023 11:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233617AbjIHJae (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 8 Sep 2023 05:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjIHJae (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 8 Sep 2023 05:30:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311971BDD
        for <linux-ext4@vger.kernel.org>; Fri,  8 Sep 2023 02:30:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CDCFCC433C9
        for <linux-ext4@vger.kernel.org>; Fri,  8 Sep 2023 09:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694165429;
        bh=t6xWon+e8FEt9eKRB0Zgwq7fxjsz7kRc5SK1ahcbEg8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=t1qqLpmFXJHEH0cfLuvnPp+T4riu81bBlcap3JnFK/qfUWGN+JnTTLku9x23EIkWL
         yZ0qz42N98drpZzko76+K4PoUvxye5ZkILVLyN1+50Fu4GE/h6LUH+4vX5qKdhtkng
         3r24Mdz8GUbjPBnAYRMW1nJc1ebGp1e48zMCm7QRMPLk+RNEBsicZHrQsKua52jxC9
         tnxhZzNj9InRQywKeO1AOZ4XHRPH3+aLwmv6G0WntrCGv7V2Pdx4Odp+7YRwz/RuO9
         A7gPansO1ZibQgZyt0gsrIxjuqKBnRJfD9X4vC6PM5jtkPXBVRp3zEV+aVrlgQTuO7
         CwFXtkiL6D1xg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id BB578C53BCD; Fri,  8 Sep 2023 09:30:29 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 217888] jbd2: potential data lost in recovering journal raced
 with synchronizing fs bdev
Date:   Fri, 08 Sep 2023 09:30:29 +0000
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
Message-ID: <bug-217888-13602-ROJbwtrtrZ@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217888-13602@https.bugzilla.kernel.org/>
References: <bug-217888-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217888

--- Comment #4 from Zhihao Cheng (chengzhihao1@huawei.com) ---
Created attachment 305069
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D305069&action=3Dedit
disk

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
