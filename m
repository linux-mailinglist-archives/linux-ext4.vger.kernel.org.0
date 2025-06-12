Return-Path: <linux-ext4+bounces-8377-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8394CAD6612
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Jun 2025 05:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4E907ADAB9
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Jun 2025 03:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679A11DE4EC;
	Thu, 12 Jun 2025 03:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OwNMvS60"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD88B18D;
	Thu, 12 Jun 2025 03:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749698097; cv=none; b=HArm7wU5vXK3soFN046Qi8f56+Qi/i5+k9v1bDVCvuCAa4y7sfrUHmstsbASnb8eOyFZ+jxVLYMpc7UzS8YSdF5onEyKpVG+mayFaN2OZXi2nwLnkt8KeO6szy5nHP+nDFcVil2f4CDqjIdg1Qzflrlr/UHXCpWjKD6klkw4+0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749698097; c=relaxed/simple;
	bh=7jJhAfebdEIfSg5lLa5dJj+zy2cgJc0CzRnWHGsNRdM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=G5tfBYC0ViWgtRQrDP3hFpMSkgW6HYBG+HeoU7mxr06x0uo+a6hS/LslkbPDlXrfarwgBB6XXBLkRLjx0yh4GmisPc7hx46LbtHe0tmTWro8MEbH42z3ScN+xu2f1KdniN5tJgPiXECjVeg4trSJflWMQKBHapWeTkKKVYeRi4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OwNMvS60; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-74849e33349so517115b3a.3;
        Wed, 11 Jun 2025 20:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749698095; x=1750302895; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VcfvNlt00FTPnlyELPoRt9S7HG9qLcQIDOCI0yY1ETI=;
        b=OwNMvS60un+NWkXu5j2HkJ6ABmuIIw1Acl/+0aeA0+EWNym2UFGB/x3ZVrKyNgRtb9
         iCOl2mgI+hp7TYg/HRL0pGLwt1dWBaYFvI/RPlhUDOWmGe1QtU6O3adrSbHJACnvqvRq
         tiatJxItlogBWgNe9l3gibQfuoWcDVFUnXjn9mm3RHLxtQdbOIM1n7TbZ1fgoD5RFQ5o
         U8FosN7KF4iKXPm2vMCGF9obbpNhmjb4LQV9i3LwmX1Naj1IKqK9rnoG9v6hIrBPAwhz
         V8ge0JXkWNCnyCyC/TvTuBrlhY/eJ5zs1fixmJV6RJBya7D3MtETkOi56XoLkwc5uwdU
         rI9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749698095; x=1750302895;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VcfvNlt00FTPnlyELPoRt9S7HG9qLcQIDOCI0yY1ETI=;
        b=ipelcwcd2V+cND88JUho3+8Anb+wGCacDEyVm+M62hHaxZZ/NSYUbA4VoE4N3aTT8R
         b6UmKh4rA7GkmSYPbTBQO4cGeX93rqEDX9P7Ie2dwfZ2QaU5NkbBXlp1/E94VZ8i+dAY
         9CNcNP6p/LCzQ+n6QbNNR49cUzQIZ5PtvlXDPAyhF6Bg7E/vu0BE8zIDagiBKEE7gedN
         ny0B1fGNuMNQW5hhj3od2N9cEEeJ2FVDADzWFb1d7qFxeZU8kcWzFatc8m8JK0ehFwjb
         3I3UB8su5zynP35K3OCfOEF5KBZk8+Kl3Qo5oXXHdSpo4nNwKIm6BN73+HxDjOmSVbzU
         bFSQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7oyuNvBgYvIww89MPb9plEkkixcpT7OTdmJicZm5DaoP4BG5Wpmm0TXa0aKqCb4PnwtqI8yfb+s5H5+g6@vger.kernel.org, AJvYcCVu8j8pynmgTE3HspVJQWZMiKYlF5M4Zd3DvrMaWS4ihZmZleHxDMRYxt7k6SDHTIBP6bd8T8RkZ9x7ag==@vger.kernel.org, AJvYcCXA2NreDOnGtF0KVeL5G5NaKE36cdb302b5P3rC6/z3209yVPG5CGWMLdQm+wKc58ytoHqQ1uPFEos=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNPz8fRpanE85KTD5Fo12VarxMbCoScu3osZ/vsXy2b/FYVfWR
	ytHYclWRcZ70zBGw7/8cTiP1d91d4w0SjkagnXNgAmAhP6Vo5OenQORH
X-Gm-Gg: ASbGncvhKKxJFXQVGcjKfdp7dDLgilvCXUYHUcraEeoCJPcJKtpxXdsxI5am5Ap2m7X
	uqEJc6O2Wswglt587ikoAqqdYLi2T0TOXbVYV2FS7ORTLVtLz0FoT3QgdaxargSoui29cw5YKOT
	2HQZl60+g28CXZSfbcAHLq+TO6MHN5Rj7gq/ULZQGX2g9dkJwBR+w2qdFgpI4Rrn6J1R79v5tVW
	sroQERmAbSOsJBMGVm2eLE6DJZXgC2zJdg2eYrJ9lInc7hYDsyrHcnL+nbSAUBw7Hsdf1tgSabD
	B8wLG+7rPvbiLNGHahyZG4xjcouE4sYQ8Sl1cfQGJ3zi8zCg0+qKBgK81U/PEUUNZB0VQ3wT9xZ
	QaCv/
X-Google-Smtp-Source: AGHT+IE89JQcQCFvk3h02GmjoF0xUyL9MLke8YxZb75TKbqJ9AyQHn/6KwKLAgtRBahWWUJo0vLigw==
X-Received: by 2002:a05:6a20:12c6:b0:1f5:889c:3cbd with SMTP id adf61e73a8af0-21f867441e9mr9009270637.35.1749698094760;
        Wed, 11 Jun 2025 20:14:54 -0700 (PDT)
Received: from [192.168.0.150] ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74880896268sm350183b3a.44.2025.06.11.20.14.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jun 2025 20:14:54 -0700 (PDT)
Message-ID: <8b354dec-021b-4083-a59d-d77b48e3e616@gmail.com>
Date: Thu, 12 Jun 2025 10:14:50 +0700
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: ext4: atomic_writes: Remove
 cross-reference labels
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Documentation <linux-doc@vger.kernel.org>,
 Linux ext4 <linux-ext4@vger.kernel.org>, Theodore Ts'o <tytso@mit.edu>,
 Andreas Dilger <adilger.kernel@dilger.ca>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
References: <20250610091200.54075-2-bagasdotme@gmail.com>
 <20250611164800.GC6134@frogsfrogsfrogs> <87ikl21a5u.fsf@trenco.lwn.net>
 <aEoaJEhw5qHkd2_w@archie.me> <20250612010942.GJ6179@frogsfrogsfrogs>
 <aEpAD2jcemzvoJlQ@archie.me>
Content-Language: en-US
In-Reply-To: <aEpAD2jcemzvoJlQ@archie.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/12/25 09:48, Bagas Sanjaya wrote:
> On Wed, Jun 11, 2025 at 06:09:42PM -0700, Darrick J. Wong wrote:
>> On Thu, Jun 12, 2025 at 07:07:00AM +0700, Bagas Sanjaya wrote:
>>> On Wed, Jun 11, 2025 at 11:05:17AM -0600, Jonathan Corbet wrote:
>>>> Sphinx wants to snarf up every .rst file it sees, regardless of whether
>>>> it is explicitly made part of the document tree.  So it will pick up
>>>> atomic_writes.rst separately from the include.
>>
>> Does that mean that overview.rst doesn't need to include the other files
>> at all?
> 
> I think overview.rst can be turned into toctree index.
> 

Or maybe slurp all included .rst's.

Thanks.


-- 
An old man doll... just what I always wanted! - Clara

