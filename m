Return-Path: <linux-ext4+bounces-12236-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F077BCAF500
	for <lists+linux-ext4@lfdr.de>; Tue, 09 Dec 2025 09:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7F96302A394
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Dec 2025 08:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04FD1287510;
	Tue,  9 Dec 2025 08:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="LpnatfEJ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8669C2773DE
	for <linux-ext4@vger.kernel.org>; Tue,  9 Dec 2025 08:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765269653; cv=none; b=uiP2C0ucKDPYciXG2pZ0ftLBekyMjUsOGctMmTMxFEZgS++XfVE8+7RcXsKObFYoU9Ck+8l6O9UcKPSvNPRJfS8HwDm6VQqxtaHVcmexgCHzpGR2T0gAeIkqGrwP9o0b0gmrJlraFjXqd4LxR5Nw0KxNP1A1depvHZX0mqdsbbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765269653; c=relaxed/simple;
	bh=QGdJ7xOj0VhIFJxyvxFFwrbE1T+Ookj54PhAEdx+8HU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Vf19gofDDA3b0ve1Hv7gKcraLi1mg+CLMf20a4tzi28jzuWDQpYvGIJICcEUTuqxtp2zra9NfeI11EWR2YbFWxkehnuhAMKDIrggtPONl4NLilIxyAba+lKcxsQms7ofubRHeBWLprS/LM5tWU8cf0MphtrZNnfNMZAodPHi/ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=LpnatfEJ; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3434700be69so7600813a91.1
        for <linux-ext4@vger.kernel.org>; Tue, 09 Dec 2025 00:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1765269651; x=1765874451; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FvpnPesPd7ddPwM9RQGFvv6eTS6ofSBZTx6aar6UV4k=;
        b=LpnatfEJ3iaK1vo+yWBui+Sk/viUH6TnlKOKruR5NjNDet0jjvNapi+HK/QEVbHOjm
         T3C0QZocDRVzKX2i+CPqtdeH7W7aLdudSre/oon+Pf4KE3gQsQPy/d9m1q0qAoatY2d9
         Nd/Fxxow7oMlQKiNAr7ovwpFXaUEa9GN1CWcPDgH0n6Fjcx3UBCOlbUri4mmYOIEQ9uX
         ApIQKTmaH3u/WZx5YsBTe/UVYW6bIxOhZnjnJ84VTLwZXljj/18X03X9suKXh/kR1OW/
         qdndjj5sUM4xxUzoXYzYe5TrKpPwc/IQJgUQc+rQSkGT21f6xN1pbL+86IZH8ViwV6Mq
         RdZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765269651; x=1765874451;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FvpnPesPd7ddPwM9RQGFvv6eTS6ofSBZTx6aar6UV4k=;
        b=FljGNp9PArGguIuYhWXgsLLccCCXwn6YjXEGuR4hI0IhCx+/jmqWvi+E0sAfBhksPm
         FyOf0+7j6WTghP2PzRD8IYsdr6xHMW1o+FSI4a092WbxjHYL6zxoymPyWRANfa9SKd9+
         pX/ZDOTC94hhXTE8E4UAWllkcqo02d/IbX9LtafZN1tNpAlwf7tidhHwbxrwDRV+pG0V
         vgtNe2y6gMg4v8vzytJ+K2ge4Cn1+2tiASJYKQXQ8sjPO0eej6oRJl9/FL5+0jK0f7zZ
         CxXMPUzkp/PxE+wenWik41WVY0q8Hk0xWLIU26sh1JvfpwOeslke50o8YwI1YGGAgRZn
         WFRA==
X-Forwarded-Encrypted: i=1; AJvYcCWmuz5fz456NVoIldOLN2DaDmUsp2jwXqnt3r3o7G7CFCoMX3GUh206rYAwGbyrfef8nuXhU4FXsKbL@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6bHoiWmhc7hXQXZbOb37zZ1jsN824/ev8kb71vF1BnVUCgQgz
	m4NnzNO8sWR9VGnkP50cadAqtutX16MoKLmmAkdCwneTu5sYqrIO8OOjsjQ31p4WlYU1bMK1w3F
	hLYl3aEs=
X-Gm-Gg: ASbGncvfTffH6MlGRKavyqMEvMOMqGuwcFqMQF93bSbW4K/jvIYa1xNJzQFD47SEtOK
	1ltN/5HMVJOyHsX8dDbM18sNDy6kKEY6gKcVEEQCLsWICjzGZczu8IHF8CL5PZU+yo6vio2F1Q5
	BdcdMekc0kaVIaI+Jg72N3qXWjqQrPY8n7TyQ1YhfncdSG/TIbps5GnWPjjkcF40r8gLK2562kp
	x0B6oFcI0ReibZ23gqeHMQiVx5kM7MdaIpTJooAXVogoXfgfm8NmwHA2bWL+JozsqCk0yIUUYYq
	EXNbLX3Y9ySQYiNV7nruL9BhBRewc5Vz8CLkCKqFzVqrSGXBC2OyK/0PdstsHdwzRVwclqAt6ps
	iUXyhkh0MWk9FZtIPMi8PPETfpcLSphfW7Jj9I+XCMQzQ9hwjYEe4S+6BXwnm4pTscBFrpvQIhm
	Q4rSaWUhqyZoj2L6D/a6Ll1e42YMPQUbcQZCwAZITF95zAhMmszL0TEHo=
X-Google-Smtp-Source: AGHT+IEHh8Dm7TI/+iPns+dvjijXoOtTLyOsrnmtX2gfSR9rwQM0vonw1roDurASiQYRrZjxRqgg7g==
X-Received: by 2002:a17:90b:5750:b0:330:84c8:92d0 with SMTP id 98e67ed59e1d1-349a261424emr8562956a91.24.1765269650766;
        Tue, 09 Dec 2025 00:40:50 -0800 (PST)
Received: from [10.88.210.107] ([61.213.176.59])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34a49b91000sm1560778a91.9.2025.12.09.00.40.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Dec 2025 00:40:49 -0800 (PST)
Message-ID: <80f77860-2d5d-4ff9-9bb8-1e5bc46a4692@bytedance.com>
Date: Tue, 9 Dec 2025 16:40:46 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ext4/004 hangs with -o inlinecrypt,test_dummy_encryption
To: Christoph Hellwig <hch@infradead.org>, linux-ext4@vger.kernel.org
References: <aTZ3ahPop7q8O5cE@infradead.org>
From: Julian Sun <sunjunchao@bytedance.com>
In-Reply-To: <aTZ3ahPop7q8O5cE@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/8/25 2:59 PM, Christoph Hellwig wrote:
> Hi all,
> 
> I've just been wanting to test my changes to the inline encruption
> fallback code, and it seems like ext/004 (the only ext4 dump test)
> hangs when using the following options:
> 
> export MKFS_OPTIONS='-O encrypt'
> export MOUNT_OPTIONS="-o inlinecrypt,test_dummy_encryption"
> 
> I thought I did not see this before, but it reproduces back to at least
> Linux 6.17.  This is in an uptodate Debian trixie VM.  The dump/restore
> process look like in weird states:
> 
>     4727 ttyS0    T      0:00 /usr/sbin/dump -0 -f - /mnt/scratch/dump_restore_dir
>     4728 ttyS0    T      0:00 /usr/sbin/restore -urvf -
>     4729 ttyS0    T      0:00 /usr/sbin/dump -0 -f - /mnt/scratch/dump_restore_dir
>     4730 ttyS0    T      0:00 /usr/sbin/dump -0 -f - /mnt/scratch/dump_restore_dir
>     4731 ttyS0    T      0:00 /usr/sbin/dump -0 -f - /mnt/scratch/dump_restore_dir
>     4732 ttyS0    T      0:00 /usr/sbin/dump -0 -f - /mnt/scratch/dump_restore_dir
> 

I can reproduce this issue locally with both v6.18 and v6.0. The problem 
disappears after removing test_dummy_encryption, and it still reproduces 
when test_dummy_encryption is set alone in MOUNT_OPTIONS. Therefore, I 
believe the issue lies in test_dummy_encryption — it is an 
implementation of fscrypt.

CC: linux-fscrypt

Thanks,
-- 
Julian Sun <sunjunchao@bytedance.com>

