Return-Path: <linux-ext4+bounces-5078-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE219C59EC
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Nov 2024 15:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FB11281BF3
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Nov 2024 14:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919AF1FC7CB;
	Tue, 12 Nov 2024 14:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Q581Fl3C"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B751FBF4A
	for <linux-ext4@vger.kernel.org>; Tue, 12 Nov 2024 14:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731420442; cv=none; b=iXrwd0qv71FULatunVvSeCyC+lSZvZw7VjVYMXy4KY7EH+PG7SB+aF4vT9lHa5tO97PeWbyoIIdBR6fagCgWhuZZsFAGBoiMFqjGQxAeE4gcJAY3RO7XEFvFttjm94+vVoetSq7LurRTOV6Msk/3HYlsUbMzTbGpTCDaHPHklzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731420442; c=relaxed/simple;
	bh=FgXKW6BhffGyYtDU5ECCxoHBzDo0QQz41DIfSkBu6LA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EZlShHSi0n4ZVEI38LGSXEVN41oWWEaUibu+agCsZ6RbMYuR1WyTDN+nAJPEUsqLh/Ht+DjL8SAnaPvoab/LB2v12NSE75i2ykFn8lQ13HtWhx7mBB5/1mEYJum2O0oSlTG70/PHj1GM4TDzIV5hVkSWOXxEyBWtgEtEWn67NEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Q581Fl3C; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2951f3af3ceso2961497fac.1
        for <linux-ext4@vger.kernel.org>; Tue, 12 Nov 2024 06:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731420439; x=1732025239; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XBLxl8MQn90IOYFQNE2QB3bhcSqpZYc/78jBtkc8gSY=;
        b=Q581Fl3C6vodl50RvVDAzxLsSqnREQ062qx27W8c6tI+slZqca+De3AkT7dWm1BQ42
         A9Dkp6IgY1DybaEpM+zC+39rqWDkHMhG0lvxQsKCW2QAx/dcCtFMenMD9YJfPXOjiKV1
         W6bXtttTHFoaJKLDzhAAFbGvf+jerD4xswuJA7uBjGowW9kdXMpZ8M3bC1SdX4osCE17
         +BWo2ZI9CJNv0uV3UH8HfIawhGPa3q3r7kHt1RppgE31wUZtO3xg7KCtYZXMlWbZLYuy
         /l4Kac1BdFCr5is15MBtMforzhVqOlT/3C3dmonSjkb+PdIQNT/FCsfgUhOtCWfOhH1m
         aQvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731420439; x=1732025239;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XBLxl8MQn90IOYFQNE2QB3bhcSqpZYc/78jBtkc8gSY=;
        b=GQ3s0dKSe1KmK+ox754A/0RhERosqGnmrWCs0kMhKqnekyAjPF4ZYQ54VtcbT06J2o
         YUvOe6bnSqz+tSnCZGNoqcewDSb8bPO9Pd6ZyPQjr6UtWzetxDC/7rReakb8CVDO9v+t
         rtVUzjYqdZbKJwisRAOPluLAB66W7uPu7mfycGkVOB94e96Fi8rRu5G9kvGTPswf4zgP
         HbuoD9BHOp4gSPjnmNaX8Ei/6jr2UtRKi7COMiSmquK1C9a95qowu2nsYNmpuSA+OePm
         GITT1vhu7SojZwqn467hXu1tw8/xfPMNLGu/DUjn807eOhmmMnNDphgt0TACj3zdLJFb
         438g==
X-Forwarded-Encrypted: i=1; AJvYcCWJc2pr+bfqxH5M6o3ZPVZb7mVYE66io+kKjlCUn2NHSrnsz/hk3Zk9BWhKi21a8jqcNHOp3lIGW3x5@vger.kernel.org
X-Gm-Message-State: AOJu0YyMmCFXK3xRxjNjh3k7792/278NPYJSYLDspHfbt9cfcCaArdx3
	6FrawqoQl2Gkltrf60MUWxfCMipNyOB5NSgQ0FuR53iMZsEHie8Si98Dr7R1xoc=
X-Google-Smtp-Source: AGHT+IE6/Zulglee42EqR6pm4NxzY3D1VnQ/4OdFs+x6lB09KGsOVRrOZIf6id75vga3Werl3HOmGQ==
X-Received: by 2002:a05:6871:7b09:b0:277:da52:777 with SMTP id 586e51a60fabf-295600acfa1mr13774116fac.11.1731420438736;
        Tue, 12 Nov 2024 06:07:18 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29546c92853sm3381006fac.18.2024.11.12.06.07.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 06:07:18 -0800 (PST)
Message-ID: <1671bb73-2e51-4ecc-b33d-d0b483348cda@kernel.dk>
Date: Tue, 12 Nov 2024 07:07:16 -0700
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/16] mm: add PG_uncached page flag
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org,
 clm@meta.com, linux-kernel@vger.kernel.org, willy@infradead.org,
 linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org
References: <20241111234842.2024180-1-axboe@kernel.dk>
 <20241111234842.2024180-4-axboe@kernel.dk>
 <lponnb7dxjx3htksbggjoasvby6sa2a4ayrkcykdnxvypwy4pp@ci2fnmcyrke7>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <lponnb7dxjx3htksbggjoasvby6sa2a4ayrkcykdnxvypwy4pp@ci2fnmcyrke7>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/12/24 2:12 AM, Kirill A. Shutemov wrote:
> On Mon, Nov 11, 2024 at 04:37:30PM -0700, Jens Axboe wrote:
>> Add a page flag that file IO can use to indicate that the IO being done
>> is uncached, as in it should not persist in the page cache after the IO
>> has been completed.
> 
> I have not found a way to avoid using a new bit. I am unsure if we have
> enough bits on 32-bit systems with all possible features enabled.

I think it should be OK, at least the kernel test bot reports build
success on all the archs it tests, which has a lot of 32-bit archs. I
have to say I didn't check on numbering and if the mm subsystem has a
BUILD_BUG_ON() for bits exceeding the allowable value for unsigned long
on the host, but I'm assuming it does?

> In the worst-case scenario, we may need to make the feature 64-bit only.
> I believe it should be acceptable as long as userspace is prepared for the
> possibility that RWF_UNCACHED may fail. It is not going to be supported by
> all filesystems anyway.

Right, I would not even see that as a big issue. 32-bit would just see
-EOPNOTSUPP for any fs, even ones that support it on 64-bit archs.

-- 
Jens Axboe

