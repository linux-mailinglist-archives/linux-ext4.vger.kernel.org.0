Return-Path: <linux-ext4+bounces-6063-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E1FA0BD9D
	for <lists+linux-ext4@lfdr.de>; Mon, 13 Jan 2025 17:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 610BB7A11BE
	for <lists+linux-ext4@lfdr.de>; Mon, 13 Jan 2025 16:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7680B14D6EB;
	Mon, 13 Jan 2025 16:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="hP01Wf0Q"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451D614A4D1
	for <linux-ext4@vger.kernel.org>; Mon, 13 Jan 2025 16:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736786037; cv=none; b=Kqlwn9j27lB+POYjHh6hhoHqzTCizClqZSAxlW/lHOiOMWYpu1HQFl7yx74AEEsKGyNYWvZZnIbWHMRhzm5J2a5Lvyn1/sfLsZlP9QwkJA2OVTRioNVcMI15/MO/tGI7TX3Jyi1N5+WsSHP0dGJkPW31eCOsCsD1MwnD3QjZf6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736786037; c=relaxed/simple;
	bh=fyfq+Uk+JhG9qNOlSTq8aLDXQT50J66awaFP2qmC3gE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SAb2YkJvagF+aqDOykWFvrGorpnqabcmmk8fAolqrX65FwTPFlVZ1Tkx6xVDih9DW2w2TEFAQGXLGVu4jZXEo2psjbNmJo8qAX5vjkgo61K9c8wmpQyskBEzaaKLdsFla+VgvIbIsOWGJUD88ABtkiUbiOUD5K9K817q6iF5ePs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=hP01Wf0Q; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-82-229.bstnma.fios.verizon.net [173.48.82.229])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 50DGXjHw030862
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2025 11:33:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1736786027; bh=GU65J1WFOJvw+8cxzb+Rq4/WgkmvYJ7WXDoAmgXXQis=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=hP01Wf0Q2mVSvZsPNsWNb1+waDrFngDEhSwQ39ZhG0YrtniFXCMZy2GCOfX2TVKHD
	 ZYtVedYuY6JRNjc9KVH3cEvE1u6was7zOfXzDtcK6ftx2YdojLVJ4GDFPQTj9iK3sR
	 XyskXB8v4Jce/3M/wENXz4ZB0mMqjgK3uU6xVC+nNWa4UtrVFm/sTIzbnTOyWW089T
	 uuFpc9GnMNZnW++Ylk0POCg71iRodinw/12ZFPOt1b/yFy7zNwSUdkanQaQdzq0IJZ
	 FOy/wbStajNOJ6sAKF2D1xB5ECkanlHzY8tDjWWhJGDainBDvyTJ0U9CWPxSDjBBp6
	 1dOuppZSHlpGQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id C10B215C0135; Mon, 13 Jan 2025 11:33:45 -0500 (EST)
Date: Mon, 13 Jan 2025 11:33:45 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Catalin Patulea <cronos586@gmail.com>
Cc: linux-ext4@vger.kernel.org, Kazuya Mio <k-mio@sx.jp.nec.com>
Subject: Re: e2fsck max blocks for huge non-extent file
Message-ID: <20250113163345.GO1284777@mit.edu>
References: <CAE2LqHL6uY=Sq2+aVtW-Lkbu9mvjFkaNqLaDA8Bkpmvx9AjHBg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE2LqHL6uY=Sq2+aVtW-Lkbu9mvjFkaNqLaDA8Bkpmvx9AjHBg@mail.gmail.com>

On Mon, Jan 13, 2025 at 12:49:19AM -0500, Catalin Patulea wrote:
> 
> I have an ext3 filesystem on which I manually enabled huge_file
> (files >2 TB) using tune2fs; then created a 3 TB file (backup image
> of another disk).  Now, I am running e2fsck and it reports errors:

Hmm, it looks like this has been broken for a while.  I've done a
quick look, and it appears this has been the case since e2fsprogs
1.28 and this commit:

commit da307041e75bdf3b24c1eb43132a4f9d8a1b3844
Author: Theodore Ts'o <tytso@mit.edu>
Date:   Tue May 21 21:19:14 2002 -0400

    Check for inodes which are too big (either too many blocks, or
    would cause i_size to be too big), and offer to truncate the inode.
    Remove old bogus i_size checks.
    
    Add test case which tests e2fsck's handling of large sparse files.
    Older e2fsck with the old(er) bogus i_size checks didn't handle
    this correctly.

I think no one noticed since trying to support files this large on a
non-extent file is so inefficient and painful that in practice anyone
trying to use files this large would be using ext4, and not a really
ancient ext3 file system.

The fix might be as simple as this, but I haven't had a chance to test
it and do appropriate regression tests....

diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index eb73922d3..e460a75f4 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -3842,7 +3842,7 @@ static int process_block(ext2_filsys fs,
 		problem = PR_1_TOOBIG_DIR;
 	if (p->is_dir && p->num_blocks + 1 >= p->max_blocks)
 		problem = PR_1_TOOBIG_DIR;
-	if (p->is_reg && p->num_blocks + 1 >= p->max_blocks)
+	if (p->is_reg && p->num_blocks + 1 >= 1U << 31)
 		problem = PR_1_TOOBIG_REG;
 	if (!p->is_dir && !p->is_reg && blockcnt > 0)
 		problem = PR_1_TOOBIG_SYMLINK;


						- Ted

