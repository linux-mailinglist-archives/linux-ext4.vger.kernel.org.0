Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3F66EB5C8
	for <lists+linux-ext4@lfdr.de>; Sat, 22 Apr 2023 01:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233609AbjDUXqY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 21 Apr 2023 19:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233520AbjDUXqX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 21 Apr 2023 19:46:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E20531BD4
        for <linux-ext4@vger.kernel.org>; Fri, 21 Apr 2023 16:46:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 67C47653D0
        for <linux-ext4@vger.kernel.org>; Fri, 21 Apr 2023 23:46:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BAB4FC433D2
        for <linux-ext4@vger.kernel.org>; Fri, 21 Apr 2023 23:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682120781;
        bh=Wfq0x1uivVIypuU8Mgw3qVNR66qNQs447WR07v3ar0s=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=or3SQWh0/699MRR1IynKb4W4igC5kz8f1+IsmG3/Db/1pBYts4gYcuqOLJh2lf5xP
         WZiFMgeYk98QkeiDQN6NpGNqDOuMizYB/qV33TMuBR524k5jqE5S9kHk5VHcg6mSGs
         R7gbciKZXQUG+QP113Pk0KQzWnkupXQnZVfBG38Onf6HcSPHjpRVbLfyZCM//n0q0h
         9+s59BOrZg420qkSuFVxwV/xJJUbKfHpA242HaoFgrPCV1Vy1E8IGAbLfwtzQuMvMy
         0NlRsJBAiZsZ06reWI99LdpaqdgFEOnNALGjZhyouR9IgTk/BRQTIKC/hN3k1+jjlz
         ogTz1CddqPxxQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 97A72C43141; Fri, 21 Apr 2023 23:46:21 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 216322] Freezing of tasks failed after 60.004 seconds (1 tasks
 refusing to freeze... task:fstrim  ext4_trim_fs - Dell XPS 13 9310
Date:   Fri, 21 Apr 2023 23:46:20 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: todd.e.brandt@intel.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-216322-13602-67uRYgG2GA@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216322-13602@https.bugzilla.kernel.org/>
References: <bug-216322-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D216322

--- Comment #12 from Todd Brandt (todd.e.brandt@intel.com) ---
Created attachment 304174
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D304174&action=3Dedit
issue.def

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
