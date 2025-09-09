Return-Path: <linux-ext4+bounces-9882-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8456B501A7
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Sep 2025 17:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 898C04E5989
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Sep 2025 15:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9667627056B;
	Tue,  9 Sep 2025 15:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FlSZr7qH"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF9A25DD0B
	for <linux-ext4@vger.kernel.org>; Tue,  9 Sep 2025 15:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757432475; cv=none; b=BKWNablkrJv/CXEl7R37G06P6rc9GiM1r0jjEq692V7NPUZGbGuf6o4QY4p3TT6ulVNJ3LRHR0j3kzD5qxEOJBXv0luQvHdAAHTd/P+RypLwYLn+0t69xpRRafgLCU7X3VCEUbKZGmewPfZhN1AgB7/xHVk6PJuSnpA3lw1pX4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757432475; c=relaxed/simple;
	bh=Y5XIsJfgxx1XhbbdV5FxFhymC3MroZRv23QaxxRxt3g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=odUVUDGjqOLbeu7bL6meKzWpu56MZnLOBR0sLhMZolKIqH7ek3pa3dQ7S6pwusiKVrdBWG71mhlLxbBedKevD4S3zF4zpytKn7b6CM5Juue+sLMuq/oiCBnEKgrz3pregbqmVTgfqe+ZP7/5MmCuPchSfYhPNe9KZEE2ufL6FP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FlSZr7qH; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7f04816589bso608415185a.3
        for <linux-ext4@vger.kernel.org>; Tue, 09 Sep 2025 08:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757432472; x=1758037272; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w+0KUk4CjFXCKyAffg1l04dXfSB6Cv4n5dsjaEpPrnQ=;
        b=FlSZr7qHPM+3saNDbns7J3J32p8sW9bq13BoOMpbpOswHVTtGam/LV+2fqEbBzZ3ua
         /nK4OSNDZZbmbjVx9UpD3xXOuoMdSlq+iQMUEa9edqMkMQhLeTWAkcA/55JAyev/O6mG
         H9psTu54kEbYGSm7gwRrPAIQDnj6UXPbUzTI7xHLR4GGdSN2nJemMFnmDpunfFCsKNTF
         O1oPvzNJbWHM6yF8gG49z5hybc5tsnZtLWAOr1rhvI3UxIKpLI7heip0BDLSU8mM6HCc
         oFi77GoYjIbGddChu7XEq/nNE1ktPPEQ/So/B1fKe/E01AHL8fhLp8GzOnVPCrnQlyTy
         N70w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757432472; x=1758037272;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w+0KUk4CjFXCKyAffg1l04dXfSB6Cv4n5dsjaEpPrnQ=;
        b=a3qHBn0abAD17hb9AtH/P9UNhupXhKbRPWIUOkSLNREkX4YXV2cE4nYOPpPrcnqXZa
         qOsaef7LvgTI/Yj97D3Gof91J42KZBDQ5fKV96EN72osGEDDIWdf8Z6S1Ba2LPY3hqY1
         N9hlV7Tg9zKY7wUzQHTr0ENh0e1cVGAdoZ1HETq6wXKX/yadeF2pDiZJo6GR+KqVIhA2
         GQKVB94EUVrR7qE/jQlQrMcDkhsJ9B2whwOiqHN/TVIobG8NWMWLL/gT8LAr+f62uFZH
         qGcO8enr1htL+fZ6GeoY0Uj/wxGufr9tJ6r423X3RN5eHozK2QOX4zObLUtRCCJ+yjPF
         JHGA==
X-Gm-Message-State: AOJu0YzJqUiNOtiwZjvdrm9quy7wM71ZcQoDjLnooELiHpgwu2Phth0T
	SYcsiNX4+kpWu1bA5CRMDuH4VX6mCT5XinEW/x5Cvm8+H1GTer734O8kAUrAHtNqJNcIerifyM5
	RQ0PW
X-Gm-Gg: ASbGncvRT8zn8PyVO0Z3Elln9Z5/vxFezAOuABRrZqFb8BFjskSN8ez/Wo3lTQmgo6J
	oomoHeyRL+sMzS6nlaYl0dXdFC5/VUfEQwb5oWPyFKrpF2vpOkKWavMIEKEiiT6fuaV4wQ1kW3j
	h246tIW9ywkjwqTVkYDZscZWh/dmtkIlt3I8PqnnNVLPi+P1jSS5uuBpE8Tt7/7OPm4oBcPeOfk
	a9fUP8Y0GrNFhGcvOdoFNRZEw1NjZSBvoTI2KQZZHZHFa/cold/C2KW73b3gyWRSfLyQg34J7pf
	B4VNyrkxREDVqA97z/SL69A8DYdTBYn7L7AtPTHFkXlgaHvCkvhLzWesr4cOt3xI2r0vGmgbgjf
	1pXinUARh7FnfypO03CyFUIR/8S0OFDExbu0ZzA==
X-Google-Smtp-Source: AGHT+IE0/JcR/plCimrbBID7wHEF8eO+PG7+5b47j0CmSbBD/OlrfGnhUadx/zYKjdPAo37Xb6h2WQ==
X-Received: by 2002:a05:620a:1a91:b0:813:5c75:b101 with SMTP id af79cd13be357-813be24ae7amr1258521185a.15.1757432472483;
        Tue, 09 Sep 2025 08:41:12 -0700 (PDT)
Received: from maple.netwinder.org ([184.147.192.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-81b58c54d9asm138885185a.1.2025.09.09.08.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 08:41:11 -0700 (PDT)
From: Ralph Siemsen <ralph.siemsen@linaro.org>
Date: Tue, 09 Sep 2025 11:40:51 -0400
Subject: [PATCH RFC 2/3] mke2fs.c: fail on multiple '-E' options
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-mke2fs-small-fixes-v1-2-c6ba28528af2@linaro.org>
References: <20250909-mke2fs-small-fixes-v1-0-c6ba28528af2@linaro.org>
In-Reply-To: <20250909-mke2fs-small-fixes-v1-0-c6ba28528af2@linaro.org>
To: linux-ext4@vger.kernel.org
Cc: Ralph Siemsen <ralph.siemsen@linaro.org>
X-Mailer: b4 0.15-dev-56183

Make it an error to pass multiple -E options. As per the man page,
multiple extended options must be specified as a comma-separated list,
instead of multiple -E options.

This helps avoid surprises, as the existing behaviour is to process
only the last -E option, and to silently ignore any earlier ones.

Signed-off-by: Ralph Siemsen <ralph.siemsen@linaro.org>
---
 misc/mke2fs.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/misc/mke2fs.c b/misc/mke2fs.c
index 3a8ff5b1..59c7be17 100644
--- a/misc/mke2fs.c
+++ b/misc/mke2fs.c
@@ -1796,6 +1796,12 @@ profile_error:
 				_("'-R' is deprecated, use '-E' instead"));
 			/* fallthrough */
 		case 'E':
+			if (extended_opts) {
+				com_err(program_name, 0, "%s",
+					_("Multiple '-E' options are not supported, "
+					  "use one comma-separated value instead"));
+				exit(1);
+			}
 			extended_opts = optarg;
 			break;
 		case 'e':

-- 
2.45.2.121.gc2b3f2b3cd


