Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0831F7B4E52
	for <lists+linux-ext4@lfdr.de>; Mon,  2 Oct 2023 10:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjJBI66 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 2 Oct 2023 04:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236106AbjJBI61 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 2 Oct 2023 04:58:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D213AB4
        for <linux-ext4@vger.kernel.org>; Mon,  2 Oct 2023 01:56:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9872DC433C9
        for <linux-ext4@vger.kernel.org>; Mon,  2 Oct 2023 08:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696236966;
        bh=sxcHpbWWs0jCDZtnDLdiZ+rwJ5Ov20ReEE9S9mcywUU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=HCmbZGyY+6RVTC5+H23ysU7/NGscLgDUoJKEK5+U8T5aJBoEPEdD+jC8Q6y4LJkJ4
         I4SZAt5VNdjJkiZg5B7RU67bV2fx9W9PwViThDc5l5G64SN8FNmG/HP083JIF9dC5l
         /ECTovc+gTfWPw2lvu88e2DMEQUYPOQaqEOaXIrIsjZ0n51QNFzqvU3epyCZ7KBvRh
         YdHfOI+HnOHJTVda77knPglhMs/ep/JYqaDx1vgDRHf6D3msqOtzr+GnZPZQbDCfCa
         pNwUm///Z8IbceCzx1XyQHHqBrWeC1/CO0csRglOVdF8264U2vsCPMgo/ma53/hOoh
         ThDdKj6QaWY0A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 7912FC53BCD; Mon,  2 Oct 2023 08:56:06 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 217965] ext4(?) regression since 6.5.0 on sata hdd
Date:   Mon, 02 Oct 2023 08:56:06 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: iivanich@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-217965-13602-23a61ZBogk@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217965-13602@https.bugzilla.kernel.org/>
References: <bug-217965-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217965

--- Comment #1 from Ivan Ivanich (iivanich@gmail.com) ---
Created attachment 305179
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D305179&action=3Dedit
Kernel config

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
