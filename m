Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4C0B4E6335
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Mar 2022 13:22:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237339AbiCXMXU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 24 Mar 2022 08:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350114AbiCXMXT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 24 Mar 2022 08:23:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5078AA94D1
        for <linux-ext4@vger.kernel.org>; Thu, 24 Mar 2022 05:21:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ED2ACB8238E
        for <linux-ext4@vger.kernel.org>; Thu, 24 Mar 2022 12:21:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B74B5C340F8
        for <linux-ext4@vger.kernel.org>; Thu, 24 Mar 2022 12:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648124498;
        bh=LWB0BI8bHgQ/v+SLOyInrbpqbqRDsnbqtzBHXSwxBlM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=DFHRFeq9MuUsVzachL/GFWMmfCdbFSE7cttLB0HI+wb8xLZ249lcdmb330FvGdgnq
         Q36O/8btwEq4aFeycb6GASyTReYDPL8bCJADBzvhtejj3FEjBj5prSTmqXGiqBwwQY
         OdmqxojCavzXl7+V6ERd3PLjoXl1+Utp9ZZWPdS62imL1hXMH4kv4UMjDqV0u7TqW2
         amcv1AxDlzRbhbRFbRvmOP1gA1ctoUtm181h03cacBXmFjO2zs+nosyK+dqC4nPr6d
         XIaOJWemULa0PN2CdRWGDjhK1Q5pw6qXOeWdHWNpgMIy3stBtX74ttuH1MBdrr/urK
         ACaaDR5PI3lUA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 8D26CCC13AD; Thu, 24 Mar 2022 12:21:38 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 215712] kernel deadlocks while mounting the image
Date:   Thu, 24 Mar 2022 12:21:38 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: lists@nerdbynature.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215712-13602-IVPpFncmgn@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215712-13602@https.bugzilla.kernel.org/>
References: <bug-215712-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215712

--- Comment #5 from Christian Kujau (lists@nerdbynature.de) ---
Another attempt to mount the image through trace-cmd took an hour to comple=
te
and produced a trace.dat file, good thing btrfs compression shrank that dow=
n to
18 GB :-)

$ trace-cmd record -e ext4 mount -v -t ext4 -o loop,ro,debug ~/tmp.img
/mnt/test/
$ trace-cmd hist
  %-2110.90  (599) mount    ext4_es_lookup_extent_enter #2097643693
         |
         --- *ext4_es_lookup_extent_enter*

  %-2110.90  (599) mount     ext4_es_lookup_extent_exit #2097643669
         |
         --- *ext4_es_lookup_extent_exit*

  %-0.29  (33) kswapd0           ext4_es_shrink_count #292356
         |
         --- *ext4_es_shrink_count*

  %-0.00  (597) trace-cmd           ext4_es_shrink_count #2592
         |
         --- *ext4_es_shrink_count*
[....]

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
