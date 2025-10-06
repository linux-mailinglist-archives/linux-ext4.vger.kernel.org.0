Return-Path: <linux-ext4+bounces-10643-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD69BBED0A
	for <lists+linux-ext4@lfdr.de>; Mon, 06 Oct 2025 19:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CF32189B215
	for <lists+linux-ext4@lfdr.de>; Mon,  6 Oct 2025 17:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB7024293C;
	Mon,  6 Oct 2025 17:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="Trp1zJnl"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB99C23DEB6
	for <linux-ext4@vger.kernel.org>; Mon,  6 Oct 2025 17:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759771737; cv=none; b=SDkTDYaJPjShJoAUgf3TVuvYtdTDlLRqUPLXVwIk6v7a9Ye9gHvZRQk2kgvEwcIHNti6e0qpekPPgfx4TpCu35YhhoQkrGyB9XUaCKm1Pg7vjZZLujW+kbtfp82umLYa2+vniF85L7yJtiZDoDtmTdRsLf2UgztY2LGPUvZbjgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759771737; c=relaxed/simple;
	bh=TvWa4PLbN07RULjmFz4mXbcO0qs5u5an45Klxr52xCk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AbbbUAoikt2THbHbPxj6c2bKkr6AfHypQtxv25uM86EBNdk1XIUPxK0T/D6hhVYYecIWjfmYhbwGtQR5C9Pw6YJncaFvOryQQ/PHsHxINWs3s7tMcVa9cTzfRHtRZRur5y7D2Uo2OCY2upOtCTqr21inK5QwAqps+mGoNQwwTjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=Trp1zJnl; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 596Fb45P690004;
	Mon, 6 Oct 2025 10:28:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=xuscCzlwDc6t4uY8r1d2zUecOAGKYHnVtb6dHUbspww=; b=Trp1zJnlbghQ
	hrtJR1pHzxySkP6EvcbQznTiZkwcLQ+d0GbOAgCq4UMQIcIbQfan28alDpYIl8/T
	8yeIkHqFekpzwTat0ZtzHyH7VVj0wWoEGstbx00YzBI7LUeIuH6XuUtwQPF0HlcF
	AgEgst1n7PIclCdXSZ874ezjSf3VMESP7EqoyWJ3E5eGMA99aNXKuT5dokZlezGm
	HhUUHjcwAcHbcmN6Efw6DKnpb0EIP6FS24584hGOQotQuCZfJHCrcqfefLDr2bOo
	fIhnR9KKdUQebJldDTfd/mReA6CYxlCPczndm1H9CJWCBSoNo20G/6I9F5ARKHDI
	xnzjwARuug==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 49m8vrmbdx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 06 Oct 2025 10:28:50 -0700 (PDT)
Received: from devbig091.ldc1.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Mon, 6 Oct 2025 17:28:49 +0000
From: Chris Mason <clm@meta.com>
To: Jan Kara <jack@suse.cz>
CC: Chris Mason <clm@meta.com>, Ted Tso <tytso@mit.edu>,
        <linux-ext4@vger.kernel.org>,
        <syzbot+0b92850d68d9b12934f5@syzkaller.appspotmail.com>
Subject: Re: [PATCH] ext4: verify orphan file size is not too big
Date: Mon, 6 Oct 2025 10:28:10 -0700
Message-ID: <20251006172822.2762117-1-clm@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250909112206.10459-2-jack@suse.cz>
References:
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA2MDEzNyBTYWx0ZWRfX42bzez6FIIkj
 3acRKoPib57CJEeyvqadumxC3JGB20+zJrpOTKDS/Wth8eEc9uUVsZ0cKyocS22f3DjENjWUjzj
 yoxpQaEB14UxAChEVUhbBNuBwcHxEBCL+6lavj6ldu+kqLihAro6P52knZsKeg4LEtGQzCsmCgF
 cYUnjAONdwe0mQ7Kf2UB8156ZMhedxzWfIbyFOprViU5aXXhNBq80f3ZcWkHFM0EOq8UfhNoYLt
 iG7NlymqEKqxfFgIsQsu3loFWTvBc3OeTdtIe9oIsxomfcHOkBkNp1gp1jkMeX2iR1RefGrG+IV
 2RI41HNDw9U5lA2mZKLb9v0m876QLfKbdUpR2pwYVlteRZaFsxhPEhMFTBAY7jYvgU9VmM03WSa
 URwd1GUUL4L3hxfmIwUFu1A9lpzqmg==
X-Proofpoint-ORIG-GUID: OqkEeDmEJcI8QSPKspJDaj_dS5ajiTkx
X-Authority-Analysis: v=2.4 cv=WfIBqkhX c=1 sm=1 tr=0 ts=68e3fc52 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=x6icFKpwvdMA:10 a=hSkVLCK3AAAA:8 a=SR8aEjiUmgjChHfCOlQA:9
 a=cQPPKAXgyycSBL8etih5:22
X-Proofpoint-GUID: OqkEeDmEJcI8QSPKspJDaj_dS5ajiTkx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_05,2025-10-06_01,2025-03-28_01

On Tue,  9 Sep 2025 13:22:07 +0200 Jan Kara <jack@suse.cz> wrote:

> In principle orphan file can be arbitrarily large. However orphan replay
> needs to traverse it all and we also pin all its buffers in memory. Thus
> filesystems with absurdly large orphan files can lead to big amounts of
> memory consumed. Limit orphan file size to a sane value and also use
> kvmalloc() for allocating array of block descriptor structures to avoid
> large order allocations for sane but large orphan files.
> 
> Reported-by: syzbot+0b92850d68d9b12934f5@syzkaller.appspotmail.com
> Fixes: 02f310fcf47f ("ext4: Speedup ext4 orphan inode handling")
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/ext4/orphan.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/orphan.c b/fs/ext4/orphan.c
> index 524d4658fa40..7e4f48c15c2e 100644
> --- a/fs/ext4/orphan.c
> +++ b/fs/ext4/orphan.c
> @@ -587,9 +587,20 @@ int ext4_init_orphan_info(struct super_block *sb)
>  		ext4_msg(sb, KERN_ERR, "get orphan inode failed");
>  		return PTR_ERR(inode);
>  	}
> +	/*
> +	 * This is just an artificial limit to prevent corrupted fs from
> +	 * consuming absurd amounts of memory when pinning blocks of orphan
> +	 * file in memory.
> +	 */
> +	if (inode->i_size > 8 << 20) {
> +		ext4_msg(sb, KERN_ERR, "orphan file too big: %llu",
> +			 (unsigned long long)inode->i_size);
> +		ret = -EFSCORRUPTED;
> +		goto out_put;
> +	}
>  	oi->of_blocks = inode->i_size >> sb->s_blocksize_bits;
>  	oi->of_csum_seed = EXT4_I(inode)->i_csum_seed;
> -	oi->of_binfo = kmalloc_array(oi->of_blocks,
> +	oi->of_binfo = kvmalloc_array(oi->of_blocks,
>  				     sizeof(struct ext4_orphan_block),
>  				     GFP_KERNEL);
>  	if (!oi->of_binfo) {

Hi everyone,

I tripped over this while testing some review automation on linux-next.

Should we swap all the kfree(oi->of_binfo) to kvfree?

-chris


