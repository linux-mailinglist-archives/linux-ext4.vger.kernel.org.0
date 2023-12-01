Return-Path: <linux-ext4+bounces-263-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A17DC801007
	for <lists+linux-ext4@lfdr.de>; Fri,  1 Dec 2023 17:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DB442810C8
	for <lists+linux-ext4@lfdr.de>; Fri,  1 Dec 2023 16:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15CBF4CDE0;
	Fri,  1 Dec 2023 16:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W7pKC199"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C89D4205E
	for <linux-ext4@vger.kernel.org>; Fri,  1 Dec 2023 16:24:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E1F0C433C9;
	Fri,  1 Dec 2023 16:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701447851;
	bh=H9s749sT4aGkk3fSh//sTwL4Q4UGTrw72hzytS2TO94=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W7pKC199eNT/4KSDySOyOJO+u9omgjW97qbAxpzTn0BWqktW/TxSwOrytujYZraHC
	 GNQk9RHCNkgj9s8H/iC2OJYc1qht3h+Z+AOAU2INAq/31CcTDPwrqd+xKAdbc3pUJl
	 7VDro91pNoQhY8u/Em5AGH7lxhCd551tUu8GJlOL+y2Rx9aTJg/x2y1zQ2RavAjqU4
	 Hx0bAwni1e1ahajyBccC1d9DKHdxBaS5uAeXdq1lnnYwIpMJpkyhgrf2M9iN/i5gtq
	 g8OAZ3qXx8IJdlm33EHa8ULB9o6EY8JVgE68x4VGeZQM2TQtXZzz+cErccUo5R9Daw
	 BZ5RIUYqLN7Dg==
Date: Fri, 1 Dec 2023 08:24:10 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Brian Norris <briannorris@chromium.org>
Cc: Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] lib/ext2fs: Validity checks for
 ext2fs_inode_scan_goto_blockgroup()
Message-ID: <20231201162410.GA36164@frogsfrogsfrogs>
References: <20231201000126.335263-1-briannorris@chromium.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201000126.335263-1-briannorris@chromium.org>

On Thu, Nov 30, 2023 at 04:01:18PM -0800, Brian Norris wrote:
> We don't validate the 'group' argument, so it's easy to get underflows
> or crashes here.
> 
> This resolves issues seen in ureadahead, when it uses an old packfile
> (with mismatching group indices) with a new filesystem.

Say what now?  The boot time pre-caching thing Ubuntu used to have?
https://manpages.ubuntu.com/manpages/trusty/man8/ureadahead.8.html

--D

> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
> 
>  lib/ext2fs/inode.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/lib/ext2fs/inode.c b/lib/ext2fs/inode.c
> index 957d5aa9f9d6..96d854b5fb69 100644
> --- a/lib/ext2fs/inode.c
> +++ b/lib/ext2fs/inode.c
> @@ -313,6 +313,9 @@ static errcode_t get_next_blockgroup(ext2_inode_scan scan)
>  errcode_t ext2fs_inode_scan_goto_blockgroup(ext2_inode_scan scan,
>  					    int	group)
>  {
> +	if (group <= 0 || group >= scan->fs->group_desc_count)
> +		return EXT2_ET_INVALID_ARGUMENT;
> +
>  	scan->current_group = group - 1;
>  	scan->groups_left = scan->fs->group_desc_count - group;
>  	scan->bad_block_ptr = 0;
> -- 
> 2.43.0.rc2.451.g8631bc7472-goog
> 
> 

