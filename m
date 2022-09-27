Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70A6D5ECBEC
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Sep 2022 20:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbiI0SLH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 27 Sep 2022 14:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232016AbiI0SLE (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 27 Sep 2022 14:11:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD23176453
        for <linux-ext4@vger.kernel.org>; Tue, 27 Sep 2022 11:11:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8B95FB81CF8
        for <linux-ext4@vger.kernel.org>; Tue, 27 Sep 2022 18:11:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2E9EEC433D7
        for <linux-ext4@vger.kernel.org>; Tue, 27 Sep 2022 18:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664302259;
        bh=b3Aiz2ei9nZkCqiWK7gbnijVzeuyf92sD3kFV8TF2o4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ubSh85BSG7MPARSdbLrUQVneETSFYlA5Rg0jcw+FWdWyntfEny+UfUphSP3Iedp8P
         2bfHGTAszJGZWkQOEUosDoo7h8V3IkIyN2fiKYimGDBmh9GrHiHpG/0lrb7oIlghMx
         jPZ6kBT3QoBqe/s/negJW6lrDGsH/dBvGwJ8bYAcV0BMBgc4vGAA5rNdFJ9snVIqd6
         7/lQhSPdv3D59iDxG3kgKaFbhDaVftTXTPQb+kQkMbMWS77MWmrBo9G6MGhQ2Yr6bp
         cbhuVJjCLbmsWHdzJPzgQ10MyFYSFDau1s4SJA1nbPMg5oMc9SCwRX6Hl2/jWr1hJd
         LpvV5D1f9lwsA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 0F093C433E9; Tue, 27 Sep 2022 18:10:59 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 216529] [fstests generic/048] BUG: Kernel NULL pointer
 dereference at 0x00000069, filemap_release_folio+0x88/0xb0
Date:   Tue, 27 Sep 2022 18:10:58 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: ritesh.list@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216529-13602-0yTEcIGgTY@https.bugzilla.kernel.org/>
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

--- Comment #4 from ritesh.list@gmail.com ---
On 22/09/26 01:02AM, Theodore Ts'o wrote:
> On Sun, Sep 25, 2022 at 11:55:29AM +0000, bugzilla-daemon@kernel.org wrot=
e:
> > https://bugzilla.kernel.org/show_bug.cgi?id=3D216529
> >
> >
> > Hit a panic on ppc64le, by running generic/048 with 1k block size:
>
> Hmm, does this reproduce reliably for you?  I test with a 1k block
> size on x86_64 as a proxy 4k block sizes on PPC64, where the blocksize
> < pagesize... and this isn't reproducing for me on x86, and I don't
> have access to a PPC64LE system.
>
> Ritesh, is this something you can take a look at it?  Thanks!

I was away for some personal work for last few days, but I am back to work =
from
today. Sure, I will take a look at this and will get back.

I did give this test a couple of runs though, but wasn't able to reproduce =
it.
But let me try few more things along with more iterations. Will update
accordingly.

-ritesh

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
