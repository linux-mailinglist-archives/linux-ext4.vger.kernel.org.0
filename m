Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D62565FA251
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Oct 2022 19:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiJJRBy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 10 Oct 2022 13:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbiJJRBq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 10 Oct 2022 13:01:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0AC2CDFA
        for <linux-ext4@vger.kernel.org>; Mon, 10 Oct 2022 10:01:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5BF01B8104D
        for <linux-ext4@vger.kernel.org>; Mon, 10 Oct 2022 17:01:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1709BC433D6
        for <linux-ext4@vger.kernel.org>; Mon, 10 Oct 2022 17:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665421302;
        bh=dyy2+ignRinmrhjNXBzLrDm0o+s6swP9C5mzx6OI7pE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=pxYr6FdYq32j2xp8P1CqY8QV2VTHYb6PC3N4xBnYJY/L96eP/25fxdZsXUNZz1wuJ
         ghs4ROAQHUWxXpYmVxfC64L9rdRI+cSaAt0yveWz6d+Ke0GFysSNqOCpeS4xJZMvKx
         sugjCy1diHwehQN1xvfCRj/HCvZJ9FnEW/wWfHuwYKEGciDADy8CzS3/D5M1hvbGMH
         0uMKrqcphDP3KPWgeXXrG0SKRKbl3AHyTuvGceZG02LaBzpQ8+7IgBDcEumxPj2cRr
         fvdlIYfIcuFfYFXnNWUiW+DAOPA2KzBGeT4mmHHLTJelRbFvf9TYrByKscc1KB50NA
         zsTdjtG5PDR7g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id F2CD0C433E9; Mon, 10 Oct 2022 17:01:41 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 216529] [fstests generic/048] BUG: Kernel NULL pointer
 dereference at 0x00000069, filemap_release_folio+0x88/0xb0
Date:   Mon, 10 Oct 2022 17:01:41 +0000
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
Message-ID: <bug-216529-13602-MpxwwIHrbs@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216529-13602@https.bugzilla.kernel.org/>
References: <bug-216529-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D216529

--- Comment #5 from ritesh.list@gmail.com ---
On 22/09/27 11:40PM, Ritesh Harjani (IBM) wrote:
> On 22/09/26 01:02AM, Theodore Ts'o wrote:
> > On Sun, Sep 25, 2022 at 11:55:29AM +0000, bugzilla-daemon@kernel.org wr=
ote:
> > > https://bugzilla.kernel.org/show_bug.cgi?id=3D216529
> > >
> > >
> > > Hit a panic on ppc64le, by running generic/048 with 1k block size:
> >
> > Hmm, does this reproduce reliably for you?  I test with a 1k block
> > size on x86_64 as a proxy 4k block sizes on PPC64, where the blocksize
> > < pagesize... and this isn't reproducing for me on x86, and I don't
> > have access to a PPC64LE system.
> >
> > Ritesh, is this something you can take a look at it?  Thanks!
>
> I was away for some personal work for last few days, but I am back to work
> from
> today. Sure, I will take a look at this and will get back.
>
> I did give this test a couple of runs though, but wasn't able to reproduce
> it.
> But let me try few more things along with more iterations. Will update
> accordingly.

I thought I had updated this. But I guess I forgot to update on this mail
thread...

I tested this for quite some time in a loop and also gave it a overnight ru=
n,
but I couldn't hit this issue. I had kept low memory size guest, so that we
could see more reclaim activity (which I also ensured by doing perf trace to
see
if we are going over that path or not while test was running).

I am not sure whether this could be a timing issue or what. Maybe if you co=
uld
share your defconfig, I could give a try with that on my setup once.

-ritesh

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
