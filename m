Return-Path: <linux-ext4+bounces-8194-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3E2AC2D5B
	for <lists+linux-ext4@lfdr.de>; Sat, 24 May 2025 06:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 918931C008E9
	for <lists+linux-ext4@lfdr.de>; Sat, 24 May 2025 04:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1740B1B0439;
	Sat, 24 May 2025 04:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MBpaq94D"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566DB19ABAC;
	Sat, 24 May 2025 04:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748061821; cv=none; b=bLWwPkvxaDBJDMGLIqob7eI1ag6My7xXq5uBnvBuYt2GFm1sWTbrGcK1j/hyVto+wUcAgia5mi/eayewFalny6ccMu3fz9I4p9fue/uEyLBzSqU2b7J9iqvb443bwTNE+mM01P7B2PbT4BP/oI/awUW+fTcSzACsnyeVXoIQ2mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748061821; c=relaxed/simple;
	bh=wM12UXAAnAU45ftr2MIfRKHPhf4eIiCkNInZ/ekmLlQ=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-version:Content-type; b=vA8KrPytb5wqmAdHgUzlLchOdhxrNmIf6xxG30HVQAznZUtPe0Np8WnvFh1o2lt8J9DLLUnyXnOZr2ZxaLyQbZJnBK/Ny2sZ9rFLBJhLWMutJ02nwt6LHukdUn7CZY48+aMBofXedu3u/CaOYy9ZucjyetJjM0H/awP9SqQCZuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MBpaq94D; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-30ec226b7d6so485048a91.2;
        Fri, 23 May 2025 21:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748061819; x=1748666619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7Wz5e15DgDNnQg1K4LG2VnU8lmDtJLZduTBJnh+PEZ0=;
        b=MBpaq94DxyuWalHC9Ut/SLBZAKRmpgHuwiqMtCpwy+hbICmh5QP5aKvG5XTqvfwTIF
         NACE2cUnFDqbmGoPOmlh2K9v5+3SRU6CYWzCzWgQR9GJKntLyfkFriL3H8zrn3VdrZqT
         H0sW/Ww3y5uKTPZMgy4kC+FFmPxjUYpmQIj9uSk9Mt/uatT1MlHJgRgREuc6XVf/wleY
         +QO484/E6V5xtEq1/zAPtVaw3rbp+I0urIJdwgIPJb8swq3RUB2dPtPZBAd5OFdXtUEt
         Zs+BE8ch9+ViuWqnXkaKZ54OlGMd42m+UccfYEJFsJl6IzZbqP665IXvm4opiJIMzJdV
         btgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748061819; x=1748666619;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Wz5e15DgDNnQg1K4LG2VnU8lmDtJLZduTBJnh+PEZ0=;
        b=SF/Ixn1Gc+7BIlDHRyHOCiIQYe66heakyQZXfXcNdVQXtzZAle8gVlhIeZJwLOQBHW
         cmGy2WoDuaw9E2bmR9dVdkrEs9WkJDicjvhblnd9XBQGZJq6Em72PlazgVhrLo3V8g8f
         ulvHeuJw1C0vylLTQ76HvNwnrCNGv2t9u/+HZfHo88WG2i9a6//uCH8MqdK/oJVhsOzS
         hwcBJ920tk2GPnB2NCqUJTpNixoSwRhazqWVsGpR5T4meRLveKpLUtOb4He3loC0ehhV
         Zhul6nebhTQLmYK/ed6WcDR8LgtVqaDBzn9ZlC6oaDj2bkjOhCp3LfxxYtrja2JQAjRQ
         MqKA==
X-Forwarded-Encrypted: i=1; AJvYcCVD9L8qZuFyriNZMgod9wynM0/YfRM+LPr5JijffVobZpJQD0FVJ3S4nA7J+qafvlPrO5yq/u55FXaCu5HO2nY=@vger.kernel.org, AJvYcCVVnKktdgT8ZxOEpd9+aZprW+pD3PXomoT+f1nSnj7fRcC8EMgWuKNNAEIGyramsKtXpPqEsgwZJ+TcB3EH@vger.kernel.org, AJvYcCWS2otrM7vsjJlc19S5BbYYhcAphlMANaMJw0XXgTm0vvewk1ckFjdTtXbBh9cYHNHqPv7O6XhzzPqNKA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzocEJBMN8UsKY1wuLI83dKnl2+pptiHaW+bE2tfyq27aF/63LN
	W0VaYZh8mVQnlIxeVX9UN3ru67XUyznaM86/fWPZWuUw9tiyERK6ERUdzI4wGA==
X-Gm-Gg: ASbGncu3e0a9DhKTe5RrSWAXvCf3vRlqWIg4CLDgKtyF4jauDHz8d6fkQUk3f5sHWVZ
	N8iQDmnPGHYVM119qVFFBBL0djDi88/fTWS+XPx+lXiLoDFtiQCnPlD1CL4/+bEDOIs47GTH16b
	+buvxJzZpk/7fbHtxWtkYgD2T9hPVltFxWwRs5BwsaKLkcDk6rO5c9kre6r2rJo49q/v4GnK6o1
	E1gnPtWpot3izBO65J0ZlmhaFGsfF7AZD6h1ps5vCxdCu6Ov3k2lytYtLPdws8ELkzN1AfRKB+J
	vuP+Ra9RlLzvWtQWVa0dQi2bKmwsY+zKyQegK1TBDcxW
X-Google-Smtp-Source: AGHT+IE3W9sVN9Kj8QzWN+bUqmOvPkuxI3tPM/F+itgLqPoHjPo7vrtoe330BPhnhy/q/oUcvqUWAA==
X-Received: by 2002:a17:90b:164a:b0:308:6d7a:5d30 with SMTP id 98e67ed59e1d1-3110f31bf8cmr2747449a91.18.1748061818625;
        Fri, 23 May 2025 21:43:38 -0700 (PDT)
Received: from dw-tp ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-311082cc986sm762945a91.12.2025.05.23.21.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 21:43:37 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] ext4: remove unnecessary duplicate check in ext4_map_blocks()
In-Reply-To: <aDCdjUhpzxB64vkD@stanley.mountain>
Date: Sat, 24 May 2025 10:07:33 +0530
Message-ID: <87ldqm39pu.fsf@gmail.com>
References: <aDCdjUhpzxB64vkD@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Dan Carpenter <dan.carpenter@linaro.org> writes:

> The previous lines ensure that EXT4_GET_BLOCKS_QUERY_LAST_IN_LEAF is
> set so remove this duplicate check.
>

Earlier, I knew it was a redundant check, but I went ahead with it
anyway; and later, I might have missed removing it. I agree that we
don’t really need this extra check.

So, the patch looks good to me. Thanks for taking care of it!

Please feel free to add:
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>


> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  fs/ext4/inode.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index be9a4cba35fd..014021019b22 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -757,8 +757,7 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
>  				orig_mlen == map->m_len)
>  			goto found;
>  
> -		if (flags & EXT4_GET_BLOCKS_QUERY_LAST_IN_LEAF)
> -			map->m_len = orig_mlen;
> +		map->m_len = orig_mlen;
>  	}
>  	/*
>  	 * In the query cache no-wait mode, nothing we can do more if we
> -- 
> 2.47.2

