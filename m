Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B303339E176
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Jun 2021 18:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbhFGQHI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Jun 2021 12:07:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:40264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231450AbhFGQHH (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 7 Jun 2021 12:07:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 9701F611AD
        for <linux-ext4@vger.kernel.org>; Mon,  7 Jun 2021 16:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623081916;
        bh=W2M0ZVVAe8sQx95rFgA6mJa8+dN72UzNBf1Bll0GeuY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=NjYvAvVnLdieEdHwtdiK+w/nBwUxTJaXgAOMsCxXJyEWKYWGbODU1RGexzU3RGZjM
         CynjbDOfCBujC7m/00bgujQYXtBWZiISKTTqVP20WZZ8WBO2XZ7Pqq2LsccYG0sVvn
         +aT6NL0oCRQ4fj9hUStEz02qRFWhKPuu6RNTS0nxLIWufRXhh3Z0RVxuuyfazrcTFn
         L+Y++5WSMT2LRCBD3GsBKyDcGCRXoZdBVgG5Q3FiPFzC7PktCAaUkyCJzbDCfAnBHm
         YbKaD1zm0HrOHXOiw+iRkfJQ7AwcBQ997T/XrCvOIZ+nhTUoshomtHNO2zNYXFFEVE
         KP3C+Qu2opPzQ==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id 93AD461175; Mon,  7 Jun 2021 16:05:16 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 213357] chattr +e writes invalid checksum to extent block
Date:   Mon, 07 Jun 2021 16:05:16 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: jeroen@wolffelaar.nl
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-213357-13602-5IFiF4ju8j@https.bugzilla.kernel.org/>
In-Reply-To: <bug-213357-13602@https.bugzilla.kernel.org/>
References: <bug-213357-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D213357

--- Comment #1 from Jeroen van Wolffelaar (jeroen@wolffelaar.nl) ---
Created attachment 297209
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D297209&action=3Dedit
Execution log of reproduction script with vanilla kernel

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
