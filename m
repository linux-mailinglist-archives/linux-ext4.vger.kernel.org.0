Return-Path: <linux-ext4+bounces-4600-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F35B9A2580
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Oct 2024 16:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04EAE283DAB
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Oct 2024 14:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021351DE3B4;
	Thu, 17 Oct 2024 14:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="PgwqRZBe"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08C91D461B
	for <linux-ext4@vger.kernel.org>; Thu, 17 Oct 2024 14:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729176481; cv=none; b=SY8lH95vjy+oEXgFac+pAw8a3xu3yQcFCp2PpJ2CAvGPZZ+imEyPcV5vtJd4syeWUzo7m1rE/z/QoCHK1oMu9eGeyTByIi7qX23Md03TiUWJZPF8Is8dgsaES30s9XwQHoEyu0JdNkr+gsHhlPVcNe5Q3GgGvb4uCdUwLfS+6hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729176481; c=relaxed/simple;
	bh=DboRHfwBpHg9o9mviaQ0C8yneuci7g2BeSD/nS16L/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s48es1R/6+Qw4+oprReSKei+7kMJ4/WQhtLg0u31FPfQgKO14riF5x5uIEcvPs7VKqRV1WM6Sz0xYy9DV70V6AKnup6xH5QXe5qClSzQXfH9A0wt4Pun3bCr2CiImbYUdy/ZUXJFHDnO7Xf70cBDVXEftzi21IaW+8hDk0fZg1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=PgwqRZBe; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-118-108.bstnma.fios.verizon.net [173.48.118.108])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 49HElVGx031226
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Oct 2024 10:47:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1729176454; bh=tQcT/FIX/gabRkfcqtUf1zpasLNor2EWth8AjaQOw6I=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=PgwqRZBeMKW+z7WoS7kjDhqrguH0sz5JXR81EglpHo0OQVMRGFWl2eilpRmmJRYaH
	 VkrL3WNwjh31AoxA3NJW6WsEFthz4ztmVfuWzwTXaV9TaBvNT9NrTSVMJtvemOcUIF
	 w3XxyI/PnZXbQRS/WvDUTOlVUsvFER8309jNGIo0xImcUce65nbtaSaUeWhRkZCxpI
	 O0huXILI6HxPIR9iJ6LxrZUe5X+yRn1j38uoBBwYwk3JGphTbCUGePPm5jUoCryP1v
	 qmdt/yqnjKnKAZjzJ0RdJy5ER4PEt9pAohEk+4af43EjRi0PBFStq7hp1ELVcSyKa/
	 zW0OK+8CZLo0Q==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 2CF3115C02DB; Thu, 17 Oct 2024 10:47:31 -0400 (EDT)
Date: Thu, 17 Oct 2024 10:47:31 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Baokun Li <libaokun1@huawei.com>
Cc: Jan Kara <jack@suse.cz>, Qianqiang Liu <qianqiang.liu@163.com>,
        adilger.kernel@dilger.ca,
        syzbot <syzbot+f792df426ff0f5ceb8d1@syzkaller.appspotmail.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, Yang Erkun <yangerkun@huawei.com>
Subject: Re: [PATCH] ext4: fix out-of-bounds issue in ext4_xattr_set_entry
Message-ID: <20241017144731.GA3254556@mit.edu>
References: <Zu+vI3EipxSsPOMe@thinkpad.lan>
 <66efba95.050a0220.3195df.008c.GAE@google.com>
 <Zu+8aQBJgMn7xVws@thinkpad.lan>
 <d62a25e9-04de-4309-98d1-22a4f9b5bb49@huawei.com>
 <20241009155028.u7jpzrw6txldt43j@quack3>
 <05f9c7c2-655a-4f5b-be8e-93f511a954bd@huawei.com>
 <20241014163120.hinbd5jc6mp4vev7@quack3>
 <3930aad6-174d-4422-944e-6c90a3ea065a@huawei.com>
 <20241016204741.GA3204734@mit.edu>
 <811eb084-55d4-4725-9388-05a6e8f489d9@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <811eb084-55d4-4725-9388-05a6e8f489d9@huawei.com>

On Thu, Oct 17, 2024 at 08:42:59PM +0800, Baokun Li wrote:
> Indeed, our rough plan is to first implement isolation of abnormal file
> system resources, so that the system can continue to run normally even
> when there is an error; then implement online scanning, so that the
> maintainer can see the health report at any time; and finally implement
> the most difficult online repair.

We have some of this already; if a block group has obvious
inconsistencies --- for example, if there is an attempt to mark a
block or inode as free, but it's already marked as free as the
allocation bitmap, we can mark the block group as inconsistent, and
then avoid allocating from the block group.  That's easy because it's
the kind of inconsistency which can be detected locally.

The problem comes with those inconsistencies which require a global
examination of the file system data structures.  For example, is the
refcount of an inode correct?  Or is a block claimed by more than one
inode?  The e2scrub approach requires creating a read-only snapshot
(which is why we need LVM) and then running e2fsck in userspace,
because it does a global examination of all file system data
structures.

> We do need to establish the mapping of physical blocks to inodes and
> inodes to parent dir. By tree managed by jbd2 do you mean updating
> the tree when committing to journal? Or are updates to the tree
> logged to journal?

When we allocate a block, we need to journal the changes to the
allocation bitmap.  If we are going to also update the reverse mapping
data structure, that needs to be journalled also, so that after a
crash, the data structures are consistent.

						- Ted

