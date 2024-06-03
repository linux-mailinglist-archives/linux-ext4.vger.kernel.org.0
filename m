Return-Path: <linux-ext4+bounces-2751-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D0938D816E
	for <lists+linux-ext4@lfdr.de>; Mon,  3 Jun 2024 13:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBE831F25D35
	for <lists+linux-ext4@lfdr.de>; Mon,  3 Jun 2024 11:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F9C84FA9;
	Mon,  3 Jun 2024 11:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NYqiv2wZ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB6C84E1D
	for <linux-ext4@vger.kernel.org>; Mon,  3 Jun 2024 11:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717414828; cv=none; b=kB9TdDPKVsWGtY/rTPLiBzmiid+SNIg+D2B4vQs5Gd/mbJKl5TsRvQNAP+4IUqJdq3AT19Avn7uPTE/WN4sc0Raj988WJWlyG0etCsZe45VltJ4O+5mOfi2+Gh7P/ewgxk3Kxz9vgFLQZhOTpWoFyqtnZ3o/es+eqb3BrBFEXl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717414828; c=relaxed/simple;
	bh=rputze7Gc2nj/oRDTNcTFk84uTivIdZJW9ZkjK82kXU=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=DK6z6I6orrqzEy40zDT1daV9WuvOh4Zj0Myz4ShtqYaWBxcI5YVz2Vf5wVt7QpcRr0EZ9tjJT5NcAg/J8xG1Vi2wDYJVXUtM5iDWtPtuZ/rBijHmPYf0r3yQGtjFd2tHedlRzLLOBXJAH5PlmRMmOTKrlFHVRloXOcn4dOShZxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NYqiv2wZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 17D1DC4AF09
	for <linux-ext4@vger.kernel.org>; Mon,  3 Jun 2024 11:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717414828;
	bh=rputze7Gc2nj/oRDTNcTFk84uTivIdZJW9ZkjK82kXU=;
	h=From:To:Subject:Date:From;
	b=NYqiv2wZMCVlOw6ubcYvDC5vumyTMIoCpjNSbaTiipnKwOy+kwJhiU42IqiyjN3FN
	 ALDqARQ8S6KS1KsRS60ORprVMb9pFM3CG4gnf9eB4ZBnsvw2avWjrAVdQ0CDk48UWe
	 4Q7E48x2+ztgbIEyGS8nTcyVe4CAYNSWd02pvpC1TxdZQNWeH13+wZ3IkkIgq5W10E
	 5cEtHUaaPj+mi05GQU7V+Rx4cY3bv0vwwqVwdY/RbTYsDauEO44g0bYJhDvDzAS94y
	 8nGsHFx0YXusCVEf37TeUXG9IvJuX95RgI3CqbugiLYJdoRWyByQFxG5sdJll1yk2h
	 VXk7hrh+YYr1Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 06434C53B50; Mon,  3 Jun 2024 11:40:28 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 218932] New: Serious problem with ext4 with all kernels,
 auto-commits do not settle to block device
Date: Mon, 03 Jun 2024 11:40:27 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: sirius@mailhaven.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-218932-13602@https.bugzilla.kernel.org/>
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

            Bug ID: 218932
           Summary: Serious problem with ext4 with all kernels,
                    auto-commits do not settle to block device
           Product: File System
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: ext4
          Assignee: fs_ext4@kernel-bugs.osdl.org
          Reporter: sirius@mailhaven.com
        Regression: No

Tested in kernel 5.11, 6.1, 6.8
Some writes to ext4 (default commit=3D5) do not commit to block device in m=
ore
than 25 seconds.

How to reproduce:
apt install php-cli -y
Instead of iostat create io watcher, that shows real writes to block device=
 in
Mb every second:
show_writes.php
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
#!/usr/bin/php
<?php
if(!isset($argv[1])) die("provide device\n");
if(!($device =3D realpath($argv[1]))) die("can't realpath device\n");
if(!preg_match("@[^/]+$@", $device, $m)) die();
$device =3D $m[0];
$prev =3D 0;
while(1) {
        $data =3D preg_split("/\s+/",
trim(file_get_contents("/sys/block/$device/stat")));
        if(empty($data)) die("can't get device info");
        if($prev) echo date("h:i:s")."
".number_format(($data[6]-$prev)*512/1024/1024,2)." M\n";
        $prev =3D $data[6];
        sleep(1);
}
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
Add free HDD/partition of 20Mb+ size (/dev/vdb)
In first console run:
php show_writes.php /dev/vdb

In second console run:
mkfs.ext4 -E lazy_itable_init=3D0 -E lazy_journal_init=3D0 /dev/vdb
mount /dev/vdb /mnt/

rm -f /mnt/test; sync; sleep 1; date && dd if=3D/dev/urandom of=3D/mnt/test=
 bs=3D1M
count=3D10
# watch that 10Mb write has settled in 5 seconds, good
rm -f /mnt/test; sync; sleep 1; date && dd if=3D/dev/urandom of=3D/mnt/test=
 bs=3D1M
count=3D10
# watch, that second 10Mb write does not commit to block device in more tha=
n 25
seconds, but should in 5 seconds, repeat if did.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

