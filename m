Return-Path: <linux-ext4+bounces-10725-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E8BBC97B8
	for <lists+linux-ext4@lfdr.de>; Thu, 09 Oct 2025 16:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C8D854FB1E3
	for <lists+linux-ext4@lfdr.de>; Thu,  9 Oct 2025 14:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01F02EA75E;
	Thu,  9 Oct 2025 14:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mjrV6+yZ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC36A2EA174
	for <linux-ext4@vger.kernel.org>; Thu,  9 Oct 2025 14:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760019678; cv=none; b=ShMJBrXyIxm2g9astQodceVuVIPtbT7AKb6oHMXfr2d64wswbc0A6ckRv9tOHBHTz/oUEE19Zg7Ps+0Kz200481eyS8GIlWK3tqd1k9Ay5Fs2DdWR7J2UkAAvwYvst1AxwQ+jP4as9EY6EsYtL/V8rVpuc2L/P6ygoKmO1ttbC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760019678; c=relaxed/simple;
	bh=hnQ43mlshaBsbrJ9WaCsfGbLahodDXpvt7Tbh9YbALw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WswX4PaP00oIVpRD8j2iHVFRYzN6CCdWXxBp3ImqfJ9+hbfbAJ0EVBXAqPaL/5ufwXIBy4sRwSHrllCRBthEPQcvySoao7Q7HNcA+Y/zmhC0ImtXM/VE4VGtoY5kTjkgGfzK16w8eZkXXvu4wUWGZsXaktBtK5NRmT7XpCstTuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mjrV6+yZ; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-71d5fb5e34cso15160157b3.0
        for <linux-ext4@vger.kernel.org>; Thu, 09 Oct 2025 07:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760019676; x=1760624476; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hnQ43mlshaBsbrJ9WaCsfGbLahodDXpvt7Tbh9YbALw=;
        b=mjrV6+yZhrWbga7FoeFg9w2MGW+rJzOnqhXIPT0fm7q5FpGS7K8cYSlrOpm/Ewf7lH
         KNCFRLRYbRUvwPJgwM0+EOWBEeNbvgW4ABpAyH+2MSZTkZzT+eWXynBnCy9Ka7R9juy4
         dxBkUHrDR65mj66xWU6CXLRqBILr3A4KAPs9eonf2weWiVh0qMvEWsS2JjN2f1iviHHY
         5bbqzRlJggEYc/BMsq5M5fw0IeDJ1m6/dFKpDq4gxZ6iT3WqZQ6+PkJOocaoOft3S/uN
         PBw1z2ZOX8hVndHrW9cwSVSpfiJnZN7ZSksCNoMScoxYIJCS39DPHk1LLClKEYnt5TX5
         lD2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760019676; x=1760624476;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hnQ43mlshaBsbrJ9WaCsfGbLahodDXpvt7Tbh9YbALw=;
        b=fV+Hh7PgwHzoVoTiFKgnGsN2xAPKf39Ani7XzvYf/M90J+n9vR3SvT2B1RYFkk9TA5
         Bj/QvcdSMSyCxngOuSabqU2FOuPJO5l3Fjf7LrdhtAxqqPPj4FMnA/0ZSnX5zXYBG63C
         CvaEbP9P2yJtShpf6TajtC+0sRYNlVVa3nTcSArv1cCdQdUwIdagDuGSVjph8JpsF2Uq
         8zHv+pq+Yddowk486aC6OzTTMm8bqmSHMkwwDIMuWfT/cujlmjuJxcK28hyQATM99Ipx
         ZdBmdxGfOM03sbKFQNNzqwtke44hP1mca/2k6VE4Ml+kg4kkPWSPlaSWqJRkJOUP0h0O
         mhqw==
X-Forwarded-Encrypted: i=1; AJvYcCU3ScuJzS6yUK+Z3edWYOqjIpU0LpbE/H4UYAjwwQdkq1RxhtZ0lcKgYIj61cngKI5dBcXASbkSdEFa@vger.kernel.org
X-Gm-Message-State: AOJu0Yya+nQx1nDhzRFNiYA/PzI/69sjRfrLz7tvtsn5OiIAkNHZyo5r
	Ok43TELplBR3N1DWXEvHfcQ7U8I4mP+dpaOC74FvP1fv7YE6UhmMKfFTwIjImg==
X-Gm-Gg: ASbGnctfLaSRfZG2F/AILVe/zGlUzzctpNST5UZ1MGa5dregCrlRjk2v2Wp8oLYIqKo
	iKzSxTZnMzPTupQDLllKVGy48vO4scfo9O5g/Znq6D7Aa0GvIoDsjhGSu0+yL1TBepN9uMPQWAS
	Mr7ogYDUSoLCN6UmTjMFbB0P61QNxlE8OziKWhfMFU5EwuX26d0JF+hdlDRYLzlQYfY4kuutfsp
	9uRPH26a61EDXYitzUX4bwlgHLP6ds8hSqnBfWKpwNXTWA7s1kvGEXaxUyW6nsl3TXYfsxheIAu
	Iyqs2mUE1mON34cc3P0k7PJ5lWn0KrzmIAcY1ebJTaP6H7xbD4L8DD1KXv5YC9/zRuuq9kjL8oY
	fIqyY5r8JAhb4ygdVTdV/6wsXccq1D+4oC5vHzWKziwxDNUsiity2Bx+70wYGkLYOgqCxchJR9r
	aLfg9uA6WndwdzwQbdy5OSbWwhggond8xx
X-Google-Smtp-Source: AGHT+IGzX6tbZi0SUPeUfevUi8dyQ6CO14lnhiXYQ9QISYSYIOi8LIwUJKcnCAIMieqG5lf7wh/wgw==
X-Received: by 2002:a05:690c:1e:b0:71e:7a40:7efb with SMTP id 00721157ae682-780d21c1a8fmr154320987b3.11.1760019675301;
        Thu, 09 Oct 2025 07:21:15 -0700 (PDT)
Received: from ?IPV6:2603:3020:2605:c100:7869:56ea:c12e:3c81? ([2603:3020:2605:c100:7869:56ea:c12e:3c81])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-781016bba20sm1629907b3.24.2025.10.09.07.21.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 07:21:14 -0700 (PDT)
Message-ID: <dc942235-bf65-4841-bc1c-b3c66b39498a@gmail.com>
Date: Thu, 9 Oct 2025 10:21:14 -0400
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Fix: ext4: add sanity check for inode inline write range
To: Ahmet Eray Karadag <eraykrdg1@gmail.com>, Theodore Ts'o <tytso@mit.edu>
Cc: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
 syzbot+f3185be57d7e8dda32b8@syzkaller.appspotmail.com,
 Albin Babu Varghese <albinbabuvarghese20@gmail.com>
References: <20251007234221.28643-2-eraykrdg1@gmail.com>
 <20251008123418.GK386127@mit.edu>
 <CAHxJ8O_HF9cy5mg-W77M02E=WHrMsSOTmyxZYogUut3jJgEyFQ@mail.gmail.com>
Content-Language: en-US
From: David Hunter <david.hunter.linux@gmail.com>
In-Reply-To: <CAHxJ8O_HF9cy5mg-W77M02E=WHrMsSOTmyxZYogUut3jJgEyFQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/8/25 09:40, Ahmet Eray Karadag wrote:
> I’ll review things more carefully before sending any follow-ups.

Hey,

I wanted to make some suggestions for you to do before sending a patch.
I recommend using tools like ftrace and the old classic printf
statements to verify that the code is doing what you are saying that the
code is doing.

If you are having trouble with the less intrusive tools, you can use
kgdb to verify your own code does what is expected, but do not use it as
a final verification because it is too intrusive and changes overall
kernel behavior.

Let me know if you are having any problems or need help with something.

Thanks,
David Hunter

