Return-Path: <linux-ext4+bounces-7581-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C19AA4B85
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Apr 2025 14:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49607175CDA
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Apr 2025 12:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8BB2586E2;
	Wed, 30 Apr 2025 12:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m7TPhEUf"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661E82DC768;
	Wed, 30 Apr 2025 12:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746017193; cv=none; b=HkMDXloRhYFlplWd0IV/3TjInrDAPMXifamWZRmJIC/imAeKmzcPgDFUu9+VPPrGlHw1N7Tu2QBrWfBlCsfaVtKh/XDsEhhh8JG7ism91XfBcW0xQfVA69YQKkDF2PLHosllwjDsCQ2R4tfwyltSDiNQz7V/NLopPxIeuUDQoC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746017193; c=relaxed/simple;
	bh=05wmw0PNlW+lshHBZbxuRHF/HIb+22Yu/4FYn/3oy3U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gUiOd9G/kRE4HmWIEGbBmzJ089iLcfJ+IEpaGM4+rpUD0nmsCtRZbpo7jiTDmOJQIofSf/WafXUYDBk/YNNJ0mFp5M2c9OSoOhVdThd5SKzThWBqnedHknMLzZb6iEuJCNV2Ja6Rpm2D9vIuLmi6dbg4RWqQrH2lwFseU/Y0XYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m7TPhEUf; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-af5085f7861so5393107a12.3;
        Wed, 30 Apr 2025 05:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746017191; x=1746621991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BbHA87LFH4GaNzFVBuJSnPYBoYVkkcanETe2Vt96c9c=;
        b=m7TPhEUfM786K+pOt6r42BeOMdQpHtmnqfu00RMXuf0k/lO3sMS6nynVrJqESYCmUQ
         rL9YoBRvjFh48NggOqPeBzGJ841g9cyAbEW27bRzhJb2giINaIBAdQv/kJUbx9Fjis9v
         1hKouslL4ZLpQA6lYu5+3bDLxsmMZZ0NeUndPyOprE3IuwTvx9SH8KW5gvXGiLOPnv/o
         ed4aMx5c1X8csL1/bwrFFjWqvgcjRHaIxkN1GuV7gmu+5FIWvrj22617DCzx5wvHbPL+
         CToELckQvAolVKD4actYX8JFjIMXO1p528TJtLiAvqCZf2NIYtTJC4AKNUAWgaPglteo
         numw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746017191; x=1746621991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BbHA87LFH4GaNzFVBuJSnPYBoYVkkcanETe2Vt96c9c=;
        b=gEdV/jBAfZOaLk4Nuy+fIq1NafuB1f2zRl61SJ5O1wB16h0Gx+WfafTmqYvaajNCiK
         hh85PM7exoDI4Iq9PhKX/Z//y3memfRciWHqu9rUykIVB+8F4P576+r7bhlfvdmjhnZP
         3UDy0JiK6FuOlHZ0BtAvfpVx0E9QK4B+72/S+FV8xI1P9DT1NwkUux188XLoHaMGPwdC
         /jrBjWWIgkbCJ4dW6VdM8RlEXjT/JPNNQKWOka3wUrK+UMV1zl8ZeVhx1KdvDsHO4TiL
         hXrJ6GalqQ006a1F2fGDkxzpfyh4ZoMMLfopsafPrM2kMO05qfNE2WqEmJ9OYHcm2PUU
         xR7w==
X-Forwarded-Encrypted: i=1; AJvYcCWlT+SnL05p+NyJYhOpwVrGKYvxnNHJOrpOqD1952qyEVHXWnSpPwsq3TKkiIGPqXGy4XmJ3tX41kA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJAXfOGl2u07rYTNJI5rkmDHa9E/3O8+1NmjABn0/g4OU4uO9H
	1o6O6QP87JZWHGZcpaK7Dw+HE3DtR3+SO1xz1ez3WvnbJAQ5rrVO9D4w8Q==
X-Gm-Gg: ASbGncubVk+8aZTSOF/Y2JygcTKP+4Cf3TrSK5PUWZHEPeJLGpJ1ihy3GqCxJMIOEXt
	53f2fWsLVFM1ppZ7NfMcQhirIqFr6NS8WzvsUAJNSM8GIeIZPs2OT9YgChxZp5i/DqctneASToZ
	K0zFYxIWGHo3M/xChZul/ES7LpqsY4Uno14ugTQeX7NdLTQ2Xz/0p9gO+l9S5R/wrRoYPGps9cy
	8NK8m+1kZxIUJxC0GN/WUiRRyTYtnN8gFMOd1jOoJOzhFyFaO0iZAe4UMK34oh0YEV/WEk82mMZ
	DG0kpDlTVQphUZnqbzPL29/dCcIs/tCZl7qL01HgYElw
X-Google-Smtp-Source: AGHT+IHpef0TJYwljbgWsRzkDi98MY7IUWjSFtw4rwzTFJUhU9SXKJvIuU/EZMqXO++bq/wc9N/TNA==
X-Received: by 2002:a17:90b:3d84:b0:309:f5c6:4c5c with SMTP id 98e67ed59e1d1-30a34450c14mr3765350a91.25.1746017190577;
        Wed, 30 Apr 2025 05:46:30 -0700 (PDT)
Received: from citest-1.. ([49.205.34.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30a349e4a40sm1476540a91.6.2025.04.30.05.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 05:46:30 -0700 (PDT)
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
To: fstests@vger.kernel.org
Cc: linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	ritesh.list@gmail.com,
	ojaswin@linux.ibm.com,
	djwong@kernel.org,
	zlang@kernel.org,
	david@fromorbit.com,
	hch@infradead.org,
	nirjhar.roy.lists@gmail.com
Subject: [PATCH v3 2/2] check: Replace exit with _fatal and _exit in check
Date: Wed, 30 Apr 2025 12:45:23 +0000
Message-Id: <34273527dab73c9e03415a7c3d6d118980929396.1746015588.git.nirjhar.roy.lists@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1746015588.git.nirjhar.roy.lists@gmail.com>
References: <cover.1746015588.git.nirjhar.roy.lists@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some of the "status=<val>;exit" and "exit <val>" were not
replaced with _exit <val> and _fatal. Doing it now.

Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
---
 check | 52 ++++++++++++++++++----------------------------------
 1 file changed, 18 insertions(+), 34 deletions(-)

diff --git a/check b/check
index bd84f213..ede54f69 100755
--- a/check
+++ b/check
@@ -123,7 +123,7 @@ examples:
  check -X .exclude -g auto
  check -E ~/.xfstests.exclude
 '
-	    exit 1
+	    _fatal
 }
 
 get_sub_group_list()
@@ -232,8 +232,7 @@ _prepare_test_list()
 		for group in $GROUP_LIST; do
 			list=$(get_group_list $group)
 			if [ -z "$list" ]; then
-				echo "Group \"$group\" is empty or not defined?"
-				exit 1
+				_fatal "Group \"$group\" is empty or not defined?"
 			fi
 
 			for t in $list; do
@@ -317,15 +316,13 @@ while [ $# -gt 0 ]; do
 	-n)	showme=true ;;
 	-r)
 		if $exact_order; then
-			echo "Cannot specify -r and --exact-order."
-			exit 1
+			_fatal "Cannot specify -r and --exact-order."
 		fi
 		randomize=true
 		;;
 	--exact-order)
 		if $randomize; then
-			echo "Cannnot specify --exact-order and -r."
-			exit 1
+			_fatal "Cannnot specify --exact-order and -r."
 		fi
 		exact_order=true
 		;;
@@ -362,8 +359,7 @@ done
 # we need common/rc, that also sources common/config. We need to source it
 # after processing args, overlay needs FSTYP set before sourcing common/config
 if ! . ./common/rc; then
-	echo "check: failed to source common/rc"
-	exit 1
+	_fatal "check: failed to source common/rc"
 fi
 
 init_rc
@@ -375,8 +371,7 @@ if [ -n "$SOAK_DURATION" ]; then
 		sed -e 's/^\([.0-9]*\)\([a-z]\)*/\1 \2/g' | \
 		$AWK_PROG -f $here/src/soak_duration.awk)"
 	if [ $? -ne 0 ]; then
-		status=1
-		exit 1
+		_fatal
 	fi
 fi
 
@@ -387,8 +382,7 @@ if [ -n "$FUZZ_REWRITE_DURATION" ]; then
 		sed -e 's/^\([.0-9]*\)\([a-z]\)*/\1 \2/g' | \
 		$AWK_PROG -f $here/src/soak_duration.awk)"
 	if [ $? -ne 0 ]; then
-		status=1
-		exit 1
+		_fatal
 	fi
 fi
 
@@ -405,9 +399,7 @@ fi
 if $have_test_arg; then
 	while [ $# -gt 0 ]; do
 		case "$1" in
-		-*)	echo "Arguments before tests, please!"
-			status=1
-			exit $status
+		-*)	_fatal "Arguments before tests, please!"
 			;;
 		*)	# Expand test pattern (e.g. xfs/???, *fs/001)
 			list=$(cd $SRC_DIR; echo $1)
@@ -439,8 +431,7 @@ fi
 
 if [ `id -u` -ne 0 ]
 then
-    echo "check: QA must be run as root"
-    exit 1
+    _fatal "check: QA must be run as root"
 fi
 
 _wipe_counters()
@@ -722,6 +713,9 @@ _detect_kmemleak
 _prepare_test_list
 fstests_start_time="$(date +"%F %T")"
 
+# We are not using _exit in the trap handler so that it is obvious to the reader
+# that we are using the last set value of "status" before we finally exit
+# from the check script.
 if $OPTIONS_HAVE_SECTIONS; then
 	trap "_summary; exit \$status" 0 1 2 3 15
 else
@@ -768,9 +762,7 @@ function run_section()
 
 	mkdir -p $RESULT_BASE
 	if [ ! -d $RESULT_BASE ]; then
-		echo "failed to create results directory $RESULT_BASE"
-		status=1
-		exit
+		_fatal "failed to create results directory $RESULT_BASE"
 	fi
 
 	if $OPTIONS_HAVE_SECTIONS; then
@@ -785,9 +777,7 @@ function run_section()
 		then
 			echo "our local _test_mkfs routine ..."
 			cat $tmp.err
-			echo "check: failed to mkfs \$TEST_DEV using specified options"
-			status=1
-			exit
+			_fatal "check: failed to mkfs \$TEST_DEV using specified options"
 		fi
 		# Previous FSTYP derived from TEST_DEV could be changed, source
 		# common/rc again with correct FSTYP to get FSTYP specific configs,
@@ -830,9 +820,7 @@ function run_section()
 	  then
 	      echo "our local _scratch_mkfs routine ..."
 	      cat $tmp.err
-	      echo "check: failed to mkfs \$SCRATCH_DEV using specified options"
-	      status=1
-	      exit
+	      _fatal "check: failed to mkfs \$SCRATCH_DEV using specified options"
 	  fi
 
 	  # call the overridden mount - make sure the FS mounts with
@@ -841,9 +829,7 @@ function run_section()
 	  then
 	      echo "our local mount routine ..."
 	      cat $tmp.err
-	      echo "check: failed to mount \$SCRATCH_DEV using specified options"
-	      status=1
-	      exit
+	      _fatal "check: failed to mount \$SCRATCH_DEV using specified options"
 	  else
 	      _scratch_unmount
 	  fi
@@ -1106,12 +1092,10 @@ for ((iters = 0; iters < $iterations; iters++)) do
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


