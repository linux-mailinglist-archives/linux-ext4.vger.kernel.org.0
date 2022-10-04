Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE6F5F49DC
	for <lists+linux-ext4@lfdr.de>; Tue,  4 Oct 2022 21:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbiJDTsx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 4 Oct 2022 15:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiJDTsw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 4 Oct 2022 15:48:52 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10BD75A800
        for <linux-ext4@vger.kernel.org>; Tue,  4 Oct 2022 12:48:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id F132DCE1162
        for <linux-ext4@vger.kernel.org>; Tue,  4 Oct 2022 19:48:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0DCD8C4314D
        for <linux-ext4@vger.kernel.org>; Tue,  4 Oct 2022 19:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664912926;
        bh=zsLcacBOTdqU/bF8JXnKTMup5ZEjIaEu+spW332vWh0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=CssxSVlch3+pgoo7PAwyj0yNk1STuGSvYSW5nUln8gZ1jCfvi0yQWei0GV/92TK9S
         fRVMCNSFN4u3+pjY+PeQP3zsz5fWhKt+yql679icldI07PSsO82WSqlRo84mhz/Qqk
         XY4FT2vlTm6l3T4UEUnip9EkeVS9OgDkFp/Upp+QvGGw+Uf6aibWzVivUqG6+t1fWg
         Wjc2Oq3WVoOwHOsrn1kMPEbXlt8GXhtLrdtO6IKTMA+PJTF6ixP0CoUndZ4hOmb60v
         XGx+pTLwRB2xFuxvGpmTeF6u8J3/NmFkVSGycBpX9DkYvPgeL87pR3DtF0DoCQqsD0
         0jmNU0G9OGa2g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id E4AB9C433EA; Tue,  4 Oct 2022 19:48:45 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 215941] FUZZ: BUG() triggered in
 fs/ext4/extent.c:ext4_ext_determine_hole() when mount and operate on crafted
 image
Date:   Tue, 04 Oct 2022 19:48:45 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: tytso@mit.edu
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status cc resolution
Message-ID: <bug-215941-13602-TD2vt8VuRR@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215941-13602@https.bugzilla.kernel.org/>
References: <bug-215941-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D215941

Theodore Tso (tytso@mit.edu) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
                 CC|                            |tytso@mit.edu
         Resolution|---                         |CODE_FIX

--- Comment #2 from Theodore Tso (tytso@mit.edu) ---
Indeed, thanks for the patch!

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
