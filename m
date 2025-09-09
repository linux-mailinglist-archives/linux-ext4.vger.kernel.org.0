Return-Path: <linux-ext4+bounces-9880-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7ABFB501A8
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Sep 2025 17:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C56BE177CEF
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Sep 2025 15:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD43D25EF87;
	Tue,  9 Sep 2025 15:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OdkY4ruW"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACD523E34C
	for <linux-ext4@vger.kernel.org>; Tue,  9 Sep 2025 15:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757432473; cv=none; b=bHqm1rknvWpHU6xEapYJsUXfbeU6xPDoQ6BzlEsF+OZcpKRbSL2JWQIfbjKxGlohAO5SAxtvhTgAbYKpEvXUeYYUWRTRyUgl35ANb7SCHMBjNjCp+XBKQpNvQSHEnrq+CWz4CvSgoru99T/JqQ1J7F2cKqfHY/ICDOSCRfLPy+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757432473; c=relaxed/simple;
	bh=GxmzYuCUGbriTjOVcM6W+9z6pqxb9pwQE0XxAj5dDww=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=eETuVu3PLBaczUa4NFWm3NyS71SDeiyrtZbQmNRorAQ1KOAOlYQdQAHh+r+2pZdZhwYts9DPYVVX8ksp8mttcCWpfYOmhGH71k3zEsFuuTnpYgHrmMyFPRTSK1LvWDXLw46K98GPmRzO7SXzMxt54iNCxs35EEe1gxeMHtTsrhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OdkY4ruW; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8117aef2476so388409285a.1
        for <linux-ext4@vger.kernel.org>; Tue, 09 Sep 2025 08:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757432470; x=1758037270; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5vzQpnmKmKY5Z6p77YdgTw9t6XoXcqP4m5OTdrw6NtU=;
        b=OdkY4ruWee262QPOBWSkUxm+VBZcS2sCOtBFu9V38T/SbCRBnvD3EO1+JSgLX33OOa
         zFCCpX1V+slWGlVMLQkkKx2O/qGIQJZo0ImUTB0oRh9nhuC+N02Y+UT/UqSoBnOi4O2L
         9VLn5qAitFZ2VDUoRz8IzE9Yj6ORW+R56oVAG4YMkXCk9sa+qezsik1ktJ4GAghSQ5Lz
         YMnXr5icUPxzmfmLKOOarXwchdrmZ3LQkEOfqJQnHlHUt5pq1nSOc/7KseQFGTBC/OFm
         N6Os4NsyM6bJ0fpfq8+O/OLNB3gAwAqE72KB+qfIBh1Dn/OFzCZU/64zMqU9IiaLbSQS
         RSNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757432470; x=1758037270;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5vzQpnmKmKY5Z6p77YdgTw9t6XoXcqP4m5OTdrw6NtU=;
        b=gblGJi3vjryCmGhM4uFFK+5DESjGGxS70V3nR0BIQVQuRLrFFOjl73tXYaj4owbGXu
         pUIdnEC6gzpfA1/mP2iLw3uqLCdYkIzrtWJqAheGg9YnzRnt8EEjAWu8uAGTcCX/tIn8
         QTH6ZVXIe2AdPdJLDLbIYDeYtBIvWgdxCl0m5uu8q2jxsY13hDNLhqmyDz8YvF+QS4pj
         /miH4HrmUuae/rPZAD6KCjXAmKADqfB7cidLlii+wfQsb50m9wr1MicR6Io1zS/p9CJb
         i92xVxv2FjS8Jq7tpAmxFFkkM5Z7V8ZXLGXeHsX3k1cdfN1K43KZUvMxOxJ+H7KOgR0i
         kU/w==
X-Gm-Message-State: AOJu0Yz1gyjriRJbqadayHQ/j4oFaPj/ATThswnGbEelkfyaOCMz04Lk
	sPCLZLD4am9fsynexI7du97kNcEQyZ4conwFujQHH1VImtXVkSLEBBppW2ru94J8tMs3AwXcCVb
	pZOyv
X-Gm-Gg: ASbGncsdPA44VRPvD8IojaYRki1WDGxCYMr4oGVVPWzUH8sM4ww028WYIR7aJ9y1U1Y
	KFVVtInGW8Y8fKd4YbMGVPGmR8PsgWBs7Rj8KwvCxUDo4QeTnpgPLCxJlgIAK2Xr6WZEVMBVLVR
	WliSjEh+m/dnSEPSN+pTc2QMv27XOdRbPtVaVZiUEDxSEtKrfu3LLJi5FWp4Ug5AFir1gp/QTgN
	nxwe2hz40ftq8iBuNnNK6apoHwcpX+uuWAFvuzwS7QnuDuzUBCli6DKQyAbpdr9Ri1QMw+w6Vfn
	qzWyhZCZTdLP1IFqhAmrmHF1H5GK+JHqahmIQ0xctwtGfZH1+pPb3pxIE7g4knthZhS1Kx8bF5j
	g7VunYBqtVnUAjTSGNt5QO9Cs9eQxzDk11gczADRkZiobQ60DGMVV1Vnb3ig=
X-Google-Smtp-Source: AGHT+IH0Khwwexv1pz+F6oEYGxDVHe6LdLerv035e8GGi8Nj3g6uodmYKWGRHzy464lgJIgDemGVwQ==
X-Received: by 2002:a05:620a:1790:b0:81d:5e69:d9c3 with SMTP id af79cd13be357-81d5e69dadcmr10588685a.77.1757432470337;
        Tue, 09 Sep 2025 08:41:10 -0700 (PDT)
Received: from maple.netwinder.org ([184.147.192.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-81b58c54d9asm138885185a.1.2025.09.09.08.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 08:41:09 -0700 (PDT)
From: Ralph Siemsen <ralph.siemsen@linaro.org>
Subject: [PATCH RFC 0/3] mke2fs: small doc and features
Date: Tue, 09 Sep 2025 11:40:49 -0400
Message-Id: <20250909-mke2fs-small-fixes-v1-0-c6ba28528af2@linaro.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIFKwGgC/x3LzwpAQBCA8VfRnE2t9d9VeQBXOWwMJiztlJS8u
 83x19f3gJBjEqiCBxxdLHxYjygMYFiMnQl59AatdKpKVeK+kp4EZTfbhhPfJJiNiVFDbIq8iMC
 Pp6M/+K+Dtqmhf98PLVftjGkAAAA=
X-Change-ID: 20250909-mke2fs-small-fixes-6d4a0c3a8781
To: linux-ext4@vger.kernel.org
Cc: Ralph Siemsen <ralph.siemsen@linaro.org>
X-Mailer: b4 0.15-dev-56183

Three independent fixes for mke2fs:

1) document the hash_seed option
2) prohibit multiple '-E' arguments 
3) add extended option for setting root inode security context

The first fix is straightforward.

For the second one, some alternatives would be:
- only print a warning, not a fatal error (but that is easy to miss)
- allow multiple '-E' options, and join them automatically

For the third one, the main use case is when generating empty
filesystems for use when SELinux is enabled.

Signed-off-by: Ralph Siemsen <ralph.siemsen@linaro.org>
---
Ralph Siemsen (3):
      mke2fs: document the hash_seed option
      mke2fs.c: fail on multiple '-E' options
      mke2fs: add root_selinux option for root inode label

 misc/mke2fs.8.in              | 14 +++++++++++
 misc/mke2fs.c                 | 53 ++++++++++++++++++++++++++++++++++++++++
 tests/m_root_selinux/expect.1 | 57 +++++++++++++++++++++++++++++++++++++++++++
 tests/m_root_selinux/script   |  4 +++
 4 files changed, 128 insertions(+)
---
base-commit: 4b02eb164221c079b428566499343af2766c2ec3
change-id: 20250909-mke2fs-small-fixes-6d4a0c3a8781

Best regards,
--  
Ralph Siemsen <ralph.siemsen@linaro.org>


