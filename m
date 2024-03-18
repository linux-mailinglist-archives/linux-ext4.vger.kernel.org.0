Return-Path: <linux-ext4+bounces-1674-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD93687E2D4
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Mar 2024 05:45:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DAAC1F2170F
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Mar 2024 04:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4ECF1F951;
	Mon, 18 Mar 2024 04:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dNGWUBWZ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F1B1AAD7
	for <linux-ext4@vger.kernel.org>; Mon, 18 Mar 2024 04:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710737127; cv=none; b=Yjt+WnDjZ2XMzDUtoxW+dK+t7X94oPj/A5tWayHd5JqoUA4Kz9o7UZ4HQ2Ju2A1tJjEKu69JmFnWFyZJTGHW7ccVsM28e9zAAvtq+d4K8RXNj9OXHjRNf+jB4XZICn7GC9WwYvkwn+sZh+DYx4nTm7b37T8WFsH4KSOFZDY82ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710737127; c=relaxed/simple;
	bh=75da4kLHgoMXaOOKZ5Q9MjACcC8zUJj9n94D/8MnHpE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eICZCTnMD6SbOuZcZ+Mfqp5mNpUXoHXRJ+c8wSa8AR+4L9VtTz68+OySGG9ZssA2+h2bBIg8kmf8xy3MImCv1JB1KuqreE6uCIxJF0+UCaA72oX5ee7m8/tF+PPZlqywr7o1E/3apNkI3+sPC5mPKvf2rlqrxmU42RWPzk38Zr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dNGWUBWZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BEC17C433B2
	for <linux-ext4@vger.kernel.org>; Mon, 18 Mar 2024 04:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710737126;
	bh=75da4kLHgoMXaOOKZ5Q9MjACcC8zUJj9n94D/8MnHpE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=dNGWUBWZLogtgjGu+qVlN0oHGfplv39ffD95yMK34EmQXX8Ju7NvzU5gJnM4KCYF5
	 tYhRtfkvEONyGzWHnJKcWsEFcNnFzx7XZPB1q54pTwrDey9Sl7IA+l11OpBL0JyRaL
	 3yJYZdIuP/ZoT5JUAPebnm5GMQDV4EARYUo3TeGom/9jQ2dT+Z97KsXWq7hanisb7Z
	 XlsB7nAT2qrdDLX0A50U0/QjjbO5z2RmRGeobX2/lEojPY+ptbcFzhJYntKSqNgPx9
	 2YuYEQNbss9plaPZDV9/YXV9ChPlcXkP2VFQtwFapfADJ7tI4OpqgNyclkm3e3KjSk
	 qNHxrG0DlJMUw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id B688FC53BD3; Mon, 18 Mar 2024 04:45:26 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 217965] ext4(?) regression since 6.5.0 on sata hdd
Date: Mon, 18 Mar 2024 04:45:26 +0000
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
Message-ID: <bug-217965-13602-0pfvbRXyV2@https.bugzilla.kernel.org/>
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

--- Comment #69 from Eyal Lebedinsky (bugzilla@eyal.emu.id.au) ---
Seeing this last comment (#68), I wondered if the fix is included in my lat=
est
kernel. Or do I have a different problem?

After just updating my fedora 38 to kernel 6.7.9 I did NOT do the remount a=
nd
repeated my original problematic test.
    $ uname -s
    Linux e7.eyal.emu.id.au 6.7.9-100.fc38.x86_64 #1 SMP PREEMPT_DYNAMIC Wed
Mar  6 19:31:16 UTC 2024 x86_64 GNU/Linux
    $ mount|grep data1
    /dev/md127 on /data1 type ext4 (rw,noatime,stripe=3D640)

I rsync a directory (262GB, 8,911,139 files) from an SSD to a raid6 (7x12TB=
 =3D>
60TB fs). Both are ext4.
    $ sudo time rsync -aHSK --stats --progress
/data/no-backup/old-backups/tapes /data1/no-backup/really-not/old-backups/

What I see is that once meminfo shows the limit (4GB) was reached, the kwor=
ker
kicks in at 100% CPU.
At that point iostat shows activity on the array dropping, from about 160MB=
/s
to very little (with an occasional burst of a few MB/s).

```
10:12:33 2024-03-18
10:12:33 Device             tps    kB_read/s    kB_wrtn/s    kB_dscd/s=20=
=20=20
kB_read    kB_wrtn    kB_dscd
[trimmed]
10:17:13 md127             0.00         0.00         0.00         0.00=20=
=20=20=20=20=20=20=20=20
0          0          0
10:17:23 md127            34.40       137.60         0.00         0.00=20=
=20=20=20=20=20
1376          0          0  <<< rsync starts
10:17:33 md127          2346.30       747.20      8638.00         0.00=20=
=20=20=20=20=20
7472      86380          0
10:17:43 md127          7067.10       431.60    133644.40         0.00=20=
=20=20=20=20=20
4316    1336444          0
10:17:53 md127          1692.80       578.80      7015.20         0.00=20=
=20=20=20=20=20
5788      70152          0
10:18:03 md127          2439.20       169.60     32071.20         0.00=20=
=20=20=20=20=20
1696     320712          0
10:18:13 md127           274.00         4.00      2242.00         0.00=20=
=20=20=20=20=20=20=20
40      22420          0
10:18:23 md127          3172.70        17.60     56828.00         0.00=20=
=20=20=20=20=20=20
176     568280          0
10:18:33 md127           416.20         0.80      1664.80         0.00=20=
=20=20=20=20=20=20=20=20
8      16648          0
10:18:43 md127            18.70         0.40        76.40         0.00=20=
=20=20=20=20=20=20=20=20
4        764          0
10:18:53 md127             6.50         0.00        30.80         0.00=20=
=20=20=20=20=20=20=20=20
0        308          0
10:19:03 md127             4.80         0.00        40.00         0.00=20=
=20=20=20=20=20=20=20=20
0        400          0
10:19:13 md127             5.70         0.00        63.60         0.00=20=
=20=20=20=20=20=20=20=20
0        636          0
10:19:23 md127             2.60         0.00        54.80         0.00=20=
=20=20=20=20=20=20=20=20
0        548          0
10:19:33 md127             7.40         0.00       243.20         0.00=20=
=20=20=20=20=20=20=20=20
0       2432          0
10:19:43 md127             5.20         0.00        75.60         0.00=20=
=20=20=20=20=20=20=20=20
0        756          0
10:19:53 md127             3.80         0.00        20.40         0.00=20=
=20=20=20=20=20=20=20=20
0        204          0
10:20:03 md127             2.00         0.00        13.20         0.00=20=
=20=20=20=20=20=20=20=20
0        132          0
10:20:13 md127             3.90         0.00        29.20         0.00=20=
=20=20=20=20=20=20=20=20
0        292          0
10:20:23 md127             3.80         0.00        19.60         0.00=20=
=20=20=20=20=20=20=20=20
0        196          0

At the same time meminfo shows:
2024-03-18 10:17:04 Dirty:     11220 kB  Buffers:    829988 kB  MemFree:=20=
=20=20
670576 kB
2024-03-18 10:17:14 Dirty:     10784 kB  Buffers:    830016 kB  MemFree:=20=
=20=20
631500 kB
2024-03-18 10:17:24 Dirty:    750616 kB  Buffers:    875592 kB  MemFree:=20=
=20=20
654236 kB
2024-03-18 10:17:34 Dirty:   2757048 kB  Buffers:    972948 kB  MemFree:=20=
=20=20
600636 kB
2024-03-18 10:17:44 Dirty:   2855196 kB  Buffers:   1046736 kB  MemFree:=20=
=20=20
551940 kB
2024-03-18 10:17:54 Dirty:   4104524 kB  Buffers:   1127200 kB  MemFree:=20=
=20=20
538136 kB
2024-03-18 10:18:04 Dirty:   4390504 kB  Buffers:   1155588 kB  MemFree:=20=
=20=20
600828 kB
2024-03-18 10:18:14 Dirty:   4518280 kB  Buffers:   1161916 kB  MemFree:=20=
=20=20
580176 kB
2024-03-18 10:18:24 Dirty:   4356952 kB  Buffers:   1185872 kB  MemFree:=20=
=20=20
543072 kB
2024-03-18 10:18:34 Dirty:   4559504 kB  Buffers:   1196396 kB  MemFree:=20=
=20=20
518872 kB
2024-03-18 10:18:44 Dirty:   4567212 kB  Buffers:   1197060 kB  MemFree:=20=
=20=20
606572 kB
2024-03-18 10:18:54 Dirty:   4567592 kB  Buffers:   1197084 kB  MemFree:=20=
=20=20
611440 kB
... and stays there until ...

I then killed the copy (14,296MB copied). The writing to the array remained
very low, the kernel thread stayed at 100%
and meminfo drained very slowly. Access to the array is now slow with some
hiccups.

2024-03-18 10:35:24 Dirty:   4484720 kB  Buffers:   4984308 kB  MemFree:=20=
=20=20
820532 kB   <<< rsync killed
2024-03-18 10:35:34 Dirty:   4484436 kB  Buffers:   4984348 kB  MemFree:=20=
=20=20
851288 kB
2024-03-18 10:35:44 Dirty:   4483992 kB  Buffers:   4984368 kB  MemFree:=20=
=20=20
817516 kB
2024-03-18 10:35:54 Dirty:   4483780 kB  Buffers:   4984400 kB  MemFree:=20=
=20=20
803156 kB
2024-03-18 10:36:04 Dirty:   4483704 kB  Buffers:   4984460 kB  MemFree:=20=
=20=20
809956 kB
2024-03-18 10:36:14 Dirty:   4479416 kB  Buffers:   4984496 kB  MemFree:=20=
=20=20
832980 kB
2024-03-18 10:36:24 Dirty:   4474312 kB  Buffers:   4984528 kB  MemFree:=20=
=20=20
881464 kB
2024-03-18 10:36:34 Dirty:   4474260 kB  Buffers:   4984568 kB  MemFree:=20=
=20=20
840444 kB
2024-03-18 10:36:44 Dirty:   4474132 kB  Buffers:   4984600 kB  MemFree:=20=
=20=20
843524 kB
2024-03-18 10:36:54 Dirty:   4474292 kB  Buffers:   4984640 kB  MemFree:=20=
=20=20
841004 kB
2024-03-18 10:37:04 Dirty:   4474052 kB  Buffers:   4984680 kB  MemFree:=20=
=20=20
834148 kB
2024-03-18 10:37:14 Dirty:   4473688 kB  Buffers:   4984712 kB  MemFree:=20=
=20=20
853200 kB
2024-03-18 10:37:24 Dirty:   4473448 kB  Buffers:   4984752 kB  MemFree:=20=
=20=20
782540 kB
2024-03-18 10:37:34 Dirty:   4473288 kB  Buffers:   4984776 kB  MemFree:=20=
=20=20
786100 kB
2024-03-18 10:37:44 Dirty:   3871768 kB  Buffers:   4984972 kB  MemFree:=20=
=20=20
846020 kB
2024-03-18 10:37:54 Dirty:   3871612 kB  Buffers:   4985020 kB  MemFree:=20=
=20=20
826664 kB
2024-03-18 10:38:04 Dirty:   3871736 kB  Buffers:   4985052 kB  MemFree:=20=
=20=20
826084 kB
2024-03-18 10:38:14 Dirty:   3871184 kB  Buffers:   4985100 kB  MemFree:=20=
=20=20
876572 kB
2024-03-18 10:38:24 Dirty:   3870936 kB  Buffers:   4985140 kB  MemFree:=20=
=20=20
918944 kB
2024-03-18 10:38:34 Dirty:   3648080 kB  Buffers:   4985256 kB  MemFree:=20=
=20=20
901336 kB
2024-03-18 10:38:44 Dirty:   3556612 kB  Buffers:   4985316 kB  MemFree:=20=
=20=20
902532 kB
2024-03-18 10:38:54 Dirty:   3551636 kB  Buffers:   4985364 kB  MemFree:=20=
=20=20
837816 kB
2024-03-18 10:39:04 Dirty:   3551968 kB  Buffers:   4985468 kB  MemFree:=20=
=20=20
823392 kB
2024-03-18 10:39:14 Dirty:   2835648 kB  Buffers:   4985656 kB  MemFree:=20=
=20=20
629428 kB
...
2024-03-18 11:05:25 Dirty:   2737096 kB  Buffers:   4993860 kB  MemFree:=20=
=20=20
599424 kB   <<< 30m later
2024-03-18 11:35:25 Dirty:   2573748 kB  Buffers:   5001184 kB  MemFree:=20=
=20=20
612288 kB   <<< again
2024-03-18 12:05:26 Dirty:   2432572 kB  Buffers:   5007704 kB  MemFree:=20=
=20=20
663928 kB   <<< again
2024-03-18 12:35:27 Dirty:   2145348 kB  Buffers:   3707492 kB  MemFree:=20=
=20=20
588464 kB   <<< again
2024-03-18 13:05:27 Dirty:   2017848 kB  Buffers:   3718936 kB  MemFree:=20=
=20=20
585500 kB   <<< again
2024-03-18 13:35:28 Dirty:   1822436 kB  Buffers:   3746824 kB  MemFree:=20=
=20=20
565560 kB   <<< again
2024-03-18 14:05:29 Dirty:   1595088 kB  Buffers:   3799124 kB  MemFree:=20=
=20=20
544504 kB   <<< again
2024-03-18 14:35:29 Dirty:   1498416 kB  Buffers:   3816868 kB  MemFree:=20=
=20
3883524 kB   <<< again
2024-03-18 15:05:30 Dirty:   1387140 kB  Buffers:   3835824 kB  MemFree:=20=
=20
3266060 kB   <<< again
...
2024-03-18 15:32:51 Dirty:   1284940 kB  Buffers:   3850936 kB  MemFree:=20=
=20
3088904 kB   <<< finally
2024-03-18 15:33:01 Dirty:    933268 kB  Buffers:   3851144 kB  MemFree:=20=
=20
3098840 kB
2024-03-18 15:33:11 Dirty:     51956 kB  Buffers:   3851248 kB  MemFree:=20=
=20
3095456 kB
2024-03-18 15:33:21 Dirty:     51968 kB  Buffers:   3851284 kB  MemFree:=20=
=20
3059212 kB
2024-03-18 15:33:31 Dirty:     52032 kB  Buffers:   3851308 kB  MemFree:=20=
=20
3085352 kB
2024-03-18 15:33:41 Dirty:       172 kB  Buffers:   3851336 kB  MemFree:=20=
=20
3090912 kB
2024-03-18 15:33:51 Dirty:        64 kB  Buffers:   3851368 kB  MemFree:=20=
=20
3030584 kB
```

So over 5 hours to copy this small part (14GB of 262GB) of the data.

Is this expected? Is this a fundamental "feature" of ext4? Or of raid6?
When I did do "sudo mount -o remount,stripe=3D0 /data1" the copy progressed
nicely with good
writing speed.

I have logs of the progress of this test at 10s intervals.

Regards

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

