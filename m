Return-Path: <linux-ext4+bounces-10473-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C204BA7FCC
	for <lists+linux-ext4@lfdr.de>; Mon, 29 Sep 2025 07:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4576D4E0F33
	for <lists+linux-ext4@lfdr.de>; Mon, 29 Sep 2025 05:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097FF280309;
	Mon, 29 Sep 2025 05:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kD1ps6Vv"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5857623ABBD
	for <linux-ext4@vger.kernel.org>; Mon, 29 Sep 2025 05:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759123425; cv=none; b=pdQGSIPNHtmDNdT8LTlt9Z1lkgoqkbFDXGcNJTcE9Ows5SvwfYAGEQYOcmjo3HeCp7+enTXKIMu3ZWQ/Ju9uO8lReJ6MY3UiAedU2mPcovRqe3ynn6nJiUXrmk94sYwwkI2FRCx16paDcC0+IbzXu1pSRgFJwLsQkX8cA1/H5UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759123425; c=relaxed/simple;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UW8PHXP/dSCcADWnwH87IpmSan42jXq/zMjELKzTaHsFMvN75sXvMo+bIk/mSEb9t72uSQiB42nH3G23nnoNCgDgdQdmH4IrJW5o6HEs15PjYMufznNoR+UpHuNTSY1cwa3/lTxrrFO3sNkL/sU9Zo6b44qZ0ZhKRyz23RPsX+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kD1ps6Vv; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3322e6360bbso4039726a91.0
        for <linux-ext4@vger.kernel.org>; Sun, 28 Sep 2025 22:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759123423; x=1759728223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=kD1ps6VvrakAp+vBCURQqPdfEpnc2zRzzw1Rio7BwIq8WEg7O3q0LngUS9jlDjAzyc
         Zq8fs1PtPMv6YRoPyXYK8sixgAukBaDj6YLaUFAjvVuC3P1D89tyMI6ZC1FN2HYlPGTu
         AeIjh63owrBImMws0VRiMZI9wpptymNMZ8LVxNmjpwWMvrQRParnqiF1gmtB9ROKB19V
         B9WpHERI5UhJyhJN6RmyM3x5dpnNqASeNkZCeGVx/fcjVuDpSdzDq62jOP/dx/6hipRo
         rHJ9wvXMOMncvyUZgE1Gqv9AetTpcNHmRcg4JAcMhqu36FoEHkpSD+l5UjCnDK5z5x3P
         qjFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759123423; x=1759728223;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=lHRvaOEypjKIXvY3z7nvpYaQVkMzIHzvPXHHzVer2f+QO4k14fylmNqXiS9NC/GKp/
         mkz26gktDzEgod4rJE1KN2NWTkXdce7HlfZiXJ64LlckFAYqueaEmaPpF60jX/YK7XKT
         itsq4rdnxsQ850hWO/pUxOCyg7sRmQ7O5k96Kj30RxY5uxEKEY1kQluxBH78xawZWDm+
         8SqX52w3By11eh6mGDc7N9NpKZrH26gDYzvXxPA3/6fmiOm0jDYtelVuDM3Aru0iJgaU
         ae3bOgGEZjxwI0gE55sQl+ofEuoa15o5LaPyK5tuCnZIT7eM7A/Y4rdEa+Jj5bc9UQZS
         Ij8A==
X-Forwarded-Encrypted: i=1; AJvYcCUtCuhH15qGyo3KtPglVV2uYVHnaGOAw25uag6dFvf3w3nSh+2/c5HkE4IeC+KTW0fdd7L9ivaAFLVZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0f8K8FcOqbzJpdOtEuVdHEOPFOR+GJAGjmnO4Fuxm9tpodxpM
	GbKZy0kH3/DSPxMDMg3GoLv2l7cQCH/GavoOgRZt4oH9niE1HVO4z4iF
X-Gm-Gg: ASbGncvn/l4LYPfxaPYhTSMjQCzzdJt9WFn19axCWdZ8j5Fqqwf/cevms6pUfYpm5OZ
	exjjnZ39M3eTN7ST1b+0z8WMpTGrvE/snifSSuevtO/lCRs4zzhYTVZ4AyIgAcSMtvqOboCZ5Qr
	y0wgNgV2ISTyBUU0r3pq8eeAHTudT4sL/wK75PxFkzCc7BgUaMnJxj0+YMysDUiUa6ktghXTTKi
	oanPadZGHRn03VquWJkFcroZZcaKkM7smkRg4Cd7ZybYrEHTEyLYD2QUW1Vht6q8uRBuGTRCp89
	nSYO3HF653NzbD9EbF2MPcMws/6y4UPTaIRnj3+FrLV7K8d+epfb0n7Gymv7GSrvj/1TxJ1atC3
	PpAS3wgvgO86PN+6wecIr9pj4BhiKymk2el3dMvONrpYMPcwTh+4mtu2s8253gaB/E31OsfDvr/
	0nUFRvWe0S0XxDINR6628ZEnHp
X-Google-Smtp-Source: AGHT+IEJoqc66VUscfTw6//v5p1CW3/qMbORU0IbE3nlilbmsGWpSH6+G0Hj7neIrDJcRxEhMBbqYA==
X-Received: by 2002:a17:90b:380e:b0:32e:7270:94aa with SMTP id 98e67ed59e1d1-3342a2c7d99mr16864651a91.19.1759123423576;
        Sun, 28 Sep 2025 22:23:43 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:3094:10a6:37a8:772f:4db1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33473f7bebasm12031483a91.13.2025.09.28.22.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 22:23:42 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: yi.zhang@huaweicloud.com
Cc: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: validate extent entries before caching in ext4_find_extent()
Date: Mon, 29 Sep 2025 10:53:37 +0530
Message-ID: <20250929052337.334807-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


