Return-Path: <linux-ext4+bounces-6043-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85068A0A1F8
	for <lists+linux-ext4@lfdr.de>; Sat, 11 Jan 2025 09:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 933FF16B9EB
	for <lists+linux-ext4@lfdr.de>; Sat, 11 Jan 2025 08:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A3A156678;
	Sat, 11 Jan 2025 08:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ntLZN6wl"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D8D24B231
	for <linux-ext4@vger.kernel.org>; Sat, 11 Jan 2025 08:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736583396; cv=none; b=aH/qM9whMb3j5cEjijfkQuOmHXqa+m2dV2Z7mDQaO4cjjcLwm11umKW2YYVVx8ou5UUCHf0wnuanXuIKgUxXNXoC6si+x5UKXwhuGJTI9Zpgxhf21LMv8+5kYknx8NK6jBNmoJV3eEkHQzXJ8K282BQUfJVRJTzwRTvX2dp1vis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736583396; c=relaxed/simple;
	bh=qM6SpqdVXSx5bii65IrBJuEJDXj0Lppq13Z0R/lS4Hs=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=SvmDo5LtS4VVJOGS1nms/5pDCu9FY5zDmhd3QfB3X0z5h/0fFqZiMntUihz9YYXsQDfo42PjDSJAdxXtrvjThwOhwE6r5bT5Lnu839EbppEOTEekubPPJ7fk/pUCb9NnN3ygSP6t5dXm9aV4oZM8uuPmL+Xn+p81RrlEzm2hinc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ntLZN6wl; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5d647d5df90so4470028a12.2
        for <linux-ext4@vger.kernel.org>; Sat, 11 Jan 2025 00:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736583393; x=1737188193; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:date:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qM6SpqdVXSx5bii65IrBJuEJDXj0Lppq13Z0R/lS4Hs=;
        b=ntLZN6wlqjsKTyBMMm78VOhxpazB+DMrPzvpjSM5kQ0b0AaMgx59EaB3NV1uorJKp2
         6v2T8ol/bGWnb+LoXddizpVEdaZjb0TPkQeaALc0tMG4f2/djA6Wz27A9lbFZhFfaFYv
         TSitdXfIBLdMaxayiau2+pRGGb5uloJu1QwnsRCICPHwbvEzpCAhI5A6iWgxkhJBFzg7
         2ysag8uf0zHrFsqLrYEJR2LZnqJ6eOOazud27Hv2x0MzsJuqga4JKbGU2jbhuvItoT8/
         xgH7OgzHMkWLyjIrvTBnYHD9foTMk4+Do5TpIfW9/d5KyPINNVF4RXz4qRA03t5qaf7D
         O9xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736583393; x=1737188193;
        h=mime-version:user-agent:content-transfer-encoding:date:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qM6SpqdVXSx5bii65IrBJuEJDXj0Lppq13Z0R/lS4Hs=;
        b=aGQrg/XAmqY5XZrqDgPtpLAQinfs3wU50mho79GNCtaPpHbgHsAw8T4/35gebhQlTG
         /041R4tO/vwrKFMGrGBzs3cxuygtSl19RqSAm75g9IOSxW0T/2AJqYYwoEgc3CBSM2Ec
         dvBJnR5IiI7ZOXjaAyy3y9ByMR+Atb+RS25Ny2Cko1LJDqRdEiyBPbSsDquMMe6Q+hkE
         +cKTu5WevrnVcJc+5lcuzKqORH4xCAfihRsa7Ua4ZP7U+LjIsNrKVgCROnN3aO74RNaQ
         VnmPAPCaRb2gk4hIydaEVUXutbncRdicgXPALoTpRNtuLhVX4eI5v23sXo6owsTHIdEM
         Tj/g==
X-Gm-Message-State: AOJu0Yy6eTH0IY563JnlTa1upghNVRHcf11pbD3S4odcxL7C/MlKSRnz
	KUciOlAJerFPr6fIVYVcD19ZP4+Q+TrE+m6HJAVgN3ADalHbwm7lP1Kvpw==
X-Gm-Gg: ASbGnctfEhN/T1NkZZzbdy08xpFaCB/pjOZTNHJn3kU+VIZA/Mwvr7EkpP8SGfAVcfZ
	n+o48DMAO8etbzvIsvd599nvrO2BRzekvAdQuOcLpXeZtDip/7HwWljadaGrFamDUTRamYqiLm6
	43q9whgCo/1Zl4GfCG/+Tz6DqdQMRQdhOO6JjFnLtaZ5/J0sGiN5ktpf1Beh7Fz/Cuo99qIllM3
	vX4HpdRs0vHbijwIGUH6GA+gjL9SDpb4L5kZL6bQ975MLHv5qHtl4ZkMaORBWMOWaBYBlAJMARM
	3kXRHKRVDTFwLPP670lV5hXuEcg7/yXm8Dfun3xdPA82tpBHjGCYgMIaTDGKjPAleldMUwi5XDL
	lCKvgxB25CW0u6ZK2x9dLQVeDZYG8
X-Google-Smtp-Source: AGHT+IGU8NxBdFjCWqge6eKNe8YIWaHrK6E7I4dh/d3udALkGRxOJtmPge+oax5+pkMd6I8XadgcXw==
X-Received: by 2002:a05:6402:3202:b0:5d3:ce7f:abee with SMTP id 4fb4d7f45d1cf-5d972e4ca2amr12815795a12.25.1736583392783;
        Sat, 11 Jan 2025 00:16:32 -0800 (PST)
Received: from p200300c717052cc0ff0887cc4f061aa0.dip0.t-ipconnect.de (p200300c717052cc0ff0887cc4f061aa0.dip0.t-ipconnect.de. [2003:c7:1705:2cc0:ff08:87cc:4f06:1aa0])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d9903c4400sm2434884a12.52.2025.01.11.00.16.31
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jan 2025 00:16:32 -0800 (PST)
Message-ID: <4f779284d797f468d715da19ec04fc1d7939e799.camel@gmail.com>
Subject: Do sparse files save HDD-space and are the blocks in random order?
From: Andreas Wagner <andreasw3756@gmail.com>
To: linux-ext4@vger.kernel.org
Date: Sat, 11 Jan 2025 09:16:30 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hello,

I have two questions on sparse files:

1. Do they really - as media suggests - reduce filesize if the file is
sparse?
2. Are the blocks of the file in random order?

Thanks in advance and regards,
Andreas Wagner

