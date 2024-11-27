Return-Path: <linux-ext4+bounces-5430-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF9A9DA1A1
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Nov 2024 06:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D17E628562C
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Nov 2024 05:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2595C13CFAD;
	Wed, 27 Nov 2024 05:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HanDru0f"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F6580054;
	Wed, 27 Nov 2024 05:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732684129; cv=none; b=MIZeKfu2f/qieBxcvdUqILXrWvjgi8R8XjGbu8DdkUGJAmvjpPiDfJeUF7megXMeqirMrsfuzjZkRM63OfCzfcx3mx1TRCp/5eKmqfdd43oZgSNyJMyw/XPh61hmXDWeR8bSNmo2s0hRxvxMzIdQTibSPb+ZCzHzxTFdEbS6eus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732684129; c=relaxed/simple;
	bh=F8cIQiefFyj4CQ+VfJ+Uanmlw/4nbISUiTBum2Pbkro=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=G+uTeNMFHuHnJrsxSW+wROe3LFnsaqRlDGjma8hz8ZOTnE1shbKvoeEaKIG7vOaiQaoPMfych0XnwSfozATpJIGEB/duEPdcThEk1Pc7gzQ6sNJ4GCsMsbhcdHW6J/blrJdOLVnH4/jNQ2v6ccxlMQUSoY2n9gtuH+VkS1Xw7wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HanDru0f; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-211fb27cc6bso62314665ad.0;
        Tue, 26 Nov 2024 21:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732684128; x=1733288928; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=F8cIQiefFyj4CQ+VfJ+Uanmlw/4nbISUiTBum2Pbkro=;
        b=HanDru0fPG+eSRyXVrSOmEOQl6ctBatMX+5aNV3seGfX4v7v2jYzpCsnHidI6xVxnc
         QuXq+iA2GTUYXVvvM2gmy09NraIrvgNnPaCRZzFDnDTkxQhPciPfg1oCdf7EfZ4V7Klw
         2Rc/o8vWpOA8rZiXXtXU6eZdJXUa3dnucSe8xnSm36TcjD2LS5vCS3FVqHB4KqaWKAeF
         nmsbtKm7wxGsHPt7zIlj2CyWdrhPxEggmj7QdW9Q0ef9Pln4aYWo3ZcKzV0SCCcBSIcm
         sYJML5vYcY2CkOicOSSUSENxWZo3TWOB3dKQGdPSXBfL1+moX5zOZVwQCHNJRFeQRwIb
         986g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732684128; x=1733288928;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F8cIQiefFyj4CQ+VfJ+Uanmlw/4nbISUiTBum2Pbkro=;
        b=r13rBu9sm+uGpzsxVbDqsD+IwgU0fFqC4kSW6V+n/+L0Zf2/fNhdrJ9359hGkzshY0
         W1HWEKtNGNw3tluX+RyXW+f+cm62WqFgriXCFADg9+7CvZrTOaQigpPR5bXTEiiGkNZ7
         Oc8UgtfQ7Z5HNQX0JGvNahGXnz57fvaOWbrwfY2V5+hci7zoltJuMVltpxEqdz880lp6
         0+V7nitqEp0ge6i5q73rWBND89Hq1DDReqVsOjg0p+FGN3OmTaZqQiNOpFqxreEBP1z7
         6gPOfMrvqRgSE/vn+KeDHUFeNos6kRr/2t7eeQm8WrBsFlW8d2pTx5XbFpS9091EGuuI
         gLwg==
X-Forwarded-Encrypted: i=1; AJvYcCVwka0BPjdxq0N/KXFyOSnYWFuB3qzo4t66lgsUWpqEfxlhyEjtBsJwQIFejEB1i0xMOXALeECRWrU8@vger.kernel.org, AJvYcCX0nDBkZs3GCJyslIRXQgQKy8MNmPwdKvw3ZONYa/h3DDAvSX//RCTh0gdcXFkpSX+mPRMA5rcq@vger.kernel.org
X-Gm-Message-State: AOJu0YzUyIkPt0tQrbh8Ae8h0sLOZzxIpc6PY9i2xYiWtCzaCW7NKCzL
	K62/6tgy8+sCrVGqgxnLQsIQlz3LQjB2qR7GD7CbSc5F638i23FT
X-Gm-Gg: ASbGncsitzR/JRPysGBW6SVMeIF/sdq//JM+QrP861+hPTLfF0hZeXOSFBCl29zG8rg
	7AjdVOeRNhpf0TUPq+f22Kl6CPRHmHfjAIaLaFktF9+gZoi2Rdqx131bQ4PpK48XOMQmmyr2EDi
	oZq8FKibRn3+gofkd7+4QzJYyoCHubJZemevu3PTQGjXZJd6T0KL8ad2lxYIuQcLDgju8BDCOpc
	GjPr82mkFjly3EqC6EadnwmwCHu4rsN1x397g2lCY0=
X-Google-Smtp-Source: AGHT+IFtyVyvBJKeCer7Z6Nh59CGewOJ6WrusPPK+5Jz77jE13BR76JLDHncz7+c/gVszTpbeK2xUg==
X-Received: by 2002:a17:902:db06:b0:212:5d38:b47f with SMTP id d9443c01a7336-2150109dcbbmr22168405ad.22.1732684127594;
        Tue, 26 Nov 2024 21:08:47 -0800 (PST)
Received: from dw-tp ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129db8c88csm93692625ad.24.2024.11.26.21.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 21:08:46 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Nirjhar Roy <nirjhar@linux.ibm.com>, fstests@vger.kernel.org
Cc: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, ojaswin@linux.ibm.com, djwong@kernel.org, zlang@kernel.org, nirjhar@linux.ibm.com
Subject: Re: [PATCH v5 2/3] common/rc: Add a new _require_scratch_extsize helper function
In-Reply-To: <fbc317332fb3d76680f65eb0c697f8c16b958bc4.1732681064.git.nirjhar@linux.ibm.com>
Date: Wed, 27 Nov 2024 10:36:48 +0530
Message-ID: <87mshlgt93.fsf@gmail.com>
References: <cover.1732681064.git.nirjhar@linux.ibm.com> <fbc317332fb3d76680f65eb0c697f8c16b958bc4.1732681064.git.nirjhar@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

Nirjhar Roy <nirjhar@linux.ibm.com> writes:

> _require_scratch_extsize helper function will be used in the
> the next patch to make the test run only on filesystems with
> extsize support.
>

Sure. Thanks for addressing the review comments.
The patch looks good to me. Please feel free to add -

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

