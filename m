Return-Path: <linux-ext4+bounces-6843-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B96EA6554F
	for <lists+linux-ext4@lfdr.de>; Mon, 17 Mar 2025 16:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A08C51883369
	for <lists+linux-ext4@lfdr.de>; Mon, 17 Mar 2025 15:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CBE422CBFC;
	Mon, 17 Mar 2025 15:17:56 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EB42F50
	for <linux-ext4@vger.kernel.org>; Mon, 17 Mar 2025 15:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742224676; cv=none; b=a/wetIJqSCxXBXfrf46EQ4xOKW/rLmlnwnjSHuYQyciLbd5l+Hs5lZaDrvbJ0BBBD0SgdcXmaYLPLsFyTJlvI/bibODC1c243Ou1pO9X4Ih9OgXfO/8Y4owA/kl9kQBY1QVixViy8eYoa977tel6iL00CbztfqyXsKNusUUdg+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742224676; c=relaxed/simple;
	bh=BW9OWMenW65ov86bpWs+A+YVZKq9Ur5I50Bo1hyvddw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rTsxA+PRuJMfq+K/zGvqXa1L7i95bM2dCCBtCMGxlaAf2rlBXRZLsCHXVjNEFzW3moDWXwQ798ZBM28ljYwQLJpkVH3pZfjRVG5z8N6y9FoQb/hRF1HeTS+voxYds2CplTKGMLn2pp2EwN+4gvzcDM/xK3kXVLfbn4mLE0kXa2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-111-34.bstnma.fios.verizon.net [173.48.111.34])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 52HFHSVV027147
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Mar 2025 11:17:29 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 460B52E010B; Mon, 17 Mar 2025 11:17:28 -0400 (EDT)
Date: Mon, 17 Mar 2025 11:17:28 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Bhupesh <bhupesh@igalia.com>
Cc: linux-ext4@vger.kernel.org, kernel-dev@igalia.com,
        linux-kernel@vger.kernel.org, revest@google.com,
        adilger.kernel@dilger.ca, cascardo@igalia.com
Subject: Re: [PATCH v2 2/2] fs/ext4/xattr: Check for 'xattr_sem' inside
 'ext4_xattr_delete_inode'
Message-ID: <20250317151728.GC954365@mit.edu>
References: <20250128082751.124948-1-bhupesh@igalia.com>
 <20250128082751.124948-3-bhupesh@igalia.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250128082751.124948-3-bhupesh@igalia.com>

On Tue, Jan 28, 2025 at 01:57:51PM +0530, Bhupesh wrote:
> Once we are inside the 'ext4_xattr_delete_inode' function and trying
> to delete the inode, the 'xattr_sem' should be unlocked.
> 
> We need trylock here to avoid false-positive warning from lockdep
> about reclaim circular dependency.
> 
> This makes the 'ext4_xattr_delete_inode' implementation mimic the
> existing 'ext2_xattr_delete_inode' implementation and thus avoid
> similar lockdep issues while deleting inodes.
> 
> Signed-off-by: Bhupesh <bhupesh@igalia.com>

This patch is causing a failure of test ext4/026, and also exposed a
bug in e2fsprogs[1].  With the e2fsprogs bug fixed, the file system
corruption which is induced by ext4/026 is (when running e2fsck -fn on
SCRATCH_DEV):

Pass 1: Checking inodes, blocks, and sizes
Pass 2: Checking directory structure
Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Regular filesystem inode 14 has EA_INODE flag set. Clear? no

Unattached inode 14
Connect to /lost+found? no

Pass 5: Checking group summary information

/tmp/kvm-xfstests-tytso/vdc.img: ********** WARNING: Filesystem still has errors **********

[1] https://lore.kernel.org/20250317144526.990271-1-tytso@mit.edu

So what appears to be happening is this patch is resulting in ext4/026
failing to clean up a no-longer-used EA inode, which is unfortunate.

Without the e2fsorigs bug fix, ext4/026 will fail but the error
message will be much less edifying:

e2fsck 1.47.2 (1-Jan-2025)
Pass 1: Checking inodes, blocks, and sizes
Pass 2: Checking directory structure
Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
ext2fs_write_inode: Attempt to write to filesystem opened read-only while writing inode 14 in pass4
e2fsck: aborted

So I'm going to drop this patch (2/2) from the ext4 tree, but I'm
going to keep patch 1/2 from this series, since it is fixing a real
bug.  I presume that without this patch, the syzbot reproducer will
trigger a false lockdep warning, but we can fix that later.

Thanks,

					- Ted

