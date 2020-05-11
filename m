Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65EB91CE07A
	for <lists+linux-ext4@lfdr.de>; Mon, 11 May 2020 18:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730016AbgEKQan convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Mon, 11 May 2020 12:30:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:41066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728556AbgEKQan (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 11 May 2020 12:30:43 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-ext4@vger.kernel.org
Subject: [Bug 207635] EXT4-fs error (device sda3): ext4_lookup:1701: inode
 #...: comm find: casefold flag without casefold feature; EXT4-fs (sda3):
 Remounting filesystem read-only
Date:   Mon, 11 May 2020 16:30:42 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: joerg.sigle@jsigle.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-207635-13602-q1TSX0sw9c@https.bugzilla.kernel.org/>
In-Reply-To: <bug-207635-13602@https.bugzilla.kernel.org/>
References: <bug-207635-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=207635

--- Comment #5 from Joerg M. Sigle (joerg.sigle@jsigle.com) ---
Eric, re. your other question:

>I'm not sure there's anything else to do here, unless we were to make the
>kernel ignore unexpected flags.
>Ted, have you considered that?  And it is intentional that e2fsck ignores
>unknown flags?

Please allow me some input on this:

Someone might use a kernel with casefold or encryption support on Monday - and
even use these features, causing a few of these flags to be set.

The same person might run a kernel with casefold and/or encryption disabled on
Tuesday. So, would it really be necessary to set their filesystem to ro -
giving them a hard time, just because they like to use different kernels? I
think not.

There are many reasons to use different kernels: System-Rescue CD; kernel
building experiments etc.

So IMHO, a kernel that doesn't support a certain capability should  not do
*anything* with the bits used for that capability. It should make no
assumptions about them, and at best not even look at them. Just leave them as
they are.

At most, it might write a warning to /var/log/messages.

But it should not turn a working machine into a not working one for "reserved"
bits being in a "surprising" state. There are other kernels out there, they
might have some reason to set them as they are.

(Saying this, I assume *and hope!* that it is generally no problem to use an fs
that has these flags set with a kernel not supporting them - apart from the
missing extra functionality.)

This is just my naive opinion; I'm writing it however as someone who sees more
and more complexity and unforeseen dependencies with bad side effects added to
all areas of computing - often by people that were just a little bit too
caring, or made too narrow assumptions on other peoples' usage scenarios.

Thank you very much again, and kind regards, Joerg

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
