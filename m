Return-Path: <linux-ext4+bounces-13645-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oAgZEb6QimkQMAAAu9opvQ
	(envelope-from <linux-ext4+bounces-13645-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Feb 2026 02:58:22 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8662211619B
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Feb 2026 02:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2CCD43011BD1
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Feb 2026 01:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5BF4287268;
	Tue, 10 Feb 2026 01:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HsJ0Z2EL"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F91C2868B5
	for <linux-ext4@vger.kernel.org>; Tue, 10 Feb 2026 01:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770688697; cv=none; b=IhH3GhqrY1K7B4B4GtIcbBb11cymbMqvQ/7caAKhI5PHjgcc1G/qKRnFoTzQeBuxHoeAAWZCoS3Rr3+PKDw32U28cd2qzb9pvNv2UBBYy3bCA03+n/tQe2MC0x7M8sFPz7tdrt5Tbf16IB/KmwIGTzJRJ3mla3trxHuvhzUUVzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770688697; c=relaxed/simple;
	bh=fxOR8cBPTz4O1lFBtABQzd4/PSoG3icSJx8KrWcLszc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WSrrlddnCnDCrSfCsJY830oEuiUMUNMI+9Cq+ktXmAFd3XQka8Yd/8KkysqpippwfubPxSRCfp9bM+mFrasI1NFRnU9k0AbiraOP9WEilqbbW0Ur96GxiQsja3EaomQBLgFxyPdPL08JdAEvVLbdoQOFq4y10FQ3TaW8+7ITPi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HsJ0Z2EL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09567C116C6;
	Tue, 10 Feb 2026 01:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770688697;
	bh=fxOR8cBPTz4O1lFBtABQzd4/PSoG3icSJx8KrWcLszc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HsJ0Z2EL9gRG16C0Ti2ec/DwyA4RjTuhkU/Obe79tsEv5yzKKZfQi13QXL9Qz+Rwu
	 qtNrSX6jzv9ncTGUwzkQ9JJtGR0y2c8vSyUD5TWpIRocOM4wxc8UyrjiP/jCmKOQZ4
	 4UjOhAJNaDSJ7GSHQJuTNzFeJ+SweeH42NnKm4Ok3DCZbHVaGGa+5wp/+iZlq8Cz5j
	 SXeLKtYOgRIk2giDXLMAQwjg+8CmdthNpU9IpeiQPM/l7LQvIMY18L+9ZEG9cnzLFc
	 mOQr6p853n0TG/wGdpmGskmYQVSqAT5oRIRuqon/TN8tC67o/Yo4BTI0NFB4JVjU3v
	 Wzwfe+69eZLtw==
Date: Mon, 9 Feb 2026 17:58:16 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Theodore Tso <tytso@mit.edu>
Cc: 294772273 <zy931031@vip.qq.com>,
	linux-ext4 <linux-ext4@vger.kernel.org>,
	"adilger.kernel" <adilger.kernel@dilger.ca>
Subject: Re: [QUESTION] ext4: Why does fsconfig allow repeated mounting?
Message-ID: <20260210015816.GQ7686@frogsfrogsfrogs>
References: <tencent_2462A2D2BBD1792040E4BF74D8EE146E9D08@qq.com>
 <20260209183822.GA15302@macsyma.lan>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260209183822.GA15302@macsyma.lan>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	SUBJECT_ENDS_QUESTION(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13645-lists,linux-ext4=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vip.qq.com,vger.kernel.org,dilger.ca];
	RCPT_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-ext4@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-ext4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kvm-xfstests:email]
X-Rspamd-Queue-Id: 8662211619B
X-Rspamd-Action: no action

On Mon, Feb 09, 2026 at 01:38:22PM -0500, Theodore Tso wrote:
> On Tue, Feb 10, 2026 at 12:07:27AM +0800, 294772273 wrote:
> 
> > The mount interface will report an error for repeated mounting, but
> > fsconfig seems to allow this. Why is that?
> 
> The mount interface does allow repeated mounting:
> 
> root@kvm-xfstests:~# mount /dev/vdc /vdc
> [248226.221469] EXT4-fs (vdc): mounted filesystem 06dd464f-1c3a-4a2b-b3dd-e937c1e7
> 624f r/w with ordered data mode. Quota mode: none.
> root@kvm-xfstests:~# mount /dev/vdc /vdc
> root@kvm-xfstests:~# grep vdc  /proc/mounts  
> /dev/vdc /vdc ext4 rw,relatime 0 0
> /dev/vdc /vdc ext4 rw,relatime 0 0
> 
> This is related to mounting the same block device in multiple places:
> 
> root@kvm-xfstests:~# mount /dev/vdc /mnt/b
> root@kvm-xfstests:~# grep vdc /proc/mounts
> /dev/vdc /mnt/a ext4 rw,relatime 0 0
> /dev/vdc /mnt/b ext4 rw,relatime 0 0
> root@kvm-xfstests:~#
> 
> ... which in turn is related to using bind mounts:
> 
> root@kvm-xfstests:~# mount /dev/vdc /mnt/a
> [248574.078106] EXT4-fs (vdc): mounted filesystem 06dd464f-1c3a-4a2b-b3dd-e937c1
> e7624f r/w with ordered data mode. Quota mode: none.
> root@kvm-xfstests:~# mount --bind /mnt/a /mnt/b
> root@kvm-xfstests:~# grep vdc /proc/mounts
> /dev/vdc /mnt/a ext4 rw,relatime 0 0
> /dev/vdc /mnt/b ext4 rw,relatime 0 0
> root@kvm-xfstests:~#
> 
> In both of these cases, you have to unmount the file system all of the
> mount points (and if applicable, in all namespaces) before the struct
> super for the block device is really unmounted.
> 
> root@kvm-xfstests:~# umount /mnt/a
> root@kvm-xfstests:~# umount /mnt/b
> [248743.872394] EXT4-fs (vdc): unmounting filesystem 06dd464f-1c3a-4a2b-b3dd-e937c1e7624f.
> root@kvm-xfstests:~# 

This is a fun new feature of the post-fsconfig mount(8) binary, as I
discovered when some of my newer fstests exploded after the D12->13
transition.

--D

> 						- Ted
> 

