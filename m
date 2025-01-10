Return-Path: <linux-ext4+bounces-6030-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F363A08AFD
	for <lists+linux-ext4@lfdr.de>; Fri, 10 Jan 2025 10:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 169597A474D
	for <lists+linux-ext4@lfdr.de>; Fri, 10 Jan 2025 09:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD0B209F5B;
	Fri, 10 Jan 2025 09:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XjxirZBV"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE3D209F4B;
	Fri, 10 Jan 2025 09:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736500351; cv=none; b=uffEMJJaMTae9JxCoDJH5tDQ7aNSj5ARpJeD1j52dvRE6L+iJeZAFj0KnFrU1eATe3bCCd/jqaAqPWe/uvmw5BrVMx8X2w00Ucss57VRIaXZs79HHA/9/cL2b6th6bik13lJ1Y03zYNdv7Yg8o//kCvUDJ+azHFedYkbUP7AMdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736500351; c=relaxed/simple;
	bh=pLyCWYOzkv9DIEhBJmj6yPaQqZsogfCxBLYjsKjq/zc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rrQ4BsF2MXa7BEtWcBAXqUqtSvXneBoE30ekYDiDjzipQUP3btf7rGeEik1zhIR+dNSOwF5/8WxQaKIep0ORHsuXXTOiCwtLzz8T4qPRlrXgMzzC9TIGuckkdC7J6Je+dsscAynsbXRHYnq749+zMvpWKsZSVcD4gXIF+YIH0GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XjxirZBV; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21670dce0a7so37231965ad.1;
        Fri, 10 Jan 2025 01:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736500349; x=1737105149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dZmCRYH+zmel61PZtTGTzmCyDMxfmGVR2XKn2zcnKqI=;
        b=XjxirZBVw1KhlLWggwgFEb4T/amTvjT9LXJKAjhZd/3iYQNIa0ApEf3dCbCOfGFWZe
         dPYe4m4suptylVN3wgGzc5eITmjiqloJSfyaE4+EwRXLZLN+hFcVpg1yrKW+VPBuRVsK
         M7HscurCbAdLbpYJ2mr0aZbjbjbYly8qs3yOX5Y5ji47V7j3NZpRwxdJaAAAbtiJXAmE
         4yT3YRRNY4PyNaUJCN66VbM5deM9PVsxDX0P28Sve2tAMZc5mxBB9HXfF1C5SnqvQ3dT
         CK7jv2pDirRWhoBstGe3qQPoeG5GtW+03YoVR+Cs7//qYDUV7YZ8uKGYQz1LREC9TLm6
         M8lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736500349; x=1737105149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dZmCRYH+zmel61PZtTGTzmCyDMxfmGVR2XKn2zcnKqI=;
        b=VcM50OCCmccU24dhI5uBXEpU2Xt8G4tn615T0M5am9ai4ntz4PjlL0FpwP/6eF3cuk
         8X+VkQv7k1LnyQvLYhkYGXP6MSQwfaYPRBtF6unIQWw3FNYvXluwmcwDiH58Z1CLy6S4
         ZUaoE60P+Xz1wsLGp+xJTjwGMko+8Zy5LIzZZmpN5KTb91hyyQSPhlFGgIGrVSGCUaNA
         qVkSZwnohVg0g5aCZhD2dStlbpWiprrNIFHwznqCB9C+xu1yPZgQEXl5Aumjzgi/WdFu
         4nNpO+zZM+0scl9KSNJCXUhg/5ubuNsU88J7H379wdWB8BldomHFZ0wdT/w3UaX4C2z0
         YFjA==
X-Forwarded-Encrypted: i=1; AJvYcCUlS3lnwA388h581WYuF5Mmrr1n5w97WIk7GcNN6Foen+EcN3d7uvOBM1h1lItTUsU3MQCaFb8mxZk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR97YxROcvYKqDlvGkBlq3wQmyxC7X+tz8ZIbEHk/UPUZ0u0AJ
	8n7ysRL8jknOOa9oW8oCghB1wba8TUsljM/8xtBcbQ2mZAsm0+mYIMywEwIh
X-Gm-Gg: ASbGncvFw0JrMU+WuppEHAp00zsVNThdX6dGdYgxi3t57yK9unMbbTjNVFnbHYojqJ5
	oDbFvu2qHVoZI7VWsxPLXAOanIhIgzfh+Xlpfjmpagv7n8eC5qVDb2DMKWRHqvRUdLUvZaksUx/
	seouGiPLc2dWB2OS8xtZFaDokzsk5tnIHKWRrkVKmbhBm8LSvnN7hVBL95Y4MsHAdWGmRAjhdbb
	HRJIWgwZEFul8+20J0V3ck8EURbl8JKewMdYkcdBCyN/kQpVYGHc7tbTxD2
X-Google-Smtp-Source: AGHT+IHEabX6sx3xiDacZPapqA2JUDOh6nxGbTfqkIlolXAJ/ApKLa2RXafYfx/1t4yr4UWjSLXibQ==
X-Received: by 2002:a17:903:230b:b0:20c:6399:d637 with SMTP id d9443c01a7336-21a83ffbea3mr178475105ad.40.1736500348613;
        Fri, 10 Jan 2025 01:12:28 -0800 (PST)
Received: from citest-1.. ([49.205.38.219])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f219a94sm10166485ad.129.2025.01.10.01.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 01:12:28 -0800 (PST)
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
To: fstests@vger.kernel.org
Cc: linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	ritesh.list@gmail.com,
	ojaswin@linux.ibm.com,
	djwong@kernel.org,
	zlang@kernel.org,
	nirjhar.roy.lists@gmail.com
Subject: [RFC 2/5] check: Add -q <n> option to support unconditional looping.
Date: Fri, 10 Jan 2025 09:10:26 +0000
Message-Id: <1826e6084fd71e3e9755b1d2750876eb5f0e1161.1736496620.git.nirjhar.roy.lists@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1736496620.git.nirjhar.roy.lists@gmail.com>
References: <cover.1736496620.git.nirjhar.roy.lists@gmail.com>
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
index 607d2456..e8ac0ce9 100755
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
@@ -857,7 +882,8 @@ function run_section()
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


