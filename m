Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 152525EC478
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Sep 2022 15:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232726AbiI0Nai (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 27 Sep 2022 09:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232892AbiI0NaL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 27 Sep 2022 09:30:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5174E48CBB
        for <linux-ext4@vger.kernel.org>; Tue, 27 Sep 2022 06:25:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 16981B81BBD
        for <linux-ext4@vger.kernel.org>; Tue, 27 Sep 2022 13:24:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C8BC5C43470
        for <linux-ext4@vger.kernel.org>; Tue, 27 Sep 2022 13:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664285061;
        bh=FP2Ue4sE6O/eu/QG4VpcjBlXcP2+ySbNtEV5Kxl89rc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=uWwp3RzVehsY17BZP5i/ZbFMJI5mNA90lfdWRB/1iihj+rRTUoqN6Jb40bdawu+Cz
         gYeD7hAgAJST3qPSkhe9snP0nw1Cuw9zyhQHTKCgw/9rHDTmK7B2LDm9sl5j/kdP3O
         plhNrnOk06S1igxpPpC4wH0rzD9CYGp8nxO936B5oVmXF3KxS6H2Eu994x6bSb7Ydr
         F6dc436haNaSvOjDtRQ8i2oJYHhkns48mnIwtTI8fHxX06sbU2DE2fwJg30u8oitGA
         6oqb8XnC/sJSj3asthKeZTMfzZ11L9sJUpv3aupPABZMTw1hrre90ErvQOBfa1P5Vs
         swOr8Zd7ENTAA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id AFB83C433E9; Tue, 27 Sep 2022 13:24:21 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 216322] Freezing of tasks failed after 60.004 seconds (1 tasks
 refusing to freeze... task:fstrim  ext4_trim_fs - Dell XPS 13 9310
Date:   Tue, 27 Sep 2022 13:24:21 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: brian.bascoy@kaluza.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216322-13602-9ougypd0bl@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216322-13602@https.bugzilla.kernel.org/>
References: <bug-216322-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216322

--- Comment #11 from brian.bascoy@kaluza.com ---
Thanks very much Jan, I think you are absolutely right and it is indeed an
issue with Fortinet VPN client (which includes some anti-malware
functionality). Sorry about the confusion.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
