Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5E247C968B
	for <lists+linux-ext4@lfdr.de>; Sat, 14 Oct 2023 23:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233358AbjJNVou (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 14 Oct 2023 17:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231987AbjJNVot (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 14 Oct 2023 17:44:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5B9D6
        for <linux-ext4@vger.kernel.org>; Sat, 14 Oct 2023 14:44:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D0298C433C9
        for <linux-ext4@vger.kernel.org>; Sat, 14 Oct 2023 21:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697319887;
        bh=NSnXoVF0nbdOdOcw5dS09oQ1UyIJE/FfHHFEfbbbeZc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=rI4waAy37y6b2F2l3+b0Pb692T6hcMWeieRxL4rrN8uAeaRyPFxVnON3wej6chAFB
         1zPy8I6K9HxkXMEzO/jC8h758qtNjKOHcYPktTsnU2cBpLYh0gxx7ANs5HqWnUUCuz
         9I2RrhdwkKb0/28P62yLzBiTtAF2TSy6jM1rgoEZAsPNWGnr4eGt3a+z+/V8DGDPG+
         Kpk+BsPJpWfWdLz01tFexNdCyTqjbDioOPh3FMXDvqHsoGd5I6Itht6wJq5cJAbXD3
         DdU37P0IIYdf939wTm4r3IilGXAKWqOGWB5hVB6YSgKlGdJqTE09N63c+nRJPXqTgp
         YbZJXDgDITB1g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id B51B4C53BD5; Sat, 14 Oct 2023 21:44:47 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 218006] [ext4] system panic when ext4_writepages:2918: Journal
 has aborted
Date:   Sat, 14 Oct 2023 21:44:47 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: tytso@mit.edu
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: INVALID
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-218006-13602-qesp1hcWNM@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218006-13602@https.bugzilla.kernel.org/>
References: <bug-218006-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D218006

Theodore Tso (tytso@mit.edu) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |tytso@mit.edu

--- Comment #2 from Theodore Tso (tytso@mit.edu) ---
Also, note the panic message:

Kernel panic - not syncing: Attempted to kill init! exitcode=3D0x00000007

This indicates that the init process received a SIGBUS (signal number 7).=
=20=20
Given all of the large number of mmc0 / sdhci errors, it's pretty clear that
the storage device is *very* unhappy.


The most common cause, as Artem as stated, is that it's a hardware problem,=
=20=20
It's possible that forcing a factory reset might work.  If the SD card is
removable, you could just to see if reseating the SD card, or if that doesn=
't
work, replacing the SD card.  If the eMMC flash device is soldered onto the
mainboard, then probably solution is complete hardware replacement.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
