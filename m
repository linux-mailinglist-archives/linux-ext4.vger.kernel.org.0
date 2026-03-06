Return-Path: <linux-ext4+bounces-14695-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNeuI0D4qmlxZAEAu9opvQ
	(envelope-from <linux-ext4+bounces-14695-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Fri, 06 Mar 2026 16:52:32 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 320A422446C
	for <lists+linux-ext4@lfdr.de>; Fri, 06 Mar 2026 16:52:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0B6FE3048DA1
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Mar 2026 15:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9D336C0B2;
	Fri,  6 Mar 2026 15:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="lrnwV3a3"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7C630EF65
	for <linux-ext4@vger.kernel.org>; Fri,  6 Mar 2026 15:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772812281; cv=none; b=sXxDbdIhQQC1MqTkKHlQtOpKGQvS+CJz2N/UXaBQ+9WpYIxoxEjE8Olq9PnJ6WO0w5ccCCwwXI5dF6853sIfd4GnPuRFkaSDODo5Aj4BMh9hWWUE8dSecXLjVpbVBRM3LEUeoQmcpvO5t7uBg25s0tWPRwvuOB1lse9cWgw8cTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772812281; c=relaxed/simple;
	bh=8BatxAUG3WmXMip3vJ/qsFeuvIzhFYU8E12hx5YU/EQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iSpJA2DkDK+PqWppPxyq4wdICSq8dCrU/UQUs6fW21UblyA/UHyjwmGz4+sdiRCVcPSTel9Ffzj5/wWW+/QHL5O19QIGEy6l4Ms0OT1s6VZpzUyKhjKsziQOwcjZiOCEfUJPHI8lXlFXXiJcdkeqBeOHamz0bqohAPRto6EtPjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=lrnwV3a3; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org ([76.148.192.212])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 626Fp9vs003568
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 6 Mar 2026 10:51:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1772812272; bh=x5af6g0aSiXLnfW6GD25Dq0meQZSFaQFYDGit/lv43Y=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=lrnwV3a3QH+k7v+T5pKBgP+eSOEd16Jq8d+16JrizQKxkKRhK/Bht2xC7ziogMfAx
	 y0QNyqVrUJGs7WyWzLAWbPdVf7IRZNGHkKHTBNYnximV3pp5H6FAm/N1NbxS5BxjNO
	 57b2V7L4eBJnauCbWRG7lHpIVLk71gJWpCgj4sLjR1j0Pn5pcGgqZjdnoReGbUeRfZ
	 +sQ0OcROu7j67I2VLmtSXgbOzCzqDHEaSAyy3SHuCA/bI+ISkmGuhFZKJuvWrR085i
	 Tx7yGYY77BD693F11z2j6ATG0iekY1BS5S53zqZnzvOSkT9zVgqWvv3cr+39BSpZ8j
	 yoVl6eMgCQOCA==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 6B7495BE699E; Fri,  6 Mar 2026 10:51:08 -0500 (EST)
Date: Fri, 6 Mar 2026 10:51:08 -0500
From: "Theodore Tso" <tytso@mit.edu>
To: Daniel Tang <danielzgtg.opensource@gmail.com>
Cc: linux-ext4@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH e2fsprogs] e2fsck: preen inline data no attr
Message-ID: <20260306155108.GA19348@macsyma.local>
References: <3188418.mvXUDI8C0e@daniel-desktop3>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3188418.mvXUDI8C0e@daniel-desktop3>
X-Rspamd-Queue-Id: 320A422446C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mit.edu,none];
	R_DKIM_ALLOW(-0.20)[mit.edu:s=outgoing];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14695-lists,linux-ext4=lfdr.de];
	DKIM_TRACE(0.00)[mit.edu:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tytso@mit.edu,linux-ext4@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-ext4];
	NEURAL_HAM(-0.00)[-0.968];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,system.data:url,macsyma.local:mid]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 08:56:37AM -0500, Daniel Tang wrote:
> I don't like being forcibly dropped into an emergency shell to truncate
> pidfiles and other temporary files every time my tablet uncleanly shuts
> down.

What version of the kernel and e2fsprogs are you running on your
tablet?  And can you send us the output of running "dumpe2fs -h
/dev/DEVICE" on the file system in question?

This really shouldn't be happening; if the extended attribute is
missing while the inline data flag is set, that sounds like either a
kernel bug, or perhaps a problem with the storage device where writes
are not being properly persisted.

Is there anything about these inodes that you need to manually remove
or truncate?  What are the inode timestamps, so we can see if they are
freshly created right about the time of the unclean shutdown?  Or are
they files that might might have been much longer lived, in which case
this might be a sign of actual data loss.

Finally, it's interesting that you're getting dropped into an
emergency shell after every unclean shutdown.  If that's because the
file system had some kind of file system inconsistency marked, then
there may be something else weird going on.

If it's just because there is a deleted inline_data file on the orphan
list, that shouldn't be an issue, and in fact, we can easily verify that:

kvm-xfstests shell
root@kvm-xfstests:~# mke2fs -t ext4 -Fq -O inline_data /dev/vdc 8M
root@kvm-xfstests:~# mount /dev/vdc /mnt
root@kvm-xfstests:~# echo foo > /mnt/foo
root@kvm-xfstests:~# cat >> /mnt/foo
^Z
[1]+  Stopped                 cat >> /mnt/foo
root@kvm-xfstests:~# rm /mnt/foo
root@kvm-xfstests:~# sync
root@kvm-xfstests:~# <Control-A> x
QEMU: terminated

We then restart the kernel, and take a quick look:

root@kvm-xfstests:~# dd if=/dev/vdc of=/tmp/test.img bs=1M count=8
8+0 records in
8+0 records out
8388608 bytes (8.4 MB, 8.0 MiB) copied, 0.0614913 s, 136 MB/s
root@kvm-xfstests:~# e2fsck /tmp/test.img
e2fsck 1.47.4-WIP (11-Nov-2025)
/tmp/test.img: recovering journal
Clearing orphaned inode 13 (uid=0, gid=0, mode=0100644, size=4)
Setting free inodes count to 2036 (was 2037)
/tmp/test.img: clean, 12/2048 files, 1649/8192 blocks
root@kvm-xfstests:~# debugfs /dev/vdc
debugfs 1.47.4-WIP (11-Nov-2025)
debugfs:  stat <13>
Inode: 13   Type: regular    Mode:  0644   Flags: 0x10000000
Generation: 2671039161    Version: 0x00000000:00000001
User:     0   Group:     0   Project:     0   Size: 4
File ACL: 0
Links: 0   Blockcount: 0
Fragment:  Address: 0    Number: 0    Size: 0
 ctime: 0x69aaf6ce:a04cc190 -- Fri Mar  6 10:46:22 2026
 atime: 0x69aaf6ca:0edd508c -- Fri Mar  6 10:46:18 2026
 mtime: 0x69aaf6ca:0edd508c -- Fri Mar  6 10:46:18 2026
crtime: 0x69aaf6ca:0edd508c -- Fri Mar  6 10:46:18 2026
Size of extra inode fields: 32
Extended attributes:
  system.data (0)
Inode checksum: 0x14853e18
Size of inline data: 60
debugfs:

So this is how things *should* work.  I'm curious why it's apparently
not working this way on your tablet.

   	       	      	       	      	  	  - Ted

