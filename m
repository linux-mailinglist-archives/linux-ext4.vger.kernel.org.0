Return-Path: <linux-ext4+bounces-9763-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E290B3CA90
	for <lists+linux-ext4@lfdr.de>; Sat, 30 Aug 2025 13:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EE5C567413
	for <lists+linux-ext4@lfdr.de>; Sat, 30 Aug 2025 11:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0A526FA6F;
	Sat, 30 Aug 2025 11:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maltris.org header.i=@maltris.org header.b="aD/6LoNY"
X-Original-To: linux-ext4@vger.kernel.org
Received: from host6.manage-it-for.me (host6.manage-it-for.me [88.99.208.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B245E26980B
	for <linux-ext4@vger.kernel.org>; Sat, 30 Aug 2025 11:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.99.208.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756553386; cv=none; b=Vr0d2U/FDSPJbQFOPnxNjH/pRUW2Jd6JbACIIBuXMOvxRe01Au93mefks/DF2qlfE+rd8vWxAL2XYo4/GquqFu3ZhGYyxRHTFDKGZgrdigt2BtV2W7HQApaY8xK0lXSeFl0/63AulQTcik67+jLrOMI5ROGnr/1PnuncqTGsUrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756553386; c=relaxed/simple;
	bh=CImg/PEcvgX0SzR6YQ0ybMzfQ4wu7zamQ8tSYeQ8ons=;
	h=From:To:MIME-Version:Date:Subject:Message-ID:Content-Type; b=CbOo2oN6Ak43SxA+jHQs/thEmzsh7KVSLWlGUy+f9wwbOt55jCm4LaAPqrb23s8qH9zjv3W6sLS5nye27SLv3pCB1MGKasQeGg/K240+M8nPJPbf0vbGTVGolyYF+KIZObD4Sx0pEH5w0VUVomC4pTEJSvuN+qswTRWNWhg1/7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maltris.org; spf=pass smtp.mailfrom=maltris.org; dkim=pass (2048-bit key) header.d=maltris.org header.i=@maltris.org header.b=aD/6LoNY; arc=none smtp.client-ip=88.99.208.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maltris.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maltris.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPA id 027AFC03D0
	for <linux-ext4@vger.kernel.org>; Sat, 30 Aug 2025 13:29:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maltris.org; s=dkim;
	t=1756553383; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding; bh=CImg/PEcvgX0SzR6YQ0ybMzfQ4wu7zamQ8tSYeQ8ons=;
	b=aD/6LoNYf9StoIVTzDxirG7Ylf8NKJLGu+Nl9OSNAKQXu923vnIr+xozC5DQTiqSd7QSXU
	Xh3EHzmoXjhgiuMLBsoJQZi+dWW3VcqKBbmY2VmQ5pMr8yYb2Ytpgw+PCLW5AVNxFyFHgR
	rMk189c1xM8KnoO4wBsr6We4tXCYbu+2ErUWYlDG1s7m4OBm1jGe3R/WeDPyjGORe7n6fK
	RIaaifp0PFtshb5wvguT33Kt+5SwlE0nbuQ0LAcSu9O5YVf7iw4/i17yBldv/1yAw8/hmz
	1DbVLVCEyC/wb+iaLRV2axjcMyREGb/+5L8cbpYsFv8COoYiq8a5hJ6PzaCocA==
From: "Malte Schmidt" <m@maltris.org>
To: linux-ext4@vger.kernel.org
User-Agent: SOGoMail 5.12.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 30 Aug 2025 13:29:42 +0200
Subject: =?utf-8?q?debugfs=2C?==?utf-8?q?_e2fsck=2C?= dumpe2fs on corrupted ~11 TB 
 partition - all tools filling 16 GB of memory until getting ended
Message-ID: <6b0f6-68b2e080-9-1e084900@214889527>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello,

I am currently dealing with a corrupted ext4 filesystem of about 11 TB =
storage. The grade of the corruption is unclear but I have been able to=
 salvage many files using file carving techniques. However it would be =
very convenient to get the filesystem in a somewhat working state to ex=
tract folder structures and/or filenames. I tried to run a general file=
system check, which finds a lot of overwritten data and plenty of thing=
s wrong with inodes. However a few seconds or minutes in all three tool=
s start to fill memory on the machine very good, until it is full and t=
hey get ended by the OOM killer.

At the beginning there was about 8 GB memory in the machine, which I la=
ter bumped up to 16 GB specifically because I found references such as:

https://serverfault.com/questions/9218/running-out-of-memory-running-fs=
ck-on-large-filesystems
https://unix.stackexchange.com/questions/689714/fsck-ext4-consumes-all-=
memory-and-gets-killed
https://groups.google.com/g/linux.debian.user/c/tLWRzDDsYY4
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D614082

Which all more or less came down to not having enough memory, so I want=
ed to try and fix that first.

Settings such as scratch=5Ffiles was enabled with the location being on=
 a reasonably fast SSD, but that did not help either.

I would like to still try and see what is possible, but I am kind of ou=
t of ideas how. What would be the next steps to dive a little deeper as=
 to why the memory is filling up so fast? I suppose that many data on t=
he filesystem, specifically towards the later end of the filesystem, is=
 actually perfectly fine. I am under the assumption that only a brief p=
art of the beginning was overwritten. I was able to verify all superblo=
cks on the block device except the very last one (block 2560000000). Us=
ing mke2fs I figured where the superblocks should be located and used a=
 short script to verify the distances between them to make sure I hit t=
he right offset for the filesystem, and do not by accident try to align=
 the filesystem starting on a backup superblock.

I think the offset is right because upon trying to mount, it recognizes=
 the filesystem but tells =E2=80=9Cthe structure needs cleaning=E2=80=9D=
. I am under the assumption that parts were overwritten because my pred=
ecessor on the topic tried to recreate a new, clean filesystem or even =
md raid on these disks, thinking this will not affect the data on them.=
 When I found them the partitions were wiped and some of the data overw=
ritten. All the superblocks however seem to have survived and the actua=
l data also, because I could already verify the results of the filecarv=
ing to be actual very good data.

Best regards, looking forward to some interesting insights,

M. S.


