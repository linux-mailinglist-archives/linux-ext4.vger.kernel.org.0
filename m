Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB785F3F42
	for <lists+linux-ext4@lfdr.de>; Tue,  4 Oct 2022 11:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbiJDJPC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 4 Oct 2022 05:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbiJDJPA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 4 Oct 2022 05:15:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D47E1409C
        for <linux-ext4@vger.kernel.org>; Tue,  4 Oct 2022 02:14:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3F369B80DC3
        for <linux-ext4@vger.kernel.org>; Tue,  4 Oct 2022 09:14:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F1CAAC43470
        for <linux-ext4@vger.kernel.org>; Tue,  4 Oct 2022 09:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664874896;
        bh=NJSb8laOpRLPreIdVfNLfEBAnfSQIqYUCJuOm6btRs8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=UYhbWmEiCHzMihOnHUjS6XMu5tyLTHafmYyOehFaTk9VbgMKC6DAQ/kt5PUmM9jlR
         jMYANb1b6WYZlZ84TkjtIHD7/xATCngXBCdcSQzxtcvAOLpekty3X0ZqWmzBUXm+ST
         P1Hb8+nQ4he5++87JRyHEWkc4f+Kpc0uyRzq9tVlsLu5F9Mw7OnkS5uCCxIzzwpvCB
         d7pEV1Ni2odLODdYUtxKZvZHCpWUbN4aqMKOIOGymKfnzmb4LCIYELFa3UgHxw8fxv
         c8Rwo2dGImkDNrwEKCjeu68Cc9SGw1TYvjCoEYBuko1H+d5JhhZLqhXFLZ7DviL0j6
         /ON/mz+l7DzIQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id E3B78C433EA; Tue,  4 Oct 2022 09:14:55 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 215941] FUZZ: BUG() triggered in
 fs/ext4/extent.c:ext4_ext_determine_hole() when mount and operate on crafted
 image
Date:   Tue, 04 Oct 2022 09:14:55 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: lhenriques@suse.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-215941-13602-CouQojhGks@https.bugzilla.kernel.org/>
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

Luis Henriques (lhenriques@suse.de) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |lhenriques@suse.de

--- Comment #1 from Luis Henriques (lhenriques@suse.de) ---
I think that, with commit 29a5b8a137ac ("ext4: fix bug in extents parsing w=
hen
eh_entries =3D=3D 0 and eh_depth > 0") merged, this bug can be closed.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
