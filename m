Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 079C9589327
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Aug 2022 22:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236406AbiHCU0f (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 3 Aug 2022 16:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236138AbiHCU0d (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 3 Aug 2022 16:26:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29EBF19012
        for <linux-ext4@vger.kernel.org>; Wed,  3 Aug 2022 13:26:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B960F614DE
        for <linux-ext4@vger.kernel.org>; Wed,  3 Aug 2022 20:26:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 22A1FC433D6
        for <linux-ext4@vger.kernel.org>; Wed,  3 Aug 2022 20:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659558392;
        bh=wYHpdCD5HXAQc1yTpP+qJyY4f4aU+dcUWNdXFtwn6kY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=b/+m95MKFF684IcbPsOrCR0a4ibFmjfcCIbOUKxfA4lt62Ha6I6qO0ETkRo3Lud8g
         NrERFy7uOOX7Azbr54U7ctGK6bb06VqphBNbpWyVkX3+EIloqi5jShs8qqFmFGvNP8
         Ncs8eq03A8OxGjN2v3RQ3tDIxXBYlpPsnRyHp5YwPwNeTo0BCFyQDgEAMRMgcohU2T
         UjkquB1toVGmgpGptEgYi+bt7qLLznlF3ltDZ9x1F8XRqpyD3wH1RghMk7eqMdEXhb
         W1YEgyGy5LZM4UgiOpjEVFjGxI+4gb6ERfmm3e7azciGEjOP8bORqX5JMfC1G+wH/+
         lhdaOXZIiUKWQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 07C3DC433E7; Wed,  3 Aug 2022 20:26:32 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 216322] Freezing of tasks failed after 60.004 seconds (1 tasks
 refusing to freeze... task:fstrim  ext4_trim_fs - Dell XPS 13 9310
Date:   Wed, 03 Aug 2022 20:26:31 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: lenb@kernel.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-216322-13602-H1RljRA495@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216322-13602@https.bugzilla.kernel.org/>
References: <bug-216322-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216322

--- Comment #1 from Len Brown (lenb@kernel.org) ---
Created attachment 301522
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D301522&action=3Dedit
html.gz page showing the failure

The sleepgraph output shows the 'fstrim' kernel thread
continuously calling schedule_time(15000).

Interestingly, re-trying the suspend after this failure
is successful.  So the failure is not permanent.
(perhaps the kernel is waiting for a frozen user process that is allowed to
proceed?)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
