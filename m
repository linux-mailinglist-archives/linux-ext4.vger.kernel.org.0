Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5F6712716
	for <lists+linux-ext4@lfdr.de>; Fri, 26 May 2023 14:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237058AbjEZMzp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 26 May 2023 08:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237306AbjEZMzo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 26 May 2023 08:55:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D35710C7
        for <linux-ext4@vger.kernel.org>; Fri, 26 May 2023 05:55:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C7FAF60C7C
        for <linux-ext4@vger.kernel.org>; Fri, 26 May 2023 12:54:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F00DAC4339B
        for <linux-ext4@vger.kernel.org>; Fri, 26 May 2023 12:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685105689;
        bh=Gt5kwiqWQNWCp78mafu+20zezxPyUuYn+F0mRZKu5s0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=VW+dletTPm57/BDEDnDUJtuucYW1osw37v2HvMAoX83KwWMzKDldpy4wP3f9KpZRv
         oa+5vFi6TScHAZuVmxhKlDdKvmRSL4tLgKqZSatVDdQjTuUanjYY2lgunnhhRlrDdm
         MCWr05Tu9d5X76JKxW5miL9Oo0dT6uXDH7QokRRU5tkDiuagcAEV23RzYdJg+OCs5j
         rfatrWXmlX5lXGY1jUrv+heJcGgfT/R3/xZDLshHAPJSflIIf0Q8vynbq9awYSP5E4
         IGUz6nhBkjPW47E4U4PWJHNaePPeN7nxWn2RUXS3FwCivLJX8EiMI6i4iOUXR5CkRR
         YYSWeDDm3MKnQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id DE6A4C43142; Fri, 26 May 2023 12:54:48 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 217490] Wrongly judgement for buffer head removing
Date:   Fri, 26 May 2023 12:54:48 +0000
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
Message-ID: <bug-217490-13602-M2sHGGNgnW@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217490-13602@https.bugzilla.kernel.org/>
References: <bug-217490-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D217490

--- Comment #3 from Zhihao Cheng (chengzhihao1@huawei.com) ---
Created attachment 304329
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D304329&action=3Dedit
diff_2

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
