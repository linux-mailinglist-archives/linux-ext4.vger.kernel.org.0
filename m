Return-Path: <linux-ext4+bounces-3502-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4111293EA14
	for <lists+linux-ext4@lfdr.de>; Mon, 29 Jul 2024 00:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB11A2817C3
	for <lists+linux-ext4@lfdr.de>; Sun, 28 Jul 2024 22:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45367C6EB;
	Sun, 28 Jul 2024 22:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="MXz/agCH"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BF178291
	for <linux-ext4@vger.kernel.org>; Sun, 28 Jul 2024 22:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722206808; cv=none; b=KlQ/uz4fuDkGiBi8Znk3zJPe6DmGxRq/DVAo9c35phcyuhxe5TUhGXAUV34ZdGewFHe7ISgCDlWPKtGh7UOcV8QzmeYOvhanmq7N0cxjA7vvEAxdT+gxoaxfI6VGBDFWIbuVXoPFPK2KBZ6heVuFMtqjgEcUJ4L4bbQHiRsF2V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722206808; c=relaxed/simple;
	bh=+37D/4nCO54n90M/u+NZWBYjP0tnb9hWEUzfyevPfCA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fDigM7BkpTKJmRGMmTupf9x2mu8rKg0bz1UrWtdLRkpHUgvD4ZlC5p4I648v8ImX4Do/Pgo2SYyJ1ua3Uy80AAWr6lm0RJrgumVOFsM50tV1nuGWjpAmRcc2OAlDRc9TvJ9xOttJ1FrK2/5twtS66S4euZtXpg6rKz3KDDkfndY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=MXz/agCH; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fc5a93ce94so1929545ad.1
        for <linux-ext4@vger.kernel.org>; Sun, 28 Jul 2024 15:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1722206805; x=1722811605; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1Xqiho1AouRxLOnHmIj3zOU/N65RdIyhSd2t/vYTGc8=;
        b=MXz/agCHZbwi9DCKAS1c7J9CCTHBpGnNN/Vk8Ny5o44HRv0o9HAFAY0zmqQm39Dm5P
         Lk1EUgHBJncEWegHMxxDNcwdaUf0lnxBC/QBKt39WSIkg44em0Q0A+zPkmLOcRIeP1KR
         9TOgMuvVNBkcb3Owus/aHh0fhevA28JNgAg6TrFq6kJA5X2qXmzYUZoBhrt5Cbog8Zzv
         9DpZG52Mimj2dgyXyeepG8f7GMvaHUls9bHsjklvrFwsq3Wqx6TsygI8eP44EYa0F+OW
         68nC4r31603r5Q5BCoPoWM8Z27zJEnu/M8vmmWGeiTUCIsuBFA78XuNKJo1CFXol+a9m
         jOdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722206805; x=1722811605;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Xqiho1AouRxLOnHmIj3zOU/N65RdIyhSd2t/vYTGc8=;
        b=Y3qcqDoGuHL7kkH8npZXwEivXrHOe5w/nAQxpyNf+Yj0wAgKXPpmGagNVAp/5522gR
         Q+dKgNzl1iJGqXecdKcro/eThkHfvnC7rJ3Ox5dkcJinc3HTKOf4jm1GFK9OJ0pX6AB9
         Ao6xXV3nTaIuSh0x91kKvhuMBj8NcnG0NxBsRaxnOYmH/diCnJMHt7dSvvgq9wZZj4MW
         DZ4O+vxilTHrJw2zYWxWB4882Y21+WJW3a6OmrFZp8GPnAJ9My7R95e0DHfrig+dHwVu
         7/b2PAkLFaiMpN2+DioK17UiNvMCsuN587d4MZYA/yje1H9FVl3ewUJfhcS0zkOd+rGg
         U4KQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/Xn6RhuVzKgz+X4Z60n5DrVJPJnSWA5/3jlJ3/5tNG87VPtDQPlSLHBBMWjpOwu5RNag52i83BO0V@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9W+rxIqQ6ZgevgE5wgZgNp7JMtPElv6St5Ipidl4Km0h+6bxw
	Mou2LhxY1DprFgijU/LfXQy9EG1zBNhjkBcUnRVh5vSlbJ48p71b8LQQSevFMnQ=
X-Google-Smtp-Source: AGHT+IHKg+a0YE3GUIxnhPOnInI/3RKPsutZEg5X+UAgetWdzYR/LDdMjPmdpFW1kUTtooMwSokq1w==
X-Received: by 2002:a17:903:234d:b0:1fc:4377:e6ea with SMTP id d9443c01a7336-1fed6cc839dmr83385505ad.9.1722206804553;
        Sun, 28 Jul 2024 15:46:44 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7f1aa0dsm69378485ad.187.2024.07.28.15.46.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jul 2024 15:46:44 -0700 (PDT)
Message-ID: <f768298d-c964-466a-b8d6-ff0a8b4ca0e4@kernel.dk>
Date: Sun, 28 Jul 2024 16:46:42 -0600
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [ext4?] KASAN: slab-out-of-bounds Read in
 ext4_read_inline_dir
To: syzbot <syzbot+ee5f6a9c86b42ed64fec@syzkaller.appspotmail.com>,
 adilger.kernel@dilger.ca, asml.silence@gmail.com,
 linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com, tytso@mit.edu
References: <000000000000f70500061e55a074@google.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <000000000000f70500061e55a074@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/28/24 3:43 PM, syzbot wrote:
> syzbot has bisected this issue to:
> 
> commit e5598d6ae62626d261b046a2f19347c38681ff51
> Author: Pavel Begunkov <asml.silence@gmail.com>
> Date:   Thu Aug 24 22:53:31 2023 +0000
> 
>     io_uring: compact SQ/CQ heads/tails

That's obviously wrong.

-- 
Jens Axboe



