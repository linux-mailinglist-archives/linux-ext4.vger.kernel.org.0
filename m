Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 706545B2C26
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Sep 2022 04:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbiIICeb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Sep 2022 22:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiIICeX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Sep 2022 22:34:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8D924E
        for <linux-ext4@vger.kernel.org>; Thu,  8 Sep 2022 19:34:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0DA1261E9A
        for <linux-ext4@vger.kernel.org>; Fri,  9 Sep 2022 02:34:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6A072C43470
        for <linux-ext4@vger.kernel.org>; Fri,  9 Sep 2022 02:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662690860;
        bh=W7LHzLQvEWvRT+gw4/U07Cs8izGRSXgpNUtiYGPLwcQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=i0MNR3EhJv/GJaqx1buNg0FucSPgdit4Ckx84bXb93VN7kMYmpLcRUCgraN0VjntC
         F41jslcxZ0jRO0QVnRCmz1B/2I0HmedY4zby+/abu6ZxJoxw4rvF+5XOH41vLF6v/U
         wZcYMg7IrzQG1xjOZ8MTeIgdwQa0MMHh9/a+Uv5mrzDMB6gvsxo7Iw6c5lMRdh1Vkr
         Xe1yEl6FoGOhq4q2CI0Kkz9icqEKynArXvxWvJcC0e7uoWn4+iEBGk11jyD8lIM0O+
         cyhrjBctdOoxsDW4RigXp6g+Bry0YatQuFg1XaSnS5pbahj0TnWNwWczB77h4Sj/ku
         CW4XHaY4gbCLw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 58178C433E7; Fri,  9 Sep 2022 02:34:20 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 216466] ext4: dir corruption when ext4_dx_add_entry() fails
Date:   Fri, 09 Sep 2022 02:34:20 +0000
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
Message-ID: <bug-216466-13602-m5CxsX1RFx@https.bugzilla.kernel.org/>
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

--- Comment #2 from Zhihao Cheng (chengzhihao1@huawei.com) ---
Created attachment 301777
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D301777&action=3Dedit
diff

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
