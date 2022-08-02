Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39CB45879D5
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Aug 2022 11:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235912AbiHBJ24 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 2 Aug 2022 05:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232771AbiHBJ2w (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 2 Aug 2022 05:28:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5388B21267
        for <linux-ext4@vger.kernel.org>; Tue,  2 Aug 2022 02:28:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E321D60DDF
        for <linux-ext4@vger.kernel.org>; Tue,  2 Aug 2022 09:28:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4FF76C433B5
        for <linux-ext4@vger.kernel.org>; Tue,  2 Aug 2022 09:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659432530;
        bh=ccjVgYefmrc7qhORwuXL/VFNffd6gCGZRB2XX93iwUc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=fk9fpP5Cr9KUIj5f593xKeVS4BguEB1wjy8zGiQEh4TgJHVSwWBEbAvgv3RVurkqv
         AEhmjkxP/HiiAISG4JUT9Sy4dRQdgv++INmcK4zTEyoyOQIXbEgZZBGqOjSJYB7yhQ
         bv2uQ1dC/mosvNUvP3m+SZm7gnKCKeLuxibO6CRJwi9XkqzEklj9+JSQLkr2zSNt7r
         PkTN0m7DNeSmNqr5yhKiWbkCblpHKEoh0wRRg6mtXzWbcV/6wcnPbYwszi3uovniPc
         PtOeaJ3nT3SLtJsHcWmr6TDWMxKlE4M9E31W6k+JayQESppbmat50wWwebu2lQr7m1
         FI6g/15eY1L+Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 1F723C433E7; Tue,  2 Aug 2022 09:28:50 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 216283] FUZZ: BUG() triggered in
 fs/ext4/extent.c:ext4_ext_insert_extent() when mount and operate on crafted
 image
Date:   Tue, 02 Aug 2022 09:28:49 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: lczerner@redhat.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216283-13602-kIr7jya5F4@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216283-13602@https.bugzilla.kernel.org/>
References: <bug-216283-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216283

--- Comment #9 from Lukas Czerner (lczerner@redhat.com) ---
On Tue, Aug 02, 2022 at 08:45:51AM +1000, Dave Chinner wrote:

--- snip ---

> >=20
> > Look, your entire argument hinges on the assumption that this is a
> > security vulnerability that could be exploited and the report makes the
> > situation worse. And that's very much debatable. I don't think it is and
> > Ted described it very well in his comment.
>=20
> On systems that automount filesytsems when you plug in a USB drive
> (which most distros do out of the box) then a crash bug during mount
> is, at minimum, an annoying DOS vector. And if it can result in a
> buffer overflow, then....
>=20
> > Asking for more information, or even asking reported to try to narrow
> > down the problem is of course fine.
>=20
> Sure, nobody is questioning how we triage these issues - the
> question is over how they are reported and the forum under which the
> initial triage takes place
>=20
> > But making sweeping claims about
> > moral and ethical responsibilities is always a little suspicious and
> > completely bogus in this case IMO.
>=20
> Hand waving away the fact that fuzzer crash bugs won't be a security
> issue without having done any investigation is pretty much the whole
> problem here. This is not responsible behaviour.

Since it's obvious that the security status of this is disputed, then
please feel free to create guidelines stating that fuzzer bugs for xfs
are considered a security issues and reporters should follow guidelines
of responsible disclosure and bugs are not to be reported publicly.

Problem solved and no moralizing needed.

-Lukas

>=20
> Cheers,
>=20
> Dave.
> --=20
> Dave Chinner
> david@fromorbit.com
>

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
