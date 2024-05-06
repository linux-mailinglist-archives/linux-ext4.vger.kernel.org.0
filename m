Return-Path: <linux-ext4+bounces-2308-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 973DE8BCCEF
	for <lists+linux-ext4@lfdr.de>; Mon,  6 May 2024 13:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E896283295
	for <lists+linux-ext4@lfdr.de>; Mon,  6 May 2024 11:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D510C143875;
	Mon,  6 May 2024 11:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dwd.de header.i=@dwd.de header.b="0GoKwYeC"
X-Original-To: linux-ext4@vger.kernel.org
Received: from ofcsgdbm.dwd.de (ofcsgdbm.dwd.de [141.38.3.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6671142E9D
	for <linux-ext4@vger.kernel.org>; Mon,  6 May 2024 11:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.38.3.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714995586; cv=none; b=uOAJWj0iXYP94+kHxuq/d5Tc6ecq4jwArMgiLFL74taqD+GNi2LleOMRkABAh+crhTKHMpNkOkkyyHHaf3PVio16LhROM4No/Z7LxYat9C0cY3QiV796BjP+mP0p/xm/FAlOd4QoaXOPxqwas9JSY4bW8gJkbZiXMug3LXYhEqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714995586; c=relaxed/simple;
	bh=OxJGO+TPbIBb9zNbxbm0ApRGQLA4OxaDvGywoaceh3s=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=SigGdQKFd1e1VV+TcIkHhm0GHEueDUqRa7eHDKVA6RocieaD68HuY1doLWW83sTH1MMoH1kKrs51fDeYi205kVM4BzBm5AJLK+xyuvmbDuaF1RwxxIEIrvrBmScn03j6b458wCNwj5FrF2d8Sf3BOAziyKzWWv/cF9Bn5lCEv3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dwd.de; spf=pass smtp.mailfrom=dwd.de; dkim=pass (2048-bit key) header.d=dwd.de header.i=@dwd.de header.b=0GoKwYeC; arc=none smtp.client-ip=141.38.3.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dwd.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dwd.de
Received: from localhost (localhost [127.0.0.1])
	by ofcsg2dn2.dwd.de (Postfix) with ESMTP id 4VXzky1P5lz2yJ6
	for <linux-ext4@vger.kernel.org>; Mon,  6 May 2024 11:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dwd.de; h=
	content-type:content-type:mime-version:message-id:subject
	:subject:from:from:date:date:received:received:received:received
	:received:received:received:received; s=dwd-csg20210107; t=
	1714995098; x=1716204699; bh=OxJGO+TPbIBb9zNbxbm0ApRGQLA4OxaDvGy
	woaceh3s=; b=0GoKwYeC/f2Jv1JoiZHyomdYoeNZSCj+fz1E7zII2UlxAr/YUUc
	XYip6n6DzJF//Yq8/BlMczlbw8JxLU4jkN7DT9a9N7qoIrgJLO+NQ1axI3zqBCyN
	Pb6+77BElajT1fLckgbzVG+RPld1j/oPLhRD5dsQGFEtZlG3rREpuUBsLQAmBQh1
	9aLyZMoOGgyll0MCI0f8uzlGAOgduO6p+bJdoWlFvljgLfbihRJrcc9HMk1wGWxY
	Ck83HV9UBm+wtSIsBTx/aUBzUxe90W0eM40/F8S3nwgcOPe8NGZ5e6X04UXe/Y4w
	yikNVjqXmtRXgDz5N+C2MxdYkrAbzJt1ezQ==
X-Virus-Scanned: by amavisd-new at csg.dwd.de
Received: from ofcsg2cteh1.dwd.de ([172.30.232.65])
 by localhost (ofcsg2dn2.dwd.de [172.30.232.25]) (amavisd-new, port 10024)
 with ESMTP id G08DeMBkhOmu for <linux-ext4@vger.kernel.org>;
 Mon,  6 May 2024 11:31:38 +0000 (UTC)
Received: from ofcsg2cteh1.dwd.de (unknown [127.0.0.1])
	by DDEI (Postfix) with ESMTP id D8974C902C35
	for <root@ofcsg2dn2.dwd.de>; Mon,  6 May 2024 11:31:37 +0000 (UTC)
Received: from ofcsg2cteh1.dwd.de (unknown [127.0.0.1])
	by DDEI (Postfix) with ESMTP id CC285C902AF4
	for <root@ofcsg2dn2.dwd.de>; Mon,  6 May 2024 11:31:37 +0000 (UTC)
X-DDEI-TLS-USAGE: Unused
Received: from ofcsgdbm.dwd.de (unknown [172.30.232.25])
	by ofcsg2cteh1.dwd.de (Postfix) with ESMTP
	for <root@ofcsg2dn2.dwd.de>; Mon,  6 May 2024 11:31:37 +0000 (UTC)
Received: from ofcsgdbm.dwd.de by localhost (Postfix XFORWARD proxy);
 Mon, 06 May 2024 11:31:37 -0000
Received: from ofcsg2dvf1.dwd.de (ofcsg2dvf1.dwd.de [172.30.232.10])
	by ofcsg2dn2.dwd.de (Postfix) with ESMTPS id 4VXzkx5V7hz2wlg;
	Mon,  6 May 2024 11:31:37 +0000 (UTC)
Received: from ofmailhub.dwd.de (oflxs04.dwd.de [141.38.39.196])
	by ofcsg2dvf1.dwd.de  with ESMTP id 446BVbgJ012975-446BVbgK012975;
	Mon, 6 May 2024 11:31:37 GMT
Received: from diagnostix.dwd.de (diagnostix.dwd.de [141.38.44.45])
	by ofmailhub.dwd.de (Postfix) with ESMTP id 85257E25F1;
	Mon,  6 May 2024 11:31:37 +0000 (UTC)
Date: Mon, 6 May 2024 11:31:37 +0000 (GMT)
From: Holger Kiehl <Holger.Kiehl@dwd.de>
To: linux-kernel <linux-kernel@vger.kernel.org>, 
    linux-raid <linux-raid@vger.kernel.org>, linux-block@vger.kernel.org, 
    Jens Axboe <axboe@kernel.dk>, linux-ext4@vger.kernel.org, 
    Theodore Ts'o <tytso@mit.edu>
Subject: Massive slowdown in kernels as of 6.x
Message-ID: <1ebabc15-51a8-59f3-c813-4e65e897a373@diagnostix.dwd.de>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-FEAS-Client-IP: 141.38.39.196
X-FE-Last-Public-Client-IP: 141.38.39.196
X-FE-Policy-ID: 2:2:1:SYSTEM
X-TMASE-Version: DDEI-5.1-9.1.1004-28364.007
X-TMASE-Result: 10--12.004400-10.000000
X-TMASE-MatchedRID: H5VXSiqTsunc+HB+YVvemBVof5GwqGWE7oHv+u1YKL7IgofMgahPrdUH
	kSuY22BsSJqNETNJsTzunCUCegRwsIg89NZ7Vbhv9Ib/6w+1lWTVy4hHC3/gyEtYyuL5CqaxEpM
	Y0o/BrKdH12Vl4V0nEfxmBR7r7HocM58Povq2gqMRW4LR41Fi8thQO8CvZj/XHwNEA0yKq2LzkM
	ZyrdGkwa9x5PIKvL4+KnReaaXHYLzW6w64U1hhzkhwlOfYeSqx70GLyvzOg0xLcvHInxh9FPJvf
	lJl1oGs817eS1xemw8QS7uBwY7uxr1qRXLVEaKWqoeab9Xgz88o9AKKr98LSKpqCpA94QmMngIg
	pj8eDcDYr6U3ZlQkdsRB0bsfrpPIFT1PBs+MVY3ocuK7+JBlJD+eJWorgiVL5u8b+BmmsWMaxEn
	zKAdoEdlXvoceU5vXH5yBgF/Oj0Q=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-DDEI-PROCESSED-RESULT: Safe

Hello,

on a 4 socket file server distributing ~90 million files with
~130TiB of data daily, I see a massive slowdown of IO operation
after some time (sometimes in less then a day). This slowdown
only started as of Kernel 6.x and does not happen with 5.15.x.
Have so far tried, 6.0.9, 6.1.27 and 6.6.30 kernel and they all
have this same slowdown effect after some time. If the load is
taken away from the server and it is nearly idle, it still has
this slowdown effect and only recovers after some hours by itself.
During this slowdown and idle time I had a look at an rsync
process with strace that was uploading some small files to the
server and could see the slowdown here was in the rename() system
call, all other system calls (read(), write(), newfstatat(),
openat(), fchmod(), etc) where not effected:

   rename(".27095571.iXVMMT", "27095571")  = 0 <18.305817>
   rename(".272629ef.22gv2x", "272629ef")  = 0 <18.325222>
   rename(".275fbacf.UBj6J5", "275fbacf")  = 0 <18.317571>
   rename(".277ab7da.K5y144", "277ab7da")  = 0 <18.312568>
   rename(".27873039.ZQ4Lum", "27873039")  = 0 <18.310120>
   rename(".27ebf01f.t1FKeU", "27ebf01f")  = 0 <18.376816>
   rename(".27f97e6a.kJqqfL", "27f97e6a")  = 0 <18.290618>
   rename(".28078cd9.rV7JdN", "28078cd9")  = 0 <18.315415>
   rename(".28105bb4.gljiDk", "28105bb4")  = 0 <18.325392>
   rename(".282209b1.Cy3Wt2", "282209b1")  = 0 <30.188303>
   rename(".28888272.aUCxRj", "28888272")  = 0 <18.263236>
   rename(".288d8408.XjfGbH", "288d8408")  = 0 <18.312444>
   rename(".2897f455.hm3FG6", "2897f455")  = 0 <18.281729>
   rename(".28d7d7e8.pzMMF6", "28d7d7e8")  = 0 <18.281402>
   rename(".28d9a820.KQuaM0", "28d9a820")  = 0 <32.620562>
   rename(".294ae845.8Y6vYR", "294ae845")  = 0 <18.289532>
   rename(".294fee3f.eccu2p", "294fee3f")  = 0 <18.260564>
   rename(".29581b50.zPTjTh", "29581b50")  = 0 <18.314536>
   rename(".2975d45f.l5FUYX", "2975d45f")  = 0 <18.293864>
   rename(".29b3770a.tlNMvb", "29b3770a")  = 0 <0.000062>
   rename(".29c5e6ee.EexCwZ", "29c5e6ee")  = 0 <18.268144>
   rename(".29d23183.sLqxpd", "29d23183")  = 0 <18.344478>
   rename(".29d4f65.oyjRWj", "29d4f65")    = 0 <18.553610>
   rename(".29dcfab1.Y47Z1B", "29dcfab1")  = 0 <18.339336>
   rename(".29f26c7c.KNZXEe", "29f26c7c")  = 0 <18.372242>
   rename(".2a09907b.SXIgev", "2a09907b")  = 0 <18.317119>
   rename(".2a0c499c.8DiCsM", "2a0c499c")  = 0 <18.380393>
   rename(".2a64b7e8.FPnsB3", "2a64b7e8")  = 0 <18.372004>
   rename(".2a6765c9.t7Z0hj", "2a6765c9")  = 0 <18.296044>
   rename(".2a83d78f.UJVoMu", "2a83d78f")  = 0 <18.380678>
   rename(".2a94e724.AorYof", "2a94e724")  = 0 <18.360716>
   rename(".2a9ea651.EWpBHM", "2a9ea651")  = 0 <18.327733>
   rename(".2a9f1679.xDYq9Q", "2a9f1679")  = 0 <18.312850>
   rename(".2ab0a134.2GWgmr", "2ab0a134")  = 0 <18.326181>
   rename(".2aebf110.pGkILq", "2aebf110")  = 0 <0.000188>
   rename(".2af10031.7Sl5g6", "2af10031")  = 0 <18.342683>
   rename(".2b095066.MCauJX", "2b095066")  = 0 <18.375003>
   rename(".2b217bfd.HauJjr", "2b217bfd")  = 0 <18.427703>
   rename(".2b336a06.w5NN0p", "2b336a06")  = 0 <18.378774>
   rename(".2b40b422.i2v0E6", "2b40b422")  = 0 <14.727797>
   rename(".2b568d13.9zmRRX", "2b568d13")  = 0 <0.000056>
   rename(".2b5ccc66.AFd86P", "2b5ccc66")  = 0 <0.000063>
   rename(".2b7d0a43.qWyxge", "2b7d0a43")  = 0 <0.000046>
   rename(".2b7f968a.QAqOCb", "2b7f968a")  = 0 <0.000041>
   rename(".2ba6dddf.ynNTvi", "2ba6dddf")  = 0 <0.000039>
   rename(".2bce23ab.tliDkg", "2bce23ab")  = 0 <0.000040>
   rename(".2c19e144.CvHPV5", "2c19e144")  = 0 <0.000060>
   rename(".2c7c0651.8x1kQy", "2c7c0651")  = 0 <0.000057>
   rename(".2ca1a6b7.QwujH4", "2ca1a6b7")  = 0 <0.000396>
   rename(".2cc71683.7n9EYA", "2cc71683")  = 0 <0.000045>
   rename(".2cebde90.ZiGcTa", "2cebde90")  = 0 <0.000042>
   rename(".2d057cb4.5PGOIP", "2d057cb4")  = 0 <0.000042>
   rename(".2d29b4a7.A8hfwg", "2d29b4a7")  = 0 <0.000043>

So during the slow phase it took mostly ~18 seconds and as the phase
ends, the renames are very fast again.

Tried to change the priority of the process with renice and
also enabled some different IO schedulers for the block device,
but this had no effect.

Could not find anything in the logs or dmesg when this happens.

Any idea what could be the cause of this slowdown?

What else can I do to better locate in which part of the kernel
the IO is stuck?

The system has 1.5TiB memory and the filesystem is ext4 on a MD
raid10 with 10 nvme drives (Intel P4610):

   cat /proc/mdstat
   Personalities : [raid10]
   md0 : active raid10 nvme1n1[2] nvme4n1[4] nvme5n1[5] nvme3n1[3] nvme9n1[9] nvme8n1[8] nvme7n1[7] nvme6n1[6] nvme2n1[1] nvme0n1[0]
         7813406720 blocks super 1.2 512K chunks 2 near-copies [10/10] [UUUUUUUUUU]
         bitmap: 28/59 pages [112KB], 65536KB chunk

Mounted as follows:

   /dev/md0 on /u2 type ext4 (rw,nodev,noatime,commit=600,stripe=640)

The following cron entry is used to trim the device:

   25 */2 * * * root /usr/sbin/fstrim -v /u2 >> /tmp/u2.trim 2>&1

A check of the raid was also performed with no issues:

   [Sun May  5 13:52:01 2024] md: data-check of RAID array md0
   [Sun May  5 14:54:25 2024] md: md0: data-check done.
   cat /sys/block/md0/md/mismatch_cnt
   0

CPU's are four Intel Xeon Platinum 8268 and server is a Dell Poweredge R940.

Additional information of the kernel config and other information I have
uploaded to https://download.dwd.de/pub/afd/test/kernel_problem

Regards,
Holger

