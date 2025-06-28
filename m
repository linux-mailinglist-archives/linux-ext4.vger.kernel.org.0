Return-Path: <linux-ext4+bounces-8687-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BBE8AEC445
	for <lists+linux-ext4@lfdr.de>; Sat, 28 Jun 2025 04:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97A9C1BC833E
	for <lists+linux-ext4@lfdr.de>; Sat, 28 Jun 2025 02:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B7E1EB5FD;
	Sat, 28 Jun 2025 02:48:47 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1B442AA6
	for <linux-ext4@vger.kernel.org>; Sat, 28 Jun 2025 02:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751078927; cv=none; b=Z9e2ALQClIb++MsL5+gfDqoC/3wno4XPlNe/HAIrBIaiPGrvNQEcWaAFd8vYno1QFXBBzxf20IMOA09iEz0dv+cQKXTdBHAk+CgKjj5j2s4tQn2yYJR37CfGXyIPIMZ3rKaqcvKGzCFHKiWPgh4KAIENDS8VI2rVjwRuU2xNqv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751078927; c=relaxed/simple;
	bh=hDgZwb25v56zUYacll0oVGfNUZksN4vV5tZuJtgF1+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DT/88uU2agE3EGYvPjfIaxpvMEmcn7cM5rf/YxGJgOaqEARIo6NhWdbYKdbuYUjztkIMOD9u5P8pTr/8S6FKqUBqaTVwTnQYZ5uu8hRSCPTvcOc5q40Ay7g7Z/8mU4YHrhl0EMe12FT2O1XALA+z2F6k29n0kL/7ojO4LQ+ekkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org ([70.33.172.117])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 55S2mb36002571
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Jun 2025 22:48:38 -0400
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id B873634068E; Fri, 27 Jun 2025 22:48:37 -0400 (EDT)
Date: Fri, 27 Jun 2025 22:48:37 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: bugzilla-daemon@kernel.org
Cc: linux-ext4@vger.kernel.org
Subject: Re: [Bug 220288] New: A typo Leads to loss of all data on disk
Message-ID: <20250628024837.GC4253@mit.edu>
References: <bug-220288-13602@https.bugzilla.kernel.org/>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bug-220288-13602@https.bugzilla.kernel.org/>

I don't see how that happened.  /dev/sdc has a partition table at the
beginning of the disk.  That partition table contains the definition
of /dev/sdc1.

So if you ran "fsck.ext4 /dev/sdc" instead of "fsck.ext4 /dev/sdc1",
you should have gotten something like this:

   root@xfstests:~# fsck.ext4 /dev/sdb
   e2fsck 1.47.2-rc1 (28-Nov-2024)
   ext2fs_open2: Bad magic number in super-block
   fsck.ext4: Superblock invalid, trying backup blocks...
   fsck.ext4: Bad magic number in super-block while trying to open /dev/sdb

   The superblock could not be read or does not describe a valid ext2/ext3/ext4
   filesystem.  If the device is valid and it really contains an ext2/ext3/ext4
   filesystem (and not swap or ufs or something else), then the superblock
   is corrupt, and you might try running e2fsck with an alternate superblock:
       e2fsck -b 8193 <device>
    or
       e2fsck -b 32768 <device>

   Found a gpt partition table in /dev/sdb

In any case, fsck.ext4 will not make any changes unless you give it
permission by answering "yes".  For example (do not try this at home,
kids):

    root@xfstests:~# debugfs  -w -R "clri <2>" /dev/sdb1 ; debugfs -w -R "ssv state 2" /dev/sdb1
    debugfs 1.47.2-rc1 (28-Nov-2024)
    debugfs 1.47.2-rc1 (28-Nov-2024)
    root@xfstests:~# fsck.ext4 /dev/sdb1
    e2fsck 1.47.2-rc1 (28-Nov-2024)
    /dev/sdb1 contains a file system with errors, check forced.
    Pass 1: Checking inodes, blocks, and sizes
    Root inode is not a directory.  Clear<y>? yes
    Pass 2: Checking directory structure
    Entry '..' in <2>/<11> (11) has deleted/unused inode 2.  Clear<y>? yes
    Pass 3: Checking directory connectivity
    Root inode not allocated.  Allocate<y>? yes
    Unconnected directory inode 11 (was in /)
    Connect to /lost+found<y>? yes
    /lost+found not found.  Create<y>? yes
    Pass 3A: Optimizing directories
    Pass 4: Checking reference counts
    Inode 11 ref count is 3, should be 2.  Fix<y>? yes
    Pass 5: Checking group summary information

    /dev/sdb1: ***** FILE SYSTEM WAS MODIFIED *****
    /dev/sdb1: 13/655360 files (0.0% non-contiguous), 67263/2620928 blocks

See how fsck.ext4 asks for permission before it makes any change to
the filesystem?

