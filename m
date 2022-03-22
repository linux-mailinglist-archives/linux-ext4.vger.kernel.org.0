Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 640F14E370C
	for <lists+linux-ext4@lfdr.de>; Tue, 22 Mar 2022 03:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235793AbiCVDAA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 21 Mar 2022 23:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235789AbiCVC77 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 21 Mar 2022 22:59:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720842E4142
        for <linux-ext4@vger.kernel.org>; Mon, 21 Mar 2022 19:58:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0668661138
        for <linux-ext4@vger.kernel.org>; Tue, 22 Mar 2022 02:58:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6A653C340E8
        for <linux-ext4@vger.kernel.org>; Tue, 22 Mar 2022 02:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647917912;
        bh=1dK/SXoN2O8lgZ5xo7Pmg4cy8eGe07DEsa9k2WeeuHM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=UaNhQzQ+sHnVve568FvoJalvge0eRCe70PJQ2aQ53g5xvJpPY6gQFXREhs7IP7ECd
         jlbfmIqhSbBsICuXihnT84NPIXTEYlotEadJors8KkKCLoG1MKNNue7fuquDi2FHEX
         YaWHBjHsxRyhCM37eR2xihz9TydZExtwR/e14euDbzsE209uUlQm7t7jLf14amgREX
         zQ31uhMl1Qo1I1YfQYAzz373ETEvq40RXADwPw4AzB6QBP7VqeyMLZ6+DF45GaVnym
         jc/MJ4P/QHI8+K7zKk1AjrBA7F7Li73kOtvQ1AEjMxoHmNxJS/hjTrREuhd/fzICdE
         kVnRhvrVeG8VQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 57FBDC05FD4; Tue, 22 Mar 2022 02:58:32 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 215712] kernel deadlocks while mounting the image
Date:   Tue, 22 Mar 2022 02:58:32 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: yanming@tju.edu.cn
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215712-13602-BSuEnZfCv9@https.bugzilla.kernel.org/>
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

--- Comment #2 from bughunter (yanming@tju.edu.cn) ---
Thank you for prompt reply! I have tested this bug on kernel v5.17, and the
problem still exists.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
