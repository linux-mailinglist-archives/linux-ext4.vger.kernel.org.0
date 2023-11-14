Return-Path: <linux-ext4+bounces-12-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F537EAB85
	for <lists+linux-ext4@lfdr.de>; Tue, 14 Nov 2023 09:22:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C25D11C20A2E
	for <lists+linux-ext4@lfdr.de>; Tue, 14 Nov 2023 08:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F0313FFE;
	Tue, 14 Nov 2023 08:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dsvzPVr9"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F319213FE4
	for <linux-ext4@vger.kernel.org>; Tue, 14 Nov 2023 08:22:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6C3ECC433C9
	for <linux-ext4@vger.kernel.org>; Tue, 14 Nov 2023 08:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699950124;
	bh=l/1FY7J6WBN6KJY7D/TCYUIhDl0drJNDKyIc6Q2S4yo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=dsvzPVr9Ym++cAIiEnI8TJSaZr1dZYYldBM0OA6zonlmyrZMxsgS6IQklRqMTcH+V
	 wuX4jyhLF7rZ1AItQpxfw73OL1lFwnvswXeX28K28feM6bNG9J0X1JvWUA0KIfm/EZ
	 +yIEWyWa/dM6LFfRbMXkz+5qsQxnq91YKXYED2MeqwE0al7YEKs3JTqHHL5TK8tGAd
	 irE0vUChKp2L/tneF5cUXW6g6W0EArm0fmgDu2bsR08jwt9SbX9F7/PJ9qmIIZy5zY
	 UqdMRaLkd0mzGncSJr/OBvSATM5L4My34sfJQdTHYQMbQ5Me8kNDy7fB3i2c5Xh5Yt
	 hY2Q3PP38uO8g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 55419C53BD5; Tue, 14 Nov 2023 08:22:04 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 217965] ext4(?) regression since 6.5.0 on sata hdd
Date: Tue, 14 Nov 2023 08:22:03 +0000
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
Message-ID: <bug-217965-13602-Nv8wItrWv8@https.bugzilla.kernel.org/>
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

--- Comment #22 from Eyal Lebedinsky (bugzilla@eyal.emu.id.au) ---
I now ran a test on 6.4.15. I copied a segment of the tree I have issues wi=
th.
    7.2GB in 77,972 files.

It took just over 9 minutes to sync the drain the dirty cache, and the array
run like this
(I am watching the kB_wrtn/s column):

         Device             tps    kB_read/s    kB_wrtn/s    kB_dscd/s=20=
=20=20
kB_read    kB_wrtn    kB_dscd
18:15:01 md127           423.00         4.00      7001.20         0.00=20=
=20=20=20=20=20=20=20
40      70012          0
18:15:11 md127           112.30        14.80      9689.60         0.00=20=
=20=20=20=20=20=20
148      96896          0
18:15:21 md127            28.70         3.60       964.80         0.00=20=
=20=20=20=20=20=20=20
36       9648          0
18:15:31 md127           321.90         4.00      1340.40         0.00=20=
=20=20=20=20=20=20=20
40      13404          0
18:15:41 md127            18.20         0.00       123.20         0.00=20=
=20=20=20=20=20=20=20=20
0       1232          0
18:15:51 md127            26.80        10.00      2062.00         0.00=20=
=20=20=20=20=20=20
100      20620          0
18:16:01 md127             2.60         0.00        56.40         0.00=20=
=20=20=20=20=20=20=20=20
0        564          0
18:16:11 md127             2.80         0.00        82.40         0.00=20=
=20=20=20=20=20=20=20=20
0        824          0
18:16:21 md127             6.10         0.00       150.80         0.00=20=
=20=20=20=20=20=20=20=20
0       1508          0
18:16:31 md127            86.00        16.80      4978.00         0.00=20=
=20=20=20=20=20=20
168      49780          0
18:16:41 md127            48.90        10.80      4505.60         0.00=20=
=20=20=20=20=20=20
108      45056          0
18:16:51 md127            36.10         6.80      1498.00         0.00=20=
=20=20=20=20=20=20=20
68      14980          0
18:17:01 md127             3.20         0.40        64.40         0.00=20=
=20=20=20=20=20=20=20=20
4        644          0
18:17:11 md127             3.40         0.80        84.80         0.00=20=
=20=20=20=20=20=20=20=20
8        848          0
18:17:21 md127             3.70         0.80       283.60         0.00=20=
=20=20=20=20=20=20=20=20
8       2836          0
18:17:31 md127            32.90         6.00      1950.00         0.00=20=
=20=20=20=20=20=20=20
60      19500          0
18:17:41 md127           907.50        24.00     15638.40         0.00=20=
=20=20=20=20=20=20
240     156384          0
18:17:51 md127           698.00         9.60     10476.40         0.00=20=
=20=20=20=20=20=20=20
96     104764          0
18:18:01 md127           146.80         0.40      4796.00         0.00=20=
=20=20=20=20=20=20=20=20
4      47960          0
18:18:11 md127           163.00         0.80      1328.80         0.00=20=
=20=20=20=20=20=20=20=20
8      13288          0
18:18:21 md127           149.50         1.20      1140.00         0.00=20=
=20=20=20=20=20=20=20
12      11400          0
18:18:31 md127            46.50         1.60       545.20         0.00=20=
=20=20=20=20=20=20=20
16       5452          0
18:18:41 md127           335.90        14.40      9770.00         0.00=20=
=20=20=20=20=20=20
144      97700          0
18:18:51 md127           119.90         4.40      3868.80         0.00=20=
=20=20=20=20=20=20=20
44      38688          0
18:19:01 md127           315.70        25.60     11422.80         0.00=20=
=20=20=20=20=20=20
256     114228          0
18:19:11 md127           285.80         1.20      4142.40         0.00=20=
=20=20=20=20=20=20=20
12      41424          0
18:19:21 md127           239.00         4.40      3888.00         0.00=20=
=20=20=20=20=20=20=20
44      38880          0
18:19:31 md127           116.30         1.20      1752.80         0.00=20=
=20=20=20=20=20=20=20
12      17528          0
18:19:41 md127           166.60         8.00      8886.00         0.00=20=
=20=20=20=20=20=20=20
80      88860          0
18:19:51 md127           357.20         5.60      6146.80         0.00=20=
=20=20=20=20=20=20=20
56      61468          0
18:20:01 md127           118.10         1.20      1670.40         0.00=20=
=20=20=20=20=20=20=20
12      16704          0
18:20:11 md127            66.00         6.40       802.80         0.00=20=
=20=20=20=20=20=20=20
64       8028          0
18:20:21 md127           139.40         4.40      1641.20         0.00=20=
=20=20=20=20=20=20=20
44      16412          0
18:20:31 md127            44.40         2.40       632.40         0.00=20=
=20=20=20=20=20=20=20
24       6324          0
18:20:41 md127           183.50        13.60      4048.40         0.00=20=
=20=20=20=20=20=20
136      40484          0
18:20:51 md127           114.40        28.40      8346.40         0.00=20=
=20=20=20=20=20=20
284      83464          0
18:21:01 md127           152.20        27.20     15576.00         0.00=20=
=20=20=20=20=20=20
272     155760          0
18:21:11 md127            75.30         1.60      1146.40         0.00=20=
=20=20=20=20=20=20=20
16      11464          0
18:21:21 md127           236.20        18.40     13491.20         0.00=20=
=20=20=20=20=20=20
184     134912          0
18:21:31 md127           226.70         3.60      3237.60         0.00=20=
=20=20=20=20=20=20=20
36      32376          0
18:21:41 md127           152.70         4.00      2048.00         0.00=20=
=20=20=20=20=20=20=20
40      20480          0
18:21:51 md127            92.10         7.60      1907.20         0.00=20=
=20=20=20=20=20=20=20
76      19072          0
18:22:01 md127           142.50         8.00      1921.60         0.00=20=
=20=20=20=20=20=20=20
80      19216          0
18:22:11 md127           137.30         5.60      2307.60         0.00=20=
=20=20=20=20=20=20=20
56      23076          0
18:22:21 md127           124.10         6.00      1511.20         0.00=20=
=20=20=20=20=20=20=20
60      15112          0
18:22:31 md127           105.90         4.00      1888.80         0.00=20=
=20=20=20=20=20=20=20
40      18888          0
18:22:41 md127           166.30         2.00      2073.20         0.00=20=
=20=20=20=20=20=20=20
20      20732          0
18:22:51 md127           649.90         6.80     10615.20         0.00=20=
=20=20=20=20=20=20=20
68     106152          0
18:23:01 md127          1253.70         8.80    175698.40         0.00=20=
=20=20=20=20=20=20=20
88    1756984          0
18:23:11 md127            88.40         2.00     66840.40         0.00=20=
=20=20=20=20=20=20=20
20     668404          0
18:23:21 md127             0.00         0.00         0.00         0.00=20=
=20=20=20=20=20=20=20=20
0          0          0

Is writing at a few MB/s reasonable for an array with disks that can top
200MB/s?
Note the burst at the end when a significant chunk of the data was written =
out.

Now running on 6.5.10 I see a very different story:

         Device             tps    kB_read/s    kB_wrtn/s    kB_dscd/s=20=
=20=20
kB_read    kB_wrtn    kB_dscd
18:45:53 md127             2.60         0.00        10.40         0.00=20=
=20=20=20=20=20=20=20=20
0        104          0
18:46:03 md127             5.40         0.00        21.60         0.00=20=
=20=20=20=20=20=20=20=20
0        216          0
18:46:13 md127             5.40         0.00        21.60         0.00=20=
=20=20=20=20=20=20=20=20
0        216          0
18:46:23 md127             5.30         0.00        21.60         0.00=20=
=20=20=20=20=20=20=20=20
0        216          0
18:46:33 md127             5.20         0.00        20.80         0.00=20=
=20=20=20=20=20=20=20=20
0        208          0
18:46:43 md127             5.30         0.00        23.60         0.00=20=
=20=20=20=20=20=20=20=20
0        236          0
18:46:53 md127             5.10         0.00        44.00         0.00=20=
=20=20=20=20=20=20=20=20
0        440          0
18:47:03 md127             2.70         0.00        21.60         0.00=20=
=20=20=20=20=20=20=20=20
0        216          0
18:47:13 md127             5.30         0.00        26.80         0.00=20=
=20=20=20=20=20=20=20=20
0        268          0
18:47:23 md127             5.40         0.00        25.20         0.00=20=
=20=20=20=20=20=20=20=20
0        252          0
18:47:33 md127             5.20         0.00        21.60         0.00=20=
=20=20=20=20=20=20=20=20
0        216          0
18:47:43 md127             5.30         0.00        21.20         0.00=20=
=20=20=20=20=20=20=20=20
0        212          0
18:47:53 md127             5.30         0.00        22.40         0.00=20=
=20=20=20=20=20=20=20=20
0        224          0
18:48:03 md127             5.40         0.00        24.00         0.00=20=
=20=20=20=20=20=20=20=20
0        240          0
18:48:13 md127             2.60         0.00        11.20         0.00=20=
=20=20=20=20=20=20=20=20
0        112          0
18:48:23 md127             5.30         0.00        22.40         0.00=20=
=20=20=20=20=20=20=20=20
0        224          0
18:48:33 md127             5.30         0.00        23.20         0.00=20=
=20=20=20=20=20=20=20=20
0        232          0
18:48:43 md127             5.20         0.00        24.40         0.00=20=
=20=20=20=20=20=20=20=20
0        244          0
18:48:53 md127             5.30         0.00        22.00         0.00=20=
=20=20=20=20=20=20=20=20
0        220          0
18:49:03 md127             6.20         3.60        23.20         0.00=20=
=20=20=20=20=20=20=20
36        232          0
18:49:13 md127             3.40         0.00        20.80         0.00=20=
=20=20=20=20=20=20=20=20
0        208          0
18:49:23 md127             5.20         0.00        20.80         0.00=20=
=20=20=20=20=20=20=20=20
0        208          0
18:49:33 md127             5.30         0.00        22.00         0.00=20=
=20=20=20=20=20=20=20=20
0        220          0
18:49:43 md127             5.30         0.00        21.60         0.00=20=
=20=20=20=20=20=20=20=20
0        216          0
18:49:53 md127             5.20         0.00        33.20         0.00=20=
=20=20=20=20=20=20=20=20
0        332          0

I expect this to take much longer to complete, possibly hours (20% drained =
in
the last 30m).

In both cases the flusher thread was running at 100%CPU.

I do have the full logs though.

HTH

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

