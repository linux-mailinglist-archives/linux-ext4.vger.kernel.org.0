Return-Path: <linux-ext4+bounces-9717-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F1FB387FF
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Aug 2025 18:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B29B1464711
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Aug 2025 16:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0970F28BAAB;
	Wed, 27 Aug 2025 16:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dw52GNYu"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C3128137A
	for <linux-ext4@vger.kernel.org>; Wed, 27 Aug 2025 16:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756313312; cv=none; b=OkV80YlDoQOZOaEoLLuok9NxjAjQBE98G/XUbyYg964DUjHsaQ2OmlQOV1jaFnmqdB0Kzy3Ajx8HyWG/G45FHsOcocq7CBCaEUiwsjM6h8ECIEabqWkeLpkH5QpiNGVvWwm++XV3M7JDaK72jBrJpYFwqFvkv4Xn2cE3RKZtInM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756313312; c=relaxed/simple;
	bh=McWmVSDFMEIDm+q2H2yKdgblIDj+ATQJBT0K2kesn10=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=F6wLCIot2G1vYQy507YT58Ybr7zti4zGr6E7BmHD92sofHZDh4ZIDtu+5DyAwbS48redwvbktCRgGCrjTIPceubc0ZgCLRlG9MtES9ro/qeGpfHhfpEGvBWfVxEy/fAqUkncPdilRQx+MyRyOYQ0rlAgZLyfiFC8Aphrdsasjtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dw52GNYu; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4b109c59dc9so320761cf.3
        for <linux-ext4@vger.kernel.org>; Wed, 27 Aug 2025 09:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756313310; x=1756918110; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xPYeA0Gu9QM1NNJonazz81KVW2/f8Oncpx8J/MBDaTw=;
        b=Dw52GNYu4vOIuPuAEEQAgcySLBySj6Kez0LkYUc9Z32GGTF6UT+kUMxWQvtEHZKtO2
         3+/DxHaOMTISXLbGSv4de1iw+c7jkLLKt41xQSSA/nrSxIapI32NC5hjElSVMjPspSDB
         aJ5Y9Pkl2GdhTMs55uFDgzKm8+chPvtlwi9gj+PZQ0YVADVkk1L9tRTUl7Shazo+O2AB
         /MOLw8JYuT9HSXEtaqNt/cAZsVRdrgbzlMfXti0oRfqEs4CVlklFEu0H2WqPVj7Nr/r0
         BmGNsBNTudtnwPPyAj59jhOWPZCGjl6QwngSEZIBKSgiGYRywcEX0M/YLVy24YH/tICw
         oZHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756313310; x=1756918110;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xPYeA0Gu9QM1NNJonazz81KVW2/f8Oncpx8J/MBDaTw=;
        b=GgP1lnDK6zFao4pTTalpdLj1Jmb3nFiG0z8R6X+qinFo6ogVbewX31OWqNN+N/tFQD
         MLX4H0ZoYH57VTx+3FmFuAPsWJUfA1rnPHo6rceDA4ZBq8rqnsJO5k0+7/zXwDt0fWjs
         PmlyxpT+k31ZoJ+YehCymCc+KlJbTd1QfBvDwRONykhSJ4ucLLhWbSRAr7LGRq5pUr9e
         y1BGy1N1iKso7+ZnmF2OulbeH+hBMkWHHChGM+hAIffbCYjGKSydnXcELnU9KqFmGz3A
         TyyfyqYpFADRZWNRDgDPfW58zDFRd000skhS95VxJo+020OlXydK8GwMxesNA1dfFe1c
         R1tA==
X-Gm-Message-State: AOJu0Yx4lPjG4R6BFP2wz24Y0Gzda80yt5vpfC2tmI8YLP2ACTt5X9VF
	WYky1hg3SdFeW54ONBsdtgEJ+Tf/7jYxi/njQYPrAFjd48gNtCUpiwaxkd8y28ZRIKyG7O8/NX7
	qAfaY/g9Lws/15cbivqwe9fWvbyU28L7o9A==
X-Gm-Gg: ASbGncvWFznQpmcRUzDuZ1cI6h2PWK8491Ss+J5cQwYKTcAsWGc6WbLEfyaQDctHCuK
	GgRbJDOIK97pBZ/iLLbgfuWW49XsV9IT0e9tw9UkLsjzUKGORk2uVNmsxuKeH5vXN1q4AoBQDjz
	si9WjUMnY7CszLk9JAdvX0PC7yA5jkdX+MODOS0e10E4dWcJadK0JcsMMPDwHk4gzZ3UxDqDqO7
	53Fm28=
X-Google-Smtp-Source: AGHT+IGqBOVoEppZ54OKEPxfzOHAZCgDJ8PqrzFqSwFMjHoqxH+Nd/FxEvnkN6TulCOB7wfgfZxsKzEkuA4n7a1y9NY=
X-Received: by 2002:a05:622a:20b:b0:4af:1f06:6b41 with SMTP id
 d75a77b69052e-4b2aab09776mr213342121cf.59.1756313309847; Wed, 27 Aug 2025
 09:48:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: David Gilman <davidgilman1@gmail.com>
Date: Wed, 27 Aug 2025 12:48:17 -0400
X-Gm-Features: Ac12FXyCMVOFCJHJAbB2jx5eBQgdjhRr1ySyngEn7-QPciMH73wL1n4hmilXzJM
Message-ID: <CALBH9DC=9t5F=EtdM134-ysOS10zNyYEgXRxcL-QS+aE=FGykg@mail.gmail.com>
Subject: e2image reading from pipe
To: linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The e2image manpage describes when and how you can write the e2image
output to stdout with -. This doesn't work in reverse: if you try to
pass - as the source device e2image doesn't do the standard -- trick
to get it to treat the rest of the arguments as literals instead of
additional flags.

I'm not familiar with the implementation of e2image, maybe you need a
seekable input to do your work. In that case could you document this
in the manpage? I see comments about the -r mode and using pipes as
output but nothing about pipes as input. But if it is possible to
source the input from a pipe could you please consider adding support
for it to e2image?

-- 
David Gilman
:DG<

