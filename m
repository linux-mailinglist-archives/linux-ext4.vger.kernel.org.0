Return-Path: <linux-ext4+bounces-8172-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F26AC0421
	for <lists+linux-ext4@lfdr.de>; Thu, 22 May 2025 07:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAB4A1BA14FB
	for <lists+linux-ext4@lfdr.de>; Thu, 22 May 2025 05:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D221A5B99;
	Thu, 22 May 2025 05:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eJJ105uM"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9A1EC5;
	Thu, 22 May 2025 05:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747892664; cv=none; b=hlAe/MhJhFFuY0M0xqqjPRLqqUU2+KCojlkQA22G8WJpJ/iswtlJE04ITYDA6fnalwHy5o0ATAQtskKtumisLD4OGDiVw+JInb7c/xX8uo3o7OVR5EUzDSSxd2+eEXSfTFsSNYaTDXuoidaFhOadFhcpp55UVOFtui8Kz/qd3xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747892664; c=relaxed/simple;
	bh=4zgQ0rA6qLyezBElOOOSoJ0UQp0oY6E9FvJIhphsTEc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EaR9GZBmns3KQ4q7cxD6IsC2NTS5D9m/OEdBLRGrxTtIu2s7Zf794LfOUJjjSPh95gtl5HKFNxovaAkCyo+2jH6FwC3/98oCn3W38crkSm+3PIB5S5Qoj5sUK5x5ZQ388WeV4EuloniRLdxg9O1tSOwLllrPG4fk44DTTgrYgWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eJJ105uM; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-23228b9d684so47090435ad.1;
        Wed, 21 May 2025 22:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747892661; x=1748497461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1dUMqs3TnZ5yeT/dGeAZ0/S9fzNQTyOCwGdr5YL9oRg=;
        b=eJJ105uMIWiHTLtL8uWR0CjRVC5fSc8dyxYsckKJNVODR9ML4Ci4sePitqGWDpOIaz
         e0ZiYsO2FbKDYF4cTz1btNdq5UfDGMyjIf9HESGbzZpJjHlzLe0S6i9YzIMvnU+SPjpJ
         s7TT3Feqw2VqJX24M7LbfsKz6ZPZjadzZNQtOsFcEnLGiioBMCKASq2SKswtuq/oNdRL
         Vh7cJ4aRUOdNhAskhnRsKPk/7i8anrJhvzjeZN1+WtXKtfIaIAoFRQ675Xd9uj+OHR5s
         8GyZAA/6k7BSTbZgF2UKxNy7UtRoCVUycoePLyk77KRXoqAo6EhFTZ26PwTQzovNhcah
         aLfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747892661; x=1748497461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1dUMqs3TnZ5yeT/dGeAZ0/S9fzNQTyOCwGdr5YL9oRg=;
        b=FhuoBdAX55/0CpdkKLv63dcLM1Q2e1th/FV5Qgu2+PFbJk/aEWuEYiu3HgLVf7aVWt
         cKiKrcbiPSxNmkDzooXZJKtr/Jxc1xTIKMoFJHf/Q61grDc1VSIKOsYpk1gocl15aK0n
         LBjrvJ9/7+0dAPdV+L6kbLt/cCZB5co/YXw3NwdqT82KcNgcNaaRVqWHfePpG30sURGm
         4VrLHDS4OXDZP8E+n8xE062KiuNiWZ354p+OqxSAH191xnpb//k3OTGrslqukmwGSja2
         XuWNb5wJvina1jMcWQrY0rWgd/drXR34tlR8ROjLj0C1Jy4K62s9gOeXsBZeAa6RZYI3
         UW2g==
X-Forwarded-Encrypted: i=1; AJvYcCWOLdLcXeqg0wHkdMYCj545UmInKeEKpYEWv3wqcMbZnJklfQe+OkM3cvKve0G4DgLgg4rIzQ5RlxE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkP2HmSrbZTOmWvLin3om3soZGvgRMI7JYZbTgXUGwhn78lNYg
	tyhkWOyymMZkyPSO9P+BumAaAgMco9GZlYXx632nGIRGcQGO8nwkGq9Z8ZOWFw==
X-Gm-Gg: ASbGncsWA4x5oBk/2bLTqCUWlohchZBI+4u7Lhars8EbfZjIwntwPx9UcpQktr2K6x0
	XCTHE/fQDC502uC7txtmGOA0bCGSG3KXKdmGxvpKuZJ+IWyxk4JmRuRgiqbQM7swCAIg/qaPHrS
	lTDuC98jT7PNJqLs1gYFiIuUMimAjQySdUL3NCFePaNhmxS1O/7EpIowFZsihqgG6pMFN4/C9sc
	j4ey1QBeai1R4WyjJs3vxKMrM7a5FVt+YlpBUcd3i31s0HyAds2KAZ68TjbBpuxYdTyIyNsF7rW
	w3czzShlP3WPeJrGTTWjExKi+60kqKR5nf0RegmajQJtJAj2KlLRulM=
X-Google-Smtp-Source: AGHT+IESyuXNbgegmTmyIl0R9FW4FcQWVtJaTDvNcBejey7qa2Htnd7pxn+eEhJ2p+R+EmCTCWnQbQ==
X-Received: by 2002:a17:902:cf42:b0:220:c86d:d7eb with SMTP id d9443c01a7336-231de3ae534mr316314475ad.36.1747892661303;
        Wed, 21 May 2025 22:44:21 -0700 (PDT)
Received: from citest-1.. ([49.205.34.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4adb73esm101577865ad.59.2025.05.21.22.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 22:44:20 -0700 (PDT)
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
Subject: [PATCH v4 2/2] new: Replace "status=0; exit 0" with _exit 0
Date: Thu, 22 May 2025 05:41:35 +0000
Message-Id: <32941e7f8f6244bc85158a9aa5014f376114fb36.1747892223.git.nirjhar.roy.lists@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1747892223.git.nirjhar.roy.lists@gmail.com>
References: <cover.1747892223.git.nirjhar.roy.lists@gmail.com>
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
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Reviewed-by: Zorro Lang <zlang@redhat.com>
---
 new | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/new b/new
index a7ad7135..60ace812 100755
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


