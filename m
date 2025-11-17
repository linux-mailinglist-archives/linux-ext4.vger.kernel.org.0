Return-Path: <linux-ext4+bounces-11871-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CE977C63580
	for <lists+linux-ext4@lfdr.de>; Mon, 17 Nov 2025 10:51:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 923CF4F4BF2
	for <lists+linux-ext4@lfdr.de>; Mon, 17 Nov 2025 09:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58915329E75;
	Mon, 17 Nov 2025 09:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/wvwEwh"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880E8329C7F
	for <linux-ext4@vger.kernel.org>; Mon, 17 Nov 2025 09:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763372409; cv=none; b=Vcye2wEyHCS0PC/nybYKPaQinlINbK8F/RO0+iJwp4e6SPnSVPUQKieZkgPi5fPUWVxeGIXx1spbhJCFKGxugstVkFP64GKerGJDXGwq5ehw50HQ/E66C3jn06jLmMyBl3EzdDIeo4s7PfKxoRSTAWVqr1DOHCi60bKZq2Ln/UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763372409; c=relaxed/simple;
	bh=+wK4zO5yMO1Gt4dqWBTqmkJzYrRGYXPOBj/a8O2gnDM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DwiH3O7DpO7dsPc2533IjGmiVVm5NMKp62TzSXOZDJq3KWlbZndOAr0s54rIqfFKUF62khNGwv+Sp/GQzvxRov6pn4EUx8kmePyeIUUizaYOZXv3TV8VAl4sR/qnHALFYiPPXLLK56Qz4iOynHsv7oq35IiE2H4I3INqbGLpymo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K/wvwEwh; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-6420dc2e5feso145773d50.3
        for <linux-ext4@vger.kernel.org>; Mon, 17 Nov 2025 01:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763372406; x=1763977206; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZPGy1ecBWpzlobuZOUWTcQe9eNhVaWselDMe+YM9UKY=;
        b=K/wvwEwhyuOngu8JK4aoaqWn8EagHreMEb2B5Qz66XgvEAqde2x2ZJMBPJDYwhFwBF
         7HFIOtNrTAuo47GZkObLzLV8YG29TUDR/2wNO1X7U9SfB5kqlpM/a9OhXpbOJnS/oYVk
         hyDZp8qe3IyrfjqUVhO2eirO1uAzoAoKHuf2txNzQgCMqcl7Osm99ZNCoR8pFWpQlErl
         ZfshPVYWWuJcaiao75idNqaGw3iyGOil5AH/UD22PrWNtDFrIZTGLS2bCigdzbkE1gE8
         TFaRRibzgeWF4ht0cgfTlYDArT80ebEeZl9UBUWFZYCEDcVuByvUbIshu+HGsDntmy7y
         X8lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763372406; x=1763977206;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZPGy1ecBWpzlobuZOUWTcQe9eNhVaWselDMe+YM9UKY=;
        b=eExY2Ww7ko7lHxzGkKWvudjAnxjsSr6jHOc+MZD/5CMmS0D0MGtkz2aoSmUqvZrn19
         1Qy+wsLo9BFK0IHjkrFfEA2NBfHCqyWeyXoUhh3QL/V8vyG4WqmbFxcMKDHAPK4cTqGt
         ThOruFKviIFErznVj30MdkWuH70mRpDCGGq/vWSJR8GdjFQEkkPM4S2kvU9GWtcIz3Rj
         qrNMEq8+iqZFU998SUr31QJmWPLoU1Q9MuehD/mf6dttv0ZL3SezFzaDBWIeXUQyTsJh
         4s0Ov3vY0qwVIRogAUXRwnUhIYpNWDVJN7AyDLttIYRuQ9L9cDylhB/GoahI9CJRbwUO
         4IFA==
X-Gm-Message-State: AOJu0Yz/fwVeRdgUXe4b6vHHMzc0G+SGWsw01fXxL24CdAAaqiE+2ImD
	yNhZbe2lxHgTqHFRsaLQYOMiC6eZwSUtmKqt5JYoiy9R1TFManN7yrCy0spcleop327Crb51PXH
	tLYtwqJBqq2Uu2m9zBNWayT7HSRi/9so=
X-Gm-Gg: ASbGncvYx/MtMks//BfOnCMQ/GItLh6gjGeA2yRBWnD2x4JuisCKdU1RA6tTFU8piy7
	LkMESMCJsHl79hNczyQ2+DR5lZvdBTdhua9cQ//D0rMY34LpWNOMIUuTkAt0a90FJVMkCM9u3kA
	48xv4R50OSZK394IJCoEwHw7WLvuVyY5B73u/F/NoC3XsgVeBGtCsQx6q/kX8KU9iceXFxUdlS1
	cu+pa6PSwXY68tzSDB7YqQlGHMGLfywyzD+QVi9ZAMdL8fNOVQr2mHkbsxWb/JiReNmQ10e3Zfe
	rWOTLS+DtOUKBHhXuJ4iWMFyA1a5
X-Google-Smtp-Source: AGHT+IE/Ick9yn3JUsaEa4bOGPgyEQ6X1+Gih6AelLMoumYXYOdPhdvif8R5V8JZllYojg4HswYjjjm3LL8en1bbWIU=
X-Received: by 2002:a05:690e:15d7:b0:63e:30e1:4429 with SMTP id
 956f58d0204a3-641e7626ed6mr8436751d50.38.1763372406399; Mon, 17 Nov 2025
 01:40:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020060936.474314-1-kartikey406@gmail.com> <CADhLXY4GzRDC0ReKwhy50UAfwugvmBb5ffsuCQG_7GNDk3NcUw@mail.gmail.com>
In-Reply-To: <CADhLXY4GzRDC0ReKwhy50UAfwugvmBb5ffsuCQG_7GNDk3NcUw@mail.gmail.com>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Mon, 17 Nov 2025 15:09:55 +0530
X-Gm-Features: AWmQ_blHsp2VtdlukHEUqzaoskc6v5o7XL_kjSQbBOnAFWrNwkfDmE1AKk5ymno
Message-ID: <CADhLXY7LqHg8V8BEA1UZOhTP=Y03ggORCixkGSH8rityX=TLtQ@mail.gmail.com>
Subject: Re: [PATCH v2] ext4: refresh inline data size before write operations
To: tytso@mit.edu, adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+f3185be57d7e8dda32b8@syzkaller.appspotmail.com, stable@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

Following up on my patch from October 20th (pinged on Oct 30th):


Patch: https://lore.kernel.org/linux-ext4/20251020060936.474314-1-kartikey406@gmail.com/T/#u

Bug:  https://syzkaller.appspot.com/bug?extid=f3185be57d7e8dda32b8

This fixes a BUG_ON crash by refreshing i_inline_size after taking
xattr_sem, similar to commit a54c4613dac1.

Any feedback would be appreciated! Happy to make changes if needed.

Thanks,
Deepanshu Kartikey

