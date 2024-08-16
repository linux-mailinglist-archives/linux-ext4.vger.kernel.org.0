Return-Path: <linux-ext4+bounces-3748-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0903C95503D
	for <lists+linux-ext4@lfdr.de>; Fri, 16 Aug 2024 19:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 850E6287C52
	for <lists+linux-ext4@lfdr.de>; Fri, 16 Aug 2024 17:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0E31C2326;
	Fri, 16 Aug 2024 17:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KRs/HU5o"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4274A1AC8BE;
	Fri, 16 Aug 2024 17:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723830621; cv=none; b=dSHHm2ZGjMy3HEkWLzXZ9PEXgelA47cXQFzs1XRjmuQyMR1NuNPHz4h8kpHg37fCuoP+alb4RQBwfehhHmdmtl6SAKilosWB+2sVtdtwctt6EVyChIxeLjPNSkSKGklM9DFDMJGlGxfm+SwDWVeOpL4srXZJRLyU3Sg7a4hajHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723830621; c=relaxed/simple;
	bh=J1Moqe2nlHI9TVePHDlu7fQ+ogA7Doq2U/Yp9dAGfrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hi53awdKEXunMOat9RWENKmIWLf3bwsQKaJCtqszdZTlEbxr3JZk0t8GGCyyk6UFbdFnFMW8Nhah1YExEAI4L3UsMJXbSJ9IkLgeXaRBhFERzwXqprcXS3Oc5OgiCjcIpOnHWh2mOLxo1L8I3jSAYuowsYy2t9bJzxp9WCEM5Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KRs/HU5o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC8AAC32782;
	Fri, 16 Aug 2024 17:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723830620;
	bh=J1Moqe2nlHI9TVePHDlu7fQ+ogA7Doq2U/Yp9dAGfrM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KRs/HU5oUl8bki3EuVqfriIhINBrOj4p8l6ZuJQ26vpMOudsQjWaSoJRYW0g33khH
	 It1fE8R7mtm1nsvEXIPYp6f5A48OCgsJI4AmLOaxqcgV9wBnZbL4toJfS74w7oXkly
	 9oPQ8eUu+R8g6MYex2MdzeSO7XLU2+VCPn+rzXCnja+HWisMbyy8gcmD6pFKOAA/YN
	 ikJmcLDx+WRlX2Ef2gUk+C1J3AYzNVO0ekEZJwcLMApZNK5cjXj0gYHOTP33V96Da7
	 8nfeRRPwvCmOhoRztMIqiCTGYmKq1KkUn2wLC3Mmq9U4chRm6hV1TFF1+5q05vMWuY
	 CcFRTGyiMKx9A==
Date: Fri, 16 Aug 2024 10:50:20 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: alexjlzheng@gmail.com
Cc: yangerkun@huaweicloud.com, adilger.kernel@dilger.ca,
	alexjlzheng@tencent.com, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org, tytso@mit.edu
Subject: Re: [PATCH] ext4: disambiguate the return value of
 ext4_dio_write_end_io()
Message-ID: <20240816175020.GB6039@frogsfrogsfrogs>
References: <9de82d23-902f-cb18-7688-f5e687e86d14@huaweicloud.com>
 <20240816165731.1007238-1-alexjlzheng@tencent.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240816165731.1007238-1-alexjlzheng@tencent.com>

On Sat, Aug 17, 2024 at 12:57:27AM +0800, alexjlzheng@gmail.com wrote:
> On Fri, 16 Aug 2024 20:21:22 +0800, yangerkun@huaweicloud.com wrote:
> > 在 2024/8/15 19:27, alexjlzheng@gmail.com 写道:
> > > From: Jinliang Zheng <alexjlzheng@tencent.com>
> > > 
> > > The commit 91562895f803 ("ext4: properly sync file size update after O_SYNC
> > > direct IO") causes confusion about the meaning of the return value of
> > > ext4_dio_write_end_io().
> > > 
> > > Specifically, when the ext4_handle_inode_extension() operation succeeds,
> > > ext4_dio_write_end_io() directly returns count instead of 0.
> > > 
> > > This does not cause a bug in the current kernel, but the semantics of the
> > > return value of the ext4_dio_write_end_io() function are wrong, which is
> > > likely to introduce bugs in the future code evolution.
> > > 
> > > Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
> > > ---
> > >   fs/ext4/file.c | 5 +++--
> > >   1 file changed, 3 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> > > index c89e434db6b7..6df5a92cec2b 100644
> > > --- a/fs/ext4/file.c
> > > +++ b/fs/ext4/file.c
> > > @@ -392,8 +392,9 @@ static int ext4_dio_write_end_io(struct kiocb *iocb, ssize_t size,
> > >   	 */
> > >   	if (pos + size <= READ_ONCE(EXT4_I(inode)->i_disksize) &&
> > >   	    pos + size <= i_size_read(inode))
> > > -		return size;
> > > -	return ext4_handle_inode_extension(inode, pos, size);
> > > +		return 0;
> > > +	error = ext4_handle_inode_extension(inode, pos, size);
> > > +	return error < 0 ? error : 0;
> > 
> > Why?
> 
> Before commit 91562895f803 ("ext4: properly sync file size update after O_SYNC
> direct IO"), all filesystems' iomap_dio_ops.end_io() return 0 on success and
> negative value on failure.
> 
> Moreover, this confusion of return value semantics caused data corruption when
> this above patch was merged to the stable branch. See
> https://lwn.net/Articles/954285/ for details.
> 
> > 
> > iomap_dio_complete can use the return value directly without any bug. 
> > And I think the code now seems more clearly...
> > 
> 
> In my opinion, clean code should be clearly defined code, especially the
> interface functions connecting various modules. So, what is the return value
> definition of iomap_dio_ops.end_io()? What is the return value definition of
> ext4_dio_write_end_io()?

iomap_dio_ops.end_io() implemenations should return one of:

- negative errno
- 0 if @size bytes were written

I'm not sure why ext4_dio_write_end_io returns size explicitly or why
ext4_handle_inode_extension returns count.  Neither function need to do
that.

--D

> Thanks,
> Jinliang Zheng
> 
> > >   }
> > >   
> > >   static const struct iomap_dio_ops ext4_dio_write_ops = {
> 

