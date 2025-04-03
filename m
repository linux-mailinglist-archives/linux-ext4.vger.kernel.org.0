Return-Path: <linux-ext4+bounces-7046-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F323A79F86
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Apr 2025 11:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 252E3188BFED
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Apr 2025 09:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09CDE2451E0;
	Thu,  3 Apr 2025 08:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cnG1vZR3"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25ED524339C;
	Thu,  3 Apr 2025 08:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743670783; cv=none; b=bYCK1ZES0x7zjlLcbm16y0q41Ej2rbwctGewzcEf1Fv0ASTgk+MSJCI0cadq2Z/c5KgWdSPWWTgSKEkEDD3MLWLuHQHGr73QQsQhBF9djEtwCfL42GUgiMLVFPqcNoQ9ZcZw707wKbJsguzkvJXdxKYErDIIX7N0ZwUXUWiikgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743670783; c=relaxed/simple;
	bh=cXpMG4evM+/eBh0rh9cOx22wN60fLnLdyOex1885nT0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I5YPZ7Bh99aobuic3uXKxwFpNriFo/FNYgfyVa/Z6qC+c+JpxPonQB9wM5LPDWRKyGB/m0NcXPCihS24kSP026cgtC0XisftM4IeDPbWsSNcUl2zS7fNpT4Qft8qBDmDW70ZNdo2ccqTk28uJQNlj6CshVUspyLWVWf9eWndQqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cnG1vZR3; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22409077c06so9954525ad.1;
        Thu, 03 Apr 2025 01:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743670781; x=1744275581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NR4dPmRB+WlVaBFBqvFj4uKQeU+r3bP802+oB47JMSg=;
        b=cnG1vZR3aJ7KW3zxwm+5273mHxVvzGMXV2bIAH6D+zrU4XJfbsEF0gyFRRqhmf8U7b
         gg7x/2LmIaS8KKOrDWZig2RtNXjic0Vwo2cGuQRr5Z+/E8RB2sdQOD7OOvC83tE3Nm3A
         HSfrpnJWbfJOVT+YnumgmqNbJPqdWbiz0jrOn0zrS8oDVyJNDMscfEeKeOB9/52O73Ux
         1/n/3kyxOcibY/qb2ueF28snDPykp4SmcXZIeQCruYiq35VqQHXrpfkifKXrnq+sSMH7
         KY9hVv/L32OSW85p+8SEejwvdcgewpehm+04iZF3HCtdEsPWlCrLQq9ecR/KRZvCpGo/
         rFGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743670781; x=1744275581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NR4dPmRB+WlVaBFBqvFj4uKQeU+r3bP802+oB47JMSg=;
        b=HRiumoi/DmXu+196xZ6Pht5DYyaDlqRHD5eoN8nwuWjnWg+XGOE/DjMWl7gijwXnv4
         Y9C4pMsyDcRrBOilFPduI/WGTMTMlMnZ3bJUvwyNFH6w8WfOWA1RWv4+Er5ISIvWdRPv
         9NBtoXvyby3VsAgma47Uuia/kQM0nP99nNw2Qr+j4w9dqDLDbd6tCo9bGdB2cBAvB7wD
         3KeZ7l4I5c54V21MrOSQV7xi1RIgoc9oDuBi9L3jdzkWZ9tCLWtlkVTbqIfmFBIhAnup
         Jw+yUZFhVvpHWo1w/3LPB/fYj4D7POHzIXVsMmnmJVI17Q7ysgBAeOlW0W82Rw5So2Ne
         xRMg==
X-Forwarded-Encrypted: i=1; AJvYcCWP++72HSKrDuVWX/uQQ00YDySH4wqHY8kxKPKJq7PjAxMJyaUeZj3dlyLo5kHQWlqfwGwvkDez798=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVxphUyTVRp3lbPbL/ROpbvIU3yrARhznAgJUAhigN/EPhOFze
	0UZ/TNyohG1rt+/Ni0PocWYiSpFXcXZ+/rcfhKuE2wQ7cVCRgOlgDx4xOw==
X-Gm-Gg: ASbGncsf3t0ee/PMvpnnf4KXKIFWbs+Wj1KS3O0VLDCeq3eArkVzw6NJ4fpDtNPTYuz
	6TbOZcsZPCmj8G1ZaaTR9QpuEGVEQB/kkG3H7C8E5/NVYOCYn16X/4y4J+AulLv/kUMySUf2jES
	BUix+9zFwTj52duLha+/zwgBO6ZK6nwLEpkOeI+7ApqhpKyrcDalB+e1oFu/khAs4jlDAl15iZE
	t8dYPfjwI8GtWKz85Z2+LbDfEoI+QAYMTDsyuIcDMpmHNh+FEM9bCU99C72/9mM9n6fz7c2qj8A
	VUz5BxNSP+3XzBJveHdet8kGQry92mM72DGDbLuDQOekMLuk1Gu/s8ySoCU=
X-Google-Smtp-Source: AGHT+IHC0+dVJMNf5ScPuEOnU+uWmFtn7jonuLrkEs1Gl0dp4lJ4z5Yberxu3G9N6t2PTIb1OjGQTA==
X-Received: by 2002:a17:902:cf10:b0:21b:b3c9:38ff with SMTP id d9443c01a7336-2292f9f54d6mr304729445ad.37.1743670780789;
        Thu, 03 Apr 2025 01:59:40 -0700 (PDT)
Received: from citest-1.. ([49.205.34.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-229785c01cdsm9535715ad.99.2025.04.03.01.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 01:59:40 -0700 (PDT)
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
Subject: [PATCH v2 3/3] check: Improve pass/fail metrics and section config output
Date: Thu,  3 Apr 2025 08:58:20 +0000
Message-Id: <72dd490d0d00ce2e35c168d21983c015ae471354.1743670253.git.nirjhar.roy.lists@gmail.com>
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
index f6007750..bb91cf9d 100755
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
@@ -834,14 +865,7 @@ function run_section()
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
@@ -879,6 +903,7 @@ function run_section()
 
 	is_bad_test=false
 	loop_status=()	# track loop rerun state
+	loop_test_stats_per_section=() # store loop test statistics per section
 	local tc_status ix
 	local -a _list=( $list )
 	for ((ix = 0; ix < ${#_list[*]}; !${#loop_status[*]} && ix++)); do
-- 
2.34.1


