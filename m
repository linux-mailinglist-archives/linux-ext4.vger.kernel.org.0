Return-Path: <linux-ext4+bounces-12709-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A46D0CBA6
	for <lists+linux-ext4@lfdr.de>; Sat, 10 Jan 2026 02:38:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0BFD302C8C3
	for <lists+linux-ext4@lfdr.de>; Sat, 10 Jan 2026 01:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BCFA22B5AC;
	Sat, 10 Jan 2026 01:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZGp0s/AD"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A0222A7E4
	for <linux-ext4@vger.kernel.org>; Sat, 10 Jan 2026 01:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768009100; cv=none; b=ms0dOUbQOLxKgtZEmLzDod6+vPJ9FuVt80IskXVacXaKruq9PWWCtTz+Nv75fQW8DzwrkS2j45g6pwpuUxF0eX+N2U9zlq/bSClz+xLbQ9DE/TFBAy8QVLe9JNHCo1GxAOOtnBEJ5BTbdxruL9bfEt4OU8ggaxkTValYmgllsOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768009100; c=relaxed/simple;
	bh=te6lqCMJMeXSafrnTev0D+y8QU6sCaT3vBxerZnarRo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u+CKRSF6KuXy/U7u0vwWYkpAprK3knusXOLyi3YiLQ4gTgRso+8i2UMYqhvYYvfaCIz1FqMlbcLchyzIzxH4LDBY3UDV9FTvM1JdMIDjCX1eQqdQYwZulG3nrLawbGObQbJVxV1rRbQRRTroiCgVrTF9ud8iZH3tKEwWbt/jsi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZGp0s/AD; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2a09a3bd9c5so32934135ad.3
        for <linux-ext4@vger.kernel.org>; Fri, 09 Jan 2026 17:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768009099; x=1768613899; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3Z88oGJmwBB94R5/ZO4QNZrTm+lahlqZzlbWmgmpx5M=;
        b=ZGp0s/ADDCHmc1kPYlWHd/4vYKhu3Vl+dxRHEbPNR2WCUuDG/Ad/eF7MdiBjScen10
         1kKfrt1ZLLXcnMV5UqzgCBpxA+7TZO8H+yPRIsqselE17pd4sIyCCaDr6m0T4QpK0vDq
         lPpg0vOdHYP/9+K5XKinNQ1wNdw1J/6Wd5rvku6U3hAUw0vhFyF4JobQ7MnFifbwApOZ
         DTbbAL8dOGV9IqgwToZ+JJX6Avphil10kVlHKyXZ8XR80gwl7thtdzyH0SHYJ+M/HHQp
         i+pUH0h8y+XM0TwTVS0mamD02TVGOO8z8ztK502BWi6qdVAwnGD1yZqhYv0jhjCt0BAs
         vkGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768009099; x=1768613899;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Z88oGJmwBB94R5/ZO4QNZrTm+lahlqZzlbWmgmpx5M=;
        b=wggjz8e5gVfhsFUXEGvsWCN4InlVAZcqIrQFOyiZr/jpuQRpnSxYT2Vr5qCjbGLXhm
         4J6Eb+f+YWYzziBA6WnV/HUJrNXp8i09diB5FK8g8lqq3lBfvFjY9iXMq+GW/bNB6eW9
         mMScnICJM9YoLsHiVN6Lr/4TmA8q3bliDK3BvwTK3o89CIVvxKGageVzxv2fr/4aQrWP
         OmSmpAfUDDPDQ9e60K2AvZ0EzMkuESBxmqB+BE7RYWnoN2LO1Gy3ejvBJnTVWQwxfxpm
         fqDptDortEuhaF/f+Z/tg50riTIjYJt71AZKBaHqVsciXdPVjvmxpJR61mKmbZG6vyj3
         sXVg==
X-Gm-Message-State: AOJu0Yw1+BsHilQeE7Dnx+Dv8qaLiOnLpKBqVEdy7b8izOQsre2wFpNH
	My/n/RI6YDS4esL8H1NLqONn+XYl+PgofGUYNs6MOiY4wdEv0e67/fnkw0p80pWyBS4=
X-Gm-Gg: AY/fxX5WNBndw509BVBRM6PCnFqdS0WZ/fxAaAcA8Uvza5OipmNmwpl/Exh3wYxxFki
	mTHp6T9gX7LR7O6SOrvA/i99ozltGemiNTCE3YmbFnE5L2ZZ4E0q1ONssIvAXA5Ps0Kayxfo1Kf
	OScy5tLSzbBUfKbO3G0Rp30jW08+PCb9e2txF3pu9mxJQ94nDh/slujsntxGIZprdtWxD+x5Qp5
	IlUhHvYigquEp982aTKAGtDC3kqD4SKU/tJgpY5k+AOeEIbNqt9tBhhkMZhQueiITNKFNzSqD7b
	RfXf9ZnH0WSXbY4TYIQbbmKNsMbS8nC6i8REkdiQUYn56ujA/Mz5QX1i3nD+tFzhbsgm2FB01/h
	CjGITn44Fp+W9yY+8fabD7pRqdzYAIoQX3id4115LazjxO/IShANZVjwkdiPWPH+dz+2jITr8KG
	PApjHgi1s2chEOsrLOJKcra+GwLT1Xbeclbl5AUkZY0fLiVNDyi5uK7TL3
X-Google-Smtp-Source: AGHT+IFzcYC0X7Jd2ag+pDUJoVOfQp+8M+bMOeXruwnv5SH0le5WxmtmZO+3cZ5Kazm6npfQfTgf7g==
X-Received: by 2002:a17:903:1984:b0:2a0:a951:ffe4 with SMTP id d9443c01a7336-2a3ee4c160bmr107019995ad.56.1768009098970;
        Fri, 09 Jan 2026 17:38:18 -0800 (PST)
Received: from ?IPV6:240e:390:a96:d731:80fd:27b:ba3:55f2? ([240e:390:a96:d731:80fd:27b:ba3:55f2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3c3a204sm114440085ad.1.2026.01.09.17.38.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jan 2026 17:38:17 -0800 (PST)
Message-ID: <5877f412-003c-4893-bf6d-229957802eda@gmail.com>
Date: Sat, 10 Jan 2026 09:38:13 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ext4: use optimized mballoc scanning regardless of
 inode format
To: Jan Kara <jack@suse.cz>, Ted Tso <tytso@mit.edu>
Cc: linux-ext4@vger.kernel.org, Baokun Li <libaokun1@huawei.com>
References: <20260109105007.27673-1-jack@suse.cz>
 <20260109105354.16008-4-jack@suse.cz>
Content-Language: en-US
From: Zhang Yi <yizhang089@gmail.com>
In-Reply-To: <20260109105354.16008-4-jack@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/9/2026 6:53 PM, Jan Kara wrote:
> Currently we don't used mballoc optimized scanning (using max free
> extent order and avg free extent order group lists) for inodes with
> indirect block based format. This is confusing for users and I don't see
> a good reason for that. Even with indirect block based inode format we
> can spend big amount of time searching for free blocks for large
> filesystems with fragmented free space. To add to the confusion before
> commit 077d0c2c78df ("ext4: make mb_optimize_scan performance mount
> option work with extents") optimized scanning was applied *only* to
> indirect block based inodes so that commit appears as a performance
> regression to some users. Just use optimized scanning whenever it is
> enabled by mount options.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>

Makes sense to me.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

> ---
>   fs/ext4/mballoc.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index f0e07bf11a93..cd98c472631e 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -1145,8 +1145,6 @@ static inline int should_optimize_scan(struct ext4_allocation_context *ac)
>   		return 0;
>   	if (ac->ac_criteria >= CR_GOAL_LEN_SLOW)
>   		return 0;
> -	if (!ext4_test_inode_flag(ac->ac_inode, EXT4_INODE_EXTENTS))
> -		return 0;
>   	return 1;
>   }
>   


