Return-Path: <linux-ext4+bounces-2575-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE85C8C9264
	for <lists+linux-ext4@lfdr.de>; Sat, 18 May 2024 23:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DB2EB213D3
	for <lists+linux-ext4@lfdr.de>; Sat, 18 May 2024 21:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C62C626DF;
	Sat, 18 May 2024 21:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="A2X89Yne"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55BE26AF2
	for <linux-ext4@vger.kernel.org>; Sat, 18 May 2024 21:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716067176; cv=none; b=eYThNZtVp94L5RGmYDV+fh8WkUeO8XcIH7S1hzmJaldGuy/f/+V7Fr7Oo3yOs9/23cBPZE8LRmiqWkOQjLlpklmHvpb4QDO5VrEfFbNmgoRD+rvHXompDb7O5UDIf1byHSEEEaONyi18NewX8ysD5HNTOBxpXTQEaUdDI+Enk8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716067176; c=relaxed/simple;
	bh=y4kdoI/Al9pfC5vOqP4j01zfH6Td4FBolYQ8ClWVsEQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a/OjaNQK0ZwSeIgGq3a8V6lbwIh0kBKvfMfrENyQTBu6Tmtb7ia/niNtDNEwxCKV1clC0E7xiYoIiq3T2fFYP3E5vHvy5VJOrTSOZuTqWwke5G7c37ccAAZtnsDXQcN3N5zZhHanomFF/9PPH0fozAgdjpvtq7nXOzZ76xAhmuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=A2X89Yne; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-572c65cea55so10149413a12.0
        for <linux-ext4@vger.kernel.org>; Sat, 18 May 2024 14:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1716067173; x=1716671973; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hqFGMDPEvV5FyIcRDEwYmBY9ZJrGM339WB0RNPHgt+w=;
        b=A2X89Ynev7BLmxGWTUvpG8PkNzfQHSAJ+KtXq52Yzdazjn8//DxKoSTVkr7XIunkeG
         oRNYw1JoEwg5+XY0TyjfiR36+NJIoP/VUJXUxOH8mtSefA1KOcnoRyLVjP4+CI3+x/Co
         iSsI/ilSwXhoKRChg9LCPey64Ik/faGt+rYmk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716067173; x=1716671973;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hqFGMDPEvV5FyIcRDEwYmBY9ZJrGM339WB0RNPHgt+w=;
        b=jMomQI0BvE4La7OIOOOQa3r3uDr1MueepqRR+iNNQ9OznLcLRsGsDzfYAetxcJcvPA
         IohSQsvkLINquUMmdGVcyaUxv15lJnOQoV+H5vbdKizRrgb1kwOQbv8KLPwp1t8X3K/d
         wKsz7kVWmk2PldFG1rXmQSURaQokOnQfgWmL3t1Da5EN0ipcfBmqHN2jKzyCeQwx+osY
         mDc371SlEeZ8jS7jCecRtO2hc747lcUJoenHxUFwNZGd/6+wDMzjjmHVFlX1C+cbCL/G
         P8/y5M28W73YAqH2Q3c/OJonS3VziC7SKYF3joY4FxGpmDXS5Vl7i8G7FF7Kp2cVn2rV
         /uhA==
X-Gm-Message-State: AOJu0YxnaKRV/JwjXSFI1DbbI6EG5i26C+2hxt4/rqdTSp23bkUc/ZQm
	HlxIZOkP57OEtYUPZbFCfmY8Ec0/4mSLqoQ07JXmCx4ZCNiBBGsc73O5ThHOrKDfMemF/nwuSE5
	j2CtsKw==
X-Google-Smtp-Source: AGHT+IEVkSeb7ov+EoiAsYS5KyPxOvl+ZfWQu41CmWgZMXz39oZhisGYmFwntE/gnnAhub8xlsqw2A==
X-Received: by 2002:a50:d61c:0:b0:575:2a03:8ff6 with SMTP id 4fb4d7f45d1cf-5752b4c9117mr2150175a12.16.1716067172907;
        Sat, 18 May 2024 14:19:32 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5750d24c8c1sm3361086a12.72.2024.05.18.14.19.32
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 May 2024 14:19:32 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a59a352bbd9so828622066b.1
        for <linux-ext4@vger.kernel.org>; Sat, 18 May 2024 14:19:32 -0700 (PDT)
X-Received: by 2002:a17:906:234b:b0:a59:cbcb:1cca with SMTP id
 a640c23a62f3a-a5d59cbf185mr211918166b.13.1716067171988; Sat, 18 May 2024
 14:19:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240518044601.GA478319@mit.edu>
In-Reply-To: <20240518044601.GA478319@mit.edu>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 18 May 2024 14:19:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgPpNkBikDhCVOciA_bs9SkHH7XakdT0DbknFyiR_4HTw@mail.gmail.com>
Message-ID: <CAHk-=wgPpNkBikDhCVOciA_bs9SkHH7XakdT0DbknFyiR_4HTw@mail.gmail.com>
Subject: Re: [GIT PULL] ext4 updates for v6.10-rc1
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Ext4 Developers List <linux-ext4@vger.kernel.org>, 
	Linux Kernel Developers List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 17 May 2024 at 21:46, Theodore Ts'o <tytso@mit.edu> wrote:
>
> Note that there is a relatively merge conflict; the relatively simple
> resolution which I used when running regression tests is at the tag
> ext4_merge_resolution in the ext4 git repo,

Heh. That tag just points to the same commit you asked me to pull. I
think you may have tagged it before you actually committed your merge
resolution.

That said, the merge resolution looks trivial, so no big deal. When
people send me a suggested merge, I usually compare against it just
because it's cheap insurance, not because it's usually necessary.

But you may want to check that I actually did the same thing you did.

             Linus

