Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 866C77CA184
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Oct 2023 10:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbjJPI0D (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 16 Oct 2023 04:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjJPI0C (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 16 Oct 2023 04:26:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409A5A1
        for <linux-ext4@vger.kernel.org>; Mon, 16 Oct 2023 01:26:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D71E5C433C8
        for <linux-ext4@vger.kernel.org>; Mon, 16 Oct 2023 08:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697444759;
        bh=/L8sCvU5emjIFtVvNndXSYHrmASTeqFxJUuAi+YfZBw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=qy7ER/j0hcAlpoBa0GVWPByJ6WiQz9Wgyt3Lw3n7JTj8E8/dvUqEeQOl3334lTMuN
         XbgstlIi7x/2MWKoCb0JQGm6ZI3z6iM2lLLKilB3Bz9S4mk0lDvPpihKjIJ4k/1/01
         I+3kdN4amBI13gkvXDTt9CnWY7laq3QtbV7uSUJsLpkJ0TeJezTyQ/xOungjUnHa4C
         4tr0dVTz3p9H1UUWNy0DjDej2x9SYs7tmFlNbqQTjnUCcF7jT7SJSx5C0FDimlVzLV
         X5aWzKOY6NPaJbxGkHck5RHWNxDx285C4c0+y1HpXaPiOOD8eSBGM5InrCu5VoEQ4z
         TS1G7dQWDcEww==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id C0B74C53BD0; Mon, 16 Oct 2023 08:25:59 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 218006] [ext4] system panic when ext4_writepages:2918: Journal
 has aborted
Date:   Mon, 16 Oct 2023 08:25:59 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: fengchunguo@126.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: INVALID
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218006-13602-f3bOGp3vrm@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218006-13602@https.bugzilla.kernel.org/>
References: <bug-218006-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218006

--- Comment #3 from Gary (fengchunguo@126.com) ---
(In reply to Theodore Tso from comment #2)
> Also, note the panic message:
>=20
> Kernel panic - not syncing: Attempted to kill init! exitcode=3D0x00000007
>=20
> This indicates that the init process received a SIGBUS (signal number 7).=
=20=20
> Given all of the large number of mmc0 / sdhci errors, it's pretty clear t=
hat
> the storage device is *very* unhappy.
>=20
>=20
> The most common cause, as Artem as stated, is that it's a hardware proble=
m,=20
> It's possible that forcing a factory reset might work.  If the SD card is
> removable, you could just to see if reseating the SD card, or if that
> doesn't work, replacing the SD card.  If the eMMC flash device is soldered
> onto the mainboard, then probably solution is complete hardware replaceme=
nt.

Hi Theodore,

Thanks for your suggestion.

Uesed cpuburn and memtest tool test 7*24 hours, not found mmc issue, includ=
ed
stroage part.

We need use kernel 4.14, could you please kindly offer the debugging way?

Thanks,

BRs,
Gary

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
