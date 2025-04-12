Return-Path: <linux-ext4+bounces-7219-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F21FA87045
	for <lists+linux-ext4@lfdr.de>; Sun, 13 Apr 2025 01:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 570ED17BA72
	for <lists+linux-ext4@lfdr.de>; Sat, 12 Apr 2025 23:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FFB11B3F3D;
	Sat, 12 Apr 2025 23:55:50 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD0B17A586
	for <linux-ext4@vger.kernel.org>; Sat, 12 Apr 2025 23:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744502150; cv=none; b=scl5N7vKgRPhwUNKnirZUfmGBkVGxo5WT/r7ksF6NRODWWszimylp8r6xMHxZkJGMG64zdet/EXGKFTBH77DRNZ+fhsvoFcoAk6Fa5wytcRff/qLTuWDijmKF7i/oBGnNFvNmkFr6CE4V/aJoalmtNTqUu2jEYhMRT7Sf3hvpuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744502150; c=relaxed/simple;
	bh=abXuAYgvwr1Ws5Hl6ZuttWEMtuZQf666Ofjlrrpz3Ak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rMBcfCKqAz8HtXAOD11zpYVGCuHoPpfIngNlASbK04T9xi+GKV/rUqQHPRpW8yq2Kt89mVIb/iJ8cCzqNRFMghkmz7TLR5+5fkwkHiJbrQnr+Sws9UTI9hljTombxliCWRHpK+osWw8LkbPaT2URVN8UUJw9XYfzc+0AoFSuxyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-82-137.bstnma.fios.verizon.net [173.48.82.137])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 53CNtZA6010237
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 12 Apr 2025 19:55:36 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 74D772E00E9; Sat, 12 Apr 2025 19:55:35 -0400 (EDT)
Date: Sat, 12 Apr 2025 19:55:35 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mateusz Guzik <mjguzik@gmail.com>, Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>, Jan Kara <jack@suse.cz>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: generic_permission() optimization
Message-ID: <20250412235535.GH13132@mit.edu>
References: <20241031-klaglos-geldmangel-c0e7775d42a7@brauner>
 <CAHk-=wjwNkQXLvAM_CKn2YwrCk8m4ScuuhDv2Jzr7YPmB8BOEA@mail.gmail.com>
 <CAHk-=wiKyMzE26G7KMa_D1KXa6hCPu5+3ZEPUN0zB613kc5g4Q@mail.gmail.com>
 <CAHk-=wiB6vJNexDzBhc3xEwPTJ8oYURvcRLsRKDNNDeFTSTORg@mail.gmail.com>
 <CAHk-=whSzc75TLLPWskV0xuaHR4tpWBr=LduqhcCFr4kCmme_w@mail.gmail.com>
 <a7gys7zvegqwj2box4cs56bvvgb5ft3o3kn4e7iz43hojd4c6g@d3hihtreqdoy>
 <CAHk-=wgEvF3_+sa5BOuYG2J_hXv72iOiQ8kpmSzCpegUhqg4Zg@mail.gmail.com>
 <CAGudoHGxr5gYb0JqPqF_J0MoSAb_qqoF4gaJMEdOhp51yobbLw@mail.gmail.com>
 <20250412215257.GF13132@mit.edu>
 <CAHk-=wifig365Ej8JQrXBzK1_BzU9H9kqvvbBGuboF7CzR28VQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wifig365Ej8JQrXBzK1_BzU9H9kqvvbBGuboF7CzR28VQ@mail.gmail.com>

On Sat, Apr 12, 2025 at 03:36:00PM -0700, Linus Torvalds wrote:
> Indeed. I sent a query to the ext4 list (and I think you) about
> whether my test was even the right one.

Sorry, I must have not seen that message; at least, I don't have any
memory of it.

> Also, while I did a "getfattr -dR" to see if there are any *existing*
> attributes (and couldn't find any), I also assume that if a file has
> ever *had* any attributes, the filesystem may have the attribute block
> allocated even if it's now empty.

Well, getfattr will only show user xattrs.  It won't show security.*
xattr's that might have been set by SELinux, or a
system.posix_acl_access xattr.

> I assume there's some trivial e2fstools thing to show things like
> that, but it needs more ext4 specific knowledge than I have.

Yes, we can test for this using the debugfs command.  For exaple:

root@kvm-xfstests:~# debugfs /dev/vdc
debugfs 1.47.2-rc1 (28-Nov-2024)
debugfs:  stat <13>
Inode: 13   Type: regular    Mode:  0644   Flags: 0x80000
Generation: 1672288850    Version: 0x00000000:00000003
User:     0   Group:     0   Project:     0   Size: 286
File ACL: 0
Links: 1   Blockcount: 8
Fragment:  Address: 0    Number: 0    Size: 0
 ctime: 0x67faf5d0:30d0b2e4 -- Sat Apr 12 19:22:56 2025
 atime: 0x67faf571:7064bd50 -- Sat Apr 12 19:21:21 2025
 mtime: 0x67faf571:71236aa8 -- Sat Apr 12 19:21:21 2025
crtime: 0x67faf571:7064bd50 -- Sat Apr 12 19:21:21 2025
Size of extra inode fields: 32
Extended attributes:
  system.posix_acl_access (28) = 01 00 00 00 01 00 06 00 02 00 04 00 b7 7a 00 00 04 00 04 00 10 00 04 00 20 00 04 00 
Inode checksum: 0xc8f7f1a7
EXTENTS:
(0):33792

(If you know the pathname instead of the inode number, you can also
give that to debugfs's stat command, e.g., "stat /lost+found")

I tested it with a simple variant of your patch, and seems to do the right
thing.  Mateusz, if you want, try the following patch, and then mount
your test file system with "mount -o debug".  (The test_opt is to
avoid a huge amount of noise on your root file system; you can skip it
if it's more trouble than it's worth.)  The patch has a reversed
seense of the test, so it will print a message for every one where
cache_no_acl *wouldn't* be called.  You casn then use debugfs's "stat
<ino#>" to verify whether it has some kind of extended attribute.

	   	  	     	      - Ted

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index f386de8c12f6..3e0ba7c4723a 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5109,6 +5109,11 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 		goto bad_inode;
 	brelse(iloc.bh);
 
+	if (test_opt(sb, DEBUG) &&
+	    (ext4_test_inode_state(inode, EXT4_STATE_XATTR) ||
+	     ei->i_file_acl))
+		ext4_msg(sb, KERN_DEBUG, "has xattr ino %lu", inode->i_ino);
+
 	unlock_new_inode(inode);
 	return inode;
 

