Return-Path: <linux-ext4+bounces-10985-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E84FFBF277F
	for <lists+linux-ext4@lfdr.de>; Mon, 20 Oct 2025 18:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 73F814E9E1C
	for <lists+linux-ext4@lfdr.de>; Mon, 20 Oct 2025 16:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B08F28B4FE;
	Mon, 20 Oct 2025 16:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ep0Qu0IT"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E5F285C88;
	Mon, 20 Oct 2025 16:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760978235; cv=none; b=W5kmJCXpBccjV8diHDNI0nph7xQxfaJqtwCtB79xTqUqihLnedka0TNOdu1jNNBgqXf0FgwRJ0W11mIhWLp77HJyYlbOHmTCtPzTuOn15FoSA0tKbCwmaXiA2P0QlyNnfhzkMA50yA0t9cDaBbk6vcZw5qltYuP0c3/QJ/+Ly5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760978235; c=relaxed/simple;
	bh=eYSWZik8I6UU2RQtP+3440ejPwpqE7azJO68VB2bH6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YNQ/6/1AQVDq4NK24dD40a6X3jfuLRtIpuvP2s4sCd6WkIzo9/HvuIfhTu6VWQi07Fcm1oBCUWVAvojTXhApoHeTfLsR7h2ueZuUxasV5s2K1vF2O+xhS/RZN1lKVUa15EhNeYqeZiUok9EmQktCl4j1NyB6i84ZzwP3Ap6emY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ep0Qu0IT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35B34C4CEF9;
	Mon, 20 Oct 2025 16:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760978234;
	bh=eYSWZik8I6UU2RQtP+3440ejPwpqE7azJO68VB2bH6g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ep0Qu0ITV5K2Su99yQfla0ByUnZb1TrDbjNbD6u5Lbju8BVkbAl/jYqsuM7zwZGYq
	 giIdc4n64xGWIb9C0d5gKjlQ2mSMxZgFVMANAxuSy66KiOiF24SR+B3vvChiC8dddk
	 vxx5q4XVn5ftkQW8RDPp84mzc4/z7LNG2U7jRq7HJyLa2W1b7IKtCR8EllvjA2iYWM
	 D9xc7CjaLmscJI29vHZW+UEK4+asoG/ImWf8vOXRYRnNjP3wGRd+MWvjC2XZQCA/DQ
	 FkM2GAT5UNmQwLt39BhcjA7VgVbpq96EKCgS5hjqzyGxYgW9SXfDxX0Dnh9p5LCkII
	 EgMMuMenT4yoA==
Date: Mon, 20 Oct 2025 09:37:13 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@infradead.org>, Theodore Ts'o <tytso@mit.edu>
Cc: zlang@redhat.com, fstests@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-ext4 <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH 6/8] common/filter: fix _filter_file_attributes to handle
 xfs file flags
Message-ID: <20251020163713.GM6178@frogsfrogsfrogs>
References: <176054617853.2391029.10911105763476647916.stgit@frogsfrogsfrogs>
 <176054618007.2391029.16547003793604851342.stgit@frogsfrogsfrogs>
 <aPHE0N8JX4H8eEo6@infradead.org>
 <20251017162218.GD6178@frogsfrogsfrogs>
 <aPXeQW0ISn6_aCoP@infradead.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPXeQW0ISn6_aCoP@infradead.org>

On Mon, Oct 20, 2025 at 12:01:21AM -0700, Christoph Hellwig wrote:
> On Fri, Oct 17, 2025 at 09:22:18AM -0700, Darrick J. Wong wrote:
> > > What XFS flags end up in lsattr?
> > 
> > Assuming you're asking which XFS flags are reported by ext4 lsattr...
> > 
> > append, noatime, nodump, immutable, projinherit, fsdax
> > 
> > Unless you meant src/file_attr.c?  In which case theyr'e
> 
> I'm actually not sure.  I was just surprised about the flags showing
> up.
> 
> > 
> > > Is this coordinated with the official
> > > registry in ext4?
> > 
> > Only informally by Ted and I talking on Thursdays.
> > 
> > The problem here is that _filter_file_attributes ... probably ought to
> > say which domain (ext4 lsattr or xfs_io lsattr) it's actually filtering.
> 
> Oooh.  That explains my confusion.
> 
> > Right now the only users of this helper are using it to filter
> > src/file_attr.c output (aka xfs_io lsattr) so I think I should change
> > the patch to document that.
> 
> Yes, please.  And we really need to figure out central authoritisied
> to document the lsattr and fsxattr domain flags.

[add tytso and linux-ext4]

I think we should standardize on the VFS (aka file_getattr) flag values,
which means the xfs version more or less wins.

The only problem there of course is that file_getattr doesn't know about
the ext-specific flags, which are:

	{ EXT2_SECRM_FL, "s", "Secure_Deletion" },
	{ EXT2_UNRM_FL, "u" , "Undelete" },
	{ EXT2_DIRSYNC_FL, "D", "Synchronous_Directory_Updates" },
	{ EXT2_COMPR_FL, "c", "Compression_Requested" },
	{ EXT4_ENCRYPT_FL, "E", "Encrypted" },
	{ EXT3_JOURNAL_DATA_FL, "j", "Journaled_Data" },
	{ EXT2_INDEX_FL, "I", "Indexed_directory" },
	{ EXT2_NOTAIL_FL, "t", "No_Tailmerging" },
	{ EXT2_TOPDIR_FL, "T", "Top_of_Directory_Hierarchies" },
	{ EXT4_EXTENTS_FL, "e", "Extents" },
	{ FS_NOCOW_FL, "C", "No_COW" },
	{ EXT4_CASEFOLD_FL, "F", "Casefold" },
	{ EXT4_INLINE_DATA_FL, "N", "Inline_Data" },
	{ EXT4_VERITY_FL, "V", "Verity" },
	{ EXT2_NOCOMPR_FL, "m", "Dont_Compress" },

Not sure what we want to do about that, since some of those flags like
the ones related to deletion, compression, and tailmerging aren't
implemented.

Other things like extents/topdir seem too ext4-specific to put in a vfs
interface....?

--D

