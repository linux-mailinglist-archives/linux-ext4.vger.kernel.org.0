Return-Path: <linux-ext4+bounces-6684-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B346BA5448C
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Mar 2025 09:20:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F09B23A7F8C
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Mar 2025 08:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6F11FCF7C;
	Thu,  6 Mar 2025 08:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JoD1PK45"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A76C1FAC52;
	Thu,  6 Mar 2025 08:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741249192; cv=none; b=hYx7WUu4gP1bApnq2PKcJG3C4et2X0uTDcCwPDF6roDFmcfGAUrVk2ygWEMhD3f90gcvqVe4txSBGMcpRAC4ae/BcfJ5M/rKOIGBIOwd7iMGmlVEMlNVAhyi86xHLTuxSVQDAUb9aJoZNNht2HT4n1XumpSQsuwMRKEXkK6r4PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741249192; c=relaxed/simple;
	bh=c+f0OZcVWbJ6QMYL8/h3WwH9CgCeH2CG5zX300UAEQk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aIHXYwuHrlhL4CGfmiBqeQQ66+AIJX/HriKRW0X/a6r63BBZmc1c3u7uHE12DW5EQLC8ka4U5v6FKCrp3KpgTtIXcgJxbqh+wn9dYzD/C8hQUCCrDZy4QiWlcERTmD03Gi/KXszpbm+cFGt7V4yRREiWabhX3J/yUMkfRwjTlSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JoD1PK45; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22382657540so5329155ad.2;
        Thu, 06 Mar 2025 00:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741249189; x=1741853989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7spQo7HRygEnDfcz3J8RFkEf+2FA2JlqPcApHdV2Dj0=;
        b=JoD1PK45agxEBT/AuJCjspbrZ7xtQAlFBv5WVS3d6brFJhol+KMD3AHXvezutFC+PH
         3g1B/h3+mJ8jFnEVZ6kxj1FVaBpYPPrsIfVVQ0vERyq4fE/4QDsGq0Qw4ao9wC4CDZof
         YeiFXJ3Ms3aw0oJJ0LdbU3CdXU4czdONyjtQP2htiZfIGVT9WR2ztVVVIfFX/W7Rofrq
         GdYab3bYiR1TVdIOPlTbGTd9av4Y+ncmorrrbvFcDiX2/0kLxgHPwWH+CWdWPCv7Y33P
         anKv6dEO/4Qvym6VC35vfDp8uetpVpFh4DGRhKpSE0RKU3PzIFy4kuTcUCzogxc9sSO6
         oduw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741249189; x=1741853989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7spQo7HRygEnDfcz3J8RFkEf+2FA2JlqPcApHdV2Dj0=;
        b=X9D5dd80eEcMMVN3gXZLLbkYbOpM4xjSufFOyHAI7eIM/C3aqfgmbRvrCqb4hIQ2RU
         kDBbfKWIrKBSQlM2t8rLMS8YDmw6Lo06JtEt9DxoUr9JJvqJDSRUacNwxwR4e6XY2C/3
         Rs22Bbp1C5i/rXULrSjWyvueQ285dlGm9YRLcyZVnO7iTWAlisOHvZMOcvZTHUPfRxn9
         88yfc1naY8SkOWXRMge/Ev+UKxCdW590kpQol7wG5H87eRFCRNm6i/hfwOtYQX4rXWpS
         T3ylVFNKRuQUmHlURFOnDvGa+kCSRiiILjwtqmEMeis7Awcz/fj4hDARdNoP3sToGafn
         0BVw==
X-Forwarded-Encrypted: i=1; AJvYcCUVzZH1FR0pFpQ5Wgjzx01XiQKSPwoveQ88Kql4R4xzyuotdvKqQHoW0A/gKI69DuEaXuZcELS1GvY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEPRgoTURK3PMWlUKL1iEIsT7TY+Zrywpr3IKHUkAZqomAeoeL
	Rv8zxjfKLzFTyMHbaWRGXXsMb9qBVUeqYX+IIw1deqcNvIvoYhBmrkitpA==
X-Gm-Gg: ASbGnctUv5Eqj14LbTLh226K4RMoZPXh18YgPMz9faWpQE4RfTBx2SyM1THOXN2/qnB
	qZc8vmsEDM5d76eKVzekQVx6MB6fBrtRNHf5dSpBUlceg0rqehJ8na1JeAy1wt3R33d2J8rBIzs
	TSpLr2t7SV314GZXWYa3TtYrz5cEIQG0mmW16YlWLatK6rv5BG4gl+wD/V0v6zeg+qC+qa+br7z
	Y2eERzVZIOV0a2MUxx3peA3+dIGM46oDwT/9+MiATKVPjsnM9Ve89M9tz+NpetADy/Civ3Qf026
	d6yl/IMVFVn/iR1rAEbMuy1WDeRp6jy6f1zsbCa/fBOjYw==
X-Google-Smtp-Source: AGHT+IF3dzHYnbgHlEDo6Z8uvohC8WwvIguwOVSpERGwKXrD3seDgpGiK9hmFmBSbbMY6HIvIajZVg==
X-Received: by 2002:a05:6a21:99a4:b0:1f3:3493:b64a with SMTP id adf61e73a8af0-1f3494fd9b5mr10383073637.21.1741249189211;
        Thu, 06 Mar 2025 00:19:49 -0800 (PST)
Received: from citest-1.. ([49.37.39.11])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af2810c6349sm660257a12.46.2025.03.06.00.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 00:19:48 -0800 (PST)
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
Subject: [PATCH v1 2/2] check,common/{preamble,rc},soak: Decoupling init_rc() call from sourcing common/rc
Date: Thu,  6 Mar 2025 08:17:41 +0000
Message-Id: <1d07e5657c2817c74e939894bb554424199fd290.1741248214.git.nirjhar.roy.lists@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1741248214.git.nirjhar.roy.lists@gmail.com>
References: <cover.1741248214.git.nirjhar.roy.lists@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Silently executing scripts during sourcing common/rc doesn't look good
and also causes unnecessary script execution. Decouple init_rc() call
and call init_rc() explicitly where required.

Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
---
 check           | 10 ++--------
 common/preamble |  1 +
 common/rc       |  2 --
 soak            |  1 +
 4 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/check b/check
index ea92b0d6..d30af1ba 100755
--- a/check
+++ b/check
@@ -840,16 +840,8 @@ function run_section()
 		_prepare_test_list
 	elif [ "$OLD_TEST_FS_MOUNT_OPTS" != "$TEST_FS_MOUNT_OPTS" ]; then
 		_test_unmount 2> /dev/null
-		if ! _test_mount
-		then
-			echo "check: failed to mount $TEST_DEV on $TEST_DIR"
-			status=1
-			exit
-		fi
 	fi
 
-	init_rc
-
 	seq="check.$$"
 	check="$RESULT_BASE/check"
 
@@ -870,6 +862,8 @@ function run_section()
 	needwrap=true
 
 	if [ ! -z "$SCRATCH_DEV" ]; then
+		_check_mounted_on SCRATCH_DEV $SCRATCH_DEV SCRATCH_MNT $SCRATCH_MNT
+		[ $? -le 1 ] || exit 1
 	  _scratch_unmount 2> /dev/null
 	  # call the overridden mkfs - make sure the FS is built
 	  # the same as we'll create it later.
diff --git a/common/preamble b/common/preamble
index 0c9ee2e0..c92e55bb 100644
--- a/common/preamble
+++ b/common/preamble
@@ -50,6 +50,7 @@ _begin_fstest()
 	_register_cleanup _cleanup
 
 	. ./common/rc
+	init_rc
 
 	# remove previous $seqres.full before test
 	rm -f $seqres.full $seqres.hints
diff --git a/common/rc b/common/rc
index d2de8588..f153ad81 100644
--- a/common/rc
+++ b/common/rc
@@ -5754,8 +5754,6 @@ _require_program() {
 	_have_program "$1" || _notrun "$tag required"
 }
 
-init_rc
-
 ################################################################################
 # make sure this script returns success
 /bin/true
diff --git a/soak b/soak
index d5c4229a..5734d854 100755
--- a/soak
+++ b/soak
@@ -5,6 +5,7 @@
 
 # get standard environment, filters and checks
 . ./common/rc
+# ToDo: Do we need an init_rc() here? How is soak used?
 . ./common/filter
 
 tmp=/tmp/$$
-- 
2.34.1


