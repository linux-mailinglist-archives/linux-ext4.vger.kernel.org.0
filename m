Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 170457478E8
	for <lists+linux-ext4@lfdr.de>; Tue,  4 Jul 2023 22:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbjGDUJ0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 4 Jul 2023 16:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbjGDUJZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 4 Jul 2023 16:09:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F02118B
        for <linux-ext4@vger.kernel.org>; Tue,  4 Jul 2023 13:09:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E77D6137B
        for <linux-ext4@vger.kernel.org>; Tue,  4 Jul 2023 20:09:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 084C5C433C9
        for <linux-ext4@vger.kernel.org>; Tue,  4 Jul 2023 20:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688501364;
        bh=CuHFrerCTX/qp7jmO7WNMn7W1POhxQvor5uqrjGELWI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Z83IrbbVDMrcCOk28Frxxbu4d3rbMTkobVV3gJfmec1mGEiyTv+kT8/GOQ9mulhIB
         pIjIj+nCOEpIBiW1OTwhm0hmDVE3JY7CqnUvT1mkZlmicGVHEOMaYk+8SYb2+98+W7
         xt69j9PJ/mbko8yNu3u3KN9sBhpdSN5IVuhSJhZWAdHUUGiybcRjlbDXrb7XtU0aEo
         DkwSV3/yzfsInigTUXR4ML03Z94nuJrylprZIKauk83S4a+orHIjKThAxJEx/SAS36
         M6rDVHSlOvFtF+UEgGAiD5G+K7cTB3K/B99sFx7ntIz+xm3CGUXuNnWfq3yXeTyQNy
         TCNCRP/jBWhDA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id E14A5C53BD0; Tue,  4 Jul 2023 20:09:23 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 217633] the insertion of disk  to  DVD make bad remout /dev/sda
Date:   Tue, 04 Jul 2023 20:09:23 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: tytso@mit.edu
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-217633-13602-02tcrw3JsY@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217633-13602@https.bugzilla.kernel.org/>
References: <bug-217633-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217633

Theodore Tso (tytso@mit.edu) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |tytso@mit.edu

--- Comment #2 from Theodore Tso (tytso@mit.edu) ---
This isn't an ext4-related problem.

Also, the bug report does not explain what /dev/sda was before the disk was
inserted.  What device was that associated with?   Such a bug report would =
need
to include a complete description of the hardware associated with the syste=
m,
including what SATA and SCSI devices were attached to the system.   I would
recommend trying to reproduce the problem on a freshly booted system, and t=
hen
saving the output "dmesg" which would be helpful for someone to understand =
what
might be going on.

Finally, it's not clear whether this is in fact a kernel bug, or just a
misunderstanding of what is supposed to be happening.  If this is a
distribution-supplied kernel, I would recommend reaching out to the
distribution's help channels first before assuming that upstream kernel
developers will give you free support for something which might not be a bu=
g,
but just simply a user education issue.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
