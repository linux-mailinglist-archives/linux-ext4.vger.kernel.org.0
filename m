Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E74D96EC916
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Apr 2023 11:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjDXJe7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 24 Apr 2023 05:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjDXJe5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 24 Apr 2023 05:34:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F78B30E1
        for <linux-ext4@vger.kernel.org>; Mon, 24 Apr 2023 02:34:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3362B614A6
        for <linux-ext4@vger.kernel.org>; Mon, 24 Apr 2023 09:33:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 989EEC4339B
        for <linux-ext4@vger.kernel.org>; Mon, 24 Apr 2023 09:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682328828;
        bh=v7YqWzZCrvF94n6Uis65YdMn911mfl+W6pMp6DeuxMA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=tr7x0L8Rjd670WmZ95mWpf07T3npCKuD/LxeTJXMEIqifA97lUxi9iI0+PFGO2LTE
         ZR1W2M7chtLrk9RE+u4BWf5QVrU31nGgHlU8VDvx+2gxIEHTHk6VX2JP0EubWUbrm6
         RFSObKqBgTkhUao8cnEHQvvdfmNNg/N+Pwba5lnXbMYchJ1lkcsedMUrD4PDHFzWRe
         v3F4pcxw+kFJC0Kd0I6y/RE5xPL47C+3uBYwvYobTuZoaMmj/UfDpP9V1nWZkR/6ht
         3wsUxyjt1dSwjqJ4DGZRz2OpGZ1KCUJf+oRAv+WQqoTqxqNtBY4sjFBPtEdSUNNTpY
         qzi/w7JfrWG+g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 8A3ABC43142; Mon, 24 Apr 2023 09:33:48 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 217363] jbd2: Data missing when reusing bh which is ready to be
 submitted in checkpoint
Date:   Mon, 24 Apr 2023 09:33:48 +0000
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
Message-ID: <bug-217363-13602-tCuPEGn2Wy@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217363-13602@https.bugzilla.kernel.org/>
References: <bug-217363-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217363

--- Comment #3 from Zhihao Cheng (chengzhihao1@huawei.com) ---
Created attachment 304183
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D304183&action=3Dedit
test.sh

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
