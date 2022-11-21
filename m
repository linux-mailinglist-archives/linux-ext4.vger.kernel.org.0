Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C349631CC4
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Nov 2022 10:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbiKUJXu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 21 Nov 2022 04:23:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbiKUJXt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 21 Nov 2022 04:23:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1620D233B9
        for <linux-ext4@vger.kernel.org>; Mon, 21 Nov 2022 01:23:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C2764B80CC4
        for <linux-ext4@vger.kernel.org>; Mon, 21 Nov 2022 09:23:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8D93EC433D6
        for <linux-ext4@vger.kernel.org>; Mon, 21 Nov 2022 09:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669022625;
        bh=LNHgTir3kQDNhoMTIBe0i4yg6wmLA1IZMMqEZvWU8co=;
        h=From:To:Subject:Date:From;
        b=aRJwf7lhjXrLlk/sv1tmNCuOYsf7s6me1e4+BM0CFcwMOE4sVvTgs07wLRtLYRZbx
         jVRV0G8K1b1c/DRSTCzeDSC26Ma6zVmgb7W6A27NadMadpX6Jhb87p2t/ylFe8b/Eq
         18nwx/GFZD5Z40hkM02F1TG+B1FIpI7wQCjTpPqE3dVaH7jLkNBT77sG2x6k/0aHYn
         e6ASeQc+U79Q018YPs67KqyBFwQ8mADbOPJJQeR4Zpe5S/z/tkig50ahXnCtE+tomI
         CosYd3w7q6cwObuNDUcm49FYHCKMapy5I55Pq4GjprwArxyIR7y7jM9kx9wKFrhnGR
         6qsjCS6NbVwAQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 7E6C4C433E7; Mon, 21 Nov 2022 09:23:45 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 216720] New: [LTP fanotify10] Fanofity10 cases is failed on
 Intel server
Date:   Mon, 21 Nov 2022 09:23:45 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: pengfei.xu@intel.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-216720-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216720

            Bug ID: 216720
           Summary: [LTP fanotify10] Fanofity10 cases is failed on Intel
                    server
           Product: File System
           Version: 2.5
    Kernel Version: v6.1-rc5
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: ext4
          Assignee: fs_ext4@kernel-bugs.osdl.org
          Reporter: pengfei.xu@intel.com
        Regression: No

I worked with Jan Kara for fanofity10 failed case.

And found this unexpected failure is due to 2 NUMA node,  and drop_caches
should keep reclaiming on all nodes.

I reported this issue and narrow down this issue with Jan Kara by email
commnunication.


Jan Kara fixed patch link:
https://lore.kernel.org/linux-mm/20221115123255.12559-1-jack@suse.cz/

Thanks!
BR.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
