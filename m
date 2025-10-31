Return-Path: <linux-ext4+bounces-11391-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A37C25E3A
	for <lists+linux-ext4@lfdr.de>; Fri, 31 Oct 2025 16:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 070A71A61AF1
	for <lists+linux-ext4@lfdr.de>; Fri, 31 Oct 2025 15:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A7F52E1C64;
	Fri, 31 Oct 2025 15:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="hMoOV3ZA"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C7E2DEA67;
	Fri, 31 Oct 2025 15:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761925493; cv=none; b=mviS3QifCya3YaGCNfq2dGDk2a9Ve7ca4lW41j2nhBq7DBNscDJ0gg7KJv0yDwCFO6mtAi7ZGKIQbuS57vXtLAHZAK118/qCOSUD0y1FGYn8tMhn9B1dlk7mzc8lf530vUTnDMy59hrvTfVxkFo4dOuBJOZ7soYhXq1eJjrq2Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761925493; c=relaxed/simple;
	bh=FDAijRtwdddL9oMCD05Q/U/iAXw08SRA+D3AEigmkA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZUkroUFJcibep0EKOR89b9FCcnKiyvGp6j88Pw21pM6jjG4ZdVh24HOnWpqsD3umoVCTcmQyot7JqqDptKAJTtk2UZW46bVgJ7f2IcWvXI9nuX6zCj43UP5dBvYfxhP/HhEQX30w+G2+2VwhOSE94pR6VDIMtO/jsBRwtSFKI/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=hMoOV3ZA; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost (unknown [10.10.165.9])
	by mail.ispras.ru (Postfix) with UTF8SMTPSA id 885C440762F2;
	Fri, 31 Oct 2025 15:44:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 885C440762F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1761925480;
	bh=0rAqqn2nJpzdHfAXSYxAawGoJkugYQCtBMPX+iP82ok=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hMoOV3ZAJATODreGpAqJKjyYrvpURmiQajbwGQOhumkRjYAWpo/nVlWc6kqdvVBzL
	 ff4dHYhiiVFteWCzs3/8rxxayuXdVFg0s1rZeSLC5Yh4T+PLsrO33x+KV7xdfyen9U
	 NKelAmzj/Svw28aS5dSdY5b8VqHCCAKT6UdibBeg=
Date: Fri, 31 Oct 2025 18:44:40 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Jan Kara <jack@suse.cz>
Cc: Theodore Ts'o <tytso@mit.edu>, 
	Andreas Dilger <adilger.kernel@dilger.ca>, "Darrick J. Wong" <djwong@kernel.org>, 
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>, 
	lvc-project@linuxtesting.org
Subject: Re: [PATCH 1/2] ext4: fix up copying of mount_opts in superblock
 tuning ioctls
Message-ID: <20251031182448-c6e06b81d18b41af5704f2ba-pchelkin@ispras>
References: <20251028130949.599847-1-pchelkin@ispras.ru>
 <yq6rbx54jt4btntsh37urd6u63wwcd3lyhovbrm6w7occaveea@riljfkx5jmhi>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <yq6rbx54jt4btntsh37urd6u63wwcd3lyhovbrm6w7occaveea@riljfkx5jmhi>

On Thu, 30. Oct 12:32, Jan Kara wrote:
> On Tue 28-10-25 16:09:47, Fedor Pchelkin wrote:
> > Judging by commit 8ecb790ea8c3 ("ext4: avoid potential buffer over-read in
> > parse_apply_sb_mount_options()"), the contents of s_mount_opts should be
> > treated as __nonstring, i.e. there might be no NUL-terminator in the
> > provided buffer.
> > 
> > Then the same holds for the corresponding mount_opts field of the struct
> > ext4_tune_sb_params exchanged with userspace via a recently implemented
> > superblock tuning ioctl.
> > 
> > The problem is that strscpy_pad() can't work properly with non-NUL-term
> > strings.  String fortifying infrastructure would complain if that happens.
> > Commit 0efc5990bca5 ("string.h: Introduce memtostr() and memtostr_pad()")
> > gives additional information in that regard.
> > 
> > Both buffers are just raw arrays of the similar fixed size, essentially
> > they should represent the same contents.  As they don't necessarily have
> > NUL-terminators, in both directions use plain memcpy() to copy their
> > contents.
> > 
> > Found by Linux Verification Center (linuxtesting.org).
> > 
> > Fixes: 04a91570ac67 ("ext4: implemet new ioctls to set and get superblock parameters")
> > Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
> 
> I agree there are some holes in the logic of 8ecb790ea8c3 ("ext4: avoid
> potential buffer over-read in parse_apply_sb_mount_options()") and
> consequently 04a91570ac67 may need fixing up as well. But I think the fixes
> should look differently. The clear intended use of s_mount_opts field is
> that it is at most 63 characters long with the last byte guaranteed to be
> 0. This is how userspace utilities use it and they complain if you try
> setting more than 63 characters long string. So I think strscpy_pad() use
> in ext4_ioctl_get_tune_sb() is actually fine (sizes of both buffers match).
> In ext4_sb_setparams() we should actually make sure userspace buffer is
> properly Nul-terminated and return error otherwise. And the buffer in
> parse_apply_sb_mount_options() should actually be only 64 bytes long to
> match the size of the source buffer at which point using strscpy_pad()
> becomes correct. How does that sound?
> 
> 								Honza

Thanks, Jan!  Sounds reasonable.  I was a bit confused by the __nonstring
declaration of s_mount_opts at e2fsprogs [1] but rechecked - tune2fs side
has always validated it to have at most 63 characters with the last one
being NUL in the corner case, just as you say.

ext4 kernel docs also specify it to be ASCIIZ string [2].

I'll rework the series.

[1]: https://github.com/tytso/e2fsprogs/blob/13dfdf2410648c361dfd49b28d7dbeac8a580532/lib/ext2fs/ext2_fs.h#L756
[2]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/filesystems/ext4/super.rst?id=58fdd8484c05a19942690008304228ad784771e9#n407

