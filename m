Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEF5D533850
	for <lists+linux-ext4@lfdr.de>; Wed, 25 May 2022 10:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbiEYIWZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 25 May 2022 04:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232661AbiEYIWN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 25 May 2022 04:22:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A3F110B
        for <linux-ext4@vger.kernel.org>; Wed, 25 May 2022 01:22:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 610B761827
        for <linux-ext4@vger.kernel.org>; Wed, 25 May 2022 08:22:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C75E5C34118
        for <linux-ext4@vger.kernel.org>; Wed, 25 May 2022 08:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653466930;
        bh=4v22vIEq/V8XzJsKFBKBWNiEP1EpTvoNCk3rM0wPD9A=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ZziXvo0IIWYgZ07z8wS5wWEmx5oDGGzXbNTCmiC1chzYpF7/9Ym0eFTYzQf1GkqbF
         8e+F37h99Bvz1viET+LCLiCPVnojMFncv8IX7mHJOsxZv6WHadHyxegI4v+IkswV2c
         vJ6nkLUitIKOzgNBywEPtKvxvIx40nC1lTHsa4j545JkBgI2voBEnKlw/kFKjtAto5
         NuFFY+fSiwfYbl3K7/HyNYcoi0VgJ89HFvRx9Nw7kg9cgVX0PIqsLm64d+mhN8oPSV
         v6vFZTEY0X8KGZepGhN4S+4bBQYMsX5GSofmEX80FUwzHbIO2TrA7UvEkMmeWvNPqT
         Czv8wb+kAycrw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 8AB34C05FD6; Wed, 25 May 2022 08:22:10 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 216012] Data loss on VirtualBox VMs
Date:   Wed, 25 May 2022 08:22:09 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: INSUFFICIENT_DATA
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cf_kernel_version
Message-ID: <bug-216012-13602-M8nOzvqw8a@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216012-13602@https.bugzilla.kernel.org/>
References: <bug-216012-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216012

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
     Kernel Version|Linux ubuntu                |Ubuntu 5.13.0-35-generic
                   |5.13.0-35-generic           |
                   |#40-Ubuntu SMP Mon Mar 7    |
                   |08:03:10 UTC 2022 x86_64    |
                   |x86_64 x86_64 GNU/Linux     |

--- Comment #4 from Artem S. Tashkinov (aros@gmx.com) ---
The kernel you're using has a solid ext4 filesystem driver as there are no
similar reports on the net which could mean that you're having issue with
either MacOS or VirtualBox or both and I'm sorry to break it to you but you=
're
on your own.

It makes sense to try this VM on another PC or recreate the VM from scratch.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
