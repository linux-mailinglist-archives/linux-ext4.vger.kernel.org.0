Return-Path: <linux-ext4+bounces-10642-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D90BBE96D
	for <lists+linux-ext4@lfdr.de>; Mon, 06 Oct 2025 18:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C20C1891C74
	for <lists+linux-ext4@lfdr.de>; Mon,  6 Oct 2025 16:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE352D9EDF;
	Mon,  6 Oct 2025 16:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IN2jIQgn"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FAAF2D97B9
	for <linux-ext4@vger.kernel.org>; Mon,  6 Oct 2025 16:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759766793; cv=none; b=mqdoLEskFYAPseHpKfC3jVwx1fTO9SaGCCUjM78aMYjjTsCEFR9a+T6HeoAy3St2kvyZBJBcBX9PC29jfQ6C5xlrm6Q3iDmOA3W/i2mzIt44f63kIIB0pwd89T1EvOwq95NIBu1O+WVjLj7v0PJoNra2lOih43mjsE58x8BZ0hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759766793; c=relaxed/simple;
	bh=5YjdkOtBWl09IAaG0yTZACRz/VwY9fqmxCrdH9KnY3M=;
	h=Content-Type:From:To:Subject:Message-ID:Date:MIME-Version; b=sRkiSzHfLTTQ+77AU1gn5iR9GHdOeHoEn08a8vTIxK6Jck6ykwTexs7IQ4pwjESqz88vy/9V89i/fohJMCCdsWm+P68b1kSUcuCfBE0obO2sk4ADgBTbKdqXhyJB4kQ3HgUl+NgKzgiZkTsRAz3MDMmKDSlfYMQ0i7wLGtFjlTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IN2jIQgn; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-781997d195aso3362310b3a.3
        for <linux-ext4@vger.kernel.org>; Mon, 06 Oct 2025 09:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759766791; x=1760371591; darn=vger.kernel.org;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :reply-to:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5YjdkOtBWl09IAaG0yTZACRz/VwY9fqmxCrdH9KnY3M=;
        b=IN2jIQgnJjrGYrgi6dum9Ymhq09iiHqD75T/NrFRlWvfXHAOUsVsmsnlQOsH9w/fR8
         /jO18FXewE2gLCwXr/Id5VwGH890r9pnuDCNOUe/wC41NE7cA6GZGm24AmpoEQzinmZ1
         fA65KpgeKNsXrO8PDG4HTiwT+uidFsfimLiIYzh3UDHWZQ3MCprJac7ME2ZgXIju5Y0w
         YKMuKuwkaRHcQMcaCr71GDvApbWK6UAE0JaxQHS5NtkJY5awa37TZ6YL67NlUx6TzLaP
         MkD0xMmtUPgb6FBnsZTUJV+GsUzhVHoZYJMkQuGwHD4ph+LVxsYhh7qln2mS8B78NzuP
         kizQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759766791; x=1760371591;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :reply-to:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5YjdkOtBWl09IAaG0yTZACRz/VwY9fqmxCrdH9KnY3M=;
        b=QAq+si95MMd8ZTJuvoeI6IZzBqTpCVCygbQdhZHEtstxA/tH7MHsWzm3Uce9bCPXgj
         1nDG47B2CB7MwPh2YV6dJ9IrFDXK3lEsPblh5Aiw+uYOq5l4b1ol7Zv867Q5uyCOvpkM
         3K52YJnS/oBpxX2ye+ilP7ha22bK+y2zGP9LZifcIEE8zkC2LkI6c3gvfXgMN6igaMgg
         PzQjazZ3mAw+fTqozm7XZBv6MpP/ZkqgE3SRBtEuuYC94r3v/SVs3YDawenVdpj0K2Sr
         f74plCYeQLPrezsTamCXdEz0vwIKZqNvxCPfPwQ2IcrWQ78hBnhMcifKepXWDqh8m6+B
         YolA==
X-Gm-Message-State: AOJu0Yxkf47nM44NliujbgZJ46d7qxh1ySfMOcQ3v17zllxixWDjzcj7
	M6L6uoTo4iDEiMfeXAFIoOxx3wA40Ae+ULfx31h61l1u1hagJjw1Z0CRMpLDRQ==
X-Gm-Gg: ASbGncuq2psll4baslOcMPB0PbdZkETMMk4LDq7J1bb1KsCMFKAlQe019LmdWF462x+
	BajkE0sPS9nsMchwBL5wEHKwP8kw/LcJ2cU8adkD7ViX4NK272MyqjjJs2AXul75giUosWLOouy
	HT3E53+hNUVTd77Y4HZwpQ/wNTmcC8Rt/vsGZb5aJOsFVcB/klsMmK/Sqt+tSrDay4bu8HhetRk
	XUCg3PbfGytwjtEhXMbMkKrZFEQtsDaPP9No8+6vVBktKAyUcgVrPvRVa1ZLxGw9vbCfKAchii2
	WKB+Q8uBBfTCBpWYKBb+octN+W8tImXdi62eNoD3TiforLiX7JHdXDEmNDlndhi5elTR6EGEDOm
	KbhUnzDmFikpL6N8/h1kCfztZVZ70ikiTRxfunqUr/okjjtPy4+5RB2Yv+ecbTyScOcfq98GEnU
	o=
X-Google-Smtp-Source: AGHT+IGvj3LokI1VKtQnOLzU+VYchwgSI7WQU1TofMZdzt8Zmnch+PsSVdGawyKXMdzooH5Iy6RkNQ==
X-Received: by 2002:a05:6a20:430e:b0:2d5:e559:d23a with SMTP id adf61e73a8af0-32b62119f67mr17011337637.55.1759766791031;
        Mon, 06 Oct 2025 09:06:31 -0700 (PDT)
Received: from [127.0.0.1] ([154.80.22.164])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6099add290sm12323579a12.6.2025.10.06.09.06.28
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 09:06:30 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: Alan Nicolas <alannicolasces@gmail.com>
To: linux-ext4@vger.kernel.org
Reply-To: chrismorgance@gmail.com
Subject: Project Estimating
Message-ID: <110ff1e1-64a1-bcd6-0b74-9541f0268315@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Oct 2025 16:06:27 +0000
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

Looking for reliable and accurate construction cost estimates for your=
 next project?

We provide detailed estimates using the latest software and=
 techniques, tailored to your specific project goals, scope, and =
requirements.

Contact us today for consultation and pricing information. =
Thanks.

Regards,
Alan Nicolas
Estimation Department
City Estimating, LLC

