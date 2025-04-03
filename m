Return-Path: <linux-ext4+bounces-7045-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD271A79F75
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Apr 2025 11:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F25C718983D3
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Apr 2025 09:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB2A2505CD;
	Thu,  3 Apr 2025 08:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TEYoQdBK"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D32F24DFE2;
	Thu,  3 Apr 2025 08:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743670772; cv=none; b=JX9ePa+IbdiARiuZZpVqlhI+bIvU8wvY7tDwBuaTc6jnYW+SGz+Rx2QGyK2CtiwWeTR7wESzEK7lCfCG6bvo/5wg/0q1Xxwa7fG+7TXOAxCk8Ybh2inPT+zAcHjK3J+ereblt2PWXVXu4jxxkRmbpo2IcZklh2AsbDqqSK76oes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743670772; c=relaxed/simple;
	bh=YPsD6BmQF9RNGFUOzhC8nd5c/Q5+Ap+meRgORq8s5bw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q+BrGQS86VZcr9+uRJtc4fLDCOpqPf04MWuNh9djoDbTwPAHFUA9n8H2EKE6VJON3N24Ah6lBBwNloM01EJPliY3J+WYCyqk9xorZ4li0+8k+/g4PVo3Qbt9t38fsIRsjVtqsqkKU0OaNj/H6+lzQqDo1vrdsQG9gEMZuZjlmBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TEYoQdBK; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-227914acd20so19284895ad.1;
        Thu, 03 Apr 2025 01:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743670760; x=1744275560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4PXwhjc8Cv5eEL1uUpHB3F+rJFG0NxsfWWqy/FqzBHk=;
        b=TEYoQdBKfdw8nzk4k1rXj2Aw0gV9jBfAZoiAiV0drXv/3kYW68Ho5sE93ZxLzFSw5K
         mvoy8LqInkaKMvp42QChA6MCm35RvWKc/ZIQWsrBl5RXiBi9UqT+RYw3PCgVSoFkYLmr
         hcAMZsEnwShzqcnQmNz9sk5CtkURSC4ENDywvFL9WXdcXY6NrffD2rcJLH9ookoS+aAk
         pc2vzutVTEZWLXQHs0G77BvKvCqjDXOaGLOfaD4Xt9p9zPVvG6Q//6J4O7i2O4H4bc9A
         69cgZWtkMAQNJYDhigU/FA6fksxd6lZGXxFTsj3EHnvNjN+rC2kdoZLt8JcspmV9fid0
         9rog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743670760; x=1744275560;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4PXwhjc8Cv5eEL1uUpHB3F+rJFG0NxsfWWqy/FqzBHk=;
        b=XxyGqojM4D3rox3f+wUzEIKtq+CkYVR2qZ87n4DO9sbzu+Px90jF0wz5tupGHaMyAJ
         MwxtS9Zig6pYRN2X7a/hEHIYP2ABDiyz0PwnfV6D9lu4C5vKtQybtQlKW4LevvkHk3Gu
         Gpv5fG+qGmFjLgGGYAe/+wjqP+7YqXNZh0NNpJ3GlwI3r+BQAlAKFXhW0ki89wR3DMQ4
         MFQGbHNzSfvn4vcm39ka6nNbaK+E7ZQfeK9lQbCoxnOYuFXZdAEY/pLLWlWp0NifuN6e
         WB+s2ANQcOrS9StBu4yLbG6YCgO7xfz7lBYjG29qtgFPXpQyrkPuV4+mVFu8LBFe64qS
         RPuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUY4SzkyQE2RmXBIHCqarvKFY3xUipYD9f1t8GjvQ50GxeTN6Nrdt5FZLK3qkpVcuUGobAwixue7fM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNQ/050g92OWm3eNtwwD/TGBTZnma3lf0YK8/ozbYNWHlQ/tdN
	Up0jDuHesUTof+Pt+K2ZLiWDnnut4PYJ+A6TzOQyisrfXJhHnZsV/qUl6A==
X-Gm-Gg: ASbGncvOp5KHeeuQzyZiUzHpc6yoxPPoRZ2B94ivOleuGLTO4+F59wBegz33uXJRFVi
	K84Mu751JNaCGisSqdfjYJFhs++PLqzL6+FNe6PZW94B985tJAZ0loiek9pSrJ6X8N7fFIRwlld
	GQ7U+FvV5sV+rq/13qki+DbigpGLYXXVungLhM8nJtTQg6bDhnp167lwvaijnEWVDxmpll661eD
	C1awLpQIUEvkcXv/58Aj/xV9mV2y7IMwETENVe8mVLg7Hck8M4fk8y8RSHyBGLAhEfXsO0Npe/6
	NBuCq/zhVl3uyVLTCCy7kde51zszy//D2T8AE5ME7R2Myz3O
X-Google-Smtp-Source: AGHT+IFsCHRVkS0W9RQ4ljdzof/v2lVMfyPbA0C1bnWDvE4blEZwx0AmNiv4mJmNOdWKiJpfF+NZrw==
X-Received: by 2002:a17:903:1b0c:b0:215:a303:24e9 with SMTP id d9443c01a7336-229765ba844mr35776985ad.3.1743670760402;
        Thu, 03 Apr 2025 01:59:20 -0700 (PDT)
Received: from citest-1.. ([49.205.34.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-229785c01cdsm9535715ad.99.2025.04.03.01.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 01:59:20 -0700 (PDT)
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
Subject: [PATCH v2 2/3] check: Add -q <n> option to support unconditional looping.
Date: Thu,  3 Apr 2025 08:58:19 +0000
Message-Id: <762d80d522724f975df087c1e92cdd202fd18cae.1743670253.git.nirjhar.roy.lists@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1743670253.git.nirjhar.roy.lists@gmail.com>
References: <cover.1743670253.git.nirjhar.roy.lists@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds -q <n> option through which one can run a given test <n>
times unconditionally. It also prints pass/fail metrics at the end.

The advantage of this over -L <n> and -i/-I <n> is that:
    a. -L <n> will not re-run a flakey test if the test passes for the first time.
    b. -I/-i <n> sets up devices during each iteration and hence slower.
Note -q <n> will override -L <n>.

Also rename _stash_fail_loop_files() to _stash_loop_files()
because this function will now be used even when the test doesn't fail
(i.e. when ran with -q <n>).

Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
Co-developed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 check | 46 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 36 insertions(+), 10 deletions(-)

diff --git a/check b/check
index 32890470..f6007750 100755
--- a/check
+++ b/check
@@ -11,6 +11,7 @@ needsum=true
 try=()
 sum_bad=0
 bad=()
+is_bad_test=false
 notrun=()
 interrupt=true
 diff="diff -u"
@@ -27,6 +28,7 @@ DUMP_OUTPUT=false
 iterations=1
 istop=false
 loop_on_fail=0
+loop_unconditional=0
 exclude_tests=()
 
 # This is a global variable used to pass test failure text to reporting gunk
@@ -83,6 +85,7 @@ check options
     -s section		run only specified section from config file
     -S section		exclude the specified section from the config file
     -L <n>		loop tests <n> times following a failure, measuring aggregate pass/fail metrics
+    -q <n>		loop tests <n> times irrespective of a pass or a failure, measuring aggregate pass/fail metrics
 
 testlist options
     -g group[,group...]	include tests from these groups
@@ -341,7 +344,9 @@ while [ $# -gt 0 ]; do
 	-L)	[[ $2 =~ ^[0-9]+$ ]] || usage
 		loop_on_fail=$2; shift
 		;;
-
+	-q)	[[ $2 =~ ^[0-9]+$ ]] || usage
+		loop_unconditional=$(($2 - 1)); shift
+		;;
 	-*)	usage ;;
 	*)	# not an argument, we've got tests now.
 		have_test_arg=true ;;
@@ -357,6 +362,11 @@ while [ $# -gt 0 ]; do
 	shift
 done
 
+# -q <n> overrides -L <m>
+if [ "$loop_unconditional" -gt 0 ]; then
+	loop_on_fail=0
+fi
+
 # we need common/rc, that also sources common/config. We need to source it
 # after processing args, overlay needs FSTYP set before sourcing common/config
 if ! . ./common/rc; then
@@ -609,7 +619,7 @@ _expunge_test()
 }
 
 # retain files which would be overwritten in subsequent reruns of the same test
-_stash_fail_loop_files() {
+_stash_loop_files() {
 	local seq_prefix="${REPORT_DIR}/${1}"
 	local cp_suffix="$2"
 
@@ -633,10 +643,18 @@ _stash_test_status() {
 	fi
 
 	if ((${#loop_status[*]} > 0)); then
-		# continuing or completing rerun-on-failure loop
-		_stash_fail_loop_files "$test_seq" ".rerun${#loop_status[*]}"
+		# continuing or completing rerun loop
+		_stash_loop_files "$test_seq" ".rerun${#loop_status[*]}"
 		loop_status+=("$test_status")
-		if ((${#loop_status[*]} > loop_on_fail)); then
+
+		# only stash @bad result for initial failure in loop
+		if [[ "$test_status" == "fail" ]] && ! $is_bad_test; then
+			bad+=("$test_seq")
+			is_bad_test=true
+		fi
+
+		if ((loop_on_fail && ${#loop_status[*]} > loop_on_fail)) || \
+		   ((loop_unconditional && ${#loop_status[*]} > loop_unconditional)); then
 			printf "%s aggregate results across %d runs: " \
 				"$test_seq" "${#loop_status[*]}"
 			awk "BEGIN {
@@ -650,23 +668,30 @@ _stash_test_status() {
 				}'
 			echo
 			loop_status=()
+			is_bad_test=false
 		fi
-		return	# only stash @bad result for initial failure in loop
+		return
 	fi
 
 	case "$test_status" in
 	fail)
-		if ((loop_on_fail > 0)); then
-			# initial failure, start rerun-on-failure loop
-			_stash_fail_loop_files "$test_seq" ".rerun0"
+		# re-run if either of the loop argument is set
+		if ((loop_on_fail > 0)) || ((loop_unconditional > 0)); then
+			_stash_loop_files "$test_seq" ".rerun0"
 			loop_status+=("$test_status")
 		fi
 		bad+=("$test_seq")
+		is_bad_test=true
 		;;
 	list|notrun)
 		notrun+=("$test_seq")
 		;;
 	pass|expunge)
+		# re-run if loop_unconditional argument is set
+		if ((loop_unconditional > 0)); then
+			_stash_loop_files "$test_seq" ".rerun0"
+			loop_status+=("$test_status")
+		fi
 		;;
 	*)
 		echo "Unexpected test $test_seq status: $test_status"
@@ -852,7 +877,8 @@ function run_section()
 	seqres="$check"
 	_check_test_fs
 
-	loop_status=()	# track rerun-on-failure state
+	is_bad_test=false
+	loop_status=()	# track loop rerun state
 	local tc_status ix
 	local -a _list=( $list )
 	for ((ix = 0; ix < ${#_list[*]}; !${#loop_status[*]} && ix++)); do
-- 
2.34.1


