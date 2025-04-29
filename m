Return-Path: <linux-ext4+bounces-7531-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66FF9AA068D
	for <lists+linux-ext4@lfdr.de>; Tue, 29 Apr 2025 11:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68F14188F24C
	for <lists+linux-ext4@lfdr.de>; Tue, 29 Apr 2025 09:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A36F2BD5A0;
	Tue, 29 Apr 2025 09:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DWKgxOOW"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC97329E071;
	Tue, 29 Apr 2025 09:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745917386; cv=none; b=JjIvZKhgxIu7lnvlN8m7OMpdd1dIkhz3OHDyNAs28cArZNNRlTDiSLsQ1p/HrM+eo/LBYPk93bh2QtN13Cg8TQxIMPtFlRMEaU4iv4Wpcbgi0hltak79xvtsExgGuOL8ah5zb0JkYf/B2Ns2YQS6GNcwQcO+Km4flJB98XGOBWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745917386; c=relaxed/simple;
	bh=cfLKBDbu/pEUdNh9z4MNV0PU6MgHSuX29TDFbk10WUc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uhBLjf2dxU/fzdSdki1IWH7ie9qU7zGQIpnfRHhRXdYxEIQcaE+3VI9D33wL/TcxqB+fj2BQOs5OLuUhZP14+uvsDJ1CX7aPFHX2+PLjKe3dIyGu1WbvCxVfwSice4XT6p3q1smRUTVcU3RwQcDYyUkt3t5Z7VB50rYs4ns7Wpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DWKgxOOW; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-736c3e7b390so5795438b3a.2;
        Tue, 29 Apr 2025 02:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745917383; x=1746522183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QHIRlEbnHO/hUuNP9Cq7a2GZrORSLk9FHI4F6YDcZHY=;
        b=DWKgxOOWkss+vlFWs9oPBCrLpWcEWJUz130ibpZK4xiUP4nFUygNioe7xxPmL/Ovbv
         VYZREGY+NHNwTCoeZtxwmSfPuZpb/QaOk2G6r6Om9yk60i2ZKJ4MFSRtHqlucjNlKHUm
         dsJDkrMkle4C3kD4p5NITUDQWV0nkYp+xQDv0M58fZ7Qzac7aa6k2sXy6A7pJuR9jq+R
         ulOmAqAZgnyH9QQgpR/oC26BmONMnijGP6pXnhKoynjWcFN3DQ/iJB2SUOdbYfRazC1h
         ax0cpBv3Ju3nE6g45rMuWCx5bkjHq84QlEgAiAESrxWjFE9mqOs+JmOIqYPMCEHZSf10
         Wp/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745917383; x=1746522183;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QHIRlEbnHO/hUuNP9Cq7a2GZrORSLk9FHI4F6YDcZHY=;
        b=FpKs5VbEN+4ApjGaS5XADIv4o+bYKIi4r+gTJU2KdMlhcFRXgZy3qfSMvWjBtCx1BB
         74WNGrmF7kZzZCfeGdMs35MzW/LMutfM2x7AXqk0HjnH8ycw4FxykInOW5o1/Em3o5O4
         2PJIFS+rOGqgReYgBRffJijAgUkZJE95WbDBS0XpEjvO/kcS6tMCGULsfQEsSwKIJ6rh
         4knrXJG8MPCJy/VVNWFY3cq3ftu8oSldQTYSMPXuuXRJJtyBxW2krp8Gfo09mILagfxo
         dToyzAqGNHcS4FnAW1tYSycA20foBIoARkZgNk/9vV+VN9fl+haN1fH9OnpKUOhxqd83
         By5g==
X-Forwarded-Encrypted: i=1; AJvYcCVGhuPYgkAcDVBHNWZo+WyyTCMr7bTpmd3LYqWt8sZZKiEKsN98wGE+K5ZqsaXuqohxy9SZK/qw@vger.kernel.org
X-Gm-Message-State: AOJu0YynjHwUGRmij/YybYw6ZpVYwNkiHcTl3CLBJqx6sNLTHZHSlNTB
	7i8q+5BxpgPHPuqCd634f+zwFa3mUBtWce34PO8yHgkUVjDcr9YKN8qQmg==
X-Gm-Gg: ASbGncvm5EA+fCO4ceBR0+8lT3irrtnbzZLMsMtB66Ix6WXixCjFUrfFG9EOalu67KH
	TjoD5omFpGaetjYDnCbWuFrPXq51/wq1ROnHoIvPGhxMKfUFA9L6XDAHexHc+Qpm/vgObzncuvM
	KxpenXJKHvj6b+C0vSvIaDuZNpi8frZ25K41SMewiIY2JaYKGtbBAPBNFF8NtLTRAD9WFhvDHI7
	mszUB/zAv9ZTxIyzzjerFiTbiPBSJtYAyKzNMFbUR41KkfUDSVLfkxLZmjigK4bMViRcCM7DBoT
	lvoNbjPpsw8fNQhC2W4njdWmkItiHv/T4u/nWfohlL4wfAZKf0PcZclJNMD7cU6buyOvelYF0gq
	+8cAPiiV7ScoGyrtWgPi72RpNRRCb
X-Google-Smtp-Source: AGHT+IEBZXYq0DXSAPQ+SLE2o2P+YIQ/IXoX11jJzJVn7EraYwfudBDwylNsUMhxXLVQonxlkdePKg==
X-Received: by 2002:a05:6a00:178a:b0:736:3979:369e with SMTP id d2e1a72fcca58-7402713cd4cmr3861549b3a.9.1745917383561;
        Tue, 29 Apr 2025 02:03:03 -0700 (PDT)
Received: from li-5d80d4cc-2782-11b2-a85c-bed59fe4c9e5.ibm.com ([49.205.34.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25acaba0sm9341237b3a.169.2025.04.29.02.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 02:03:03 -0700 (PDT)
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
To: linux-xfs@vger.kernel.org
Cc: linux-ext4@vger.kernel.org,
	fstests@vger.kernel.org,
	ritesh.list@gmail.com,
	ojaswin@linux.ibm.com,
	djwong@kernel.org,
	zlang@kernel.org,
	david@fromorbit.com,
	hch@infradead.org,
	nirjhar.roy.lists@gmail.com
Subject: [PATCH v2 0/1] xfs: Fail remount with noattr2 on a v5 xfs with v4 enabled kernel.
Date: Tue, 29 Apr 2025 14:32:07 +0530
Message-ID: <cover.1745916682.git.nirjhar.roy.lists@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes an issue where remount with noattr2 doesn't fail explicitly
on v5 xfs with CONFIG_XFS_SUPPORT_V4=y. Details are there in the commit message
of the patch.

Related discussion in [1].

[v1] --> v2
 - Added another final verification with xfs_finish_flags() in xfs_fs_reconfigure()
   during remount.

[v1] https://lore.kernel.org/all/7c4202348f67788db55c7ec445cbe3f2d587daf2.1744394929.git.nirjhar.roy.lists@gmail.com/
[1] https://lore.kernel.org/all/Z65o6nWxT00MaUrW@dread.disaster.area/

Nirjhar Roy (IBM) (1):
  xfs: Fail remount with noattr2 on a v5 with v4 enabled

 fs/xfs/xfs_super.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

--
2.43.5


