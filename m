Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CAC85ECBE1
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Sep 2022 20:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233024AbiI0SGi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 27 Sep 2022 14:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233083AbiI0SGh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 27 Sep 2022 14:06:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C0DD98D6
        for <linux-ext4@vger.kernel.org>; Tue, 27 Sep 2022 11:06:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E6772B81CF7
        for <linux-ext4@vger.kernel.org>; Tue, 27 Sep 2022 18:06:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AC349C433C1
        for <linux-ext4@vger.kernel.org>; Tue, 27 Sep 2022 18:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664301993;
        bh=x9z+meJ+MD4gupidK5WHg25/IvGIbquPmCPRv8Wez3Y=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=DkMHuYMYi0kHqA1vvcMNEbnY4r4xuxNwHvOU3EI/DXByvJuQoBzrHc0xdG22WBYzE
         STI44HVyosjPxhivGurSdCl3Enl63MwZgjl3dy3gzBxZYBAqrSlVuYRl9oBd2brcXf
         CMsLeO4KLiXnwgpFK2yi6wpr0CChvoFGbcj7Xz5PHjxWiAIQaH365v8BUDhHfoZWeM
         IkfHKIWERYUmw6VRPTkb0WSZHOODq88iStCuQhJUpQ3XW6h4MgcCyG78dG+bt8vAsN
         ClnjsoKZUE0JsI2kgHk8FgqXjD9CLRwKg7lVQTMaXBx9t2qgUMdMwN//fyDC6HTS8v
         fsUvRGmF/TVRg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 95950C433E9; Tue, 27 Sep 2022 18:06:33 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 216529] [fstests generic/048] BUG: Kernel NULL pointer
 dereference at 0x00000069, filemap_release_folio+0x88/0xb0
Date:   Tue, 27 Sep 2022 18:06:33 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: tytso@mit.edu
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216529-13602-BzFrqlSsx4@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216529-13602@https.bugzilla.kernel.org/>
References: <bug-216529-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216529

--- Comment #3 from Theodore Tso (tytso@mit.edu) ---
On Tue, Sep 27, 2022 at 12:47:02AM +0000, bugzilla-daemon@kernel.org wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=3D216529
>=20
> Yes, it's reproducible for me, I just reproduced it again on another ppc6=
4le
> (P8) machine [1]. But it's not easy to reproduce by running generic/048
> (maybe
> there's a better way to reproduce it).

Can you give a rough percentage of how often it reproduces?  e.g.,
does it reproduces 10% of the time?  50% of the time?  2-3 times after
100 tries, so 2-3%?  etc.  If it reproduces but rarely, it'll be a lot
harder to try to bisect.

Something perhaps to try is to enable KASAN, since both stack traces
seem to involve a null pointer derference while trying to free
buffers.   Maybe that will give us some hints towards the cause....

Thanks,

                                                - Ted

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
