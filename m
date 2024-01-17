Return-Path: <linux-ext4+bounces-838-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B089830741
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Jan 2024 14:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C06B3B23D24
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Jan 2024 13:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEFC82032F;
	Wed, 17 Jan 2024 13:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=horus.com header.i=@horus.com header.b="F6ayITQq"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail.horus.com (mail.horus.com [78.46.148.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D07520320
	for <linux-ext4@vger.kernel.org>; Wed, 17 Jan 2024 13:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.148.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705498961; cv=none; b=KjUWM2jzK+fCNjhtUQO1EBC56oPne1t2NNcLqrp5tgjgjwMlU9bDgmYZWeh86Ko8EMbfsgqG9Z57g4F7+0ilGsis3clZZbYwf79djfCoV4Zym8D1lB5GUAllKhY7whoXq9oKO+mabUGtgptR5piDF7k9y1LM/yoyxrMv9H/i4T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705498961; c=relaxed/simple;
	bh=awk4iHeATJzsI4A5YiC7Kth/dAkqM+Kwdx4MIUlnryU=;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:MIME-Version:Content-Type:Content-Disposition; b=hcugG8gyT764B7iv/bQFp78dk1ywy1pNmFN/UTd9zSm96f6jFpDKvHJrTK48qmjnQCh2emckUj6XDGzb0lKk0aFCywzJfoyOFUSRKmxDRl/qi/E+lbmfO6mkdMotghhvRiGVnhMalpXDwQBYqTh+q4Cz8dAgNkSaM3ftUc4oiLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=horus.com; spf=pass smtp.mailfrom=horus.com; dkim=pass (1024-bit key) header.d=horus.com header.i=@horus.com header.b=F6ayITQq; arc=none smtp.client-ip=78.46.148.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=horus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=horus.com
Received: from [192.168.1.22] (62-47-202-122.adsl.highway.telekom.at [62.47.202.122])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.horus.com (Postfix) with ESMTPSA id 072B6640C2;
	Wed, 17 Jan 2024 14:34:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=horus.com;
	s=20180324; t=1705498476;
	bh=awk4iHeATJzsI4A5YiC7Kth/dAkqM+Kwdx4MIUlnryU=;
	h=Date:From:To:Cc:Subject:From;
	b=F6ayITQqygY+eqPJPBJksxh+6KMVqRsfkL4j3OGWgi7ezBVNpKLMWkI0ev9xxw7v3
	 5FbRKWh9+88b15h1qUHN0rUhneGDZZKN52zkkaCTN6jsYpS8/Sv4ti3HxMPHw000Rd
	 gjUIDJat3IynBskQVCoVx30lm7slHw8p6FmTiCLM=
Received: by camel3.lan (Postfix, from userid 1000)
	id 8FE19580299; Wed, 17 Jan 2024 14:34:35 +0100 (CET)
Date: Wed, 17 Jan 2024 14:34:35 +0100
From: Matthias Reichl <hias@horus.com>
To: Theodore Ts'o <tytso@mit.edu>
Cc: linux-ext4@vger.kernel.org, hias@horus.com
Subject: [e2fsprogs] resize2fs 1.47.0 creates unclean orphan file
Message-ID: <ZafXawnqlO7OvG1k@camel3.lan>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

When resizing a 32 MiB ext4 filesystem that was created with the
orphan_file option to something larger than 32GiB the resulting
filesystem has an unclean orphan file block.

I initially ran into this issue with e2fsprogs 1.47.0 on aarch64
but could also reproduce it with current e2fsprogs master
(githash 260dfea450e387cbd2c8de79a7c2eeacc26f74e9) and e2fsprogs
1.47.0 from Debian Bookworm (the latter needs -O orphan_file as
Debian disabled that option by default) on x86_64.

resize2fs works fine if the target filesystem size is smaller than
32GiB (tested with 30GiB) or if the ext4 filesystem was created without
the orphan_file option.

Steps to reproduce:

$ ./configure --with-root-prefix=/usr/local
$ make
$ truncate -s 32MiB fs
$ ./misc/mke2fs -t ext4 -m 0 fs
$ truncate -s 33GiB fs
$ ./e2fsck/e2fsck -f -n fs
e2fsck 1.47.0 (5-Feb-2023)
Pass 1: Checking inodes, blocks, and sizes
Pass 2: Checking directory structure
Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Pass 5: Checking group summary information
fs: 12/8192 files (0.0% non-contiguous), 6970/32768 blocks
$ ./resize/resize2fs fs
resize2fs 1.47.0 (5-Feb-2023)
Resizing the filesystem on fs to 34603008 (1k) blocks.
The filesystem on fs is now 34603008 (1k) blocks long.

$ ./e2fsck/e2fsck -f -n fs
e2fsck 1.47.0 (5-Feb-2023)
Pass 1: Checking inodes, blocks, and sizes
Pass 2: Checking directory structure
Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Pass 5: Checking group summary information
Orphan file (inode 12) block 2 is not clean.
Clear? no

Failed to initialize orphan file.
Recreate? no


fs: ********** WARNING: Filesystem still has errors **********

fs: 12/8650752 files (16.7% non-contiguous), 2180049/34603008 blocks


so long,

Hias

