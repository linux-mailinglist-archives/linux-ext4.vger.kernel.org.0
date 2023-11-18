Return-Path: <linux-ext4+bounces-33-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6497EFFCC
	for <lists+linux-ext4@lfdr.de>; Sat, 18 Nov 2023 14:18:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 056401F22EFD
	for <lists+linux-ext4@lfdr.de>; Sat, 18 Nov 2023 13:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3471F10944;
	Sat, 18 Nov 2023 13:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WCVrNw/N"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA24101C5
	for <linux-ext4@vger.kernel.org>; Sat, 18 Nov 2023 13:18:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 22ACAC433CB
	for <linux-ext4@vger.kernel.org>; Sat, 18 Nov 2023 13:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700313480;
	bh=QcNlhyAAQsO2Are1hH2psYiaAY82npH92QOS11MfaYU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=WCVrNw/NlnAVqbe/DCFC54tf6usDeqNkauhViParIiESToXw1SJqBXEVRfQ0h5pYV
	 29rdsj7zSNoZx2jHPdr3K/0ZmLnI8ObvLp/KViiZRuqvsdKwLYqOuK2kx+HhUPQfqW
	 0Sl8jiSmxw9TXHWeikbz4zl/YP7t91AdbW/tN+VQnYcdm2K4SvPsmGqyTAZunhqgd0
	 WlX2NGVn+NyqA/kc5AD6xgWBIO5mhhsdEX0meyRYvKpcceEqehxs88Oxb2l6nDOdxA
	 7C9zVjG0AQbtUPHQ0PzE63oxFsma52cYaI0AhQKzvBuTbyXsGXnxYuRwHbvhn5CPsd
	 w5b1XfShBKYZQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 05B7AC53BD5; Sat, 18 Nov 2023 13:18:00 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 217965] ext4(?) regression since 6.5.0 on sata hdd
Date: Sat, 18 Nov 2023 13:17:59 +0000
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
Message-ID: <bug-217965-13602-AVoESEUTYG@https.bugzilla.kernel.org/>
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

--- Comment #41 from Eyal Lebedinsky (bugzilla@eyal.emu.id.au) ---
OK, so how do I disable the stripe=3D640 that was automatically added?
Is there a mount option to disable it?
I would rather not futz with tune2fs.

RE kernel build: I used to often do this maybe 30 years ago, but on a
workstation, not on the server. The build I expect to be simple, but it is =
the
risk of a bad patch that worries me. I would rather not do that.

BTW, while you are looking at the cache issue, what are your thoughts on the
fact that the array shows (iostat -x) a very high w_await when the members =
are
much lower? Is it normal?

         Device            r/s     rkB/s   rrqm/s  %rrqm r_await rareq-sz=
=20=20=20=20
w/s     wkB/s   wrqm/s  %wrqm w_await wareq-sz     d/s     dkB/s   drqm/s=20
%drqm d_await dareq-sz     f/s f_await  aqu-sz  %util
16:04:08 md127            0.20      0.80     0.00   0.00   10.50     4.00=
=20=20=20
9.80    739.20     0.00   0.00 1495.44    75.43    0.00      0.00     0.00=
=20=20
0.00    0.00     0.00    0.00    0.00   14.66   4.51
16:04:08 sdb              2.30    187.20    44.50  95.09   30.74    81.39=
=20=20=20
6.80    345.20    79.70  92.14   29.72    50.76    0.00      0.00     0.00=
=20=20
0.00    0.00     0.00    0.60   14.33    0.28   1.26
16:04:08 sdc              1.90    138.80    32.80  94.52   16.63    73.05=
=20=20=20
6.60    295.60    67.50  91.09   13.06    44.79    0.00      0.00     0.00=
=20=20
0.00    0.00     0.00    0.60   11.33    0.12   1.05
16:04:08 sdd              2.30    194.40    46.30  95.27    3.70    84.52=
=20=20=20
2.90    138.80    32.00  91.69    3.34    47.86    0.00      0.00     0.00=
=20=20
0.00    0.00     0.00    0.60    4.67    0.02   0.54
16:04:08 sde              1.80    204.00    49.20  96.47   14.89   113.33=
=20=20=20
4.10    302.40    71.70  94.59   13.27    73.76    0.00      0.00     0.00=
=20=20
0.00    0.00     0.00    0.60    6.17    0.08   1.66
16:04:08 sdf              1.90     97.20    22.40  92.18   14.63    51.16=
=20=20=20
4.70    212.00    48.50  91.17   19.70    45.11    0.00      0.00     0.00=
=20=20
0.00    0.00     0.00    0.60   11.50    0.13   1.98
16:04:08 sdg              2.00    212.00    51.00  96.23    7.80   106.00=
=20=20=20
4.70    279.20    65.30  93.29    8.32    59.40    0.00      0.00     0.00=
=20=20
0.00    0.00     0.00    0.60    8.00    0.06   1.86
16:04:08 sdh              2.20    213.20    51.10  95.87   21.73    96.91=
=20=20=20
4.80    315.60    74.30  93.93   27.77    65.75    0.00      0.00     0.00=
=20=20
0.00    0.00     0.00    0.60   14.33    0.19   2.05

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

