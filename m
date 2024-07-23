Return-Path: <linux-ext4+bounces-3368-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B2F939CE8
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Jul 2024 10:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8436C1C21CA5
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Jul 2024 08:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3259514D2B8;
	Tue, 23 Jul 2024 08:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LlpWyiuY"
X-Original-To: linux-ext4@vger.kernel.org
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1655614C5AA
	for <linux-ext4@vger.kernel.org>; Tue, 23 Jul 2024 08:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721724269; cv=none; b=IOhBOF85Bo63mIVlRaCxGbeYd3mRCLhOO3I/5ee+l1g3mLB6Je8+VaiPDD7TQDR3Zz9WrYLE3Iy3kv+58eSt1Hm/dl8jZk8MJd3QRW0wIIvW++s4lIv6dRy9xCkrvdwgxEPHWTGxNAyx/wMmp/lw1R/KYZU84wEBaBUKTGk54RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721724269; c=relaxed/simple;
	bh=2ZjbRPeeXbrIm0xAnumdD1ly1zV8UN2KljaltnZiPCE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W+xCn1W/8SXOKtQvo+a3siljA7gyq9wDSl5d7EkS8hDjZrMguLibssyYDzwodlSMfIbB17cVFxSd1dZRsXdU9m13DEEKGoiDO9dHD6+Tq5pPSrkTPb1KJ9wR6A51saJ1e7KgAKC53csyIOnqBU3vyR/SF/a+JJfhNSzDklDlRKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LlpWyiuY; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: hch@infradead.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721724265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NK2EcdiJh2UsKYq9ETH81uD0C/sipi+a4DjtdiFTXK4=;
	b=LlpWyiuY+PZBgxwLd/IpEVDwLE222BpKHgr1RpB7VbGs6XxatJY6uaj7S1+p1f3sA/rhGF
	LBIt7voECdMcUrmmkXTUog+VjPBiXMj9DKY1ALk9NO54Y7OmFs1PVT72nKDJToeJaRnU9n
	woVBW/ixI37h287XNnk+URuOhlDOLe8=
X-Envelope-To: viro@zeniv.linux.org.uk
X-Envelope-To: brauner@kernel.org
X-Envelope-To: jack@suse.cz
X-Envelope-To: clm@fb.com
X-Envelope-To: josef@toxicpanda.com
X-Envelope-To: dsterba@suse.com
X-Envelope-To: tytso@mit.edu
X-Envelope-To: adilger.kernel@dilger.ca
X-Envelope-To: jaegeuk@kernel.org
X-Envelope-To: chao@kernel.org
X-Envelope-To: linux-fsdevel@vger.kernel.org
X-Envelope-To: linux-btrfs@vger.kernel.org
X-Envelope-To: linux-ext4@vger.kernel.org
X-Envelope-To: linux-f2fs-devel@lists.sourceforge.net
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: mcgrof@kernel.org
X-Envelope-To: linux-modules@vger.kernel.org
Message-ID: <b58e6f36-9a13-488a-85d2-913dd758f89b@linux.dev>
Date: Tue, 23 Jul 2024 16:44:14 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 0/3] Add {init, exit}_sequence_fs() helper function
To: Christoph Hellwig <hch@infradead.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, tytso@mit.edu,
 Andreas Dilger <adilger.kernel@dilger.ca>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 Luis Chamberlain <mcgrof@kernel.org>, linux-modules@vger.kernel.org
References: <20240711074859.366088-1-youling.tang@linux.dev>
 <Zo-XMrK6luarjfqZ@infradead.org>
Content-Language: en-US, en-AU
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Youling Tang <youling.tang@linux.dev>
In-Reply-To: <Zo-XMrK6luarjfqZ@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi, Christoph

On 11/07/2024 16:26, Christoph Hellwig wrote:
> Can we please stop this boilerplate code an instead our __init/__exit
> sections to supper multiple entires per module.  This should be mostly
> trivial, except that we'd probably want a single macro that has the
> init and exit calls so that the order in the section is the same and
> the unroll on failure can walk back form the given offset. e.g.
> something like:
>
> module_subinit(foo_bar_init, foo_bar_exit);
> module_subinit(foo_bar2_init, foo_bar2_exit);
>
>
Thanks for your suggestion,  I re-implemented it using section mode,
and the new patch set [1] has been sent.

[1]: 
https://lore.kernel.org/all/20240723083239.41533-1-youling.tang@linux.dev/T/#md81aaefe0c1fef70a0592d1580cbbb10ec9989b0

Thanks,
Youling.

