Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CEA27CA18A
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Oct 2023 10:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjJPI1E (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 16 Oct 2023 04:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjJPI1D (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 16 Oct 2023 04:27:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07009B4
        for <linux-ext4@vger.kernel.org>; Mon, 16 Oct 2023 01:27:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6FF28C433CA
        for <linux-ext4@vger.kernel.org>; Mon, 16 Oct 2023 08:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697444821;
        bh=Kou6IaK+G1tjzxHECMbuA3wq1v04wCRLU5UAMIjlzcg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=bv0vzIEoeboj17W9mKLrFf6HK10Y1hgQ/0uDse36dv5Fdg+U5B0baW9v2giGtGRME
         wdba5n4QlB8ju2x/O4Gu8IC+vZlbodwT2SJ8/Avow2eBfUSpcNyEH2xFklADgl+90Y
         w//iUPKpmOddgy1f4ky2yL81Bs8bRYHG6aSDPL3i4LphmvjGIj8WEzV8kwVj+E7KEu
         GqqVZizUp13N+pUcJL4eth/0vEOqJR45eBg9B/y055AMPphEuzljpvCU865Kuzz5Qe
         1WqE9IOG+Eni7D7GI8ndTmQm4iT//n2zxqMEpLasdqaRkvSYyVRf8gT3gKpmHDYyu8
         c6HhOV5zLbCcA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 5F3DDC53BCD; Mon, 16 Oct 2023 08:27:01 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 218006] [ext4] system panic when ext4_writepages:2918: Journal
 has aborted
Date:   Mon, 16 Oct 2023 08:27:01 +0000
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
Message-ID: <bug-218006-13602-KWn8h93E9X@https.bugzilla.kernel.org/>
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

--- Comment #4 from Gary (fengchunguo@126.com) ---
(In reply to Artem S. Tashkinov from comment #1)
> Looks like your storage is faulty:
>=20
> mmcblk0: error -110 sending status

Hi Artem S. Tashkinov,

Thanks for your suggestion.

It seems than it was not mmc issue.

Thanks,

BRs,
Gary

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
