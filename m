Return-Path: <linux-ext4+bounces-4660-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 998339A5FE7
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Oct 2024 11:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA8AB1C215FB
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Oct 2024 09:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840D01E32C5;
	Mon, 21 Oct 2024 09:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Dlpy2Jwb"
X-Original-To: linux-ext4@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B3B1E32B3
	for <linux-ext4@vger.kernel.org>; Mon, 21 Oct 2024 09:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729502689; cv=none; b=d1+vSPL0Nq2oct31IKXlNYI2vCM4Jp8fgXCfm/mw86rrztznGO3YeCBRa448NzqWgJGazfo/R/C+aWmuhtb5NF9Qk3wJ5gQ5zev4m9x4VQTJ61XqUYIXZzvNFJ2HKEenBnHEc1EamzABubMFZ/LHh7wvs2STE88Ok+XB0t+oX+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729502689; c=relaxed/simple;
	bh=oN7qiDQipperR4UjvYN8qgzYH4Qe9V/N9cgnzqdMiug=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fVDFs4Pk6xYNjTLlM86RB0VlaMmFezc2VZgUIETubGAqhHtcUrpiBMr6kkd+nxDyWhB6JILWOdsL7NWfAFS2mPd6vIH3O2iL1FmlhIIhFY4XBbncdfKLOZdv7ZLyZrQmQXId83gWbmbWEmvAwk6Yw1tU3vhacEGnRQYdu0gERvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Dlpy2Jwb; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729502683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vjI3hYQUlPyRy+W/MATCg8+9V3YFYgteupu549Ayntc=;
	b=Dlpy2Jwb1xHcnsQ7Yakd668+IZbd9x3LD/ZB5ij/h4z29c2G/vki+9QKHOdaf/dEETS2ma
	f4ItOZqpGYMY/gPCiF32xOMN7SExhtwrW+kzJk/DELbHLdDBoNXxG8K3rQqQ+8qZmhnAOB
	mznQrfdy8wbxn+ouoXC+yTtEh75R2Bo=
From: Luis Henriques <luis.henriques@linux.dev>
To: Eric Sandeen <sandeen@sandeen.net>
Cc: Theodore Ts'o <tytso@mit.edu>,  Andreas Dilger <adilger@dilger.ca>,
  linux-ext4@vger.kernel.org
Subject: Re: [PATCH 0/2] e2fsck: make sure orphan files are cleaned-up
In-Reply-To: <62c41f80-4bfc-488e-ba8f-8e1d5fc472a9@sandeen.net> (Eric
	Sandeen's message of "Fri, 18 Oct 2024 19:46:24 -0500")
References: <20240611142704.14307-1-luis.henriques@linux.dev>
	<62c41f80-4bfc-488e-ba8f-8e1d5fc472a9@sandeen.net>
Date: Mon, 21 Oct 2024 10:24:31 +0100
Message-ID: <87bjzdn700.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

On Fri, Oct 18 2024, Eric Sandeen wrote:

> On 6/11/24 9:27 AM, Luis Henriques (SUSE) wrote:
>> Hi!
>>=20
>> I'm sending a fix to e2fsck that forces the filesystem checks to happen
>> when the orphan file is present in the filesystem.  This patch resulted =
from
>> a bug reported in openSUSE Tumbleweed[1] where e2fsck doesn't clean-up t=
his
>> file and later the filesystem  fails to be mounted read-only (because it
>> still requires recovery).
>
> Looks like Fedora is hitting this bug now:
>
> https://bugzilla.redhat.com/show_bug.cgi?id=3D2318710
>
> (unclear why fedora upgrade is leaving an unclean root fs on reboot, but
> that's a separate issue.)
>
> With this patch in place, bare e2fsck asks for confirmation, not sure if =
that's
> expected. But with "yes" answers, the filesystem is cleaned properly and
> mounts just fine.
>
> Also - shouldn't we go ahead and deal with the orphan inode file even on a
> readonly mount, as long as the bdev itself is not readonly?

Since that would be a filesystem-level change, my opinion is that we
should not do that in a read-only mount.  But that's just my opinion and
maybe there are other similar cases (I didn't check) where changes are
written on read-only mounts.

Cheers,
--=20
Lu=C3=ADs

> ext4_mark_recovery_complete():
>
>         if (sb_rdonly(sb) && (ext4_has_feature_journal_needs_recovery(sb)=
 ||
>             ext4_has_feature_orphan_present(sb))) {
>                 if (!ext4_orphan_file_empty(sb)) {
>                         ext4_error(sb, "Orphan file not empty on read-onl=
y fs.");
>                         err =3D -EFSCORRUPTED;
>                         goto out;
>                 }
>                 ext4_clear_feature_journal_needs_recovery(sb);
>                 ext4_clear_feature_orphan_present(sb);
>                 ext4_commit_super(sb);
>         }
>
> # losetup /dev/loop0 2318710-e2image.raw   ## from above bz attachment
> # e2fsck /dev/loop0 (without this patch)
> ...
> # mount -o ro /dev/loop0 mnt
> mount: /root/e2fsprogs/mnt: fsconfig system call failed: Structure needs =
cleaning.
>        dmesg(1) may have more information after failed mount system call.
> # dmesg | tail -n 2
> [ 3083.343622] EXT4-fs error (device loop0): ext4_mark_recovery_complete:=
6229: comm mount: Orphan file not empty on read-only fs.
> [ 3083.345339] EXT4-fs (loop0): mount failed
> # mount -o rw /dev/loop0 mnt
> # echo $?
> 0
>
> -Eric
>
>
>> I'm also sending a new test to validate this scenario.
>>=20
>> [1] https://bugzilla.suse.com/show_bug.cgi?id=3D1226043
>>=20
>> Luis Henriques (SUSE) (2):
>>   e2fsck: don'k skip checks if the orphan file is present in the
>>     filesystem
>>   tests: new test to check that the orphan file is cleaned up
>>=20
>>  e2fsck/unix.c                      |   4 ++++
>>  tests/f_clear_orphan_file/expect.1 |  35 +++++++++++++++++++++++++++++
>>  tests/f_clear_orphan_file/expect.2 |   7 ++++++
>>  tests/f_clear_orphan_file/image.gz | Bin 0 -> 12449 bytes
>>  tests/f_clear_orphan_file/name     |   1 +
>>  tests/f_clear_orphan_file/script   |   2 ++
>>  6 files changed, 49 insertions(+)
>>  create mode 100644 tests/f_clear_orphan_file/expect.1
>>  create mode 100644 tests/f_clear_orphan_file/expect.2
>>  create mode 100644 tests/f_clear_orphan_file/image.gz
>>  create mode 100644 tests/f_clear_orphan_file/name
>>  create mode 100644 tests/f_clear_orphan_file/script
>>=20
>>=20
>


