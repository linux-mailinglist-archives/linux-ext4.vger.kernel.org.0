Return-Path: <linux-ext4+bounces-9900-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C28CB51850
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Sep 2025 15:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FBEE4622A2
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Sep 2025 13:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B55821ADB9;
	Wed, 10 Sep 2025 13:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FIlcoVlJ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E0D21ABAA
	for <linux-ext4@vger.kernel.org>; Wed, 10 Sep 2025 13:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757512324; cv=none; b=GmbFgaNOpCSAJ4yFtpP8y8rUjrcdDBz+KxUpePP8uj3krpVNqKk/KuiXYorSUgStLeWS1nrEKD/E5i5ycYMUagRqWn12WCKE3DDBrSa1EAx3IXUe3azkfvP08cnlt+6jPXhguYHTOM34JvqCUmWnANMOJHUHRmURRvKcP39ab3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757512324; c=relaxed/simple;
	bh=HaAsamIMVuOXOfSiEBRRdjvpmcYCgYK0tefmzdDJ2qI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EcTKyYesyXXPxhHQX66QEujHlpvdU9yvZKIdOJnZTBpSQNqr1MXbH3p0wD0yjHfgNI6GkwfmIqIPllF7cvv2RKvUAoOD870+1byILAdetgdB4aevOw+bD+VE0IayBJ9JgZdtdm8Lf5Vbgl7WAFgwD8HkjVV41a/jj1IKKQSDwFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FIlcoVlJ; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-72631c2c2fbso72219986d6.1
        for <linux-ext4@vger.kernel.org>; Wed, 10 Sep 2025 06:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757512321; x=1758117121; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MuYEOD+AGUuyJmR//l186Ce7ecpQt4er4wHeoEy1TqM=;
        b=FIlcoVlJtEDvDkj9nlgNBmpT56bMd5c46UdRCYGRkuP+f4Fua/bJaQL5aYYMIos/0v
         PKoxKOjf/eAnT3E9ARTZSOdQ/WIWaae5sx4oeZcmPxqjXmfbWJ8pX7axfL1BjUpPdXAR
         lXqYsX+pmrrY5eviwC0jdgEIeuE95obwqKAKx8+F9oRzMx1DQ2U0n1kbgTNOEQlRf8Ex
         9Jc0Bc81hMCiY8Rwm9F7HhZq1fgnHhl8NcSLBCGbWu8VX7s7kPA286iO5sSO2oSXWffY
         bQ+ymROvYO0RtkufMNxncFNOXkDuFj5WOXGyFpNySutZdKb9L19h8paTHOH2o/treZe5
         i8kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757512321; x=1758117121;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MuYEOD+AGUuyJmR//l186Ce7ecpQt4er4wHeoEy1TqM=;
        b=nfXxiPAY1nzeoMyVO882bQIx5prAHUQL9ueLDujbpXjSAx6EoEHLrk1rwwiWnvXdHJ
         90AlWoVH7CZ4Q+hK3qQXypEgngCoahH/KPHgR/Vrz1TKWEfYEtDt348lwj1jaPVmdHuD
         /5XqmrXBDM043nbgcyC5S90KlKAf4DBjTDJlz2xuxVrIOrkvjRyBzDIRb64nItpnoTK3
         BjjTpeykA+JHTjGYYMxYz/KgDycxHdeN/ZRveGFWurK4JjtmGjjMd8BD6Gij1aJ2cD1W
         yfiewVkc44sK75IpsWxIkyKCKbP2pcGETVb4E5keBtt3EShyMMOgqbm0YnowF2kU3bBP
         qtyw==
X-Gm-Message-State: AOJu0YwtS4+gqxOe9xHzdikXkeiLDz/z6+35Mlt7vKvvcYTjqKzWT8Tc
	oBy+fTsaMjfxPXhLYEDgzjlPeyHBnLmhw1G4q+mLI/o3RFDxVfD/hCB+fE0yymErk6o=
X-Gm-Gg: ASbGncvGKh7ywyy3eKJo18OLDHN6nfBu7DFulxZAGr+1b68zUAE9VvwrCqQIQE8ILnt
	MWHzCmADUNRadJg1IdCyknQXFcljG+aDURyOWr4x0oV2JHAm2VXr4nAF/MvayTssRx0PRkiTKTh
	+ZYHfC/MSukZH/Oa1lTNJISp11P4bTRmRDgmdCedCa0fSUJaDfX7Qp0zlFkcEi/6dZeUbcMmZpa
	vqtIuYo6rzgA/ZZyjStoCH1uA9KWgZFV/ZBgnZi7UZKox0T2wK4ZM5Wqj2N2QxH3a/RWvZWeNmb
	kg39vdc4+hjtpBHPSkQ6ncn4aoHEYlK1HPS2jQhoui1vHaWY+foHes2U/GmynFnFoMviq8qzH+B
	d+oIg5M50X2xXGh+WuybviaeCnJfgVEZKCsrERd0lqIA8EP06XPt0z9ZRqKI=
X-Google-Smtp-Source: AGHT+IHZ6PE1tIZfMXlMnQmxhO7O+hJ2fxSDFeX/qLXUMnP88YlG18/I53otUH77oUF+X0DO1gbJLw==
X-Received: by 2002:a05:6214:29ee:b0:70d:7561:64bc with SMTP id 6a1803df08f44-73921b3b44bmr177546616d6.11.1757512321212;
        Wed, 10 Sep 2025 06:52:01 -0700 (PDT)
Received: from maple.netwinder.org ([184.147.192.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7252d6ad05asm137500176d6.62.2025.09.10.06.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 06:52:00 -0700 (PDT)
From: Ralph Siemsen <ralph.siemsen@linaro.org>
Date: Wed, 10 Sep 2025 09:51:48 -0400
Subject: [PATCH v2 4/4] mke2fs: fix missing .TP in man page
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-mke2fs-small-fixes-v2-4-55c9842494e0@linaro.org>
References: <20250910-mke2fs-small-fixes-v2-0-55c9842494e0@linaro.org>
In-Reply-To: <20250910-mke2fs-small-fixes-v2-0-55c9842494e0@linaro.org>
To: linux-ext4@vger.kernel.org
Cc: Ralph Siemsen <ralph.siemsen@linaro.org>
X-Mailer: b4 0.15-dev-56183

Signed-off-by: Ralph Siemsen <ralph.siemsen@linaro.org>
---
 misc/mke2fs.8.in | 1 +
 1 file changed, 1 insertion(+)

diff --git a/misc/mke2fs.8.in b/misc/mke2fs.8.in
index ffe02eb0..94d82082 100644
--- a/misc/mke2fs.8.in
+++ b/misc/mke2fs.8.in
@@ -739,6 +739,7 @@ the manual page
 Quiet execution.  Useful if
 .B mke2fs
 is run in a script.
+.TP
 .B \-S
 Write superblock and group descriptors only.  This is an extreme
 measure to be taken only in the very unlikely case that all of

-- 
2.45.2.121.gc2b3f2b3cd


