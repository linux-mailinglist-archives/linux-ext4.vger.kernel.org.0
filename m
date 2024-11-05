Return-Path: <linux-ext4+bounces-4964-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 037749BCC68
	for <lists+linux-ext4@lfdr.de>; Tue,  5 Nov 2024 13:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34AF71C21C01
	for <lists+linux-ext4@lfdr.de>; Tue,  5 Nov 2024 12:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C347B1D5154;
	Tue,  5 Nov 2024 12:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qkRcMpiX"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357441D47C8;
	Tue,  5 Nov 2024 12:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730808700; cv=none; b=E/XSsOin2NW2IAWFJC6m9dTQjQCkbgddWqClacKTiA5yMa/7Lp78KQFEjwC+nMcn19WI4XRxriTbdDPl8vOjh5ogjJLdyaNTrBp3SkbpJk42ZWGpKSBGJgHwi0oJLD8yDNbQDnKYwH79sIQkO2p/S8vpnfmAMyn3gKHT5/nntMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730808700; c=relaxed/simple;
	bh=98CubrVy+i8NU65pnvMJZi4IglBj1qZqIkotOr9SbOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ouZY4uqp6iVQr+fAaZL038RnfXXvtEhZhQBAsMyKUzSthzdT7/ShY4ck0YWWHwcfy16Tj/1Ki5zYWSnpW/Vg5WPj7fo3G52VFpEQjQdd5H6JfNUHVhm1GL5lFzhEF1dopzprq6ydgGN8jAIu8goZqrNhf2hB6RpO7xWHkVjR2b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qkRcMpiX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6125EC4CECF;
	Tue,  5 Nov 2024 12:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730808699;
	bh=98CubrVy+i8NU65pnvMJZi4IglBj1qZqIkotOr9SbOA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qkRcMpiX3kjgusZ87cmHYBJdeqP59j0IcPZGDftjTnLxtidJcZK3BTLlaPJSLw9mD
	 qsQ1hJzwQJns6Eo53o/RKAV4kg4cWzECmYNw0im3v/4UoE9fcIQVXEQpG54DEezMQO
	 BS8s+OJDOe/i64GzABlbRTebjo62OyggKIZ0lcSY=
Date: Tue, 5 Nov 2024 13:11:22 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.cz>,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: Use struct_size() to improve
 ext4_htree_store_dirent()
Message-ID: <2024110510-hardening-turmoil-8032@gregkh>
References: <20241105103353.11590-2-thorsten.blum@linux.dev>
 <2024110539-frugality-glutton-58f0@gregkh>
 <4F6CE3AC-0C34-46E5-BF67-95845DFC8449@linux.dev>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4F6CE3AC-0C34-46E5-BF67-95845DFC8449@linux.dev>

On Tue, Nov 05, 2024 at 12:06:42PM +0100, Thorsten Blum wrote:
> On 5. Nov 2024, at 11:39, Greg KH wrote:
> > On Tue, Nov 05, 2024 at 11:33:54AM +0100, Thorsten Blum wrote:
> >> Inline and use struct_size() to calculate the number of bytes to
> >> allocate for new_fn and remove the local variable len.
> >> 
> >> Reviewed-by: Jan Kara <jack@suse.cz>
> >> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> >> ---
> >> This change was originally part of another patch that was split into two
> >> separate patches after feedback from Greg KH
> >> - Link: https://lore.kernel.org/r/20241104234214.8094-2-thorsten.blum@linux.dev/
> >> ---
> >> fs/ext4/dir.c | 5 ++---
> >> 1 file changed, 2 insertions(+), 3 deletions(-)
> >> 
> >> diff --git a/fs/ext4/dir.c b/fs/ext4/dir.c
> >> index 233479647f1b..02d47a64e8d1 100644
> >> --- a/fs/ext4/dir.c
> >> +++ b/fs/ext4/dir.c
> >> @@ -471,14 +471,13 @@ int ext4_htree_store_dirent(struct file *dir_file, __u32 hash,
> >> struct rb_node **p, *parent = NULL;
> >> struct fname *fname, *new_fn;
> >> struct dir_private_info *info;
> >> - int len;
> >> 
> >> info = dir_file->private_data;
> >> p = &info->root.rb_node;
> >> 
> >> /* Create and allocate the fname structure */
> >> - len = sizeof(struct fname) + ent_name->len + 1;
> >> - new_fn = kzalloc(len, GFP_KERNEL);
> >> + new_fn = kzalloc(struct_size(new_fn, name, ent_name->len + 1),
> >> + GFP_KERNEL);
> > 
> > Does this actually matter and make the code any more robust or faster?
> > 
> > The original code here is easier to read and understand, why add
> > complexity if it is not required?
> 
> I find struct_size() to be more readable because it explicitly
> communicates the relationship between the flexible array member name and
> ent_name->len that the open-coded version doesn't. Plus, struct_size()
> has some additional compile-time checks (e.g., __must_be_array()).

Ah, missed that, sure, that makes more sense, sorry for the noise.

greg k-h

