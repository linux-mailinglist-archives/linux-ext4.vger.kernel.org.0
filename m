Return-Path: <linux-ext4+bounces-5039-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E7E9C4899
	for <lists+linux-ext4@lfdr.de>; Mon, 11 Nov 2024 22:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D65428A939
	for <lists+linux-ext4@lfdr.de>; Mon, 11 Nov 2024 21:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0B81BC9F4;
	Mon, 11 Nov 2024 21:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EoSEoCog"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034EC1BBBE5
	for <linux-ext4@vger.kernel.org>; Mon, 11 Nov 2024 21:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731362155; cv=none; b=tP7IZ/6sxQ+4aP5BdHexsTuiUEFI9SOdbx5RlQF5vSpDKayiESn7vbn3R4l+/594gX8mjjwLdtjP2ZVouhYwiwGh2AwqEEXAMY/E8+LHE1c4ZK/tqf+x5B4uk04LYhDYUnbteEK9QXM06xycKz6n8yjfO/qHTc1aA7oOTqmtwRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731362155; c=relaxed/simple;
	bh=SZIQDa8NLYM1ipFkY+LfWhNba2RshbH0DPtK6JH9h1M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p94i63tYkz5Gsmt4MzO1nyeNu7s3LI6vdW1PjsOfbh/NxulwjaF0gdI/sOip++Y6OC7S/8YWeFCOPpXdmTnHCdBwIl5qD+r6XySutv3TI1TP38ehDq5Q6ayB8zShuobTpx8FZ7+aRiD3gb2oxxs0zmDNKkybB5wKDiOXQZMKP1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=EoSEoCog; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5cefc36c5d4so6923390a12.0
        for <linux-ext4@vger.kernel.org>; Mon, 11 Nov 2024 13:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1731362152; x=1731966952; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1yUAbMKFGFD+r6n6bBm/WiyB3YmOPXFQ3bg8vJC1p2Q=;
        b=EoSEoCog0SnIj1X5HfbyxumZ+u8awpO/7mf3viFIucmnBVpP6bewav/EyCK7Iydi5G
         Rn+WxBmh/DCAsLg7EMjIJdLT1GOVZBYOiU7CtM0r4rmtWeV6W0ZmhLiDa7Pc7YJ+6KZn
         Ltm1CiYJCPFsiEqSH2aWzKuWLi0DBNW+UElmg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731362152; x=1731966952;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1yUAbMKFGFD+r6n6bBm/WiyB3YmOPXFQ3bg8vJC1p2Q=;
        b=XRjQ3BNQHJio+juMeP6p+oToaXsTo4XXgJe9R5o3iufuxW8hV8QRssNxeI9dVaRVFq
         uDFGsXp4vKoF4/2I2ANHZ4RMhHwpgssCQ23aVc7iAwUFqhrMApqox6KVVrJyhi8W8BR/
         jcIrBShzpzFqgRENNbWGoN8R9hBH4OwudK5ocTOotZySxXNrKL7SkwiFQFM/tRzm1sK1
         7JynuRYjjPiC81hvKvV36ZgI9TQcjpujycFem+HtwsNJZZcEkiZ9Ec8WXNNVutn8jzdF
         SLL6BCWSPPYbLBUoAoJmyYWEvn9FLhImNDxpFxGbmBQl5xa03iwfzQA7dSvbkQKBNspf
         Kr1A==
X-Forwarded-Encrypted: i=1; AJvYcCU7r+HVr/CBpyGKbrrg/8CyVKWmsot4tHrwX5JseNR5VQy780q6pJ0pIoBFSlR//Q1kCFCS/BhcqXKN@vger.kernel.org
X-Gm-Message-State: AOJu0YxxG5DNRyRWPpK+6OaQ5k2PXbitueFQNgPcoLfFn7IhOGbuNoGK
	ApXfOwztJfi2AmfWtD+MAByON6HNi7obV7BJNto00sAd+Txb2UmzLcjeIu8PTS3rk08EwGgoxcA
	FGuQ=
X-Google-Smtp-Source: AGHT+IFZFkRX8HN3x/lTKWu3duZYz3ROHjk7q2xd/KDFR2oYaZ+TMx1uJw/tb/nwDlUsDys6zR5H9w==
X-Received: by 2002:aa7:c252:0:b0:5ce:fa13:2630 with SMTP id 4fb4d7f45d1cf-5cf0a45d3eamr9071406a12.33.1731362152156;
        Mon, 11 Nov 2024 13:55:52 -0800 (PST)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf03c4f0bdsm5266731a12.56.2024.11.11.13.55.49
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 13:55:50 -0800 (PST)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5cefc36c5d4so6923324a12.0
        for <linux-ext4@vger.kernel.org>; Mon, 11 Nov 2024 13:55:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWJE6MUxFqNIJHq8CZg8zEJ6cVxtZTbnBh7TSlTEmSB8k4dOdmLt9B1a75lMpzcDs/HymyE2HNmlYj/@vger.kernel.org
X-Received: by 2002:a17:907:eac:b0:a99:379b:6b2c with SMTP id
 a640c23a62f3a-a9eeffeee33mr1449197766b.42.1731362149380; Mon, 11 Nov 2024
 13:55:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1731355931.git.josef@toxicpanda.com>
In-Reply-To: <cover.1731355931.git.josef@toxicpanda.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 11 Nov 2024 13:55:32 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjUDNooQeU36ybRnecT5mJm_RE_7wU4Cpuu7vea-Tgiag@mail.gmail.com>
Message-ID: <CAHk-=wjUDNooQeU36ybRnecT5mJm_RE_7wU4Cpuu7vea-Tgiag@mail.gmail.com>
Subject: Re: [PATCH v6 00/17] fanotify: add pre-content hooks
To: Josef Bacik <josef@toxicpanda.com>
Cc: kernel-team@fb.com, linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	amir73il@gmail.com, brauner@kernel.org, linux-xfs@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-mm@kvack.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 11 Nov 2024 at 12:19, Josef Bacik <josef@toxicpanda.com> wrote:
>
> - Linus had problems with this and rejected Jan's PR
>   (https://lore.kernel.org/linux-fsdevel/20240923110348.tbwihs42dxxltabc@quack3/),
>   so I'm respinning this series to address his concerns.  Hopefully this is more
>   acceptable.

I'm still rejecting this. I spent some time trying to avoid overhead
in the really basic permission code the last couple of weeks, and I
look at this and go "this is adding more overhead".

It all seems to be completely broken too. Doing some permission check
at open() time *aftert* the O_TRUNC has already truncated the file?
No. That's just beyond stupid. That's just terminally broken sh*t.

And that's just the stuff I noticed until I got so fed up that I
stopped reading the patches.

             Linus

