Return-Path: <linux-ext4+bounces-7402-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B00A97F71
	for <lists+linux-ext4@lfdr.de>; Wed, 23 Apr 2025 08:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F94B189B252
	for <lists+linux-ext4@lfdr.de>; Wed, 23 Apr 2025 06:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C092676DE;
	Wed, 23 Apr 2025 06:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PeMdjVTt"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C60C264602;
	Wed, 23 Apr 2025 06:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745390547; cv=none; b=iZZI8d4VvmoUWh+XZepNZ5AFbZdkT7FTi+cTe5CdnBoSZnPoOyV6+As1an6rnHNv4qmYuTAW+TBKcQauw0bzExb+ngkMSqgYQALZyR6g6ibynl6bQsV8JynWXBanQjw2f8nK08ALXbAJYvvQvamw03FAfwXjVthU2+018FNYuuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745390547; c=relaxed/simple;
	bh=3sHmtH/fcuqr6uhoWuT2SST1v+xQWAtds51Od6RXPck=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ekIpW8cyvgpQrZm3MhVJJS35JH96uFUrgu0Bw8W9NFqA2J1WZE9Z7iA17Hex9YLfZ3b46ZPF1oTbiTwFa4TH2RdYtXW+uHm5mXlmwyXDcsnFDzVGaaUjW/R+CMMHEOt6bgM28A99xfRHhCQJKHZsb47krtPXxX9jLpINZ+whqug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PeMdjVTt; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b0b2d0b2843so4807101a12.2;
        Tue, 22 Apr 2025 23:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745390545; x=1745995345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g27k7RYdORpTeRKrTufSRWiTfEwEp85jDt+1SSkTjiM=;
        b=PeMdjVTtUGLByPJ12PKsIAK4SLa7wFWBvRhRLOIJeFjggoLO2IPVTzgQmOIJItL4B/
         kacpqQkzYo5fRVNVLVgVUUe5MkWrXf7JFeqkGqanzByaVrjZ8t15g6Ib4RZBf51LAXWA
         DNHxWJORngZP9ecYjmBQJ0ZY9e2Sroeycsdwyrmm1GznW7xW4AF9rFKsxcSKmUzij+Ux
         qys/TN/FK0PUGIo0Om9r5P2WG65DMFsvXKgoM902tktpwwxy0R86lXOweS2HCRshUQfm
         +Ws24ULhr9vSOEtR2RWLZg1aVGvuuUFdPrWF+ptoXJ5XG8PDsCQ79yMzvfmbMvopkL9s
         CK1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745390545; x=1745995345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g27k7RYdORpTeRKrTufSRWiTfEwEp85jDt+1SSkTjiM=;
        b=IWusN9RxE9eAz/1VhET4lTSFAOh8gdyAdCgvlxJbHxBq6SnZtfc71CbsLa4VsD7L0B
         Cl+FvK7RjbjtxUW+zm5KJa+uyJ7YM/pRDrswOUJ90etLDi4ijz5ZQpPR2mSo3QkZusqc
         xkM4TTO2MjftERHgJkTtFFZaOKOxCus3mjSmpjghE+3a1Jj3/L/1uPLJPXHXuRf5vSVN
         u1xBAmqQICEavphdt5ZVGxy1tr/pEPR5r/77qppccuv97RHsu1pbGm+3Y6T0Si3PzHxS
         giiOoR9O6gVpEM9nfZTs1Z6ahH8gFJETuLofvw6Gg/mnKETiztQEopvn5JcghXP2eEfF
         578A==
X-Forwarded-Encrypted: i=1; AJvYcCX+qvusd8JbRdBXH6scilzMcIYF8ouFPgIKCRXfD1+/2p9DSMXd4s3S2w+lLBiKikRHY1CHBKDUC/4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWZ1dTwXxprgY+OilzQobnzMQeAd/Kql2jweg/NEYn4wQYmas1
	m5UkcroQhu+aRN2GqikyR1L+/rtWTJr2qibw3KH6TFiwiDMgUNLPCwzBXQ==
X-Gm-Gg: ASbGncuoIFPVphrCbyUzIJz0h65nl4F+rN4OdSjgxufb8PliOm8OR7zaGSnpOUj9MJF
	pRZQVc2reErWMr73j6ejqrG5ZED8Fhz8uPrxSQTjCogzdmzjbYetAHLL313LJYMgetQnLQ5vQS+
	kjsJ7MNkYlUkyTXb72V2cNEdxEZCCdKhyxCwHm0BBF7AesV/OLqiaQv7rWjxlXjOc+oP4cNQEng
	nV20urEX3QizeMTUXFatmgrQf+exOF5lZH6KgbO1DGPzCg6kXOmdhVRqcXymnErWspr8bUqBwZb
	kLzXMBgeTeYeTsAXCq3qOJJTllnJpprCwa99nf0h5JBo
X-Google-Smtp-Source: AGHT+IE2ksOZAMjPFCRblotYyVZE5eWd+S7wBhFabH0fFByfxwyBRPweOnKrkOiigeFyVvafceLVqg==
X-Received: by 2002:a17:90b:51d1:b0:2ff:6788:cc67 with SMTP id 98e67ed59e1d1-3087bbbb5damr21865487a91.34.1745390545005;
        Tue, 22 Apr 2025 23:42:25 -0700 (PDT)
Received: from citest-1.. ([49.205.34.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-309df9f051csm897705a91.4.2025.04.22.23.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 23:42:24 -0700 (PDT)
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
Subject: [PATCH v1 2/2] check: Replace exit with _exit in check
Date: Wed, 23 Apr 2025 06:41:35 +0000
Message-Id: <7d8587b8342ee2cbe226fb691b372ac7df5fdb71.1745390030.git.nirjhar.roy.lists@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1745390030.git.nirjhar.roy.lists@gmail.com>
References: <cover.1745390030.git.nirjhar.roy.lists@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some of the "status=<val>;exit" and "exit <val>" were not
replace with _exit <val>. Doing it now.

Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
---
 check | 39 +++++++++++++++------------------------
 1 file changed, 15 insertions(+), 24 deletions(-)

diff --git a/check b/check
index 67355c52..30d44c0e 100755
--- a/check
+++ b/check
@@ -122,7 +122,7 @@ examples:
  check -X .exclude -g auto
  check -E ~/.xfstests.exclude
 '
-	    exit 1
+	    _exit 1
 }
 
 get_sub_group_list()
@@ -232,7 +232,7 @@ _prepare_test_list()
 			list=$(get_group_list $group)
 			if [ -z "$list" ]; then
 				echo "Group \"$group\" is empty or not defined?"
-				exit 1
+				_exit 1
 			fi
 
 			for t in $list; do
@@ -317,14 +317,14 @@ while [ $# -gt 0 ]; do
 	-r)
 		if $exact_order; then
 			echo "Cannot specify -r and --exact-order."
-			exit 1
+			_exit 1
 		fi
 		randomize=true
 		;;
 	--exact-order)
 		if $randomize; then
 			echo "Cannnot specify --exact-order and -r."
-			exit 1
+			_exit 1
 		fi
 		exact_order=true
 		;;
@@ -362,7 +362,7 @@ done
 # after processing args, overlay needs FSTYP set before sourcing common/config
 if ! . ./common/rc; then
 	echo "check: failed to source common/rc"
-	exit 1
+	_exit 1
 fi
 
 init_rc
@@ -374,8 +374,7 @@ if [ -n "$SOAK_DURATION" ]; then
 		sed -e 's/^\([.0-9]*\)\([a-z]\)*/\1 \2/g' | \
 		$AWK_PROG -f $here/src/soak_duration.awk)"
 	if [ $? -ne 0 ]; then
-		status=1
-		exit 1
+		_exit 1
 	fi
 fi
 
@@ -386,8 +385,7 @@ if [ -n "$FUZZ_REWRITE_DURATION" ]; then
 		sed -e 's/^\([.0-9]*\)\([a-z]\)*/\1 \2/g' | \
 		$AWK_PROG -f $here/src/soak_duration.awk)"
 	if [ $? -ne 0 ]; then
-		status=1
-		exit 1
+		_exit 1
 	fi
 fi
 
@@ -405,8 +403,7 @@ if $have_test_arg; then
 	while [ $# -gt 0 ]; do
 		case "$1" in
 		-*)	echo "Arguments before tests, please!"
-			status=1
-			exit $status
+			_exit 1
 			;;
 		*)	# Expand test pattern (e.g. xfs/???, *fs/001)
 			list=$(cd $SRC_DIR; echo $1)
@@ -439,7 +436,7 @@ fi
 if [ `id -u` -ne 0 ]
 then
     echo "check: QA must be run as root"
-    exit 1
+    _exit 1
 fi
 
 _wipe_counters()
@@ -768,8 +765,7 @@ function run_section()
 	mkdir -p $RESULT_BASE
 	if [ ! -d $RESULT_BASE ]; then
 		echo "failed to create results directory $RESULT_BASE"
-		status=1
-		exit
+		_exit 1
 	fi
 
 	if $OPTIONS_HAVE_SECTIONS; then
@@ -785,8 +781,7 @@ function run_section()
 			echo "our local _test_mkfs routine ..."
 			cat $tmp.err
 			echo "check: failed to mkfs \$TEST_DEV using specified options"
-			status=1
-			exit
+			_exit 1
 		fi
 		# Previous FSTYP derived from TEST_DEV could be changed, source
 		# common/rc again with correct FSTYP to get FSTYP specific configs,
@@ -830,8 +825,7 @@ function run_section()
 	      echo "our local _scratch_mkfs routine ..."
 	      cat $tmp.err
 	      echo "check: failed to mkfs \$SCRATCH_DEV using specified options"
-	      status=1
-	      exit
+	      _exit 1
 	  fi
 
 	  # call the overridden mount - make sure the FS mounts with
@@ -841,8 +835,7 @@ function run_section()
 	      echo "our local mount routine ..."
 	      cat $tmp.err
 	      echo "check: failed to mount \$SCRATCH_DEV using specified options"
-	      status=1
-	      exit
+	      _exit 1
 	  else
 	      _scratch_unmount
 	  fi
@@ -1105,12 +1098,10 @@ for ((iters = 0; iters < $iterations; iters++)) do
 		run_section $section
 		if [ "$sum_bad" != 0 ] && [ "$istop" = true ]; then
 			interrupt=false
-			status=`expr $sum_bad != 0`
-			exit
+			_exit `expr $sum_bad != 0`
 		fi
 	done
 done
 
 interrupt=false
-status=`expr $sum_bad != 0`
-exit
+_exit `expr $sum_bad != 0`
-- 
2.34.1


