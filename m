Return-Path: <linux-ext4+bounces-7528-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1885EAA03CA
	for <lists+linux-ext4@lfdr.de>; Tue, 29 Apr 2025 08:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 494B97A6878
	for <lists+linux-ext4@lfdr.de>; Tue, 29 Apr 2025 06:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B9E275109;
	Tue, 29 Apr 2025 06:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z28dmLXI"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E9827470;
	Tue, 29 Apr 2025 06:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745909651; cv=none; b=uY2sCKqF81/hdrwhS3AGl20G8gboWWD+tj8Llg9rlo4ZT+E1gAkwpSl51UZwFOb1w7kBBAxhJpWi7VVoOx7sUBsb/0UjwacZTKeJCD1c1DJlw6bBioJcu2n5NxzJ9BD3DFUZ/2pJYD0h8gXO7xZxWNJnKXYhlHskJobpGGVniMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745909651; c=relaxed/simple;
	bh=i0Vjx2wh7A9oxaIr0/tfeLLqiw9glMBzXLzkvuZ6dLc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q3Wc6vd0JFVeWYqOLIJXhT7KrHvTCXh1PRtWgvA8yLV4L+d9las7zV+IPPvTkO1jmU6BFn/qNf0o8MXCZc4dyaQ/iT7GWfHknUvWAm+tfNpfAL36pZZ/zcRt1aMzjevPO5Ks62OTUvd85qIa+CPryOjVKFmU22tSTlVFoRJc2HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z28dmLXI; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22435603572so63911475ad.1;
        Mon, 28 Apr 2025 23:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745909649; x=1746514449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ff/2aKRh++V4xy2pRgvhy/+zjMovvcORnEDcFkhbNic=;
        b=Z28dmLXIoS0WOhVVOhDaCB5j4FT8LeMpRV8Ezr7jIee7KNZHyiNGZm85SCZCda5YEi
         mqr3i4UUUYdhqus4s3RbEGxcERQuDBhhf+Vj+f4VHfz8LjgitVmnaV0DE/c8UZ/YJmBp
         K2tZEi3XBaLDNegO9OjfM7/7WZPjbs5thFDSnlncc4LFfIoXJu3XBSxU64tF8o8D5oKP
         /wEwjZ7rbm9XCU+rpZu/w6P8KES44pZnT7RKJAWNRd+hyi03nZXftwFWD8F+cAEjL9qQ
         epo3pDcaRnw73r2VVhoIHyAwbVSyaLhHdP4yiImIC5ZMu+8j1xZj07p5nUtfjucOa5tf
         GMQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745909649; x=1746514449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ff/2aKRh++V4xy2pRgvhy/+zjMovvcORnEDcFkhbNic=;
        b=Ju3hpI+QBlxtwfzdIfj+7uWM6XMrQ3UdTZy90BNFlprhO/uL4PSuK7HP9W3677KHW5
         3ZVLTxOKNsLMEWab+9KCq0CcbBku2U5Cq+SdRp7mZQw9Tf3v7HZTBWDYHjg+BHIOj5m3
         +SC3Usz45foSlVoFZvPZ91jzPKOTRvLA0G7kNh6oTNspyWZoqH8AraMV9nXJILxwCdyK
         6t6tSlwgkqkru7yPb4KvLZ9tJ6ap+gWKyxktXyvY5ALCI5tJqVr0O9hLdr7OS3rg3qrh
         JJzwkbJyfn24dgRjr4tx7DWsOdoL/mSSdCetUe/v/0ZQeKAjkmvQO+10gWzVDOWKXpkn
         mj+A==
X-Forwarded-Encrypted: i=1; AJvYcCWseNzonM4Jvw6djFCkguD5xDeUvrsvyROzQO5kV5BoWHlJvyecE83pu1X50q4/ghMHLDWf9JvVLhI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzijU8cZdzA+2kwUbPUpMEPvIR37fc3SMMR6uamroK6CTYIKObl
	QNFEBzFdE/k5B47SVW80yV8piw4xoTOwquUdVfm8jDttH0P8p0ODwXBV5w==
X-Gm-Gg: ASbGncuaLf3nxuDzmEwcw/yOaRgYwbDXtvsUXFRefFYhBI483HO6Cvwsaar7+fA7Jd0
	QviFegKpqjVygc9K36p7v/BBZ/mFWs/q4BK7lTdy693At539P0iPc87yrMpSuCGd6ODpEKJ4fRJ
	C2PjlVDmf1/g6ygW6++0OJqrAiF40kHlzU8IGegwKmBkNQxUAObyxpdwusiD5cc5wFWJeQkRtLW
	+eIuBrlSmtm5ct01KVBl2/OOSAe9L4NOtkzc+1CIem1N4Ct0uMDKK9SAXvZrGdiyfZr+LriTeuU
	yJ/XWG8sxUdhLAcI+BYUjCel1+mEEbwCF6KU9U4hssEp/2hEiwIxF9M=
X-Google-Smtp-Source: AGHT+IHjYL1g5roEbCrmEm3QeBEcgFa9njXYGsbCxELuF+FHhdyuQpePxQJym9hJNPoy5iUV6g75hQ==
X-Received: by 2002:a17:902:f70a:b0:21f:1549:a563 with SMTP id d9443c01a7336-22de5ec19b6mr37012835ad.2.1745909648828;
        Mon, 28 Apr 2025 23:54:08 -0700 (PDT)
Received: from citest-1.. ([49.205.34.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ddf3c9d1dsm24149805ad.244.2025.04.28.23.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 23:54:08 -0700 (PDT)
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
Subject: [PATCH v2 2/2] check: Replace exit with _exit in check
Date: Tue, 29 Apr 2025 06:52:54 +0000
Message-Id: <de352e171003ab91fab2328652f8b1990a2d8cce.1745908976.git.nirjhar.roy.lists@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1745908976.git.nirjhar.roy.lists@gmail.com>
References: <cover.1745908976.git.nirjhar.roy.lists@gmail.com>
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
 check | 44 ++++++++++++++++++--------------------------
 1 file changed, 18 insertions(+), 26 deletions(-)

diff --git a/check b/check
index 9451c350..99d38492 100755
--- a/check
+++ b/check
@@ -47,6 +47,7 @@ export DIFF_LENGTH=${DIFF_LENGTH:=10}
 # by default don't output timestamps
 timestamp=${TIMESTAMP:=false}
 
+. common/exit
 rm -f $tmp.list $tmp.tmp $tmp.grep $here/$iam.out $tmp.report.* $tmp.arglist
 
 SRC_GROUPS="generic"
@@ -121,7 +122,7 @@ examples:
  check -X .exclude -g auto
  check -E ~/.xfstests.exclude
 '
-	    exit 1
+	    _exit 1
 }
 
 get_sub_group_list()
@@ -231,7 +232,7 @@ _prepare_test_list()
 			list=$(get_group_list $group)
 			if [ -z "$list" ]; then
 				echo "Group \"$group\" is empty or not defined?"
-				exit 1
+				_exit 1
 			fi
 
 			for t in $list; do
@@ -316,14 +317,14 @@ while [ $# -gt 0 ]; do
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
@@ -361,7 +362,7 @@ done
 # after processing args, overlay needs FSTYP set before sourcing common/config
 if ! . ./common/rc; then
 	echo "check: failed to source common/rc"
-	exit 1
+	_exit 1
 fi
 
 init_rc
@@ -373,8 +374,7 @@ if [ -n "$SOAK_DURATION" ]; then
 		sed -e 's/^\([.0-9]*\)\([a-z]\)*/\1 \2/g' | \
 		$AWK_PROG -f $here/src/soak_duration.awk)"
 	if [ $? -ne 0 ]; then
-		status=1
-		exit 1
+		_exit 1
 	fi
 fi
 
@@ -385,8 +385,7 @@ if [ -n "$FUZZ_REWRITE_DURATION" ]; then
 		sed -e 's/^\([.0-9]*\)\([a-z]\)*/\1 \2/g' | \
 		$AWK_PROG -f $here/src/soak_duration.awk)"
 	if [ $? -ne 0 ]; then
-		status=1
-		exit 1
+		_exit 1
 	fi
 fi
 
@@ -404,8 +403,7 @@ if $have_test_arg; then
 	while [ $# -gt 0 ]; do
 		case "$1" in
 		-*)	echo "Arguments before tests, please!"
-			status=1
-			exit $status
+			_exit 1
 			;;
 		*)	# Expand test pattern (e.g. xfs/???, *fs/001)
 			list=$(cd $SRC_DIR; echo $1)
@@ -438,7 +436,7 @@ fi
 if [ `id -u` -ne 0 ]
 then
     echo "check: QA must be run as root"
-    exit 1
+    _exit 1
 fi
 
 _wipe_counters()
@@ -721,9 +719,9 @@ _prepare_test_list
 fstests_start_time="$(date +"%F %T")"
 
 if $OPTIONS_HAVE_SECTIONS; then
-	trap "_summary; exit \$status" 0 1 2 3 15
+	trap "_summary; _exit" 0 1 2 3 15
 else
-	trap "_wrapup; exit \$status" 0 1 2 3 15
+	trap "_wrapup; _exit" 0 1 2 3 15
 fi
 
 function run_section()
@@ -767,8 +765,7 @@ function run_section()
 	mkdir -p $RESULT_BASE
 	if [ ! -d $RESULT_BASE ]; then
 		echo "failed to create results directory $RESULT_BASE"
-		status=1
-		exit
+		_exit 1
 	fi
 
 	if $OPTIONS_HAVE_SECTIONS; then
@@ -784,8 +781,7 @@ function run_section()
 			echo "our local _test_mkfs routine ..."
 			cat $tmp.err
 			echo "check: failed to mkfs \$TEST_DEV using specified options"
-			status=1
-			exit
+			_exit 1
 		fi
 		# Previous FSTYP derived from TEST_DEV could be changed, source
 		# common/rc again with correct FSTYP to get FSTYP specific configs,
@@ -829,8 +825,7 @@ function run_section()
 	      echo "our local _scratch_mkfs routine ..."
 	      cat $tmp.err
 	      echo "check: failed to mkfs \$SCRATCH_DEV using specified options"
-	      status=1
-	      exit
+	      _exit 1
 	  fi
 
 	  # call the overridden mount - make sure the FS mounts with
@@ -840,8 +835,7 @@ function run_section()
 	      echo "our local mount routine ..."
 	      cat $tmp.err
 	      echo "check: failed to mount \$SCRATCH_DEV using specified options"
-	      status=1
-	      exit
+	      _exit 1
 	  else
 	      _scratch_unmount
 	  fi
@@ -1104,12 +1098,10 @@ for ((iters = 0; iters < $iterations; iters++)) do
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


