Return-Path: <linux-ext4+bounces-11719-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57ED5C46672
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Nov 2025 12:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B272188F11D
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Nov 2025 11:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC6130AACE;
	Mon, 10 Nov 2025 11:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Lcd3QpnY"
X-Original-To: linux-ext4@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1730B24BC07;
	Mon, 10 Nov 2025 11:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762775751; cv=none; b=MWPo5ksA2zoEt99RQ6Yh0+EeWMVmP+Dx80j0V+pBQmbzVlNOs3gXJVZOBkVOQ0fuvkkX9zA0Ioo5BPGmXKTZun3QR+MQHT3oZcoTvXpLyEtmcZ28U0+9dGgUPL23Q8JNVdbVxO0ka5xTR8I5P8kA9XJM6KrGHwk1iwLTsYoaTV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762775751; c=relaxed/simple;
	bh=BG/R3SxEAtIIo0LWOHrCfcSUHdJTZWPLY5lx1lGieTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dx3B5TZFKA5TT2QLXJ4Z5gFl74BXrnWtK69jPPCGvBXTMgl4V/lM68tMIXvsoSdR44KzI8PA9xfXJCBjaMTqoS/XXCAISxzD58DytFvTIav7sy3zT4FqRg3IpGEEBQANnaTfL7DTc923P7Biv+VqWuJiynllotPsWJsPpWEoZ6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Lcd3QpnY; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=zq/UYqU7b99yJOfWIAe6XEkp8akZneMuARWWpOHmJ8s=; b=Lcd3QpnYwO6bBhf01O3jwhiMdb
	FqaGkD6CqogBGXEZbIYOJrIYqD4gz8nnJTUG62KIgur4FnnnjowkKIPhAwtDcfZ/Ceok2EsAq0rF3
	YWLEDq5CNPeKs4eLM6whVs0KmVM534XOLBAivtUIfVABZ4Z86ixHLovuIV2VG/e4khsncCyKGTOU+
	ezT9orBGOv5J2Ibow62qrzFa96fWT3S11gf2fxJ9hgQr69XJLIA8xtvqcX+xpF+N2zCN0AXSEMm0l
	Tql1LGOwAK6Hhzr1wMnoOCE8HGw0dDJ4h1g1RJR1j2NNrCPJR5XQ24lvllIGxKiR/NVjNfWmqqO9j
	JFTjPliw==;
Received: from 179-125-86-112-dinamico.pombonet.net.br ([179.125.86.112] helo=quatroqueijos.cascardo.eti.br)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vIQUe-004aQX-9A; Mon, 10 Nov 2025 12:55:32 +0100
Date: Mon, 10 Nov 2025 08:55:26 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: Raphael Pinsonneault-Thibeault <rpthibeault@gmail.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org,
	syzbot+3ee481e21fd75e14c397@syzkaller.appspotmail.com
Subject: Re: [PATCH] ext4: validate xattrs to avoid OOB in
 ext4_find_inline_entry
Message-ID: <aRHSrpFone-SSkZa@quatroqueijos.cascardo.eti.br>
References: <20251108202545.1524330-2-rpthibeault@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251108202545.1524330-2-rpthibeault@gmail.com>

On Sat, Nov 08, 2025 at 03:25:46PM -0500, Raphael Pinsonneault-Thibeault wrote:
> When looking for an entry in an inlined directory, if e_value_offs is
> changed underneath the filesystem by some change in the block device, it
> will lead to an out-of-bounds access that KASAN detects as a
> use-after-free.
> 
> This is a similar problem as fixed by
> commit c6b72f5d82b1 ("ext4: avoid OOB when system.data xattr changes underneath the filesystem")
> whose fix was to call ext4_xattr_ibody_find() right after reading the
> inode with ext4_get_inode_loc() to check the validity of the xattrs.
> 
> However, ext4_xattr_ibody_find() only checks xattr names, via
> xattr_find_entry(), not e_value_offs.
> 
> Fix by calling xattr_check_inode() which performs a full check on the
> xattrs in inode.
> 
> Reported-by: syzbot+3ee481e21fd75e14c397@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3ee481e21fd75e14c397
> Tested-by: syzbot+3ee481e21fd75e14c397@syzkaller.appspotmail.com
> Fixes: c6b72f5d82b10 ("ext4: avoid OOB when system.data xattr changes underneath the filesystem")
> Signed-off-by: Raphael Pinsonneault-Thibeault <rpthibeault@gmail.com>
> ---
>  fs/ext4/inline.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
> index 1b094a4f3866..7d46e1e16b52 100644
> --- a/fs/ext4/inline.c
> +++ b/fs/ext4/inline.c
> @@ -1593,6 +1593,13 @@ struct buffer_head *ext4_find_inline_entry(struct inode *dir,
>  
>  	down_read(&EXT4_I(dir)->xattr_sem);
>  
> +	if (EXT4_INODE_HAS_XATTR_SPACE(dir)) {
> +		ret = xattr_check_inode(dir, IHDR(dir, ext4_raw_inode(&is.iloc)),
> +					ITAIL(dir, ext4_raw_inode(&is.iloc)));
> +		if (ret)
> +			goto out;
> +	}
> +

ext4_xattr_ibody_find used to call xattr_check_inode until commit
5701875f9609 ("ext4: fix out-of-bound read in ext4_xattr_inode_dec_ref_all()").

So every other place where ext4_xattr_ibody_find was protecting against such
block device changes is not working since.

At least, the Fixes: line should change to point out to that commit, but I
wonder if the inode checking should be put back there. I haven't investigated if
that would regress the bug it fixes, though.

Cascardo.

>  	ret = ext4_xattr_ibody_find(dir, &i, &is);
>  	if (ret)
>  		goto out;
> -- 
> 2.43.0
> 

