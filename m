Return-Path: <linux-ext4+bounces-3246-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5D0930870
	for <lists+linux-ext4@lfdr.de>; Sun, 14 Jul 2024 05:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A4F41F21723
	for <lists+linux-ext4@lfdr.de>; Sun, 14 Jul 2024 03:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D07EDDAD;
	Sun, 14 Jul 2024 03:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ExbuVDQ4"
X-Original-To: linux-ext4@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3871D2FE
	for <linux-ext4@vger.kernel.org>; Sun, 14 Jul 2024 03:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720928796; cv=none; b=HEjCINLGb6ZHkmjxsdwY4odxaVpn7aUBjkEIFSK/kCe+kigA7PXiNJ6aue8jAvv7pe1KfZovbjflX0ABOk4yoZPtBc9EkG32A0AvP3/t46S45yoYM0vO3spYONkW0Dug8rdZOsZjWz/0AYDfVJR8tZFpYAMr7mKyFMQyxq8/fDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720928796; c=relaxed/simple;
	bh=lueZb2IvTdg5PSZ5WwBI/cCNp57TVK/ntWRBwsIbjAM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Y3EfGjVh6bLnCPH7WTbZ9A/9b9d/l+YbZVvzQI4i1lL9ks+P0CJGV3f1JLeaGM0TjPjwUw5uYx/+KPRAxQEtIBDlKM4Kn+hHmP+R5D9QPwSrvHJXtYS88YG81ZhC+mNxbQBdTMnDMrLZu4esWq/T2by5+BItP4LwI2cFHuyfODY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ExbuVDQ4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720928792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ENlOMcFe7et1GqUYUGbLy3DOsLPScip6IITwPy45jS4=;
	b=ExbuVDQ4ukTVNY0VgG+SxJnWfHmKa3hYuGTV5S/8VHKUzwQJtxUYBUWnx55vRfk1fRDJIF
	G9xAJ5oyTPPFCxy06RaYse5IKc/7HXehypoX92GvuVr+2r2i2aOxOBHeNm6Vaospra2ibQ
	9oCBPNZ5ZJobG4mLZJEK9e51+2KBFTs=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-26wjSVZkOwWQqqLiTfx-Qg-1; Sat, 13 Jul 2024 23:46:30 -0400
X-MC-Unique: 26wjSVZkOwWQqqLiTfx-Qg-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-70b1808deeaso3385995b3a.1
        for <linux-ext4@vger.kernel.org>; Sat, 13 Jul 2024 20:46:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720928789; x=1721533589;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ENlOMcFe7et1GqUYUGbLy3DOsLPScip6IITwPy45jS4=;
        b=GEeox6GuYwEfPW1BPudggJQc0axlwYgbRhVpiJrt0xA1NYCd9TxHW9Wx6UwjUBQb2k
         vTE25E9rqIqkDogS8WJLPIhHrlT1W/aCR5JZxM3JXnSwSaug8Bh8pwITz0TZYs3cuR/C
         Eg3V3+qVlrV86Pgj3Xhk4RUNpJscAk6xMMuTV8bjTCwEi3GkKhaYXGfzAwnCZZnqbg9a
         7xBI/ecco79j9LMungIFv7jJg97fJSZHS0kzLClzepbC+JwQG8AZ8ngtM5xSOToGLRo6
         mazz71BdvZKnSZtYFMKW8j8LpkviJAfTyb7N/0w15Z/XwDKeG3BDS+qV56+O7j5DdFsh
         C1AQ==
X-Gm-Message-State: AOJu0YwgBqn9Q9ZAOZFVfFiBfogYNt17Gt10cBYcNcVmCdmSIeN4h99b
	hpe0a1qInaDkCz29atUhjhAsUZMeJRSZV75sk+1V1B60rfpPJjzvSLEIXNsIvcuDF7MrrR07kfK
	c7HnDnM774NtYLgPeIPHd9ubzFN0Jqy4edUk1cOurykKcKZYHEO04wDpsYmR3CeIhVmqaya0/P6
	Pp7zQYL2WTUknajga9LVpn2fX51ReOiFqUle0krh9Www==
X-Received: by 2002:a05:6a00:1387:b0:705:a600:31da with SMTP id d2e1a72fcca58-70b435f628bmr19321762b3a.23.1720928789040;
        Sat, 13 Jul 2024 20:46:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWrDEXvdsI3T3iaw9kdiXvGyRHmULsrS5JugN4VnEUA11Xz4dvH7l/2pvsh1weqb8mCO/GTQ==
X-Received: by 2002:a05:6a00:1387:b0:705:a600:31da with SMTP id d2e1a72fcca58-70b435f628bmr19321740b3a.23.1720928788317;
        Sat, 13 Jul 2024 20:46:28 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7ebb54acsm1921122b3a.45.2024.07.13.20.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jul 2024 20:46:27 -0700 (PDT)
Date: Sun, 14 Jul 2024 11:46:24 +0800
From: Zorro Lang <zlang@redhat.com>
To: linux-ext4@vger.kernel.org
Cc: fstests@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>,
	Daniel Gomez <da.gomez@samsung.com>
Subject: [Bug report]: fstests g/388 crash on ext4, BUG: kernel NULL pointer
 dereference, address: 0000000000000000
Message-ID: <20240714034624.qz3l7f52pi6m27yx@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi,

A weird kernel panic on ext4 happened when I tried to test a
fstests patchset:
https://lore.kernel.org/fstests/20240712093341.ftesijixy2yrjlxx@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com/T/#med4b8d2fe14ef627519d84474b4cd1a25d386f75

its 4nd one:
https://lore.kernel.org/fstests/20240712093341.ftesijixy2yrjlxx@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com/T/#m5627037d617e9bc41b12bb7cc3f54fe4fb238dc6
brings in lots of test failures, that might be a test bug.

But besides that, an ext4 kernel panic was triggered with this
patchset (I can't reproduce it without this patchset). Looks like
an error was triggered by another error, so I decided to report out.

With this patchset, the generic/388 rarely(~1%) hit below panic[1], the
.full output as [0]. I'm not sure if it's a hidden ext4 bug, so send
to ext4 list to get a review.

Thanks,
Zorro


[0]
Creating filesystem with 3932160 4k blocks and 983040 inodes
Filesystem UUID: b9690547-c193-4a82-b0df-4682bd621d3f
Superblock backups stored on blocks: 
	32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632, 2654208

Allocating group tables:   0/120␈␈␈␈␈␈␈       ␈␈␈␈␈␈␈done                            
Writing inode tables:   0/120␈␈␈␈␈␈␈       ␈␈␈␈␈␈␈done                            
Creating journal (16384 blocks): done
Writing superblocks and filesystem accounting information:   0/120␈␈␈␈␈␈␈       ␈␈␈␈␈␈␈done

seed = 1721442161
seed = 1721536124
seed = 1721158986
seed = 1720946557
seed = 1721227174
seed = 1721752477
seed = 1721267087
seed = 1721329675
seed = 1721263635
seed = 1721309164
seed = 1721144436
seed = 1721492144
seed = 1721512519
seed = 1720725632
cycle mount failed

[1]
[35310.777927] run fstests generic/388 at 2024-07-13 21:12:06
[35312.098738] EXT4-fs (sda2): mounted filesystem 6fedaf97-5fe1-4d3d-868d-5ad4900db404 r/w with ordered data mode. Quota mode: none.
[35312.124292] EXT4-fs (sda2): shut down requested (1)
[35312.129211] Aborting journal on device sda2-8.
[35312.147925] EXT4-fs (sda2): unmounting filesystem 6fedaf97-5fe1-4d3d-868d-5ad4900db404.
[35312.486599] EXT4-fs (sda2): mounted filesystem 23005ea9-4b8d-4f4d-a3d8-9eb88399cde2 r/w with ordered data mode. Quota mode: none.
[35312.524885] EXT4-fs (sda2): shut down requested (2)
[35312.529803] Aborting journal on device sda2-8.
[35313.280289] EXT4-fs (sda2): unmounting filesystem 23005ea9-4b8d-4f4d-a3d8-9eb88399cde2.
[35313.353971] EXT4-fs (sda2): recovery complete
[35313.359705] EXT4-fs (sda2): mounted filesystem 23005ea9-4b8d-4f4d-a3d8-9eb88399cde2 r/w with ordered data mode. Quota mode: none.
[35315.399337] EXT4-fs (sda2): shut down requested (2)
[35315.404250] Aborting journal on device sda2-8.
[35316.683330] EXT4-fs (sda2): unmounting filesystem 23005ea9-4b8d-4f4d-a3d8-9eb88399cde2.
[35316.764573] EXT4-fs (sda2): INFO: recovery required on readonly filesystem
[35316.771480] EXT4-fs (sda2): write access will be enabled during recovery
[35317.049655] EXT4-fs (sda2): recovery complete
[35317.055129] EXT4-fs (sda2): mounted filesystem 23005ea9-4b8d-4f4d-a3d8-9eb88399cde2 ro with ordered data mode. Quota mode: none.
[35317.080533] EXT4-fs (sda2): unmounting filesystem 23005ea9-4b8d-4f4d-a3d8-9eb88399cde2.
[35317.165130] EXT4-fs (sda2): mounted filesystem 23005ea9-4b8d-4f4d-a3d8-9eb88399cde2 r/w with ordered data mode. Quota mode: none.
[35319.203680] EXT4-fs (sda2): shut down requested (2)
[35319.208606] Aborting journal on device sda2-8.
[35320.521093] EXT4-fs (sda2): unmounting filesystem 23005ea9-4b8d-4f4d-a3d8-9eb88399cde2.
[35320.603849] EXT4-fs (sda2): INFO: recovery required on readonly filesystem
[35320.611211] EXT4-fs (sda2): write access will be enabled during recovery
[35320.993602] EXT4-fs (sda2): recovery complete
[35320.999013] EXT4-fs (sda2): mounted filesystem 23005ea9-4b8d-4f4d-a3d8-9eb88399cde2 ro with ordered data mode. Quota mode: none.
[35321.025053] EXT4-fs (sda2): unmounting filesystem 23005ea9-4b8d-4f4d-a3d8-9eb88399cde2.
[35321.119319] EXT4-fs (sda2): mounted filesystem 23005ea9-4b8d-4f4d-a3d8-9eb88399cde2 r/w with ordered data mode. Quota mode: none.
[35323.157897] EXT4-fs (sda2): shut down requested (2)
[35323.162810] Aborting journal on device sda2-8.
[35324.496257] EXT4-fs (sda2): unmounting filesystem 23005ea9-4b8d-4f4d-a3d8-9eb88399cde2.
[35324.575773] EXT4-fs (sda2): INFO: recovery required on readonly filesystem
[35324.582695] EXT4-fs (sda2): write access will be enabled during recovery
[35324.717245] EXT4-fs (sda2): recovery complete
[35324.723102] EXT4-fs (sda2): mounted filesystem 23005ea9-4b8d-4f4d-a3d8-9eb88399cde2 ro with ordered data mode. Quota mode: none.
[35324.748295] EXT4-fs (sda2): unmounting filesystem 23005ea9-4b8d-4f4d-a3d8-9eb88399cde2.
[35324.817159] EXT4-fs (sda2): mounted filesystem 23005ea9-4b8d-4f4d-a3d8-9eb88399cde2 r/w with ordered data mode. Quota mode: none.
[35324.855518] EXT4-fs (sda2): shut down requested (2)
[35324.860423] Aborting journal on device sda2-8.
[35324.867025] SELinux: inode_doinit_use_xattr:  getxattr returned 5 for dev=sda2 ino=393645
[35324.867280] SELinux: inode_doinit_use_xattr:  getxattr returned 5 for dev=sda2 ino=786642
[35324.868330] SELinux: inode_doinit_use_xattr:  getxattr returned 5 for dev=sda2 ino=131526
[35324.868593] SELinux: inode_doinit_use_xattr:  getxattr returned 5 for dev=sda2 ino=131938
[35324.878133] SELinux: inode_doinit_use_xattr:  getxattr returned 5 for dev=sda2 ino=394150
[35324.883455] SELinux: inode_doinit_use_xattr:  getxattr returned 5 for dev=sda2 ino=786642
[35324.916255] SELinux: inode_doinit_use_xattr:  getxattr returned 5 for dev=sda2 ino=786642
[35325.610405] EXT4-fs (sda2): unmounting filesystem 23005ea9-4b8d-4f4d-a3d8-9eb88399cde2.
[35325.662638] EXT4-fs (sda2): INFO: recovery required on readonly filesystem
[35325.669550] EXT4-fs (sda2): write access will be enabled during recovery
[35325.687756] EXT4-fs (sda2): recovery complete
[35325.694064] EXT4-fs (sda2): mounted filesystem 23005ea9-4b8d-4f4d-a3d8-9eb88399cde2 ro with ordered data mode. Quota mode: none.
[35325.719752] EXT4-fs (sda2): unmounting filesystem 23005ea9-4b8d-4f4d-a3d8-9eb88399cde2.
[35325.770603] EXT4-fs (sda2): mounted filesystem 23005ea9-4b8d-4f4d-a3d8-9eb88399cde2 r/w with ordered data mode. Quota mode: none.
[35326.809758] EXT4-fs (sda2): shut down requested (2)
[35326.814670] Aborting journal on device sda2-8.
[35327.823794] EXT4-fs (sda2): unmounting filesystem 23005ea9-4b8d-4f4d-a3d8-9eb88399cde2.
[35328.283170] EXT4-fs (sda2): 1 orphan inode deleted
[35328.288002] EXT4-fs (sda2): recovery complete
[35328.294197] EXT4-fs (sda2): mounted filesystem 23005ea9-4b8d-4f4d-a3d8-9eb88399cde2 r/w with ordered data mode. Quota mode: none.
[35329.333283] EXT4-fs (sda2): shut down requested (2)
[35329.338200] Aborting journal on device sda2-8.
[35330.341614] EXT4-fs (sda2): unmounting filesystem 23005ea9-4b8d-4f4d-a3d8-9eb88399cde2.
[35330.912577] EXT4-fs (sda2): 1 truncate cleaned up
[35330.917347] EXT4-fs (sda2): recovery complete
[35330.923052] EXT4-fs (sda2): mounted filesystem 23005ea9-4b8d-4f4d-a3d8-9eb88399cde2 r/w with ordered data mode. Quota mode: none.
[35331.962748] EXT4-fs (sda2): shut down requested (2)
[35331.967667] Aborting journal on device sda2-8.
[35333.031590] EXT4-fs (sda2): unmounting filesystem 23005ea9-4b8d-4f4d-a3d8-9eb88399cde2.
[35333.147943] EXT4-fs (sda2): INFO: recovery required on readonly filesystem
[35333.154863] EXT4-fs (sda2): write access will be enabled during recovery
[35333.577648] EXT4-fs (sda2): recovery complete
[35333.583083] EXT4-fs (sda2): mounted filesystem 23005ea9-4b8d-4f4d-a3d8-9eb88399cde2 ro with ordered data mode. Quota mode: none.
[35333.611173] EXT4-fs (sda2): unmounting filesystem 23005ea9-4b8d-4f4d-a3d8-9eb88399cde2.
[35333.706016] EXT4-fs (sda2): mounted filesystem 23005ea9-4b8d-4f4d-a3d8-9eb88399cde2 r/w with ordered data mode. Quota mode: none.
[35333.803908] EXT4-fs warning (device sda2): ext4_convert_unwritten_extents_endio:3720: Inode (132935) finished: extent logical block 733, len 66; IO logical block 758, len 26
[35335.746179] EXT4-fs (sda2): shut down requested (2)
[35335.751095] Aborting journal on device sda2-8.
[35337.014618] EXT4-fs (sda2): unmounting filesystem 23005ea9-4b8d-4f4d-a3d8-9eb88399cde2.
[35337.098961] EXT4-fs (sda2): INFO: recovery required on readonly filesystem
[35337.106293] EXT4-fs (sda2): write access will be enabled during recovery
[35337.361488] EXT4-fs (sda2): recovery complete
[35337.366906] EXT4-fs (sda2): mounted filesystem 23005ea9-4b8d-4f4d-a3d8-9eb88399cde2 ro with ordered data mode. Quota mode: none.
[35337.392378] EXT4-fs (sda2): unmounting filesystem 23005ea9-4b8d-4f4d-a3d8-9eb88399cde2.
[35337.472254] EXT4-fs (sda2): mounted filesystem 23005ea9-4b8d-4f4d-a3d8-9eb88399cde2 r/w with ordered data mode. Quota mode: none.
[35338.512258] EXT4-fs (sda2): shut down requested (2)
[35338.517251] Aborting journal on device sda2-8.
[35339.596659] EXT4-fs (sda2): unmounting filesystem 23005ea9-4b8d-4f4d-a3d8-9eb88399cde2.
[35339.660376] EXT4-fs (sda2): INFO: recovery required on readonly filesystem
[35339.667282] EXT4-fs (sda2): write access will be enabled during recovery
[35340.055893] EXT4-fs (sda2): recovery complete
[35340.061309] EXT4-fs (sda2): mounted filesystem 23005ea9-4b8d-4f4d-a3d8-9eb88399cde2 ro with ordered data mode. Quota mode: none.
[35340.086643] EXT4-fs (sda2): unmounting filesystem 23005ea9-4b8d-4f4d-a3d8-9eb88399cde2.
[35340.180932] EXT4-fs (sda2): mounted filesystem 23005ea9-4b8d-4f4d-a3d8-9eb88399cde2 r/w with ordered data mode. Quota mode: none.
[35341.220716] EXT4-fs (sda2): shut down requested (2)
[35341.225633] Aborting journal on device sda2-8.
[35342.243570] EXT4-fs (sda2): unmounting filesystem 23005ea9-4b8d-4f4d-a3d8-9eb88399cde2.
[35342.672960] EXT4-fs (sda2): recovery complete
[35342.678447] EXT4-fs (sda2): mounted filesystem 23005ea9-4b8d-4f4d-a3d8-9eb88399cde2 r/w with ordered data mode. Quota mode: none.
[35343.300000] EXT4-fs warning (device sda2): ext4_convert_unwritten_extents_endio:3720: Inode (133749) finished: extent logical block 144, len 101; IO logical block 175, len 31
[35343.717912] EXT4-fs (sda2): shut down requested (2)
[35343.722824] Aborting journal on device sda2-8.
[35344.767987] EXT4-fs (sda2): unmounting filesystem 23005ea9-4b8d-4f4d-a3d8-9eb88399cde2.
[35344.876771] EXT4-fs (sda2): INFO: recovery required on readonly filesystem
[35344.883673] EXT4-fs (sda2): write access will be enabled during recovery
[35345.260916] EXT4-fs (sda2): recovery complete
[35345.266320] EXT4-fs (sda2): mounted filesystem 23005ea9-4b8d-4f4d-a3d8-9eb88399cde2 ro with ordered data mode. Quota mode: none.
[35345.291510] EXT4-fs (sda2): unmounting filesystem 23005ea9-4b8d-4f4d-a3d8-9eb88399cde2.
[35345.383234] EXT4-fs (sda2): mounted filesystem 23005ea9-4b8d-4f4d-a3d8-9eb88399cde2 r/w with ordered data mode. Quota mode: none.
[35345.422241] EXT4-fs (sda2): shut down requested (2)
[35345.427163] Aborting journal on device sda2-8.
[35345.431675] SELinux: inode_doinit_use_xattr:  getxattr returned 5 for dev=sda2 ino=394420
[35345.431678] SELinux: inode_doinit_use_xattr:  getxattr returned 5 for dev=sda2 ino=264308
[35345.433372] SELinux: inode_doinit_use_xattr:  getxattr returned 5 for dev=sda2 ino=789092
[35345.434998] SELinux: inode_doinit_use_xattr:  getxattr returned 5 for dev=sda2 ino=263942
[35345.435030] SELinux: inode_doinit_use_xattr:  getxattr returned 5 for dev=sda2 ino=263942
[35345.435048] SELinux: inode_doinit_use_xattr:  getxattr returned 5 for dev=sda2 ino=263942
[35345.436064] SELinux: inode_doinit_use_xattr:  getxattr returned 5 for dev=sda2 ino=133331
[35345.436251] SELinux: inode_doinit_use_xattr:  getxattr returned 5 for dev=sda2 ino=264675
[35345.437159] SELinux: inode_doinit_use_xattr:  getxattr returned 5 for dev=sda2 ino=264710
[35345.437251] SELinux: inode_doinit_use_xattr:  getxattr returned 5 for dev=sda2 ino=133579
[35345.437281] SELinux: inode_doinit_use_xattr:  getxattr returned 5 for dev=sda2 ino=133579
[35345.437301] SELinux: inode_doinit_use_xattr:  getxattr returned 5 for dev=sda2 ino=133579
[35345.438368] SELinux: inode_doinit_use_xattr:  getxattr returned 5 for dev=sda2 ino=263983
[35345.439129] SELinux: inode_doinit_use_xattr:  getxattr returned 5 for dev=sda2 ino=263949
[35345.439894] SELinux: inode_doinit_use_xattr:  getxattr returned 5 for dev=sda2 ino=131950
[35345.441211] SELinux: inode_doinit_use_xattr:  getxattr returned 5 for dev=sda2 ino=264682
[35345.442818] SELinux: inode_doinit_use_xattr:  getxattr returned 5 for dev=sda2 ino=132288
[35345.443412] SELinux: inode_doinit_use_xattr:  getxattr returned 5 for dev=sda2 ino=132494
[35345.443556] SELinux: inode_doinit_use_xattr:  getxattr returned 5 for dev=sda2 ino=132490
[35345.444855] SELinux: inode_doinit_use_xattr:  getxattr returned 5 for dev=sda2 ino=395376
[35345.446132] SELinux: inode_doinit_use_xattr:  getxattr returned 5 for dev=sda2 ino=132705
[35345.446580] SELinux: inode_doinit_use_xattr:  getxattr returned 5 for dev=sda2 ino=395370
[35345.449679] SELinux: inode_doinit_use_xattr:  getxattr returned 5 for dev=sda2 ino=394044
[35345.450739] SELinux: inode_doinit_use_xattr:  getxattr returned 5 for dev=sda2 ino=788856
[35345.450766] SELinux: inode_doinit_use_xattr:  getxattr returned 5 for dev=sda2 ino=788856
[35345.452532] SELinux: inode_doinit_use_xattr:  getxattr returned 5 for dev=sda2 ino=786827
[35345.454651] SELinux: inode_doinit_use_xattr:  getxattr returned 5 for dev=sda2 ino=788873
[35345.655294] SELinux: inode_doinit_use_xattr:  getxattr returned 5 for dev=sda2 ino=395839
[35346.176336] EXT4-fs (sda2): unmounting filesystem 23005ea9-4b8d-4f4d-a3d8-9eb88399cde2.
[35346.243173] BUG: kernel NULL pointer dereference, address: 0000000000000000
[35346.250140] #PF: supervisor instruction fetch in kernel mode
[35346.255799] #PF: error_code(0x0010) - not-present page
[35346.260938] PGD 1140f35067 P4D 0 
[35346.264267] Oops: Oops: 0010 [#1] PREEMPT SMP KASAN NOPTI
[35346.269665] CPU: 11 PID: 379238 Comm: mount Kdump: loaded Not tainted 6.10.0-rc7+ #1
[35346.277405] Hardware name: Dell Inc. PowerEdge R750/0PJ80M, BIOS 1.5.4 12/17/2021
[35346.284883] RIP: 0010:0x0
[35346.287512] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[35346.294035] RSP: 0018:ffa000002e0ef6c8 EFLAGS: 00010246
[35346.299260] RAX: 0000000000000000 RBX: ff110015601db830 RCX: ffffffff81fa6fea
[35346.306393] RDX: 1ffffffff0888c6f RSI: ffd400004f2556c0 RDI: ff110015601dba70
[35346.313527] RBP: ffd400004f2556c0 R08: 0000000000000000 R09: fffa7c0009e4aad8
[35346.320661] R10: ffd400004f2556c7 R11: 0000000000000000 R12: 0000000000000060
[35346.327792] R13: ff11001323c64a50 R14: 0000000000000000 R15: 0000000000000000
[35346.334925] FS:  00007fd5de6e6800(0000) GS:ff11002032400000(0000) knlGS:0000000000000000
[35346.343011] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[35346.348758] CR2: ffffffffffffffd6 CR3: 0000001320da6001 CR4: 0000000000771ef0
[35346.355890] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[35346.363023] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[35346.370156] PKRU: 55555554
[35346.372867] Call Trace:
[35346.375319]  <TASK>
[35346.377426]  ? __die+0x20/0x70
[35346.380493]  ? page_fault_oops+0x116/0x230
[35346.384602]  ? __pfx_page_fault_oops+0x10/0x10
[35346.389048]  ? _raw_spin_unlock+0x29/0x50
[35346.393072]  ? rcu_is_watching+0x11/0xb0
[35346.397006]  ? exc_page_fault+0x59/0xe0
[35346.400854]  ? asm_exc_page_fault+0x22/0x30
[35346.405049]  ? folio_mark_dirty+0x2a/0xf0
[35346.409072]  __ext4_block_zero_page_range+0x50c/0x7b0 [ext4]
[35346.414809]  ext4_truncate+0xcd3/0x1210 [ext4]
[35346.419312]  ? ext4_process_orphan+0xe3/0x3a0 [ext4]
[35346.424349]  ? __pfx_ext4_truncate+0x10/0x10 [ext4]
[35346.429288]  ? __pfx_down_write+0x10/0x10
[35346.433301]  ? ext4_inode_is_fast_symlink+0x125/0x2f0 [ext4]
[35346.439021]  ext4_process_orphan+0x132/0x3a0 [ext4]
[35346.443961]  ext4_orphan_cleanup+0x611/0xeb0 [ext4]
[35346.448904]  ? __pfx_ext4_orphan_cleanup+0x10/0x10 [ext4]
[35346.454359]  ? is_module_address+0x34/0x70
[35346.458464]  __ext4_fill_super+0x2824/0x46e0 [ext4]
[35346.463412]  ? __pfx___ext4_fill_super+0x10/0x10 [ext4]
[35346.468695]  ? __kmalloc_large_node+0x10c/0x1c0
[35346.473237]  ? rcu_is_watching+0x11/0xb0
[35346.477165]  ext4_fill_super+0x22a/0x7c0 [ext4]
[35346.481758]  get_tree_bdev+0x304/0x560
[35346.485515]  ? __pfx_ext4_fill_super+0x10/0x10 [ext4]
[35346.490622]  ? __pfx_get_tree_bdev+0x10/0x10
[35346.494895]  ? security_sb_eat_lsm_opts+0x44/0x80
[35346.499611]  vfs_get_tree+0x87/0x350
[35346.503198]  do_new_mount+0x2a0/0x5f0
[35346.506863]  ? __pfx_do_new_mount+0x10/0x10
[35346.511049]  ? security_capable+0x53/0xa0
[35346.515064]  path_mount+0x2d5/0x1520
[35346.518644]  ? __pfx_path_mount+0x10/0x10
[35346.522653]  ? user_path_at_empty+0x45/0x60
[35346.526843]  __x64_sys_mount+0x1fe/0x270
[35346.530775]  ? __pfx___x64_sys_mount+0x10/0x10
[35346.535222]  do_syscall_64+0x8c/0x180
[35346.538894]  ? __pfx_map_id_up+0x10/0x10
[35346.542821]  ? __pfx_do_mkdirat+0x10/0x10
[35346.546834]  ? ktime_get_coarse_real_ts64+0x130/0x170
[35346.551890]  ? from_kgid_munged+0x84/0x110
[35346.555996]  ? rcu_is_watching+0x11/0xb0
[35346.559920]  ? lockdep_hardirqs_on_prepare+0x179/0x400
[35346.565061]  ? do_syscall_64+0x98/0x180
[35346.568899]  ? lockdep_hardirqs_on+0x78/0x100
[35346.573259]  ? do_syscall_64+0x98/0x180
[35346.577099]  ? clear_bhb_loop+0x45/0xa0
[35346.580938]  ? clear_bhb_loop+0x45/0xa0
[35346.584776]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[35346.589829] RIP: 0033:0x7fd5de50f03e
[35346.593407] Code: 48 8b 0d e5 ad 0e 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d b2 ad 0e 00 f7 d8 64 89 01 48
[35346.612155] RSP: 002b:00007ffc6fe2ccc8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
[35346.619720] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fd5de50f03e
[35346.626853] RDX: 000055e41568f630 RSI: 000055e41568f6b0 RDI: 000055e41568f690
[35346.633984] RBP: 000055e41568f400 R08: 000055e41568f650 R09: 00007ffc6fe2b9f0
[35346.641118] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
[35346.648251] R13: 000055e41568f630 R14: 000055e41568f690 R15: 000055e41568f400
[35346.655388]  </TASK>
[35346.657583] Modules linked in: ext4 mbcache jbd2 intel_rapl_msr intel_rapl_common intel_uncore_frequency intel_uncore_frequency_common i10nm_edac nfit x86_pkg_temp_thermal intel_powerclamp rfkill mlx5_ib coretemp dax_hmem cxl_acpi kvm_intel ib_uverbs mgag200 acpi_power_meter cxl_core iTCO_wdt i2c_algo_bit macsec mei_me dell_smbios iTCO_vendor_support drm_shmem_helper ipmi_ssif sunrpc dcdbas kvm rapl intel_cstate intel_uncore intel_th_gth wmi_bmof dell_wmi_descriptor einj pcspkr ib_core isst_if_mbox_pci drm_kms_helper isst_if_mmio mei intel_th_pci i2c_i801 isst_if_common ipmi_si i2c_smbus intel_vsec intel_pch_thermal acpi_ipmi intel_th ipmi_devintf ipmi_msghandler drm fuse xfs libcrc32c sd_mod t10_pi sg mlx5_core mlxfw crct10dif_pclmul crc32_pclmul crc32c_intel ahci tls libahci ghash_clmulni_intel psample dimlib megaraid_sas tg3 libata pci_hyperv_intf wmi
[35346.733230] CR2: 0000000000000000
[35346.736548] ---[ end trace 0000000000000000 ]---
[35346.807404] RIP: 0010:0x0
[35346.810031] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[35346.816557] RSP: 0018:ffa000002e0ef6c8 EFLAGS: 00010246
[35346.821784] RAX: 0000000000000000 RBX: ff110015601db830 RCX: ffffffff81fa6fea
[35346.828915] RDX: 1ffffffff0888c6f RSI: ffd400004f2556c0 RDI: ff110015601dba70
[35346.836049] RBP: ffd400004f2556c0 R08: 0000000000000000 R09: fffa7c0009e4aad8
[35346.843182] R10: ffd400004f2556c7 R11: 0000000000000000 R12: 0000000000000060
[35346.850314] R13: ff11001323c64a50 R14: 0000000000000000 R15: 0000000000000000
[35346.857447] FS:  00007fd5de6e6800(0000) GS:ff11002032400000(0000) knlGS:0000000000000000
[35346.865532] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[35346.871277] CR2: ffffffffffffffd6 CR3: 0000001320da6001 CR4: 0000000000771ef0
[35346.878410] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[35346.885543] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[35346.892675] PKRU: 55555554
[35346.895390] note: mount[379238] exited with irqs disabled
[35347.014675] EXT4-fs (sda3): unmounting filesystem bfceea3a-021b-46b0-944b-87e2d6693f83.


