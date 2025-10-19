Return-Path: <linux-ext4+bounces-10968-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD63BEDD7B
	for <lists+linux-ext4@lfdr.de>; Sun, 19 Oct 2025 03:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0DDF74E27FD
	for <lists+linux-ext4@lfdr.de>; Sun, 19 Oct 2025 01:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6441018DB0D;
	Sun, 19 Oct 2025 01:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IfEqW8p4"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF527260A
	for <linux-ext4@vger.kernel.org>; Sun, 19 Oct 2025 01:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760835910; cv=none; b=OB9G8pTSQ2ximGqTSEZ8ETzLm2cog72ZshfN8KmWPEH/XW+6t6tpBk9KxH9mdDJgQ5zrLeW45JXGWdefJY71A9diuST+YehOlrDTTQBtYyoqtaYwHONFHQX/qAO5mn4B6u62Cq2ORYDI+XGOAE2DzC/6mghcy2lTbqQs5pwYruM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760835910; c=relaxed/simple;
	bh=slM9aoKA3Xp62bTaKHhzG0+cP/ySgGia8B2eX4rEERk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HljegtrsSh2h5GnT1WkqEA3+5majY8HFRUI/J8jLpUbmN1qLrUV/sKyMfSX0CAM0LHhTvfS8GZR6i9bZJeGuU58XENJAgXpfPXVKL1W8QiouAQkBeMhm6Frc0MHL/F+gAMzKjr8w83dGMdFgxI2I7o1WIc8T00xILlbZ/5t6xuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IfEqW8p4; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-781da6c1a37so37457377b3.0
        for <linux-ext4@vger.kernel.org>; Sat, 18 Oct 2025 18:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760835907; x=1761440707; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=slM9aoKA3Xp62bTaKHhzG0+cP/ySgGia8B2eX4rEERk=;
        b=IfEqW8p4kkGTgdB8pwj9FRHJOa3k5c4LzI6Sfnq6kdHZhxqSzDw+bz8tzKqboJeKf8
         pImBEcJRWMj7YC/xt0N9uL1ipSSflSx7CXpPMCeK1oFMnShPgbovTKKc/cKkwrwqmBNF
         S53Y2XAKwfpJ4jjPBYDTWywV+STn++CDb6n6ZZ14X9Tf5clJfyUt5CqtSFEHN/VLXIYC
         fA1HTyKHWnrC4BSqZhQma6W9VH65YgSpon3beY6ROGoSFoRMU/8x7Ur8UXaHRlAHMaLx
         riwrAzikUz65I9WyPE07+trwu//6RayQDyIOUnQyCY7bwQKzJC52fnIbiffFLDm5zOPA
         FU8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760835907; x=1761440707;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=slM9aoKA3Xp62bTaKHhzG0+cP/ySgGia8B2eX4rEERk=;
        b=of4+sYz0KUp7Sgzw2uINXoHCVhgEbzrs5yttiLBbwYdHT5OQiG/eCveVUKJVPUWXRZ
         xcWV7NunzLj7MO+TEEId/f+qkRDAWbK5r9lsz2HeFAo1dWwD6/OJ4ZaxpLXI+dA0nPWX
         apDhhF8ob+wxWPF7wo5MyJ1wL1VcwDUvzQn151rgfh8DQek+SlSEfR7IXP5Nj8E6mpc5
         QMAshKZ9I9KojKh7ufG1uUuOc6CKdLJAh6xt6bGG+W+82GFlIgp8+x8KZ6TfvpwmYeH0
         YGFTlnwnnJ2sHSGSh8yYFJkqR17DPeh19Tq/9+Rb45kDPgt0nV0RhgOjaFD2assmoyH8
         fsFA==
X-Gm-Message-State: AOJu0YzaPLyuAJGaeUTI7zrh8K4ivdnMvPR+Z6rLEGtYJdsDihEitIu0
	3lDGQ1sDHnV+tHhCu1+I2O140F27XZneEKfH2jYVTM6e9Is6Jk47GTB3HlfvwtTNN5WWnagBd7X
	berkmcNO1lYKuJxhapqg5Xa/03e0YvCg=
X-Gm-Gg: ASbGncsc/itJWS6IeVMSYXTmvMVCcZKlUgw/9nJ8jiX8ZH++RNV4TpcbDye1OP6doDd
	mTGkxsFmBfYF/yiElAHSpLGm2Akz/ehZpvNGVcLSb3vT6Y1iuSgLnr6/Xq7l1GzGUqrFHKnh4Yy
	F6mZqt2I6cXRqO6YneDKUDhuhWG0sTP+rkDLYHV8jfOJotwNN6jo06IWtLEshJyLvAX2y4NF8NY
	9goMhq30OaG4klZuAOj5wKqAqGJr7LHCvhU+5tXvBMFJhTXhihWxvyTStGWtBDZiQNo+NlNAEMo
	Cn526w6trDSYWXXm5umUsSDNmYcTQy8m67Os+USWcc/UqtxZHbT8ULi7+Eat
X-Google-Smtp-Source: AGHT+IGQUGouugSUTq3kUUp3fedwi54W7X2mGDpIFyPj7e34E6vkmlTZ2jjANkKLxtGL8Q0Ilaq1xyJ5JaLL6xK2XlE=
X-Received: by 2002:a05:690e:118d:b0:63e:3011:58dc with SMTP id
 956f58d0204a3-63e301159c2mr2061231d50.20.1760835907439; Sat, 18 Oct 2025
 18:05:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251018161606.412713-1-kartikey406@gmail.com>
In-Reply-To: <20251018161606.412713-1-kartikey406@gmail.com>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Sun, 19 Oct 2025 06:34:55 +0530
X-Gm-Features: AS18NWBmQggENSF5mjmhuiaDooacbBWEcJg1eA64gNZsVLF-505iPGKUY7QFZkw
Message-ID: <CADhLXY6Wpq_7R_prPYkiY4z2=VoU7=EX=8oofRiBRCUktSUVkg@mail.gmail.com>
Subject: Re: [PATCH] ext4: fix inline data overflow when xattr value is empty
To: tytso@mit.edu, adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+f3185be57d7e8dda32b8@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

Hi,

Please disregard this patch. This patch is still producing an error. I
am fixing it. Will send the new patch shortly.

Thanks

Deepanshu

