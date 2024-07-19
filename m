Return-Path: <linux-ext4+bounces-3328-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F709377C7
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Jul 2024 14:33:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D326B1C2154C
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Jul 2024 12:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72731130A7D;
	Fri, 19 Jul 2024 12:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AjQV9wGB"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCCD84D3E
	for <linux-ext4@vger.kernel.org>; Fri, 19 Jul 2024 12:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721392406; cv=none; b=bd7a33uF8m74hyr6WEuP2O+/3x9dxv2bMjbofBqklPXVKJL/z436EW5rgsQpHZZ1fdvv2TxjGWt9H5CY8r3ia+GeYRg4QBR83TbOT1Gvp6TX5w0XY6L3pY38Jwdci0Y7QIB6OE7SBQE/Da+nV8wgjUXvqt5qDPDeasM6ghMBwcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721392406; c=relaxed/simple;
	bh=/HZGP1eEwvDjjDxCNABUY+9csmbCzETWNHa/RuJDxPY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iiG4SfoDlLLMjMNxUAMvW8HwD1e/Itay+IDpAK0sns2UTAj4wQvkNyqXaajNxSEasZAjypqPxFkhjUg0Vv5hKzn20ze2xSWlublMthsz6UOwR2B+lo6bkQuY3pz09wL9Mgw7e6FRpnCxqAcvCNNwixrj9xp5LTvoYpyKAN3/H8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AjQV9wGB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 95132C4AF0A
	for <linux-ext4@vger.kernel.org>; Fri, 19 Jul 2024 12:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721392405;
	bh=/HZGP1eEwvDjjDxCNABUY+9csmbCzETWNHa/RuJDxPY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=AjQV9wGBsGRBmRXB3Y9yosbK3TWcPi6TZSThL2pkxt3yIk3Cb4bDB7btpuwEj9s6T
	 qoiJR4mhkvcDxn9T3dFQ+OuC0JUfyoRoWbuN1sCZ+IbS4vAd2SW/ZwbfHIP6H5D2wb
	 23MwjvN1+H3/wnPI3EULev2qRa7BfSXoI9/R50DMkE0DyiQYyG7wZZR2Z33d6FBaJS
	 mM0UfcB4+FWp8e7SVYalT1oYRH1MBqGWzOqupky8wbTHdfY6JJj7Ppp6CycyLfBm0G
	 x1YejSPy52s0+1DnyrEiOpwDU0PucMwZgchRjYwrh0tiDI+aS9WRam7aeE+B5/n8Hz
	 ZkvVpSfaX7TYw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 856D1C53B73; Fri, 19 Jul 2024 12:33:25 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 218932] Serious problem with ext4 with all kernels,
 auto-commits do not settle to block device
Date: Fri, 19 Jul 2024 12:33:25 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: jack@suse.cz
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: INVALID
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-218932-13602-LvxXtfNJIW@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218932-13602@https.bugzilla.kernel.org/>
References: <bug-218932-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

https://bugzilla.kernel.org/show_bug.cgi?id=3D218932

Jan Kara (jack@suse.cz) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |jack@suse.cz

--- Comment #7 from Jan Kara (jack@suse.cz) ---
Not sure where you've got the URL in comment 5 from but it is an ancient
version of the documentation. This text has been fixed in 2018. Current ver=
sion
of the documentation is at
https://www.kernel.org/doc/html/latest/admin-guide/ext4.html and has:

commit=3Dnrsec (*)

    This setting limits the maximum age of the running transaction to =E2=
=80=98nrsec=E2=80=99
seconds. The default value is 5 seconds. This means that if you lose your
power, you will lose as much as the latest 5 seconds of metadata changes (y=
our
filesystem will not be damaged though, thanks to the journaling). This defa=
ult
value (or any low value) will hurt performance, but it=E2=80=99s good for d=
ata-safety.
Setting it to 0 will have the same effect as leaving it at the default (5
seconds). Setting it to very large values will improve performance. Note th=
at
due to delayed allocation even older data can be lost on power failure since
writeback of those data begins only after time set in
/proc/sys/vm/dirty_expire_centisecs.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

