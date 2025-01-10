Return-Path: <linux-ext4+bounces-6031-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 372DDA08B02
	for <lists+linux-ext4@lfdr.de>; Fri, 10 Jan 2025 10:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4650E3A9B04
	for <lists+linux-ext4@lfdr.de>; Fri, 10 Jan 2025 09:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56EE8209F26;
	Fri, 10 Jan 2025 09:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MhDCFGyA"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AF51ADFE4;
	Fri, 10 Jan 2025 09:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736500378; cv=none; b=mHVcWM632dRM4XSwrYheYcdn1M+9vEDiygOPUmzlGOf6BAS4fThQcM5QTdHY8kgCG4VsU7RI2FS7PAGFJN6qdZADR8fYcmciqNUbul6rQddxsMm45v2JbS4tOLKGI+W/sBtQGN//WefK6ArSfv63C6QHrRUlgVkdFItTQLP5jPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736500378; c=relaxed/simple;
	bh=UfuCQdTf8KFSIx0HUKuDNJx7sXmm6WeKrstDgVeYf3w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TVKh1Huf6gsLUczwpCpDHODgJIRqvAkf+u7GInDfwxFBYfHu4hFySgKDXbR+gRbVnuhoK1uAcH7JJkwaW3GAovOlwQNDR7mSE+6zDIeAfF9xmRQLh7ehO4IB7i3DBOY3L3uN4eH77ZMUkDQpy+ASuNJzeOeVlTBDpv0xaqTleFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MhDCFGyA; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-2156e078563so26055615ad.2;
        Fri, 10 Jan 2025 01:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736500375; x=1737105175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MNHVd5f+RmGJ130wS048pYq3Wu/sA+aJSBfgORf1PRM=;
        b=MhDCFGyA5EZFwDrgxQHTC6G8wh6ljzKCcY2OYmS9RpBP7eD0y3ySvj/g2x95J1qdJp
         9GftbC4JwDmnwowfpqXBETY43bzrVG8THHsDNdeeDubAo4cJZimoY2hogFZTZRXzNSyX
         hE0nNU+4OXxo/VxsMgjzD/ugMJt8SmUC2oSMp+Nxwr/neMcMaQQmS2LNwZTuDKIOMSui
         Ixlro5xnFFFh1fZujtMOFd1O0toBsRVSlBaS96VrogKEI+0tCreD12TMVyFccSJJM6qz
         Qe6uq9BCC/ELL8szUfR3vAV+lUn+2LeAEoTMPr1RoltdG9eBsENRrDC7lBqqjWOnj5CR
         H39w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736500375; x=1737105175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MNHVd5f+RmGJ130wS048pYq3Wu/sA+aJSBfgORf1PRM=;
        b=vfrOwl6s1bAny/sN1GcoL6IsaMhAh5F/rRRXOhKfhBbFdHqeXe8g9NYZOMcdPSfFbj
         kDz1moyQWlSlNh1IkblUKuZ/Xqv7HC263UXgLOh92euf68mBX6ICJsbbMYLZ7j5GPB+7
         c1fkWy1Pua7jNdYYmA8nftvKyN3XOtUN3AqFiR+JhKyCUiYC5NLBr/QpIGFoaFuD8+gH
         jhCVjA7G1Q1RHlvtVNHE8UUWRmkEx83xBKiefA8zVgTBL40Tij/oI6B1GLUNHltzU0fo
         FkpOlYnF/OKwDFCVNSknk23RITQHfNmmL+ALEh1G8yq7SB7oVv/SraPXoK/EdjWCJP7c
         XK6w==
X-Forwarded-Encrypted: i=1; AJvYcCW7mU+Z8WYui5y8T/QdLNZEeVJv5edw6Slx5/aW78zOVBqxu7FFxhGlHs9wSbQVNNx3+/CyoxKs/Mc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoKycNe8g7TqUuS0RxKcRuRsYqwBkKxBiBRThpBndMa0/M1Ood
	lRcVD/tw23FG60tfXoSMJXBwY2izt5UM7XJyj1PHThxNb0WqumfImD9QeGIIyPg=
X-Gm-Gg: ASbGncseOANPFW/DYSUSqtUckEX/r/mVIU963Tl7OQlkaqMdTAB/iCZTbnNPfD5zpBA
	BJTQiUBXiqZLMoM6IXCODD5Dix0aAvxK49aMDCSiyux5YrKeP88T2Iu8AcT1vJInY9kCTdfZupf
	3NkkjN7dYs9oRLcUiGDPlvMpTZplQFYOLRBnFZXsIcu5apYCiYHdP+8b8R/49LuZkS0CSjoDbPe
	6Q29KGCO2h/Cc90EyoF7/X6arpKih1IEeVzAsFbpaGmLcQqWEiEQGIaSO8A
X-Google-Smtp-Source: AGHT+IGTz8lGbytPSR6x1DXX/SDtRvQlD82ShBxJ6P4sfSUQfoU939GTq2584BeKyM61xd8YITJrFQ==
X-Received: by 2002:a17:902:d50d:b0:216:2abc:194f with SMTP id d9443c01a7336-21a83fb1563mr149881585ad.40.1736500375196;
        Fri, 10 Jan 2025 01:12:55 -0800 (PST)
Received: from citest-1.. ([49.205.38.219])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f219a94sm10166485ad.129.2025.01.10.01.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 01:12:54 -0800 (PST)
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
To: fstests@vger.kernel.org
Cc: linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	ritesh.list@gmail.com,
	ojaswin@linux.ibm.com,
	djwong@kernel.org,
	zlang@kernel.org,
	nirjhar.roy.lists@gmail.com
Subject: [RFC 3/5] check: Improve pass/fail metrics and section config output
Date: Fri, 10 Jan 2025 09:10:27 +0000
Message-Id: <05768096e43da32f50ef337c0676d06fb8c9454e.1736496620.git.nirjhar.roy.lists@gmail.com>
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

This patch improves the output by:
- Adding pass/fail aggregate results in the stdout for each section's
  summary. Also adds the location of the xunit xml files in the
  section's summary.
- Adds section config details into the result's global log file.

e.g.

$ ./check -q 2 -R xunit-quiet   selftest/001

SECTION       -- s1
=========================
selftest/001 aggregate results across 2 runs: pass=2 (100.0%)
Ran: selftest/001
Passed all 1 tests
Xunit report: /home/ubuntu/xfstests/results//s1/result.xml

SECTION       -- s2
=========================
selftest/001 aggregate results across 2 runs: pass=2 (100.0%)
Ran: selftest/001
Passed all 1 tests
Xunit report: /home/ubuntu/xfstests/results//s2/result.xml

Output in results/check.log file

Kernel version: 6.13.0-rc1-00182-gb8f52214c61a-dirty
Wed Jan  8 11:23:57 UTC 2025
SECTION       -- s1
=========================
FSTYP         -- ext4
PLATFORM      -- Linux/x86_64 citest-1 6.13.0-rc1-00182-gb8f52214c61a-dirty #5 SMP PREEMPT_DYNAMIC Wed Dec 18 14:03:34 IST 2024
MKFS_OPTIONS  -- -F /dev/loop1
MOUNT_OPTIONS -- -o acl,user_xattr /dev/loop1 /mnt1/scratch
selftest/001 aggregate results across 2 runs: pass=2 (100.0%)
Ran: selftest/001
Passed all 1 tests
Xunit report: /home/ubuntu/xfstests/results//s1/result.xml

Kernel version: 6.13.0-rc1-00182-gb8f52214c61a-dirty
Wed Jan  8 11:24:02 UTC 2025
SECTION       -- s2
=========================
FSTYP         -- ext4
PLATFORM      -- Linux/x86_64 citest-1 6.13.0-rc1-00182-gb8f52214c61a-dirty #5 SMP PREEMPT_DYNAMIC Wed Dec 18 14:03:34 IST 2024
MKFS_OPTIONS  -- -F /dev/loop1
MOUNT_OPTIONS -- -o acl,user_xattr /dev/loop1 /mnt1/scratch
selftest/001 aggregate results across 2 runs: pass=2 (100.0%)
Ran: selftest/001
Passed all 1 tests
Xunit report: /home/ubuntu/xfstests/results//s2/result.xml

Suggested-by: Ritesh Harjani <ritesh.list@gmail.com>
Co-developed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
---
 check | 67 ++++++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 46 insertions(+), 21 deletions(-)

diff --git a/check b/check
index e8ac0ce9..f7028836 100755
--- a/check
+++ b/check
@@ -468,6 +468,25 @@ if [ -n "$REPORT_GCOV" ]; then
 	_gcov_check_report_gcov
 fi
 
+_print_list()
+{
+	local -n list=$1
+	local item
+	for item in "${list[@]}"; do
+		echo "$item"
+	done
+}
+
+_display_test_configuration()
+{
+	echo "FSTYP         -- `_full_fstyp_details`"
+	echo "PLATFORM      -- `_full_platform_details`"
+	if [ ! -z "$SCRATCH_DEV" ]; then
+		echo "MKFS_OPTIONS  -- `_scratch_mkfs_options`"
+		echo "MOUNT_OPTIONS -- `_scratch_mount_options`"
+	fi
+}
+
 _wrapup()
 {
 	seq="check.$$"
@@ -505,11 +524,19 @@ _wrapup()
 
 		echo "SECTION       -- $section" >>$tmp.summary
 		echo "=========================" >>$tmp.summary
+
+		_global_log "SECTION       -- $section"
+		_global_log "=========================" >>$tmp.summary
+		_global_log "$(_display_test_configuration)"
 		if ((${#try[*]} > 0)); then
+			local test_aggr_stats=$(_print_list loop_test_stats_per_section)
 			if [ $brief_test_summary == "false" ]; then
+				[[ -n "$test_aggr_stats" ]] && echo "$test_aggr_stats" >> \
+					$tmp.summary
 				echo "Ran: ${try[*]}"
 				echo "Ran: ${try[*]}" >>$tmp.summary
 			fi
+			_global_log "$test_aggr_stats"
 			_global_log "Ran: ${try[*]}"
 		fi
 
@@ -539,12 +566,15 @@ _wrapup()
 			_global_log "Passed all ${#try[*]} tests"
 			echo "Passed all ${#try[*]} tests" >>$tmp.summary
 		fi
-		echo "" >>$tmp.summary
 		if $do_report; then
 			_make_section_report "$section" "${#try[*]}" \
 					     "${#bad[*]}" "${#notrun[*]}" \
 					     "$((sect_stop - sect_start))"
+			local out_fn="$REPORT_DIR/result.xml"
+			echo "Xunit report: $out_fn" >> $tmp.summary
+			_global_log "Xunit report: $out_fn"
 		fi
+		echo "" >>$tmp.summary
 
 		# Generate code coverage report
 		if [ -n "$REPORT_GCOV" ]; then
@@ -655,18 +685,19 @@ _stash_test_status() {
 
 		if ((loop_on_fail && ${#loop_status[*]} > loop_on_fail)) || \
 		   ((loop_unconditional && ${#loop_status[*]} > loop_unconditional)); then
-			printf "%s aggregate results across %d runs: " \
-				"$test_seq" "${#loop_status[*]}"
-			awk "BEGIN {
-				n=split(\"${loop_status[*]}\", arr);"'
-				for (i = 1; i <= n; i++)
-					stats[arr[i]]++;
-				for (x in stats)
-					printf("%s=%d (%.1f%%)",
-					       (i-- > n ? x : ", " x),
-					       stats[x], 100 * stats[x] / n);
-				}'
-			echo
+			local test_stats=$(printf "%s aggregate results across %d runs: " \
+				"$test_seq" "${#loop_status[*]}")
+			test_stats+=$(awk "BEGIN {
+					n=split(\"${loop_status[*]}\", arr);"'
+					for (i = 1; i <= n; i++)
+						stats[arr[i]]++;
+					for (x in stats)
+						printf("%s=%d (%.1f%%)",
+							   (i-- > n ? x : ", " x),
+							   stats[x], 100 * stats[x] / n);
+					}')
+			echo "$test_stats"
+			loop_test_stats_per_section+=("$test_stats")
 			loop_status=()
 			is_bad_test=false
 		fi
@@ -839,14 +870,7 @@ function run_section()
 	rm -f $check.full
 
 	[ -f $check.time ] || touch $check.time
-
-	# print out our test configuration
-	echo "FSTYP         -- `_full_fstyp_details`"
-	echo "PLATFORM      -- `_full_platform_details`"
-	if [ ! -z "$SCRATCH_DEV" ]; then
-	  echo "MKFS_OPTIONS  -- `_scratch_mkfs_options`"
-	  echo "MOUNT_OPTIONS -- `_scratch_mount_options`"
-	fi
+	_display_test_configuration
 	echo
 	test -n "$REPORT_GCOV" && _gcov_reset
 	needwrap=true
@@ -884,6 +908,7 @@ function run_section()
 
 	is_bad_test=false
 	loop_status=()	# track loop rerun state
+	loop_test_stats_per_section=() # store loop test statistics per section
 	local tc_status ix
 	local -a _list=( $list )
 	for ((ix = 0; ix < ${#_list[*]}; !${#loop_status[*]} && ix++)); do
-- 
2.34.1


