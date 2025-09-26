Return-Path: <linux-ext4+bounces-10436-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A88BA5319
	for <lists+linux-ext4@lfdr.de>; Fri, 26 Sep 2025 23:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C6B7D4E1061
	for <lists+linux-ext4@lfdr.de>; Fri, 26 Sep 2025 21:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E97421E091;
	Fri, 26 Sep 2025 21:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="KPFLa3g5"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2741725F98E
	for <linux-ext4@vger.kernel.org>; Fri, 26 Sep 2025 21:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758921900; cv=none; b=VFhfDSYaCm5cBlPIngBooMkfxxhzKKTcTACrFws67VYGlR3bhLvxI6knOmd+9CqhjPAdd6E9sWrA8oUySSlYNu8+/gXPVvKgsVIU53YyO4S3hIvM8O0rAVVPqAEMj81lMTtJ0vpzBlx7ugBrpikM20VRCue5p1tkQIYPEP8aNUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758921900; c=relaxed/simple;
	bh=qnPensNAWhBiKF5VASKWlQ6fEgVJiKIEOO4Pgqued4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hS0H9ropXOh1dVJ5kKiEwviOE4pUdXTceCNwq0+enhk4k7RZIv6MTrvl9eg3eurNwTusQA55oP1WPG/2g+sca4qSLTcAmqw7/mTmCNLSfP4tqpFItGGymDj6yPU8j+ouPtJQDKKDyKZd6GGcEam5cqZbq6AWkV6lX5ecoswK5rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=KPFLa3g5; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-115-162.bstnma.fios.verizon.net [173.48.115.162])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 58QLOpJ2003860
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Sep 2025 17:24:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1758921894; bh=Y8aXKKQ0yeqF7PZo3lZqNvEJwo0UBdExLjEKZgtTxQw=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=KPFLa3g5NK5jlmKAZ+EWDYKKsSzVK+XToQtvDKiCKBZXgOEdHckBgwrBCI2cxjdtR
	 KuKI+TNkFoEEDpV6wFcTJLCEB06RKrGL4x4EADukhdcn5JiBld/7BFks020AMnHV5j
	 vZYGTHXK190snPvpMgfj368U5NCOPdQlTzWuLKRPmVUkNf5pq/YmxHlbHbBAtivE2L
	 SymG63RfLnM5Br0SO/e19MtHITbukPQXXa9YfQBw0dbpA4hxD8pH19n5ezSNV/YbXf
	 84DmakGj5WInyaCABi34jmBchKvyPtMqXLIUGNztkLrSXRdvLXJd0DpxeE4VgM3jel
	 TXkzYh7hsq1fA==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id BDEAF2E00D9; Fri, 26 Sep 2025 17:24:51 -0400 (EDT)
Date: Fri, 26 Sep 2025 17:24:51 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Andreas Dilger <adilger@dilger.ca>
Cc: Deepanshu Kartikey <kartikey406@gmail.com>,
        linux-ext4 <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH v2] ext4: validate ea_ino and size in check_xattrs
Message-ID: <20250926212451.GB118657@mit.edu>
References: <20250923133245.1091761-1-kartikey406@gmail.com>
 <AB6112E6-A3CE-4232-83C6-9099463A7AA4@dilger.ca>
 <CADhLXY5mSwFEXo3BdupqycA-VC96WqKfmqNDq7MYM-_SRFKWxg@mail.gmail.com>
 <0093DAF4-7036-40EA-9051-082D3CD2115A@dilger.ca>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0093DAF4-7036-40EA-9051-082D3CD2115A@dilger.ca>

On Fri, Sep 26, 2025 at 01:47:14PM -0600, Andreas Dilger wrote:
> 
> *NOTE* I haven't tested whether e2fsck already handles this scenario
> correctly, but it is definitely worthwhile to test this with your
> reproducer image to see if e2fsck already fixes the issue. If that is
> already the case, then there is nothing more to be done.

It doesn't.  But see the patch that I sent to fix this.

> If e2fsck does *not* repair this error, then the right workflow is to
> make a *minimal* filesystem image with this corruption and use it for
> a new test case.

I aready sent a patch on this thread, and it includes a minimal file
sytem image.  Unfortunately, we don't have easy way to create
corrupted extended attributre entries using the debugfs tool.  This is
why I decided to just create the patch and test case, instead of
asking Deepanshu to try to create it, since creating the test case
requires using a hex editor and understanding of the extended
attribute layout.  One of these days we really should add the ability
to easily edit extended attribute blocks to corrupt them, but to date
it's been easier for me to just use emacs hexl-mode to edit the image.

The good news is that there are tools to examine extended attributes.
For example:

% debugfs /tmp/f_ea_zero_size.img
debugfs 1.47.3-rc2 (12-Jun-2025)
debugfs:  stat lustre
Inode: 12   Type: regular    Mode:  0644   Flags: 0x80000
Generation: 1631366467    Version: 0x00000000:00000001
User:     0   Group:     0   Project:     0   Size: 0
File ACL: 13
Links: 1   Blockcount: 8
Fragment:  Address: 0    Number: 0    Size: 0
 ctime: 0x594f621c:5143fea0 -- Sun Jun 25 03:11:24 2017
 atime: 0x594f621c:396c7aa4 -- Sun Jun 25 03:11:24 2017
 mtime: 0x594f621c:396c7aa4 -- Sun Jun 25 03:11:24 2017
crtime: 0x594f621c:396c7aa4 -- Sun Jun 25 03:11:24 2017
Size of extra inode fields: 32
EXTENTS:
debugfs:  block_dump -x 13
magic = ea020000, length = 4096
refcount = 1, blocks = 1
hash = 767a7676, checksum = 00000000
reserved: 00000000 00000000 00000000

offset = 32 (0040), hash = 3109, name_len = 2, name_index = 1
value_offset = 0 (0000), value_inum = 14, value_size = 0
name = be

offset = 52 (0064), hash = 2053076598, name_len = 2, name_index = 1
value_offset = 3996 (7634), value_inum = 0, value_size = 100
name = bi
value = vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv

last entry found at offset 72 (0110)

There are also debugfs commands "ea_get, ea_set, and ea_list", which
is good for edit valid extended attribute blocks.  So what I tend to
do is to use these tools to create a valid extended attribute block
--- and then I'll corrupt it using emacs hexl-mode.

    	     	  	     	   	 - Ted


