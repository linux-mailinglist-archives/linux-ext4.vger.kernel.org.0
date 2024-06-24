Return-Path: <linux-ext4+bounces-2929-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1802391404B
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Jun 2024 04:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E9121C21CBD
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Jun 2024 02:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441544A2D;
	Mon, 24 Jun 2024 02:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maticrobots.com header.i=@maticrobots.com header.b="MclAWsTW"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852F13C28
	for <linux-ext4@vger.kernel.org>; Mon, 24 Jun 2024 02:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719194648; cv=none; b=hiImQkiRxkaVd138+QblvE8PFz9SzL8xJzagAxRaoGiZKimE91LsvgrwJQ/S7Zm5Ea03XKDq+UcOjv6enLGkyc7uW7EzdYPsiRi3aNklJ/R7S0UA3k/PjAGi1javG9kIVi0xYq1o4BlyUG8GvuYxN9ff8cTicBYCDxPvJNKrUQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719194648; c=relaxed/simple;
	bh=bhQexe9HQ1tYTBwABIpEVcllLrmE4nxu3yrfIRNM1Ew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oxlNwlvuNx3GL0XFj1zLogWpqpaNe8P6lSaxxgzI15GDMuKgPSlJfApG/4dD6P8HMKxOX2ON5oprvwHBg3glpwoH/SJRtZHkRYS3Al1dGunLl+B8d5uWmoMGmIN9AoQKfmRdFjI/QlHdXjhr0T4beSQhAZtOSg6lcyOUa7Q74p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maticrobots.com; spf=pass smtp.mailfrom=matician.com; dkim=pass (2048-bit key) header.d=maticrobots.com header.i=@maticrobots.com header.b=MclAWsTW; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maticrobots.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=matician.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e02e4eb5c3dso2744990276.3
        for <linux-ext4@vger.kernel.org>; Sun, 23 Jun 2024 19:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maticrobots.com; s=google; t=1719194646; x=1719799446; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bhQexe9HQ1tYTBwABIpEVcllLrmE4nxu3yrfIRNM1Ew=;
        b=MclAWsTWLxxRjy4u7Qnhmcb5XTtcxvCYugrTJpZ7S5jmO8sq1FAWWACt5vlVqGmqHi
         yfiit4dWBJWYGxNY5ANxSaqN+qqPMFjz2mQ5Ws1m5CFG8Ux6SgTeev55D4bjfl66i/Sp
         +l7GoJdc38Q+xB1qCkgFqa7L8H3mGB6PNHIu4fmHb8VwUSNw2JHHfZ692CsBlLXVvk4X
         V/ltm7e/3kE3veFKA9DLmQtq+D5KIewF2mMnV4VoXvJgm3DnP1fnpsRLNtrpxc05vhfZ
         S/VJ/GkdMluwPO+IpMrstFKRZ5cukq+IBRDAMB1ZaYr5/NDwGyDamGkZ1zSmNNcFpMJk
         Stwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719194646; x=1719799446;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bhQexe9HQ1tYTBwABIpEVcllLrmE4nxu3yrfIRNM1Ew=;
        b=hDujKGj8i4Y5Ipyn0HavOmecawQgcylIWFXY2TvtmC7Y36Q8t+JDXEll+UV+rhF5n3
         bZD1dKO2/9pupXvHYINdLAhpbPW2j3XV1KtBgUXKOLFTA1xWG7JjEAIybg4mfXcqhE00
         xsOxhYKpRTb58BtcmhDqi+bsRdPlgZMdgbOmqCO2LlxXnUFJJa8eipLxZce2z3zC7m4g
         PXws4Mu7+LcqvbOWFHZoyk5oI6alor3M79ZxpY36L2c0QG0uWEfugAXCxWE4qqisxqPa
         am5Y2hQif4lAwo3mhjKcw58I36ViJxoU2CJvjBy954zYitrsB1vb2j0dO8IE3l1KcgyP
         L2ug==
X-Gm-Message-State: AOJu0YzYUBS8UnAqD2s/bbOcfNP7GqStCplwxBHeh1Yv95rQ+SaO2i84
	9a0CQVzYqizOaXq7VwBFZy7PCM3MERPnfhYhpKCHd8hANzsb+5VaVITKR2trIZgthK1sc3OmmC0
	7+B4RLxZGULTbGo/fnsI13KZysdvbFwmrq+Tjc1Y1kqh05ZmBHC9spw==
X-Google-Smtp-Source: AGHT+IH3CEbJTidGwTmSSlYlGVYozH8HrS+6fLtHzmJm4NAvVkbYSn8L1T+U/0kg28tt9koMI9Aght+HlGvoarFeN7k=
X-Received: by 2002:a5b:d4d:0:b0:df4:a607:2429 with SMTP id
 3f1490d57ef6-e02fc350b15mr3955751276.45.1719194646368; Sun, 23 Jun 2024
 19:04:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+hUFcuGs04JHZ_WzA1zGN57+ehL2qmHOt5a7RMpo+rv6Vyxtw@mail.gmail.com>
In-Reply-To: <CA+hUFcuGs04JHZ_WzA1zGN57+ehL2qmHOt5a7RMpo+rv6Vyxtw@mail.gmail.com>
From: Alexander Coffin <alex.coffin@maticrobots.com>
Date: Sun, 23 Jun 2024 19:03:50 -0700
Message-ID: <CA+hUFctSB1wT+du3FROhF0cG+9gWTBn6L_odWjYDbsYQsk5mCA@mail.gmail.com>
Subject: Re: PROBLEM: ext4 resize2fs on-line resizing panic
To: "Theodore Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.com>
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello again,

Sorry about the quick follow up email.

I realized that I alluded to the following in my initial email, but I
realized that I forgot to directly address this issue. If the
partition is resized when not currently mounted it seems to works
fine.

```
root@debian11-vm-acoffin:~/tmp# gunzip ./foo.iso.gz
root@debian11-vm-acoffin:~/tmp# resize2fs ./foo.iso
resize2fs 1.46.2 (28-Feb-2021)
Please run 'e2fsck -f ./foo.iso' first.

root@debian11-vm-acoffin:~/tmp# e2fsck -f ./foo.iso
e2fsck 1.46.2 (28-Feb-2021)
Pass 1: Checking inodes, blocks, and sizes
Pass 2: Checking directory structure
Pass 3: Checking directory connectivity
Pass 3A: Optimizing directories
Pass 4: Checking reference counts
Pass 5: Checking group summary information

./foo.iso: ***** FILE SYSTEM WAS MODIFIED *****
./foo.iso: 2321/7904 files (0.2% non-contiguous), 18945/32769 blocks
root@debian11-vm-acoffin:~/tmp# resize2fs ./foo.iso
resize2fs 1.46.2 (28-Feb-2021)
Resizing the filesystem on ./foo.iso to 524288 (1k) blocks.
The filesystem on ./foo.iso is now 524288 (1k) blocks long.
```

Regards,
Alex Coffin

