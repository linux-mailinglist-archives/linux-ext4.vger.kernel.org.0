Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1349E6BDE29
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Mar 2023 02:33:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbjCQBdd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 16 Mar 2023 21:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjCQBdc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 16 Mar 2023 21:33:32 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36E961259B
        for <linux-ext4@vger.kernel.org>; Thu, 16 Mar 2023 18:33:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 79D32CE1D32
        for <linux-ext4@vger.kernel.org>; Fri, 17 Mar 2023 01:33:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AD3D1C433D2
        for <linux-ext4@vger.kernel.org>; Fri, 17 Mar 2023 01:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679016806;
        bh=QIsKk9H8VfHJ9RPl0zSut+NINBN9yZE7S4vUuV8t1Lg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=LvsDXwfiGqaFhqkig0hPw4T5ne5lnIVazjwdr2U7lD41FrSFnhpNkSFSkr5XjNLJm
         BA2S1X7xh4/rupNp56x2hU1CpUDVElm+KIz2DHum76AUn+zrpcqsFuNf4MRgziY5KP
         M5VXgK41Tixrpjpr2hKLeqsK5NWeADP65QE5ltc7+3aG6U6Dn9VdFcw7sdCgWzVw4J
         +ezN62mPeE7s9RQEaTdjF6Ms8aZcF9MKYi3ky8u+wnewCAqxwm0PMHqgYuz1KD1SYU
         iaJDdHewsj3ggxK1NDAhQt95HLCbanwC9qnjhzPkgZv5iDBZ5ZGGlzko71HKcrFDUU
         mOvnZ9/CK+NMA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 9BA92C43143; Fri, 17 Mar 2023 01:33:26 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 217209] ext4_da_write_end: i_disksize exceeds i_size in
 paritally written case
Date:   Fri, 17 Mar 2023 01:33:26 +0000
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
Message-ID: <bug-217209-13602-xcwpTgXtKj@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217209-13602@https.bugzilla.kernel.org/>
References: <bug-217209-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D217209

--- Comment #3 from Zhihao Cheng (chengzhihao1@huawei.com) ---
Created attachment 303970
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D303970&action=3Dedit
diff

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
