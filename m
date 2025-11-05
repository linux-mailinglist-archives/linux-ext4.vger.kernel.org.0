Return-Path: <linux-ext4+bounces-11494-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46141C36F6F
	for <lists+linux-ext4@lfdr.de>; Wed, 05 Nov 2025 18:11:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F102647F43
	for <lists+linux-ext4@lfdr.de>; Wed,  5 Nov 2025 16:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867BC2D372A;
	Wed,  5 Nov 2025 16:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ni3SsPrU"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A730242D7F
	for <linux-ext4@vger.kernel.org>; Wed,  5 Nov 2025 16:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762360305; cv=none; b=idK94fyB/yUfg7HC/bwgb5lZl4Xn154oLm+EdqurK+6E1qz2sTive1tOFNN/NkJuOgniRqlbMrUTG1g9p4gC+tSrjK6eMjK6P+76cKgSpKYa7RRXVQ61bQS/lKIEiTBzUkDk9mS42zWwXNScZXp6nG4swfPgdzBwV3yDv0IU6Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762360305; c=relaxed/simple;
	bh=0KYGhhbtYlOaRqbpjySLAQkj5nowajzKTukQQcmAxMQ=;
	h=Content-Type:From:To:Subject:Message-ID:Date:MIME-Version; b=SyHMT5SURYySwuMh+pEuNgiVBgjgtTAXzuBMHjDl5wrXq4A925UjcNR47SMwSD0j1xCm9RzQw1RVdzEEai3cyagyOyOKuZc3yt4o38PLHMKUuyy6GyuAcOitb8th2QnWh26Q1BSfjabNLdptmOOwWKYrfeDip5jkpdCbcYfOQjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ni3SsPrU; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-477563bcaacso15616875e9.1
        for <linux-ext4@vger.kernel.org>; Wed, 05 Nov 2025 08:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762360302; x=1762965102; darn=vger.kernel.org;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :reply-to:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0KYGhhbtYlOaRqbpjySLAQkj5nowajzKTukQQcmAxMQ=;
        b=ni3SsPrUwy9U0vBmQ+WqO53TAZqOzkkrYxL9MeGji/Vu/K0Sw5jlZrjo2m1aJgwZ9M
         o8rUpa7UIeH+Xr8b9t6jhU6/wR0lFp53KxJn1R0NHeggIxV/aq8nVoloTrsHVs6dU7k8
         +U0TL7d8Tt90qsWKBZsYfsCMx1rz0USF1HpPm6nZYs7Qho8kbwdMDeZ223mFT7Li2Akv
         9IP9m0lfo5p6DZFIX0WLNAfAiVRE6WeGWA8SiV+7frreRrGYhtdcZyauJ9sGbzAChhOo
         p006sWLjZ2dxxjk3lYNl4qTOFEnsch02SzwKiiAy2ZP7XpIGyMj3XnHPJ7ThzVovBXCm
         enUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762360302; x=1762965102;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :reply-to:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0KYGhhbtYlOaRqbpjySLAQkj5nowajzKTukQQcmAxMQ=;
        b=usZXQeKj+eo78RZtKOmD2ggPKzDgZH2QeCuCo+sxlEIVNENtJbPLp4C0tv2yMzNwck
         +L4R60o3kwyput3DnbY0rlvvZihCr7MDJ0NDR6zVp3c5t9cUgFQcjRvTJtEfHYhE81JQ
         jwrcLr923UkLr6nmTwCZe0r+tGVzwPwH6vWAAU/Zw7xS26cNB6H/GWTSQkxJ0MazQPDv
         AuHQQV/15pJ5mwpyihsRvfuozwRt0hLNW29C7Px25aqP/m/9n19Ato2jSkI9bWTCEhUt
         ppXKv7+XJ5MhqIgYL+KWUg3n9A94Rp4k8seaYy6SMh413hb4NBbSoW1ovLEM6WNZ44cj
         drhg==
X-Gm-Message-State: AOJu0Yw+GxAuAmoBeh1+50/P5av7dqgwf68HMOOFp2j/k57Sz2wsJGu6
	/KMvWYfQmfGJj3aNfDAFEKFkKoR2oCizTXjU85FQyFqIB4OKsnRHOWGxcTIHrA==
X-Gm-Gg: ASbGncv+Rj4JHCntZ2ghcM/6jA5Nez6lfEVekAx5/X6xYlgjRRBMDymZr+ASiqMpS4F
	NeKzcr8wnsRtRpdvHlgCCw00DYL2YP3Y/brr+R6I6b9wLA3SMoVu3Wq/XtmIq+AD2lpaNSWyS1c
	cZP5OusF7Tti9KnHPNmMstx6HRiIxDK8X8SYxekqyuAtbSJjML5bpXnoKomNB16VprKJE5hNufs
	57KJDoLD0nWMLULGJeQxSRD/9bYKQpNftQpTCq9AQswyPbUDep5HPld7glR4HIwR9GZb0qGaFot
	B5IshrF40isAsIXSd9suxPaSlq82esbkEXVdBjcHRARn6eiWX9VT6uuNXMaBL6gFutd03FMGdgw
	vIhEL/Yr7dsRrKRg4j/29CgE5lAGNOVDqZ2w88a3xpW08J4FYWqqHXQXYgoMRZLlR2tdO9n+7js
	+6+33VqwU5ombDlibNei0smzhG5q1s6/LCt8nGwVJEASPR6fJ5MRxvyCL42uoixoE=
X-Google-Smtp-Source: AGHT+IFYZBemAradBa65ksrafvrBPzkK5gfZa6r3rqALoQt2F5aZhamw/RCZowTMGdAhbKQ2D+8B+Q==
X-Received: by 2002:a05:600c:6299:b0:477:559a:1ca7 with SMTP id 5b1f17b1804b1-4775ce8e088mr29944345e9.39.1762360301271;
        Wed, 05 Nov 2025 08:31:41 -0800 (PST)
Received: from [127.0.0.1] ([139.135.46.105])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775cdc386csm57685135e9.4.2025.11.05.08.31.40
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 08:31:40 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: David Scott <eidendereckces@gmail.com>
To: linux-ext4@vger.kernel.org
Reply-To: davidscottces@gmail.com
Subject: Estimates and Takeoffs
Message-ID: <8bde7102-b0fa-b5d8-748f-421b6da11259@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Nov 2025 16:31:39 +0000
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

Are you looking to estimate your projects?

We offer construction =
estimating services and quantity takeoffs to contractors, sub-contractors, =
developers, architects, etc.

Get accurate takeoffs at competitive rates =
with a quick turnaround and win more bids. Thanks.

Regards,
David Scott
Estimation Department
City Estimating, LLC

