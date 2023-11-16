Return-Path: <linux-ext4+bounces-20-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 864217EDAB5
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Nov 2023 05:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10C7AB20A63
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Nov 2023 04:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9BAFC03;
	Thu, 16 Nov 2023 04:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E/OoE7Ok"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB29AFBE5
	for <linux-ext4@vger.kernel.org>; Thu, 16 Nov 2023 04:31:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CC4CEC433CA
	for <linux-ext4@vger.kernel.org>; Thu, 16 Nov 2023 04:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700109065;
	bh=0B6ivo65AqZU0CUqL8NBNN3I/w24LcBmM2ZH7ukDI/U=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=E/OoE7Ok9bylxVONe2z9v459jlUNT0l+d02ExwpBgG1BcxsvrfbI+pESoyz+fFNFQ
	 vmEOtczduZXXLL3Kc7leH5PgGs7vo5q88+BUUGxFJigTsEeh5We7OgNIuKXKguU8uM
	 pzIFfy8AXNNGROo3dwMkhxMB/imRubwKgwzng8tq+/A8pCFi3B0y05nmdxCY12VJvQ
	 +HIW7JgSGi6NtVokM90kBYkAmX51aVntiQZCpOENVDOY8YYtX+4t9n9cS2hkrb7S3t
	 cI4b0f/cWprc5Iu+2eAG1SzAoU0TGAOCZUtttjCLn6iNrpHfObU//xi33bB+SuQWxh
	 qxmxNIDfIVY/Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id BA5D6C53BD0; Thu, 16 Nov 2023 04:31:05 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 217965] ext4(?) regression since 6.5.0 on sata hdd
Date: Thu, 16 Nov 2023 04:31:05 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: bugzilla@eyal.emu.id.au
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217965-13602-sAJn0mxqFu@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217965-13602@https.bugzilla.kernel.org/>
References: <bug-217965-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D217965

--- Comment #29 from Eyal Lebedinsky (bugzilla@eyal.emu.id.au) ---
I now repeated the test with the new option.

The result is that very few dirty buffers are recorded, but the rsync that
usually takes a few seconds, now stops for minutes at a time.

The machine also stutters, for example as I open a snall file on /data1.

The following perf run is of the rsync.

$ sudo sysctl vm.drop_caches=3D3
$ sudo mount -o remount,nodelalloc /data1
$ (d=3D"`date`" ; sudo rsync -aHSK --stats --progress --checksum-choice=3Dn=
one
--no-compress -W /data2/no-backup/old-backups/tapes/13/file.1.data
/data1/no-backup/old-backups/tapes-again/13/ ; echo "`date`: started $d")
$ sudo perf record -p 1531839 -g sleep 60
$ sudo perf report --no-children --stdio -i perf.data

I will add the logs as an attachment (I hope).

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

