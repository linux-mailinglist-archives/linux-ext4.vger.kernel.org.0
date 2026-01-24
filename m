Return-Path: <linux-ext4+bounces-13286-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id dr2SL7h9dGne6AAAu9opvQ
	(envelope-from <linux-ext4+bounces-13286-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Sat, 24 Jan 2026 09:07:20 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 239E87CF30
	for <lists+linux-ext4@lfdr.de>; Sat, 24 Jan 2026 09:07:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9BA0F30097EE
	for <lists+linux-ext4@lfdr.de>; Sat, 24 Jan 2026 08:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA61225403;
	Sat, 24 Jan 2026 08:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cg5noWxm"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC2B84039
	for <linux-ext4@vger.kernel.org>; Sat, 24 Jan 2026 08:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769242036; cv=none; b=B8BIybnG5pKPtjT11ihMJVjsBZCIdHPesSCSFP45WSVTdoZXk7kCNHo8DLio1VG2gMAkzxh4iLvg8Gc0B+HRP4xP/gxEx4TziTMIV0aWhDbEw78qOJbuH+F6F6SqW7jfGKcP+kY4RZs/6204qFwjArsOoE5zRNk8AJ/THwajlAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769242036; c=relaxed/simple;
	bh=eCFcNa/HY19GOkFMltoj4bjlltVQaLp2EvzjmyJCuQo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZaUj7GEx95RDYqhuaUy0YPdmZJ+FZtqmfrsrU2j+KGIEbYONssmON4u0e1Ml3QWFwS8UP8XVPi3yJtNK1e2Q6FsafYQjb7T/rEORNTgaWMA6k5G5o3DVOGt1B3pMTkQVqP8VtMP78sqUD0IiIq+UhU5gRWJmqpK8bgUXQbJXhAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cg5noWxm; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-29f102b013fso27193955ad.2
        for <linux-ext4@vger.kernel.org>; Sat, 24 Jan 2026 00:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769242034; x=1769846834; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bmNq0+UsLIk5q/c1rFFe2Tb3EQ8fjZ0k3OENU3nF5bk=;
        b=cg5noWxmyl/gwOmLB29J+44fe2xGgxpx4kqI9ab8I32SHqGYxhh4jUumSkJak68YPg
         VIhcMvzk+vE0KmJnPElSjpXtVis3zwoyGJT8fFem0lsdJGNE8exsQoeNjClgnRIry1Pb
         C8pkT0Js55bISdHuWKqNVwusvVtU+tH8VSWJKu02Tk77BB3wTyvvwOmKl/WavjKDJ4bW
         tqCkUIQfxi/R4SWtjdfSurD9Y/xUThpjpnI7eAjVPqiXuoA6LIy7cgneB7fvvoNkY1M3
         P/DPMOPd7+0AKHBJDApxzjNCSOANTopxLAQuO0lh3fO9Wlnm9+oEZsc2nkuIn3LGPCql
         xpRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769242034; x=1769846834;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bmNq0+UsLIk5q/c1rFFe2Tb3EQ8fjZ0k3OENU3nF5bk=;
        b=Y7tH9HzMp/fTZFAia6aLgOSq2y2J3MfFJ7kIBEPGud6AHy3kmLSLsG+ry+pQOJDCCo
         pDxFoEwUNIDak5pg7NvPkH/8ejn1pa43GCsZLbsxO1lqpYuc5hi9uH3fFrQXxIC39c8H
         mlnbXF5g84a+z6QGv74zcnCSK9cbN8tBiBZ0M2CVkealOM2ahl9tpLrFCLWEm6qZCEej
         pjy4Fj03ZAAlM8+z1E6f0WZl+VxujvocSzC1CFN19iZyIbcimejxdezSowTnjaXUvHjY
         gSCNAet4zaYPM5KeYkVejqvl92MrCNM4YrqaX8Gx9vUFDgrmKDFg8V33oBWE9Y58rhGo
         UjWQ==
X-Gm-Message-State: AOJu0Yynp6PBT+FD/71ZprcoYbVYfrbg5fctgLKzyrNd/XEz1Xz/jmSa
	U/IrPiALoZUDg2bsZseFRwQzTnmzepezZTcpZrM3pvJrD/G5xDFj8LEpttvxY8ZfqEk=
X-Gm-Gg: AZuq6aJeHifQYucv7UWXTJzM1fxTxeyVAouOyLuJULjNpMWMol2ksIuuYn2k7WqN6Rx
	cDtlIVj8YEmxFJGVaxxqoryR+k4XScEJ3ikZFVl3k5BJoFIh4v2o5NirSu4LDL3xM9juE5TLcAv
	DU5Zo8FaJsZVHE/RTo6F2Yfiev1HXZlcsaMlPrszq+R0jc2wcXFNhrDcEvt8xPyUkphKvZTknOU
	Z8q6kmG8BqCnIKB3GByChgOT3BKVTOr8DunFSSmaYmfB80wUqnYLzffo2FvEX6PtRPc8j/a5UOb
	G/pZmCcufhJ3IUL3eAqjcMNX3FN/j3HEsU9tEt46fy5wynGhq1qmMEAQxr7S02e+ORMLvk2m2ex
	rAWP2K9GF5utRmiT9eMzQ/Rc8CM9DFyvrHSZO4huClaFEIQrsF3KPn+Q2V+Dj6Mq86ZeDU2OLnB
	okHcvTYcA1U1S+qoslRBOCfJg2BzgApEh5NKoItXtUOIEiNbJRuJuoENU3pqATcQ==
X-Received: by 2002:a17:902:c94b:b0:2a7:683c:afb8 with SMTP id d9443c01a7336-2a7fe55ecf5mr61272995ad.16.1769242034386;
        Sat, 24 Jan 2026 00:07:14 -0800 (PST)
Received: from ?IPV6:240e:390:a84:ae11:f96c:3476:2936:720f? ([240e:390:a84:ae11:f96c:3476:2936:720f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a802daa994sm37976755ad.6.2026.01.24.00.07.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jan 2026 00:07:13 -0800 (PST)
Message-ID: <5ebab91a-8510-40be-a77e-da17dca83e45@gmail.com>
Date: Sat, 24 Jan 2026 16:07:10 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ext4: remove tl argument from
 ext4_fc_replay_{add,del}_range
To: Guoqing Jiang <guoqing.jiang@linux.dev>, tytso@mit.edu,
 adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org
References: <20260121063805.19863-1-guoqing.jiang@linux.dev>
Content-Language: en-US
From: Zhang Yi <yizhang089@gmail.com>
In-Reply-To: <20260121063805.19863-1-guoqing.jiang@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-13286-lists,linux-ext4=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yizhang089@gmail.com,linux-ext4@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-ext4];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 239E87CF30
X-Rspamd-Action: no action

On 1/21/2026 2:38 PM, Guoqing Jiang wrote:
> Since commit a7ba36bc94f2 ("ext4: fix fast commit alignment issues"),
> both ext4_fc_replay_add_range and ext4_fc_replay_del_range get
> ex based on 'val' instead of 'tl'.
> 
> Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>

Thank you for the cleanup, it looks good to me.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

> ---
>   fs/ext4/fast_commit.c | 10 ++++------
>   1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> index fa66b08de999..8474ae52f8dd 100644
> --- a/fs/ext4/fast_commit.c
> +++ b/fs/ext4/fast_commit.c
> @@ -1751,8 +1751,7 @@ int ext4_fc_record_regions(struct super_block *sb, int ino,
>   }
>   
>   /* Replay add range tag */
> -static int ext4_fc_replay_add_range(struct super_block *sb,
> -				    struct ext4_fc_tl_mem *tl, u8 *val)
> +static int ext4_fc_replay_add_range(struct super_block *sb, u8 *val)
>   {
>   	struct ext4_fc_add_range fc_add_ex;
>   	struct ext4_extent newex, *ex;
> @@ -1872,8 +1871,7 @@ static int ext4_fc_replay_add_range(struct super_block *sb,
>   
>   /* Replay DEL_RANGE tag */
>   static int
> -ext4_fc_replay_del_range(struct super_block *sb,
> -			 struct ext4_fc_tl_mem *tl, u8 *val)
> +ext4_fc_replay_del_range(struct super_block *sb, u8 *val)
>   {
>   	struct inode *inode;
>   	struct ext4_fc_del_range lrange;
> @@ -2243,13 +2241,13 @@ static int ext4_fc_replay(journal_t *journal, struct buffer_head *bh,
>   			ret = ext4_fc_replay_unlink(sb, &tl, val);
>   			break;
>   		case EXT4_FC_TAG_ADD_RANGE:
> -			ret = ext4_fc_replay_add_range(sb, &tl, val);
> +			ret = ext4_fc_replay_add_range(sb, val);
>   			break;
>   		case EXT4_FC_TAG_CREAT:
>   			ret = ext4_fc_replay_create(sb, &tl, val);
>   			break;
>   		case EXT4_FC_TAG_DEL_RANGE:
> -			ret = ext4_fc_replay_del_range(sb, &tl, val);
> +			ret = ext4_fc_replay_del_range(sb, val);
>   			break;
>   		case EXT4_FC_TAG_INODE:
>   			ret = ext4_fc_replay_inode(sb, &tl, val);


