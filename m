Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09FAC7AD78C
	for <lists+linux-ext4@lfdr.de>; Mon, 25 Sep 2023 14:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbjIYMFZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 25 Sep 2023 08:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231556AbjIYMFJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 25 Sep 2023 08:05:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A73B0E64
        for <linux-ext4@vger.kernel.org>; Mon, 25 Sep 2023 05:04:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3530FC433CA
        for <linux-ext4@vger.kernel.org>; Mon, 25 Sep 2023 12:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695643464;
        bh=JQLldtaTL5Ooniw24xq3Xd2/OM+jjIe6KlyXOBN0NLY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=IzsMEPxoV9m2SdH2+eK03xqdr+T/AV7SHGgfMOpajPjI9onOo0cBtaQb/fVjKBIrx
         lrKb4Sydvd46yTa8lLiWPnV83LCEDwXUGyiLH27wZ/tybi4OAt3hzMrADb3jfP2ewL
         pCB1t51hajCRPnxdJ6ypIilPG5NArP1dp5yhSAHoGzH7CkKgtOkfzWr+nL0LCB4+jY
         bDr2u0l1Q54xYKbEFhb5zeylWAQFg/qHl2ONhNBD+VyS2zAy4Bucv9SjwOap5MyVII
         P+6RqOb1EyL+MEL1asPoBfsw+jTGvq1W9tCscS8ljV0HpUdzJ4vk/dcKiWC29VtmDI
         K7bfQ7FSVCIyw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 1D46BC53BD1; Mon, 25 Sep 2023 12:04:24 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 216322] Freezing of tasks failed after 60.004 seconds (1 tasks
 refusing to freeze... task:fstrim  ext4_trim_fs - Dell XPS 13 9310
Date:   Mon, 25 Sep 2023 12:04:23 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: jack@suse.cz
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-216322-13602-IcPSl9ZKqb@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216322-13602@https.bugzilla.kernel.org/>
References: <bug-216322-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D216322

Jan Kara (jack@suse.cz) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |CODE_FIX

--- Comment #16 from Jan Kara (jack@suse.cz) ---
Patches were merged upstream as commits 45e4ab320c9 ("ext4: move setting of
trimmed bit into ext4_try_to_trim_range()") and 5229a658f645 ("ext4: do not=
 let
fstrim block system suspend"). Closing the bug.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
