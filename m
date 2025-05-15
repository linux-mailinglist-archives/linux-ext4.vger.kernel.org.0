Return-Path: <linux-ext4+bounces-7910-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1DA8AB847B
	for <lists+linux-ext4@lfdr.de>; Thu, 15 May 2025 13:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D952A1BC0BE2
	for <lists+linux-ext4@lfdr.de>; Thu, 15 May 2025 11:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7DD2297B6E;
	Thu, 15 May 2025 11:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LcCY+wrr"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1603D10E5;
	Thu, 15 May 2025 11:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747306913; cv=none; b=PUGsBb0UWhNGImkWU+zvLxaXnA/2jEt79LUk9M8ale7ttiDXMAJo+BvoL2wkFOsm0/Vjq/KqdS2HrPGmY0cHl04i01SAaEhb/o+ilji7vIprCcSDRbY3LqpQ4fkqRx78jd7z8oqrz3c96adHJDALNNarR2XNDCdraUAYJhCS/j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747306913; c=relaxed/simple;
	bh=oF1I/e+0ZW/JAyWLqkT0Ey5HVUISop7fmzQEedssQwI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IdBqBt5MHL3GJCRjpG4X+DIGPmWdvjG8TMXUZGxFYMhWrzTL4YyEPX0mZjUWLrzZRL/BUMdF25q058wi8WDQeVhl+Fp3yrh2/7DGztLd9hj2tMYx/Uy4zl7668QFl1D+VABZGB3vPX7AG5Zb8nRlvD3KpUkWCADrr1QNEatuE/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LcCY+wrr; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7399838db7fso767485b3a.0;
        Thu, 15 May 2025 04:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747306911; x=1747911711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UHJtB1q9Untov6MKY8w4xfneHkWOk4rUpt3L0nmtuKw=;
        b=LcCY+wrrJ6I154SUkavFV9VXtBU1shQ/UheS/aMUpRP94BEz7/cIQNeBG3RuKILHlN
         WjVY7bZ1L+7igVlMRtiwjhEujJC6FsssoZJC3HfsciChrGAY940yCQl6tREAKR3c/gWb
         5XTXBxoFUvgTllZKgifVzdyThpHdKxmEG0b0KsZ3mYN31WK53+wLIu4oSNDTc9Wnni7h
         XchWSCY6lQJxlChqPC848TDrj3OSY1h9dWE00m8qY+1ss+S6g27KUqYNosYiqpGIm3mV
         7cZZxZWlVIGUsy3JYbBkN75tv6vTFRRNkM/xo26OlZMBLnKRsRttVz8JCFv0FkFGVfwd
         Dofw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747306911; x=1747911711;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UHJtB1q9Untov6MKY8w4xfneHkWOk4rUpt3L0nmtuKw=;
        b=YpabdcCWeVdpk3ecjdgejEUL+Bl439GDz/9vtHbdH7dcomuieL/zUzrGmJDRfEQGKE
         SXRfoM1D0U2xWj/mhh4ThInpHkmYo/+Cdp9ngds/2alm3n+JkLCj5mg5p33Hnh3kk08b
         zkrrToD2X5hmP0A3G9pDlUYPTok1yaMA8mqy6hkL2tuvkcW2lJHLyBWiXgdoxZdRMVt1
         uR9/nH6sxWdYJqzvNV7+thLjY53hoqz/9ZdpXekzL5EbuIa73zrplAtdRZrfG04K4Oaf
         AfIJVBuCiIL8/2apOvQY6rSbfQ+SlN6ZyFuqh8TErN/oZ6j5SI1Dj4FWPOwouwZUiZsl
         SY/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWHwc6fJcJwArdMm5IT7m+q6MEAM+jaZAJ1IQWHWPg7Wt18h1a+FgRjgNCL9j9mWb+Lk45PJf0j6Iw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB47jMYxx4UDjcylCx7UkF5z7IoJ2THJ15ARHjM9YjgPfLgQnT
	BDOEl7vygTyG3ToOTwaz0Rmk6TqRaAAospIXZ2Sy0nh7STn8Z8Uot0jE2g==
X-Gm-Gg: ASbGncs9QW7IyzdA80A5qPJZgHoVYmI81vBMBYtJbQCA25YDVfvrP8QvoXsnB8L15He
	TxsenaYsIpEMziSNIdsNKirb4NPxzS8GPjslsQdDpMj89lnfwgTIQ8MK21HxoUXu97UvQsN/R0n
	cXtsdeAPjWhyxXdtoVifCnILXEcuNZ8AMAI5gXmkwvzuufHF5Vjx5t8X4t4QWvuBMIlRD8YZ03r
	WiVwWXKqk557/5u4yoMkmXcWUebXkDFVhSrfYzwQwuMhy7HJ1Qh2Akx+5yEp7lW76shJgGYw0X1
	Fd+rVcrpkCrT8HmiRi/HixB24GY7TLYOULihCTz/+lLsAghvU813lrs=
X-Google-Smtp-Source: AGHT+IH+rzgDbrs0Ry3xGdFeeeapP8e8/+QlX+9iC9TNT5/AvEZESgvnjY+MPAUSCwRyN3uApOVq5w==
X-Received: by 2002:a05:6a00:4b44:b0:73b:ac3d:9d6b with SMTP id d2e1a72fcca58-742961d4254mr4606678b3a.4.1747306910780;
        Thu, 15 May 2025 04:01:50 -0700 (PDT)
Received: from citest-1.. ([49.205.34.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7423772752csm10733673b3a.45.2025.05.15.04.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 04:01:50 -0700 (PDT)
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
To: fstests@vger.kernel.org
Cc: linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	ritesh.list@gmail.com,
	ojaswin@linux.ibm.com,
	djwong@kernel.org,
	zlang@kernel.org,
	david@fromorbit.com,
	nirjhar.roy.lists@gmail.com
Subject: [PATCH v2 2/2] new: Replace "status=0; exit 0" with _exit 0
Date: Thu, 15 May 2025 11:00:17 +0000
Message-Id: <463f1f99c7b9ced218f62ea9fc048c2e645227c5.1747306604.git.nirjhar.roy.lists@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1747306604.git.nirjhar.roy.lists@gmail.com>
References: <cover.1747306604.git.nirjhar.roy.lists@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We should now start using _exit 0 for every new test
that we add.

Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
Reviewed-by: Zorro Lang <zlang@redhat.com>
---
 new | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/new b/new
index 636648e2..dff69265 100755
--- a/new
+++ b/new
@@ -176,8 +176,7 @@ exit
 #echo "If failure, check \$seqres.full (this) and \$seqres.full.ok (reference)"
 
 # success, all done
-status=0
-exit
+_exit 0
 End-of-File
 
 sleep 2		# latency to read messages to this point
-- 
2.34.1


