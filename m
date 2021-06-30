Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1303B882C
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Jun 2021 20:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232984AbhF3SKK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 30 Jun 2021 14:10:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:34322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229991AbhF3SKJ (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 30 Jun 2021 14:10:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 9E99961468
        for <linux-ext4@vger.kernel.org>; Wed, 30 Jun 2021 18:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625076460;
        bh=KwIwzcdIRtteWpbFhpjkzXUOm+v0Qcm2wgToLUJdZHA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ivJ6HSL62o0Gp4wCoqxrSH0S5zUDo4lx8GgnWh075dyIsyGwZ6mHUQqIU/JMAxJlq
         pC4bDJJVTgsLiGNpaohr/t8Lg3LrUwq2Grv9ZvrNXQy8eaAWwHYzPEQl0cRBDN0Rv2
         0/bW/12noRg7d1yV+6kkz92lgi5YxPMvYwRSYzVRVaK/XUzW+Pm3oOQO6FOvsquppb
         RrBHGS9Ni+p1plirTcRcfyCV6UTUm2xOj+J6qd/iEtLkL9imPg9tX6nsAeZYdrhTR9
         zG6l4EoG394ve98UbC6l7UXzxTkhnToF/Vk9VHwEZNgj16FYjvOFW7t5fUkubye8lz
         7k6YEDjXrMbaA==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id 9C0E1612AD; Wed, 30 Jun 2021 18:07:40 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 213627] Fail to read block descriptors data of ext4 filesystem
Date:   Wed, 30 Jun 2021 18:07:40 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: nipunasri.eerapu@arcserve.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-213627-13602-OMinj4gWM9@https.bugzilla.kernel.org/>
In-Reply-To: <bug-213627-13602@https.bugzilla.kernel.org/>
References: <bug-213627-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D213627

--- Comment #1 from Nipuna (nipunasri.eerapu@arcserve.com) ---
Please let me know if more details are required.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
