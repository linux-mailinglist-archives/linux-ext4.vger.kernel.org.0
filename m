Return-Path: <linux-ext4+bounces-11500-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C67C37589
	for <lists+linux-ext4@lfdr.de>; Wed, 05 Nov 2025 19:37:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E883634F9E0
	for <lists+linux-ext4@lfdr.de>; Wed,  5 Nov 2025 18:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E503286D70;
	Wed,  5 Nov 2025 18:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fYVCN4Of"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF63D27FB3E
	for <linux-ext4@vger.kernel.org>; Wed,  5 Nov 2025 18:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762367835; cv=none; b=and2fpe69rPTL1eI5ogZ23qdjpyTDXlxISLAQ1m0riDg5xI8NC7nMQde1Us2gl7au/EzZWu78XKjeO8jfv8K8BqzRd3qz3RFDZBAx+ZqL0QZ/DCDZetgp3ks1zGhq/C/Y6VIsEE5uNiCMumGw9mj7Ceqb5K3Jz5YfwkfgaLXO30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762367835; c=relaxed/simple;
	bh=w1KYQIP//0eBMv4//DhZ5KFx9PNW1UPFH7nnebTruwA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DPsfhaGaSSegNLXR3td+lslgdKbqy7HJ9k/1cV8cmiYMJEQbF/q+kvfHPxRSo4brGwEz5RcAmzvMDEtgNl7AHwcspYKKgwZFRVKqKaqbP7pytBJY0e0hWNcH81BIk1kWu6HMWpVjcB/nBbokNG7WRFRR1FFS4dsbXJW5Sd/Wj4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fYVCN4Of; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-421851bcb25so80597f8f.2
        for <linux-ext4@vger.kernel.org>; Wed, 05 Nov 2025 10:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762367832; x=1762972632; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wVms5zHRqmmTEZveui8rFB3VRHHPz5yVXKILCesT61s=;
        b=fYVCN4OfbHIr8B6q0Fi2RkHSRnuiG8B6MV/syAoNmWfmZuE8ZlusEVg3Pxq17sxR2v
         7AkJFhY7iCk+P/zK0QeVYfM3eWMSeeYDlikkK639vYgdmNG49juLIQskyq3AZY6yMYjx
         yTev4+Oj088dMF8IXyH2XTXsnz8C/6Eh3kSn9HIovoxccDTgbLnSmWSHcQZ+WNckNFiK
         lCaMSfbb7ZZoq+2+O9PX8PodM/MiZP0K/rYwn/z2RdZo++j2yZBUqEJfQZpV/HGQLTQH
         zhanoIv2dkwGV4Pe0knKElXwBIAVqJqXT6PhTpFHxfSlSI/40HlRhhEC+nRYsoGS3n/h
         UT0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762367832; x=1762972632;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wVms5zHRqmmTEZveui8rFB3VRHHPz5yVXKILCesT61s=;
        b=gRdr621OnuSVDBdMa0jamWrwYvqqarSxDP4BaSpIksh5oPwtWKSOy/ROPtkBGAue/1
         ZsMg4gh4hbtbzbcZExKghMhLIqxDcgbPw9UQ+mTF6mUaFQ/HN/PUIJnuNjaBbIirrqal
         J7ZmpREPTfkSgYUAMzh26MaO3Y/BlPliN1mqpR7g3d6bU5FZTi1vNagFQkSBTLekHRY2
         /KZ0AJ4PpMVAcMmH7VXosojPqW0ETqQ/dpMzej28gwt18vLS65DQjPCn0lBstirAefvm
         pKjtuzHNEIW2cAG9M/SG1KHdOOZGN658wWCQICMHXhvBuoOPdmutqMa0kcMGXZeJtM3u
         TgTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIGaf2XhKczcnNMGd3heE7cx7GU2kBqbmWIIBrxN05brHGt5jmJfzoLeCkrOgT0cTG2yfyxNDjlCez@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/FcnBn7q6yi4btO8DsLi6bsBu1SwGd9dS2lmDWO72OCE3RaDV
	nCxLKl4v4KXIzQOuPdSlnBTFybdMN97qUjOh7NQRj6xaaK3ETOMvgpkmyc3vvNKTQbxysyt3Rrb
	aACrJOfdtrFtDxg9JwDSWo6phH0ZH5LLEdwGABCQWWSB9ynPr0xab
X-Gm-Gg: ASbGncu2ZBUNVMawLjHzA4TpTP+Q2xXC1JHHY5lcltUrk5mlY8N88WY+3EcFfVzHvds
	n2jLSMyf6o2U7uT7WqEKuRb/r7n1yy1HKvFShHqRJu81D+sXqEpLBB6c0KT7WvysV4rUJO8/95d
	zKVPpBWM3QIhimiMb72ifOwf9jOq2Bs6LRZu9PdiX9lMYy3CYQw44jPiCzfWn4y3e5QZF0JUy/Y
	LFQJ4C2S4dFQWlDZXQotDEhfhzE0PLgCLhz+9V5bK26E/61aNtMebsFsl7Cpj3OTJyi3aIhd9e2
	PlUOjzLgC2HdpnKa469yriVy7edL2QjZGoWlQelpqy6/ihltFTQZ8rLgtR7zL17ZVhXN
X-Google-Smtp-Source: AGHT+IG5bZpCpAJS0uB9KNssTM0G9hDscPSWpbhRk73gTjzcEZVb+SiJRjSt3rx+GFSKRtyh83PP5p7jyKcIDWTsbQs=
X-Received: by 2002:a05:6000:4593:b0:429:de20:3d84 with SMTP id
 ffacd0b85a97d-429e35d299emr2327042f8f.6.1762367832176; Wed, 05 Nov 2025
 10:37:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104-work-guards-v1-0-5108ac78a171@kernel.org> <20251104-work-guards-v1-7-5108ac78a171@kernel.org>
In-Reply-To: <20251104-work-guards-v1-7-5108ac78a171@kernel.org>
From: Daniel Vacek <neelx@suse.com>
Date: Wed, 5 Nov 2025 19:37:01 +0100
X-Gm-Features: AWmQ_bmfaeOypajqSuDAqK1J5uivhcjJ2drotaSadJ4EnDW1YFSkgONoikGnaIQ
Message-ID: <CAPjX3Feor+wY-_rniWOaGQf_7RPaUQLDZmmjABDkAav8AExaxA@mail.gmail.com>
Subject: Re: [PATCH RFC 7/8] open: use super write guard in do_ftruncate()
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-xfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 4 Nov 2025 at 13:16, Christian Brauner <brauner@kernel.org> wrote:
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/open.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/fs/open.c b/fs/open.c
> index 3d64372ecc67..1d73a17192da 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -191,12 +191,9 @@ int do_ftruncate(struct file *file, loff_t length, int small)
>         if (error)
>                 return error;
>
> -       sb_start_write(inode->i_sb);
> -       error = do_truncate(file_mnt_idmap(file), dentry, length,
> -                           ATTR_MTIME | ATTR_CTIME, file);
> -       sb_end_write(inode->i_sb);
> -
> -       return error;
> +       scoped_guard(super_write, inode->i_sb)
> +               return do_truncate(file_mnt_idmap(file), dentry, length,
> +                                  ATTR_MTIME | ATTR_CTIME, file);

Again, why scoped_guard? It does not make sense, or do I miss something?

--nX

>  }
>
>  int do_sys_ftruncate(unsigned int fd, loff_t length, int small)
>
> --
> 2.47.3
>
>

