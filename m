Return-Path: <linux-ext4+bounces-5239-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A0B79D13A0
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Nov 2024 15:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B63EB1F2369D
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Nov 2024 14:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5731AA1DA;
	Mon, 18 Nov 2024 14:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="k0Is1buZ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B28B1A0B00
	for <linux-ext4@vger.kernel.org>; Mon, 18 Nov 2024 14:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731941404; cv=none; b=LgUOKglcFT4z5jprQr+tl9UrkIJ5kcyIXlEYmq6cCmu9rLuA8QPb46eriJbSQMeRE4x20JwSnEBpmp/M4QX+VvNnHRX2AGDPnQs5/u2RFdSRFqlc4lcSo/X6qOK5mT92TLZhRElGjlt/WWgA2P2ASG9BVrCfQTt0uYxTz8apIQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731941404; c=relaxed/simple;
	bh=jabCupIh1FJFAKWSdaG7M5rrT0Y7L0LAPYbB0FE65Q0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GclXt8QFCYGdtR5njBuD4Zf3K3D1WH7ouKvDFg7L88fiuGV3jFd0TB20rdUocTw7XWidyzZegF27qpY75tyBOG2Bs45o9IFEwIEicy4f7B5r1UTvYAxPxWnELkB2SuOttuKGcd914TFjGLGSJmlYh3ixcLW9Ph0AwXgWXPmRCFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=k0Is1buZ; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2968322f5feso380288fac.0
        for <linux-ext4@vger.kernel.org>; Mon, 18 Nov 2024 06:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731941400; x=1732546200; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=64rV6XVBsSRZD9lz1azW3sqQ1KWaD6KRPC47/eG5qsA=;
        b=k0Is1buZhEVRX8aA2YpNv8xH51kd3XdbQCdU6sjFm6apcmft7wlkZzhH7Mb9GK/+2G
         1ych5iZYYRNoEgNf/GkM0axLJb9fKsMg61umrjWEmu90EW9mrMb1789SRAbRJEhfjo6y
         Xmccgf3Vb9OQ5OYpKxWee2AxCS87/bX4pAKbglFrVIXGqo2Tj9/DNJukkN8cSrx9Vw6d
         GL5P2MEa+d1yuxxcKeDri93rmq7rjaGcTCBL87Ks5NGABsRSD9DPWYcfdy6Uhy0xWtZ5
         +SU85X3/ub2mgUOCY6QgZVRoxVXkkmtf+jTTNLtdabubJEcV5dBnSLlNhBBJk/jCdviS
         RnQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731941400; x=1732546200;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=64rV6XVBsSRZD9lz1azW3sqQ1KWaD6KRPC47/eG5qsA=;
        b=r23IahZAk+t6Wl/jErjTGu8vDli1F68xqQCBZmZsFcNDKGpwtXYsWXDxJJ1GV9UJD/
         XKrBjzgc0xTxRwFP+TElol8+Q5riHhnROLjpf0PeLBCBQ6M+c/c44IbUAuhlj9kbzLDs
         BXFDL0GLWrRQzf6/JEUbf+OEpZ6SxDVtX9HAmRlUN3IROt95/DQ/o1UryXHhz1bSklNF
         DDndu5YgeW1esb8c0jTmrtINjfAAcGsGnXo7K9PQhg45v0PJZb9dpOY/HMdA/k3tiZ+M
         CNL0RsZtzp15NcPaLsH6p+NeDic/wlSLz/QMDJOY7H/l8yVAKyaxAStVpVVHTi7gI+ir
         LUCA==
X-Forwarded-Encrypted: i=1; AJvYcCUIFg5QHbPBB8o3cqSoaiJUMxz3Bk+6wvZEhdPnn7mUCPmmX1XDgSAbDbkBJObjIw3RmJpGkAois7KS@vger.kernel.org
X-Gm-Message-State: AOJu0YyVw2vn1u3Hbwk0E58pJvGTMQE2jzjCwzT73nUkVHxeMGJq2AWo
	BUefGIFo2Qukpw1QqYhN2KaaR0HHRAaShTK7qistYtL2juAqEpes0wGP6yv16gQ=
X-Google-Smtp-Source: AGHT+IF4SYJY9kdWkwrKjlAiH5Z+Bn8SZkqEPmKpcyMndgMPRn4H9T8dbqU6Hyt3/gFfCCmMTdbpdA==
X-Received: by 2002:a05:6870:ab0b:b0:287:1b05:297d with SMTP id 586e51a60fabf-2962e01ad0dmr10557378fac.33.1731941400385;
        Mon, 18 Nov 2024 06:50:00 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29651852c27sm2626597fac.2.2024.11.18.06.49.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2024 06:49:59 -0800 (PST)
Message-ID: <c54063db-5f82-46d6-ba7b-5e4a0073ebf9@kernel.dk>
Date: Mon, 18 Nov 2024 07:49:58 -0700
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/17] mm/filemap: make buffered writes work with
 RWF_UNCACHED
To: Baokun Li <libaokun1@huawei.com>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, hannes@cmpxchg.org,
 clm@meta.com, linux-kernel@vger.kernel.org, willy@infradead.org,
 kirill@shutemov.name, linux-btrfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, bfoster@redhat.com,
 Yang Erkun <yangerkun@huawei.com>
References: <20241114152743.2381672-2-axboe@kernel.dk>
 <20241114152743.2381672-12-axboe@kernel.dk>
 <01fadf73-6b0f-44ff-9325-515fae37d968@huawei.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <01fadf73-6b0f-44ff-9325-515fae37d968@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/18/24 1:42 AM, Baokun Li wrote:
>> diff --git a/include/linux/fs.h b/include/linux/fs.h
>> index 45510d0b8de0..122ae821989f 100644
>> --- a/include/linux/fs.h
>> +++ b/include/linux/fs.h
>> @@ -2877,6 +2877,11 @@ static inline ssize_t generic_write_sync(struct kiocb *iocb, ssize_t count)
>>                   (iocb->ki_flags & IOCB_SYNC) ? 0 : 1);
>>           if (ret)
>>               return ret;
>> +    } else if (iocb->ki_flags & IOCB_UNCACHED) {
>> +        struct address_space *mapping = iocb->ki_filp->f_mapping;
>> +
>> +        filemap_fdatawrite_range_kick(mapping, iocb->ki_pos,
>> +                          iocb->ki_pos + count);
>>       }
>>   
> 
> Hi Jens,
> 
> The filemap_fdatawrite_range_kick() helper function is not added until
> the next patch, so you should swap the order of patch 10 and patch 11.

Ah thanks, not sure how I missed that. I'll swap them for the next
posting, and also do a basic bisection test just to ensure I did't do
more of those...

-- 
Jens Axboe

