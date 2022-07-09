Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B963B56CB11
	for <lists+linux-ext4@lfdr.de>; Sat,  9 Jul 2022 20:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbiGIS1V (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 9 Jul 2022 14:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGIS1V (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 9 Jul 2022 14:27:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61911183F
        for <linux-ext4@vger.kernel.org>; Sat,  9 Jul 2022 11:27:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D97C60F28
        for <linux-ext4@vger.kernel.org>; Sat,  9 Jul 2022 18:27:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D96D9C341CB
        for <linux-ext4@vger.kernel.org>; Sat,  9 Jul 2022 18:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657391239;
        bh=cJvOWjqlmtBMg/4/Xgv8xMHLiu9nEYQ3FxUNwYg/tqY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=LOoaYs2WJoHWdGcKZA7J9jJqTE5P0MCaQGLUv98Eth04rhggPdLc/d62RZE1SPh8P
         AHOTbAUjymK1WV/w7Wvb8V54XTrHuxhu5mId0p6tr16SQVvskcDuxbL/o+YZ8XZ149
         vNyHsWqk7hZefqqPmZPxm9ixJwFwq+vEjgEiC/qLGR+YLT/FskaRuE2A3/4hm+SZc/
         6nWCId88JhQDSlkhqISbgmhscs+uHu+gk6XnhGF7D3SIsi9jhipzl82OPH+Gi/+xso
         OSBf5iYPbweQg6kwUtSHCLvFcEs3wVsbeYHc1MBjKS2KnCNN981AXPd08JxI/iG+LW
         9hMwRqtqsAa/A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id C7348CC13B8; Sat,  9 Jul 2022 18:27:19 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 216229] Same content in two different files - strange problem,
 unsure if caused by kernel housekeeping
Date:   Sat, 09 Jul 2022 18:27:19 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext2@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: joerg.sigle@jsigle.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext2@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: component
Message-ID: <bug-216229-13602-dECWiOYffx@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216229-13602@https.bugzilla.kernel.org/>
References: <bug-216229-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D216229

Joerg M. Sigle (joerg.sigle@jsigle.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
          Component|ext2                        |ext4

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
