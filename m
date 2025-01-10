Return-Path: <linux-ext4+bounces-6032-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4E5A08B04
	for <lists+linux-ext4@lfdr.de>; Fri, 10 Jan 2025 10:13:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BA4E169342
	for <lists+linux-ext4@lfdr.de>; Fri, 10 Jan 2025 09:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D208209F31;
	Fri, 10 Jan 2025 09:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j4HIUt1M"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA1B206F06;
	Fri, 10 Jan 2025 09:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736500393; cv=none; b=aGVJidKKOt0Q1hdhsKTVfLU713AScGg+ZVPtX1XG2a3GKdEa0MWkTi/rk6d23A+I7K6WCBHF5MiJmEMeUrBlf/F1witBuk1theP8JXWHpwXWOC4QtPE4E9IjZPAG4ytoFZL//z/NDtjfXSAt8E7hzISyMu938YulvnbXu5a3eNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736500393; c=relaxed/simple;
	bh=osXmSc+d9s0VDc8vmJPxoNfJLMIqnBEOpIPI8GJnhCg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r6Z+ieDbJsoJWOph5E4n+Ss4Oku1knejd7/omzpfYMX3C9VneaSrZSqbYG2yhjV44lH46p6lShnQPyocBNAAiELTew8ODhvE95MW/iwr5w9FGRB1bFgA5X8MFRsfiJTyYrijpx337w8IZpRIyCVGyLONOvxEqmo3J02Vs69bBG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j4HIUt1M; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21661be2c2dso28181035ad.1;
        Fri, 10 Jan 2025 01:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736500390; x=1737105190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nwfekoxfp+MbUnjT7fxgtz18HcGaexSsgzbOvFkAHUw=;
        b=j4HIUt1MT0f5Y+FS4GTW+WQ1zYGzE/qmTTQzn1raeDjx/VOd2reJWgHq8uaG5iBVVH
         /l+GpfEgojkFdPPrTTiULGNAMOO+i1l+3LYnnYblLL6XAD5X8wgnbjQ0xe4LupAwDvle
         zFTs7UMMXf6cmTWqLbk1v59U7B9eQLugVGy4Yq8nJvWgiQWG4n7pWS5ckKyfiHmS6IAz
         qm1gp7rFKwLCYlS94j8A3sIbnr4wjHh40tH4v8XYWKDzKGyKdglIoMLjgbZaaR7mfXC+
         1/kzJPD/azWs6ZxQA65MTEilbvI31no/K/UdC4u2C+2oKkMg0qWy+6855zQVqeJpnqL4
         3G7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736500390; x=1737105190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nwfekoxfp+MbUnjT7fxgtz18HcGaexSsgzbOvFkAHUw=;
        b=V2fzXyKHz3us9a1K/rQgvO5d4WD1Sv4Vh+kSQMtbN50l4sppv+nqU7wmPlJJfarY1R
         5ZEhrS3b9Z7QgcAfTy4x7pLm/2Mzm+JzMH4oesufKLNFPwFGDHfEp7hAhekG5H627YwR
         Df2BuZsLMsblq9jZU1BAjDCX6B2PSrsHXCM5DtoWkLMbgaFi+WlkhG2V+IZ3rsdSNrTR
         ZtPz5LoPBZuf7BqATUBvbL73DpwLOpOx/C4AHC21T6CI6EA2WIz0Dd0AhUooAFvp01QW
         YyU687O3FRDp5k9B52R/NSQqhr0i903uhIaWO5kG54vDyg8d+PlPX5oykstkhFjuyJsB
         67tA==
X-Forwarded-Encrypted: i=1; AJvYcCXpHNU5kzQg+1yPVWS1CQ0Xs0uVs7bC5g8Jj5g+FSS+v7xc3n3ho0zmEESi/xrhaXluvQYePzzQ6Kk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGpugPCKZRv6jR2fvv5auMDt4dBoNaOzutCf9kh98ak4oXMDcy
	CNbD5YOrXrvkTY7J8LdbW/DfJTMmREieEhQHlbazOHAEfk6N9GLdImTwtrwm
X-Gm-Gg: ASbGncuXFRdjuGfvccpFv5OVviXWk1Mcap+Bj8PELXiwM05aPhQzDB0B3l3QhMZlXai
	23Gv3WydCpMrNarY7D0WCPZLSI2iKTBcMUm6KsnzTU552rT4hpSdow/EokRbxYwhiQrR78lP/8a
	d/Lfy2MVdNpZJwdVyMvW1eheogAMsYqvj2CXVCoQ0Ppkn1qy9GCwi/y8+y54W+NER4b1txZsvIX
	JQDa164cq1j40IOVeBD2d5Y99B4Gh6s/c/TsUPRSgrB74dr7LYfrg+qD4/8
X-Google-Smtp-Source: AGHT+IEUV/d+GJdKrslMUpeAxaK60BkEdx3rsMi9BlIZv1o1JTeUFabz1qArW9QesRohebfoq/1zbA==
X-Received: by 2002:a17:902:cccb:b0:216:6769:9eca with SMTP id d9443c01a7336-21a83fd35bdmr147260335ad.37.1736500389931;
        Fri, 10 Jan 2025 01:13:09 -0800 (PST)
Received: from citest-1.. ([49.205.38.219])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f219a94sm10166485ad.129.2025.01.10.01.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 01:13:09 -0800 (PST)
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
To: fstests@vger.kernel.org
Cc: linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	ritesh.list@gmail.com,
	ojaswin@linux.ibm.com,
	djwong@kernel.org,
	zlang@kernel.org,
	nirjhar.roy.lists@gmail.com
Subject: [RFC 4/5] check,common/config: Add support for central fsconfig
Date: Fri, 10 Jan 2025 09:10:28 +0000
Message-Id: <9a6764237b900f40e563d8dee2853f1430245b74.1736496620.git.nirjhar.roy.lists@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1736496620.git.nirjhar.roy.lists@gmail.com>
References: <cover.1736496620.git.nirjhar.roy.lists@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This adds support to pick and use any existing FS config from
configs/<fstype>/<config>. e.g.

configs/xfs/1k
configs/xfs/4k
configs/ext4/4k
configs/ext4/64k

This should help us maintain and test different fs test
configurations from a central place. We also hope that
this will be useful for both developers and testers to
look into what is being actively maintained and tested
by FS Maintainers.

When we will have fsconfigs set, then will be another subdirectory created
in results/<section>. For example let's look at the following:

The directory tree structure on running
sudo ./check -q 2 -R xunit-quiet -c xfs/4k,configs/xfs/1k selftest/001 selftest/007

$ tree results/
results/
├── check.full
├── check.log
├── check.time
├── xfs_1
│   └── xfs
│       ├── 1k
│       │   ├── check.log
│       │   ├── check.time
│       │   ├── result.xml
│       │   └── selftest
│       │       ├── 001.full
│       │       ├── 001.full.rerun0
│       │       ├── 001.full.rerun1
│       │       ├── 007.full
│       │       ├── 007.full.rerun0
│       │       ├── 007.full.rerun1
│       │       ├── 007.out.bad
│       │       ├── 007.out.bad.rerun0
│       │       ├── 007.out.bad.rerun1
│       │       └── dmesg_filter
│       └── 4k
│           ├── check.log
│           ├── check.time
│           ├── result.xml
│           └── selftest
│               ├── 001.full
│               ├── 001.full.rerun0
│               ├── 001.full.rerun1
│               ├── 007.full
│               ├── 007.full.rerun0
│               ├── 007.full.rerun1
│               ├── 007.out.bad
│               ├── 007.out.bad.rerun0
│               ├── 007.out.bad.rerun1
│               └── dmesg_filter
└── xfs_2
    └── xfs
        ├── 1k
        │   ├── check.log
        │   ├── check.time
        │   ├── result.xml
        │   └── selftest
        │       ├── 001.full
        │       ├── 001.full.rerun0
        │       ├── 001.full.rerun1
        │       ├── 007.full
        │       ├── 007.full.rerun0
        │       ├── 007.full.rerun1
        │       └── dmesg_filter
        └── 4k
            ├── check.log
            ├── check.time
            ├── result.xml
            └── selftest
                ├── 001.full
                ├── 001.full.rerun0
                ├── 001.full.rerun1
                ├── 007.full
                ├── 007.full.rerun0
                ├── 007.full.rerun1
                ├── 007.out.bad
                ├── 007.out.bad.rerun1
                └── dmesg_filter

12 directories, 51 files

Contents of one of the xml/xunit files (results/xfs_1/xfs/4k/result.xml):
(Please note that FS_CONFIG_OPTION is a new property that is added in this patch)

<?xml version="1.0" encoding="UTF-8"?>
<testsuite
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xsi:schemaLocation="https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/tree/doc/xunit.xsd"

 name="xfstests"
 failures="1" skipped="0" tests="2" time="6"
 hostname="li-5d80d4cc-2782-11b2-a85c-bed59fe4c9e5"
  start_timestamp="2024-12-11T13:07:29+05:30"
        timestamp="2024-12-11T13:07:35+05:30"
 report_timestamp="2024-12-11T13:07:35+05:30"
>
	<properties>
		<property name="ARCH" value="x86_64"/>
                ...
		<property name="FSTYP" value="xfs"/>
		<property name="FS_CONFIG_OPTION" value="xfs/4k"/>
		<property name="HOST_OPTIONS" value="local.config"/>
                ...
	</properties>
	<testcase classname="xfstests.xfs_1" name="selftest/001" time="0">
	</testcase>
	<testcase classname="xfstests.xfs_1" name="selftest/001" time="1">
	</testcase>
	<testcase classname="xfstests.xfs_1" name="selftest/007" time="1">
		<failure message="- output mismatch (see /home/nirjhar/work/xfstests-dev/results//xfs_1/xfs/4k/selftest/007.out.bad)" type="TestFail" />
	</testcase>
	<testcase classname="xfstests.xfs_1" name="selftest/007" time="1">
		<failure message="- output mismatch (see /home/nirjhar/work/xfstests-dev/results//xfs_1/xfs/4k/selftest/007.out.bad)" type="TestFail" />
	</testcase>
</testsuite>

Suggested-by: Ritesh Harjani <ritesh.list@gmail.com>
Co-developed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
---
 README.config-sections | 12 +++++++
 check                  | 82 +++++++++++++++++++++++++++++++++---------
 common/config          | 51 ++++++++++++++++++++++++--
 common/report          |  2 +-
 4 files changed, 128 insertions(+), 19 deletions(-)

diff --git a/README.config-sections b/README.config-sections
index a42d9d7b..0511b707 100644
--- a/README.config-sections
+++ b/README.config-sections
@@ -108,10 +108,22 @@ MKFS_OPTIONS="-q -F -b1024"
 [ext4_nojournal]
 MKFS_OPTIONS="-q -F -b4096 -O ^has_journal"
 
+# we could also do like: FS_CONFIG_OPTION=ext4/1k
+[ext4_1k_bs_fsconfig]
+FS_CONFIG_OPTION=configs/ext4/1k
+
+# we could also do like: FS_CONFIG_OPTION=ext4/nojournal
+[ext4_nojournal_fsconfig]
+FS_CONFIG_OPTION=configs/ext4/nojournal
+
 [xfs_filesystem]
 MKFS_OPTIONS="-f"
 FSTYP=xfs
 
+# we could also do like: FS_CONFIG_OPTION=xfs/4k
+[xfs_4k_bs_fsconfig]
+FS_CONFIG_OPTION=configs/xfs/4k
+
 [ext3_filesystem]
 FSTYP=ext3
 MOUNT_OPTIONS="-o noatime"
diff --git a/check b/check
index f7028836..90aa94ba 100755
--- a/check
+++ b/check
@@ -80,6 +80,7 @@ check options
     -I <n>		iterate the test list <n> times, but stops iterating further in case of any test failure
     -d			dump test output to stdout
     -b			brief test summary
+    -c			use fs configs from configs/<fstype>/<config> e.g. configs/xfs/4k
     -R fmt[,fmt]	generate report in formats specified. Supported formats: xunit, xunit-quiet
     --large-fs		optimise scratch device for large filesystems
     -s section		run only specified section from config file
@@ -116,6 +117,14 @@ excluded from the list of tests to run from that test dir.
 external_file argument is a path to a single file containing a list of tests
 to exclude in the form of <test dir>/<test name>.
 
+-c can be used in various formats as mentioned below. We can also set the
+FS_CONFIG_OPTION environment variable in the local.config file and get the
+same functionality. e.g.
+    1) FS_CONFIG_OPTION=xfs/4k
+    2) FS_CONFIG_OPTION=configs/xfs/4k
+Please note that cmdline will take precedence if FS_CONFIG_OPTION is
+passed in both local.config file and via cmdline.
+
 examples:
  check xfs/001
  check -g quick
@@ -123,6 +132,9 @@ examples:
  check -x stress xfs/*
  check -X .exclude -g auto
  check -E ~/.xfstests.exclude
+ check -c xfs/4k,ext4/1k
+ check -c xfs/4k -c configs/ext4/1k
+ check -c $(echo configs/xfs/* | tr ' ' ',') -q 5 tests/selftest/007
 '
 	    exit 1
 }
@@ -312,6 +324,8 @@ while [ $# -gt 0 ]; do
 		;;
 	-s)	RUN_SECTION="$RUN_SECTION $2"; shift ;;
 	-S)	EXCLUDE_SECTION="$EXCLUDE_SECTION $2"; shift ;;
+	-c)	CMD_FS_CONFIG_OPTION="$CMD_FS_CONFIG_OPTION$2,";
+		export OPTIONS_HAVE_FSCONFIGS=true; shift ;;
 	-l)	diff="diff" ;;
 	-udiff)	diff="$diff -u" ;;
 
@@ -458,7 +472,7 @@ _wipe_counters()
 
 _global_log() {
 	echo "$1" >> $check.log
-	if $OPTIONS_HAVE_SECTIONS; then
+	if options_have_sections_or_fs_configs; then
 		echo "$1" >> ${REPORT_DIR}/check.log
 	fi
 }
@@ -513,7 +527,7 @@ _wrapup()
 				}' \
 				| sort -n >$tmp.out
 			mv $tmp.out $check.time
-			if $OPTIONS_HAVE_SECTIONS; then
+			if options_have_sections_or_fs_configs; then
 				cp $check.time ${REPORT_DIR}/check.time
 			fi
 		fi
@@ -524,9 +538,14 @@ _wrapup()
 
 		echo "SECTION       -- $section" >>$tmp.summary
 		echo "=========================" >>$tmp.summary
-
 		_global_log "SECTION       -- $section"
 		_global_log "=========================" >>$tmp.summary
+
+		if [[ -n $FS_CONFIG_OPTION ]]; then
+			echo "FSCONFIG      -- $FS_CONFIG_OPTION" >> $tmp.summary
+			_global_log "FSCONFIG      -- $FS_CONFIG_OPTION"
+		fi
+
 		_global_log "$(_display_test_configuration)"
 		if ((${#try[*]} > 0)); then
 			local test_aggr_stats=$(_print_list loop_test_stats_per_section)
@@ -541,7 +560,7 @@ _wrapup()
 		fi
 
 		$interrupt && echo "Interrupted!" | tee -a $check.log
-		if $OPTIONS_HAVE_SECTIONS; then
+		if options_have_sections_or_fs_configs; then
 			$interrupt && echo "Interrupted!" | tee -a \
 				${REPORT_DIR}/check.log
 		fi
@@ -592,7 +611,7 @@ _wrapup()
 
 	sum_bad=`expr $sum_bad + ${#bad[*]}`
 	_wipe_counters
-	if ! $OPTIONS_HAVE_SECTIONS; then
+	if ! options_have_sections_or_fs_configs; then
 		rm -f $tmp.*
 	fi
 }
@@ -773,7 +792,7 @@ _detect_kmemleak
 _prepare_test_list
 fstests_start_time="$(date +"%F %T")"
 
-if $OPTIONS_HAVE_SECTIONS; then
+if options_have_sections_or_fs_configs; then
 	trap "_summary; exit \$status" 0 1 2 3 15
 else
 	trap "_wrapup; exit \$status" 0 1 2 3 15
@@ -782,6 +801,7 @@ fi
 function run_section()
 {
 	local section=$1 skip
+	local fsconfig=$2
 
 	OLD_FSTYP=$FSTYP
 	OLD_TEST_FS_MOUNT_OPTS=$TEST_FS_MOUNT_OPTS
@@ -814,7 +834,10 @@ function run_section()
 		fi
 	fi
 
-	get_next_config $section
+	# FS_CONFIG_OPTION (if provided) will only be set after get_next_config
+	# has run which will export the FS_CONFIG_OPTION, so that we can use it
+	# later
+	get_next_config $section $fsconfig
 	_canonicalize_devices
 
 	mkdir -p $RESULT_BASE
@@ -828,6 +851,10 @@ function run_section()
 		echo "SECTION       -- $section"
 	fi
 
+	if $OPTIONS_HAVE_FSCONFIGS; then
+		echo "FSCONFIG      -- $FS_CONFIG_OPTION"
+	fi
+
 	sect_start=`_wallclock`
 	if $RECREATE_TEST_DEV || [ "$OLD_FSTYP" != "$FSTYP" ]; then
 		echo "RECREATING    -- $FSTYP on $TEST_DEV"
@@ -849,7 +876,12 @@ function run_section()
 		# TEST_DEV has been recreated, previous FSTYP derived from
 		# TEST_DEV could be changed, source common/rc again with
 		# correct FSTYP to get FSTYP specific configs, e.g. common/xfs
+		# sourcing common/rc can re-set FS_CONFIG_OPTION to the value in
+		# local.config file(if present). So store and restore the value of
+		# FS_CONFIG_OPTION which is there currently at this point.
+		local fs_config_tmp="$FS_CONFIG_OPTION"
 		. common/rc
+		export FS_CONFIG_OPTION="$fs_config_tmp"
 		_prepare_test_list
 	elif [ "$OLD_TEST_FS_MOUNT_OPTS" != "$TEST_FS_MOUNT_OPTS" ]; then
 		_test_unmount 2> /dev/null
@@ -933,10 +965,14 @@ function run_section()
 		# we don't include the tests/ directory in the name output.
 		export seqnum=${seq#$SRC_DIR/}
 		group=${seqnum%%/*}
+
+		REPORT_DIR="$RESULT_BASE"
 		if $OPTIONS_HAVE_SECTIONS; then
-			REPORT_DIR="$RESULT_BASE/$section"
-		else
-			REPORT_DIR="$RESULT_BASE"
+			REPORT_DIR="$REPORT_DIR/$section"
+		fi
+		if $OPTIONS_HAVE_FSCONFIGS; then
+			local fsconfig_subdir="${FS_CONFIG_OPTION//configs/''}"
+			REPORT_DIR="$REPORT_DIR/$fsconfig_subdir"
 		fi
 		export RESULT_DIR="$REPORT_DIR/$group"
 		seqres="$REPORT_DIR/$seqnum"
@@ -1151,14 +1187,28 @@ function run_section()
 	_scratch_unmount 2> /dev/null
 }
 
+prepare_fs_config_list()
+{
+	IFS=',' read -r -a CMD_FS_CONFIG_OPTION_LIST <<< "$CMD_FS_CONFIG_OPTION"
+	CMD_FS_OPTION_LIST_LEN=${#CMD_FS_CONFIG_OPTION_LIST[@]}
+	if [ $CMD_FS_OPTION_LIST_LEN -eq 0 ]; then
+		# Create an empty fsconfig "" to pass to run_section in iters loop
+		CMD_FS_CONFIG_OPTION_LIST=("")
+	fi
+}
+
+prepare_fs_config_list
+
 for ((iters = 0; iters < $iterations; iters++)) do
 	for section in $HOST_OPTIONS_SECTIONS; do
-		run_section $section
-		if [ "$sum_bad" != 0 ] && [ "$istop" = true ]; then
-			interrupt=false
-			status=`expr $sum_bad != 0`
-			exit
-		fi
+		for fsconfig in "${CMD_FS_CONFIG_OPTION_LIST[@]}"; do
+			run_section $section $fsconfig
+			if [ "$sum_bad" != 0 ] && [ "$istop" = true ]; then
+				interrupt=false
+				status=`expr $sum_bad != 0`
+				exit
+			fi
+		done
 	done
 done
 
diff --git a/common/config b/common/config
index 5f86fc2c..901dc1e8 100644
--- a/common/config
+++ b/common/config
@@ -343,6 +343,11 @@ if [ -x /usr/sbin/selinuxenabled ] && /usr/sbin/selinuxenabled; then
 	export SELINUX_MOUNT_OPTIONS
 fi
 
+options_have_sections_or_fs_configs()
+{
+	$OPTIONS_HAVE_SECTIONS || $OPTIONS_HAVE_FSCONFIGS
+}
+
 _common_mount_opts()
 {
 	case $FSTYP in
@@ -783,8 +788,32 @@ parse_config_section() {
 		| sed -n -e "/^\[$SECTION\]/,/^\s*\[/{/^[^#].*\=.*/p;}"`
 }
 
+parse_fs_config_option() {
+	local fs_config_option
+	if ! $OPTIONS_HAVE_FSCONFIGS; then
+		return 0
+	fi
+
+	if [ -f "$1" ]; then
+		fs_config_option=$1
+	elif [ -f configs/"$1" ]; then
+		fs_config_option=configs/"$1"
+	else
+		echo "Invalid FS_CONFIG_OPTION $1"
+		exit 1
+	fi
+
+	eval `sed -e 's/[[:space:]]*\=[[:space:]]*/=/g' \
+		-e 's/#.*$//' \
+		-e 's/[[:space:]]*$//' \
+		-e 's/^[[:space:]]*//' \
+		-e "s/^\([^=]*\)=\"\?'\?\([^\"']*\)\"\?'\?$/export \1=\"\2\"/" \
+		< $fs_config_option`
+}
+
 get_next_config() {
-	if [ ! -z "$CONFIG_INCLUDED" ] && ! $OPTIONS_HAVE_SECTIONS; then
+	local cmd_fs_config_option=$2
+	if [[ $CONFIG_INCLUDED && ! options_have_sections_or_fs_configs ]]; then
 		return 0
 	fi
 
@@ -817,6 +846,23 @@ get_next_config() {
 	fi
 
 	parse_config_section $1
+
+	# FS_CONFIG_OPTION can be set either via cmdline -c xfs/4k (through
+	# CMD_FS_CONFIG_OPTION) or can be set in section config file
+	# FS_CONFIG_OPTION=xfs/4k.
+	# Please note that FS_CONFIG_OPTION in the local.config file can be
+	# overridden by the value passed through the command line.
+	if [[ -n "$cmd_fs_config_option" ]]; then
+		export FS_CONFIG_OPTION=$cmd_fs_config_option
+	fi
+
+	if [[ -n "$FS_CONFIG_OPTION" ]]; then
+		export OPTIONS_HAVE_FSCONFIGS=true
+		parse_fs_config_option $FS_CONFIG_OPTION
+	else
+		export OPTIONS_HAVE_FSCONFIGS=false
+	fi
+
 	if [ ! -z "$OLD_FSTYP" ] && [ $OLD_FSTYP != $FSTYP ]; then
 		[ -z "$MOUNT_OPTIONS" ] && _mount_opts
 		[ -z "$TEST_FS_MOUNT_OPTS" ] && _test_mount_opts
@@ -900,7 +946,8 @@ get_next_config() {
 }
 
 if [ -z "$CONFIG_INCLUDED" ]; then
-	get_next_config `echo $HOST_OPTIONS_SECTIONS | cut -f1 -d" "`
+	get_next_config `echo $HOST_OPTIONS_SECTIONS | cut -f1 -d" "` \
+		`echo $CMD_FS_CONFIG_OPTION | cut -f1 -d","`
 	export CONFIG_INCLUDED=true
 
 	# Autodetect fs type based on what's on $TEST_DEV unless it's been set
diff --git a/common/report b/common/report
index 7128bbeb..8723c510 100644
--- a/common/report
+++ b/common/report
@@ -12,7 +12,7 @@ REPORT_ENV_LIST=("SECTION" "FSTYP" "PLATFORM" "MKFS_OPTIONS" "MOUNT_OPTIONS" \
 # Variables that are captured in the report /if/ they are set.
 REPORT_ENV_LIST_OPT=("TAPE_DEV" "RMT_TAPE_DEV" "FSSTRESS_AVOID" "FSX_AVOID"
 		     "KCONFIG_PATH" "PERF_CONFIGNAME" "MIN_FSSIZE"
-		     "IDMAPPED_MOUNTS")
+		     "IDMAPPED_MOUNTS" "FS_CONFIG_OPTION")
 
 encode_xml()
 {
-- 
2.34.1


