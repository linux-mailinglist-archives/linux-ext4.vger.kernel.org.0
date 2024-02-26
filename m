Return-Path: <linux-ext4+bounces-1391-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C813867A2C
	for <lists+linux-ext4@lfdr.de>; Mon, 26 Feb 2024 16:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D86F1C23146
	for <lists+linux-ext4@lfdr.de>; Mon, 26 Feb 2024 15:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B900812BF29;
	Mon, 26 Feb 2024 15:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RyguRwkX"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9053612AAC8;
	Mon, 26 Feb 2024 15:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708961148; cv=none; b=Jkzf8IyQgLrONUL5PWNz57EDebqnRMVA+Fdqz4QvwRuiGzIDXWLoc28FYF5M4C2NRcieSgR9GKnVjo6muNXYBtH87K4kYhM/pelKQITmzLdnZ0aOciwJ2Er0Pz2BZ1Zc85u3c+bfkwsXlhKgUcdNfBCietdB1lZPmMOBYyhyvD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708961148; c=relaxed/simple;
	bh=35PpGcNElBfhbkjp86sPv570xrDAxjARvJldXaJsLJ0=;
	h=Date:Message-Id:From:To:Cc:Subject:In-Reply-To; b=uFX69m0RQt2C30j9CeVFbUTqkY0q2MUVMMtbqx0p9XqM0aN9W3bjaOgOfgJhVZoU77KvtviJahfaOlgcD20up93bbmdubXp9vMx78jaZu9LIZZrig1KrCfk/GDP/Nzjt0DThfL44ttCwvGyQC0KPRmMj7xXkpMeJUJeQsJNIdj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RyguRwkX; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e457fab0e2so1932924b3a.0;
        Mon, 26 Feb 2024 07:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708961145; x=1709565945; darn=vger.kernel.org;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=F8NKzZ475Ed0sOpYbcC1ZbHtZtsQL/sozjb3F+5kRmI=;
        b=RyguRwkXkeDbLi/gmyI8h8saaDb7mBBb8kXslI4rV5y4KqpCGKtU8CT6VAoxfQ4g2X
         ysr3DgPY+fanh3NAhHE7GB233tSo5nshJpIhrSOOtLZyHjQ5UQHrQVo//H5Mo4L5lX1j
         4gSQY1+PDQasmv1JCjKHCqvpeoJ0mUzPyArHu3rYm7t9uqNTfRipvoenjOg8yDwABdhe
         Gvk6t273TQyyv/bSTJ4at3638qTKxkrLI1G4q/wmHVJg+jD/AAPVuZErdcPwJtg8Phcv
         /2ehxB5EdKiPwimFC4pr0TTX8jmKYQoK4Gi47dPWIzcPq10ozZg6O02hdp9DgXa4hTAS
         jzbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708961145; x=1709565945;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F8NKzZ475Ed0sOpYbcC1ZbHtZtsQL/sozjb3F+5kRmI=;
        b=kt3PAKtaFqpCIWneyRXzsMVLt84QBG9a+7FrsTKPfmSXJhylkftiT1q6vDIm/D6d5O
         2dDdtM1LHXLO9/vIxFMd+ojh5onROdc/90P0Pf++574nkinyUrgarr/bFqm3jWxmNoPx
         KpcQvM5x2sOuv4gkP48eya/Y/LZH1KISpkVu36U0gy6a4ft4hgONx773gv2UR6Y/LMYz
         AeTx4rf9ddhsJP6p7tBye8FXB/c7yc2kGlWkruQwg1/FzLVnLphazfAjAmJBsq81Qyik
         0bzviE2IOatJ3VU0iw8nHj3GkFoXOrvvanF3aSb5kbf7EQ4PMAW7us5NzQNMO8IZCYv+
         18UA==
X-Forwarded-Encrypted: i=1; AJvYcCXk/39xpRQehujapChuotdGNyD0KXJ9oj2aj1JCoiHsPUGA7ST2ad5e00CAMIw/RBAjSOZKFfKvKO+8L1FNtJtpE/CedVRy5jPr4Ik32dN6K9q3gHq41xz4OlgDyh9gvkDaQcBWZnfZuw==
X-Gm-Message-State: AOJu0Yz+AMHnDKyp9ofKLzQB/YtRJzPvYzy6PIisCmxsVH3jFXJIKuxw
	4pAfQ9PGAwMa5vUFJY2D+gucsdTBT6IG+JtZXJlRcKdOEC3d/CDW
X-Google-Smtp-Source: AGHT+IH7O66PS1kSAdFwBUsTZAkLBVJQ014OLt0Vyy8s/hru2LcBTua4x8Y9mwKONnJDFaVy1ImQOA==
X-Received: by 2002:a05:6a00:a0a:b0:6e4:fdb5:fd99 with SMTP id p10-20020a056a000a0a00b006e4fdb5fd99mr6690577pfh.5.1708961145032;
        Mon, 26 Feb 2024 07:25:45 -0800 (PST)
Received: from dw-tp ([171.76.80.106])
        by smtp.gmail.com with ESMTPSA id r11-20020aa79ecb000000b006e484e13454sm4170729pfq.32.2024.02.26.07.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 07:25:44 -0800 (PST)
Date: Mon, 26 Feb 2024 20:55:40 +0530
Message-Id: <875xyb1c3v.fsf@doe.com>
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Wenchao Hao <haowenchao2@huawei.com>, Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: louhongxiang@huawei.com, Wenchao Hao <haowenchao2@huawei.com>
Subject: Re: [PATCH] ext4: remove unused parameter biop in ext4_issue_discard()
In-Reply-To: <20240226081731.3224470-1-haowenchao2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

Wenchao Hao <haowenchao2@huawei.com> writes:

> all caller of ext4_issue_discard() would set biop to NULL since
> 'commit 55cdd0af2bc5 ("ext4: get discard out of jbd2 commit kthread
> contex")', it's unnecessary to keep this parameter any more.
>
> Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>

Nice little cleanup. Feel free to add - 

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>


