Return-Path: <linux-ext4+bounces-10343-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18773B91C9E
	for <lists+linux-ext4@lfdr.de>; Mon, 22 Sep 2025 16:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25E841894DEC
	for <lists+linux-ext4@lfdr.de>; Mon, 22 Sep 2025 14:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5BB2737E1;
	Mon, 22 Sep 2025 14:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qVdqvJpa"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD331D63D3
	for <linux-ext4@vger.kernel.org>; Mon, 22 Sep 2025 14:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758552393; cv=none; b=VVUi0RrJSqnZ08Tw4swt8z4Y3c2nYEfouR8X+XKO0XqK/3LtbJgI/9OmChvSvTRjsKfiRJBtcACXzcvqBZdzrgM4GFiiQ7avoxVaF20mk8oqDGGrVPAAzLbuQha92QObznzEZDAVoPakBikJk0HFn1nsfRXLat4Me/bn254P5xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758552393; c=relaxed/simple;
	bh=pKQsTdhZcqsBnDdIRjlEFhx0XiXy0sbR+0FCu5dECpY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fn/YdJ8a3nmTT7VMfdNltSEwTa6TkGaY6h12/0Cos8vIwOU5AvDYqqifcxXdusLCs4nsQ69T65yBmtUPx7ARfIWXJx2FUBk/R6BXSiQYPN5e2fU770S8i/K1j/Y1V8VQpXyRyNl5PfgRgvjpnqc7HkDp7Tt4BmK7479TsFWeCjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qVdqvJpa; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b555b0fb839so276472a12.3
        for <linux-ext4@vger.kernel.org>; Mon, 22 Sep 2025 07:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758552391; x=1759157191; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F8Ic2fBM6im31fe3I5zSKJiDJzniPJ5AeiWfLHUqEm4=;
        b=qVdqvJpaXVeDwI0a/I6IWZV4f24GQBVIzZHXombK6rq0ovNwtZWMC2lde8j5JwtJQu
         m/hMs6gORS+JM3/hlJ8Lp5uPuJBsYyi3bSLfsylV+YVLeh+xCcHpDHSYO576M0LBeN6z
         o9Pr9B4QH1ZYvf494DWDidH8iTFKEZtXjkFUsYek7DG9BQ5DNFk5sNnJuCdwXT1L9mZ4
         cqmz5ODoUCwpAt6xzAQz68O/G9o+JPhv3AzX+z6CX1ppjpA+PkI+LiFWXMAf7dkEr1IP
         NPjJMZ9YJNzCYnDw9xw82nQvXdkvKGX0IFCKKKUa9fQhKV8qWA2fO70t/VKTQQ5JlYt0
         4RTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758552391; x=1759157191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F8Ic2fBM6im31fe3I5zSKJiDJzniPJ5AeiWfLHUqEm4=;
        b=Om9QbxvseK2INmevEQnAMdC5WllvrPPVVwIvBNubuX8qBsS0hvRz/zna4qFkcZ7eWR
         jSNMEltB7Srys/564/JwcYJlViBMGenlVIfuJMj65P1em2ZSub2g9N3CqCcnrL3/P9Ys
         /u/8avhQS44wH1d7IezmeCZN7ZaRu4RaQ3fY8/yrlhG1F/19LcrZ1knRFeuDnLwXyYad
         eR6xx4ePmrKbjImwOM7KHk0PbXhXnp0YJ28sDUlDufDcqZxXmL4buodKL2qRIlFSaNW4
         Wd6fYXi8/nWlSH5a82hco2IHKTaWOOvCJK6lgWKAsZ7aBjr2fIscS0Ll69Y9/SyNtInF
         D5sQ==
X-Gm-Message-State: AOJu0YxQpIBMPPtE95ddauBP5w649ZXXEmpBD3kN6AdOh9Lu2NXTB/KR
	GVG+cAdlaZ4mUNDeu2+Y8LR34Z/qzhI1+2mIYzbwis2QocAxaIFF3tf1kJoLw71TZClHrmGPo4Q
	X1PakWIliGHcZzIZoYAOUKuCbQiofxTvM8cE5sSFLmPdxRj3iBnBT
X-Gm-Gg: ASbGncvTqeHw/j7+6p19pVdEbpI7y2ptw/rQQVZWJSUuQai8IVd0Iog3/CIUf8z6Ltt
	b1xcyTii4rVmfHtEfBpTe1kSn2pY2lAdLAB+OISZEdnM9vXNz7rT28mw9smDWoZZ2/sxzSR5aL0
	hZjne0f8K/v/TLvAKtwelF2U6dx6L9pZ0/fYj1s2JcU9926xiknAJsXhb962rQeG1am4l/dAGHf
	R0haA==
X-Google-Smtp-Source: AGHT+IHbhcVSafYXVfD2p8WPRa+PfO0WRuiFJCurhR8XlcbhwO5mZIQbe8laCL/d4TUm/Q3NSFS4bXkqcVAEkjwWO7Q=
X-Received: by 2002:a17:902:ea02:b0:27b:472e:3a23 with SMTP id
 d9443c01a7336-27b472e3b6fmr19039225ad.14.1758552390939; Mon, 22 Sep 2025
 07:46:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910-mke2fs-small-fixes-v2-0-55c9842494e0@linaro.org>
 <20250910-mke2fs-small-fixes-v2-4-55c9842494e0@linaro.org> <728E8839-CC3D-4316-9FD6-7819CCE0DC07@dilger.ca>
In-Reply-To: <728E8839-CC3D-4316-9FD6-7819CCE0DC07@dilger.ca>
From: Ralph Siemsen <ralph.siemsen@linaro.org>
Date: Mon, 22 Sep 2025 10:46:17 -0400
X-Gm-Features: AS18NWD_-mMUa27AGcGlHr3-cZno5neoc5TRyyrZcM-pO-gE-aT8OyZiyDYcFxw
Message-ID: <CANp-EDZOf1MP-9F_e5zpAe0xd6XmSMDatGcO0rJEGKJYB79jKQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] mke2fs: fix missing .TP in man page
To: Andreas Dilger <adilger@dilger.ca>
Cc: linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andreas,

On Sat, Sep 20, 2025 at 6:59=E2=80=AFPM Andreas Dilger <adilger@dilger.ca> =
wrote:
>
> Looks fine.  I found a related formatting issue with a duplicate .TP mark=
er
> in another part of mke2fs.8.in, and have submitted a separate patch for t=
hat.

Good catch. Curiously, it doesn't seem to affect formatting for me
(with nroff 1.23).

> It looks like this patch could have:
> Fixes: 3fffe9dd6be5 ("tune2fs: replace the -r option with -E revision=3D<=
fs-rev>")

Is it worth doing a v3 for this?

Regards,
-Ralph

