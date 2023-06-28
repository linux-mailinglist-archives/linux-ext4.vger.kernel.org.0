Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A28B741225
	for <lists+linux-ext4@lfdr.de>; Wed, 28 Jun 2023 15:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbjF1NUZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 28 Jun 2023 09:20:25 -0400
Received: from dfw.source.kernel.org ([139.178.84.217]:36110 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbjF1NUN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 28 Jun 2023 09:20:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B5EB5612A5
        for <linux-ext4@vger.kernel.org>; Wed, 28 Jun 2023 13:20:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2A831C433C0
        for <linux-ext4@vger.kernel.org>; Wed, 28 Jun 2023 13:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687958412;
        bh=/a3HIDW/w+ZBED9IK/HtGHMSnCFZknup4fB3zSHWgoQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Vwm+8KXWU6zeoSOza+hmq0Bj8bS7e/b4c1co42vD1U9qd1d/9uqOZk2b/+gHnKmhF
         wF42eUSRpN2T0DMjPtOg8Q8+avL1bLXOq+v6iETMtPM5HqF9dDnO6//2kPh5Fh7uWX
         1D23AcmZ00g+Go5d2HHib1vApMdBAFzpPiTZrxiYwd89y/ac3k7UV0PeUQW2Q8bXjd
         vYFYnuJtBvav/Ls/tSKeoM6d1Kj8jg26RQLA/sBBP3bNrJBbv/Tl921VzA0BBIDb8C
         2F0kwqB2w3bOCWVWMoYlhyavyKcZ4tS2do3l+uxYSXvPiVm5YAu5j62B9WoeVROsHw
         DRl0xRC5bXcrQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 1A3B9C53BD0; Wed, 28 Jun 2023 13:20:12 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 217605] unttached inode after power cut with orphan file
 feature enabled
Date:   Wed, 28 Jun 2023 13:20:11 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: chengzhihao1@huawei.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-217605-13602-5p2cb7PXuY@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217605-13602@https.bugzilla.kernel.org/>
References: <bug-217605-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217605

--- Comment #3 from Zhihao Cheng (chengzhihao1@huawei.com) ---
Created attachment 304498
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D304498&action=3Dedit
test.sh

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
