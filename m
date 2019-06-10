Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C99553BB14
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Jun 2019 19:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388411AbfFJRfz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 10 Jun 2019 13:35:55 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:58562 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387779AbfFJRfx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 10 Jun 2019 13:35:53 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id E153F260195
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     tytso@mit.edu
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
        "Lakshmipathi.G" <lakshmipathi.ganapathi@collabora.co.uk>,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: [PATCH v3 2/2] shared/012: Add tests for filename casefolding feature
Date:   Mon, 10 Jun 2019 13:35:41 -0400
Message-Id: <20190610173541.20511-2-krisman@collabora.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190610173541.20511-1-krisman@collabora.com>
References: <20190610173541.20511-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: "Lakshmipathi.G" <lakshmipathi.ganapathi@collabora.co.uk>

This new test implements verification for the per-directory
case-insensitive feature, as supported by the reference implementation
in Ext4.

Signed-off-by: Lakshmipathi.G <lakshmipathi.ganapathi@collabora.co.uk>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
  [Rewrite to support feature design]
  [Refactor to simplify implementation]
---
 tests/shared/012     | 508 +++++++++++++++++++++++++++++++++++++++++++
 tests/shared/012.out |  16 ++
 tests/shared/group   |   1 +
 3 files changed, 525 insertions(+)
 create mode 100755 tests/shared/012
 create mode 100644 tests/shared/012.out

diff --git a/tests/shared/012 b/tests/shared/012
new file mode 100755
index 000000000000..d7e9cb43f524
--- /dev/null
+++ b/tests/shared/012
@@ -0,0 +1,508 @@
+# SPDX-License-Identifier: GPL-2.0+
+#!/bin/bash
+# FSQA Test No. 012
+#
+# Test the basic functionality of filesystems with case-insensitive
+# support.
+
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+status=1 # failure is thea default
+
+. ./common/rc
+. ./common/filter
+. ./common/casefold
+. ./common/attr
+
+_supported_os Linux
+_require_scratch_nocheck
+_require_scratch_casefold
+_require_check_dmesg
+_require_attrs
+
+sdev=$(_short_dev ${SCRATCH_DEV})
+
+filename1="file.txt"
+filename2="FILE.TXT"
+
+pt_file1=$(echo -e "coração")
+pt_file2=$(echo -e "corac\xcc\xa7\xc3\xa3o" | tr a-z A-Z)
+
+fr_file2=$(echo -e "french_caf\xc3\xa9.txt")
+fr_file1=$(echo -e "french_cafe\xcc\x81.txt")
+
+ar_file1=$(echo -e "arabic_\xdb\x92\xd9\x94.txt")
+ar_file2=$(echo -e "arabic_\xdb\x93.txt" | tr a-z A-Z)
+
+jp_file1=$(echo -e "japanese_\xe3\x82\xb2.txt")
+jp_file2=$(echo -e "japanese_\xe3\x82\xb1\xe3\x82\x99.txt")
+
+# '\xc3\x00' is an invalid sequence. Despite that, the sequences
+# below could match, if we ignored the error.  But we don't want
+# to be greedy at normalization, so at the first error we treat
+# the entire sequence as an opaque blob.  Therefore, these two
+# must NOT match.
+blob_file1=$(echo -e "corac\xcc\xa7\xc3")
+blob_file2=$(echo -e "coraç\xc3")
+
+# Test helpers
+basic_create_lookup()
+{
+	local basedir=${1}
+	local exact=${2}
+	local lookup=${3}
+
+	touch "${basedir}/${exact}"
+	[ -f "${basedir}/${lookup}" ] || \
+		echo "lookup of ${exact} using ${lookup} failed"
+	_casefold_check_exact_name "${basedir}" "${exact}" || \
+		echo "Created file ${exact} with wrong name."
+}
+
+# CI search should fail.
+bad_basic_create_lookup()
+{
+	local basedir=${1}
+	local exact=${2}
+	local lookup=${3}
+
+	touch "${basedir}/${exact}"
+	[ -f "${basedir}/${lookup}" ] && \
+		echo "Lookup of ${exact} using ${lookup} should fail"
+}
+
+# Testcases
+test_casefold_lookup()
+{
+	local basedir=${SCRATCH_MNT}/casefold_lookup
+
+	mkdir -p ${basedir}
+	_casefold_set_attr ${basedir}
+
+	basic_create_lookup "${basedir}" "${filename1}" "${filename2}"
+	basic_create_lookup "${basedir}" "${pt_file1}" "${pt_file2}"
+	basic_create_lookup "${basedir}" "${fr_file1}" "${fr_file2}"
+	basic_create_lookup "${basedir}" "${ar_file1}" "${ar_file2}"
+	basic_create_lookup "${basedir}" "${jp_file1}" "${jp_file2}"
+}
+
+test_bad_casefold_lookup()
+{
+	local basedir=${SCRATCH_MNT}/casefold_lookup
+
+	mkdir -p ${basedir}
+
+	bad_basic_create_lookup ${basedir} ${blob_file1} ${blob_file2}
+}
+
+do_create_and_remove()
+{
+	local basedir=${1}
+	local exact=${2}
+	local casefold=${3}
+
+	basic_create_lookup ${basedir} ${exact} ${casefold}
+	rm -f ${basedir}/${exact}
+	[ -f ${basedir}/${exact} ] && \
+		echo "File ${exact} was not removed using exact name"
+
+	basic_create_lookup ${basedir} ${exact} ${casefold}
+	rm -f ${basedir}/${casefold}
+	[ -f ${basedir}/${exact} ] && \
+		echo "File ${exact} was not removed using inexact name"
+}
+
+# remove and recreate
+test_create_and_remove()
+{
+	local basedir=${SCRATCH_MNT}/create_and_remove
+	mkdir -p ${basedir}
+
+	_casefold_set_attr ${basedir}
+	do_create_and_remove "${basedir}" "${pt_file1}" "${pt_file2}"
+	do_create_and_remove "${basedir}" "${jp_file1}" "${jp_file2}"
+	do_create_and_remove "${basedir}" "${ar_file1}" "${ar_file2}"
+	do_create_and_remove "${basedir}" "${fr_file1}" "${fr_file2}"
+}
+
+test_casefold_flag_basic()
+{
+	local basedir=${SCRATCH_MNT}/basic
+
+	mkdir -p ${basedir}
+	_casefold_set_attr ${basedir}
+	_casefold_lsattr_dir ${basedir} | _filter_scratch
+
+	_casefold_unset_attr ${basedir}
+	_casefold_lsattr_dir ${basedir} | _filter_scratch
+}
+
+test_casefold_flag_removal()
+{
+	local basedir=${SCRATCH_MNT}/casefold_flag_removal
+
+	mkdir -p ${basedir}
+	_casefold_set_attr ${basedir}
+	_casefold_lsattr_dir ${basedir} | _filter_scratch
+
+	# Try to remove +F attribute on non empty directory
+	touch ${basedir}/${filename1}
+	_casefold_unset_attr ${basedir} &>/dev/null
+	_casefold_lsattr_dir ${basedir} | _filter_scratch
+}
+
+# Test Inheritance of casefold flag
+test_casefold_flag_inheritance()
+{
+	local basedir=${SCRATCH_MNT}/flag_inheritance
+	local dirpath1="d1/d2/d3"
+	local dirpath2="D1/D2/D3"
+
+	mkdir -p ${basedir}
+	_casefold_set_attr ${basedir}
+
+	mkdir -p ${basedir}/${dirpath1}
+	_casefold_lsattr_dir ${basedir}/${dirpath1} | _filter_scratch
+
+	[ -d ${basedir}/${dirpath2} ] || \
+		echo "Directory CI Lookup failed."
+	_casefold_check_exact_name "${basedir}" "${dirpath1}" || \
+		echo "Created directory with wrong name."
+
+	touch ${basedir}/${dirpath2}/${filename1}
+	[ -f ${basedir}/${dirpath1}/${filename2} ] || \
+		echo "Couldn't create file on casefolded parent."
+}
+
+# Test nesting of sensitive directory inside insensitive directory.
+test_nesting_sensitive_insensitive_tree_simple()
+{
+	local basedir=${SCRATCH_MNT}/sd1
+
+	mkdir -p ${basedir}
+	_casefold_set_attr ${basedir}
+
+	mkdir -p ${basedir}/sd1
+	_casefold_set_attr ${basedir}/sd1
+
+	mkdir ${basedir}/sd1/sd2
+	_casefold_unset_attr ${basedir}/sd1/sd2
+
+	touch ${basedir}/sd1/sd2/${filename1}
+	[ -f ${basedir}/sd1/sd2/${filename1} ] || \
+		echo "Exact nested file lookup failed."
+	[ -f ${basedir}/sd1/SD2/${filename1} ] || \
+		echo "Nested file lookup failed."
+	[ -f ${basedir}/sd1/SD2/${filename2} ] && \
+		echo "Wrong file lookup passed, should have fail."
+}
+
+test_nesting_sensitive_insensitive_tree_complex()
+{
+	# Test nested-directories
+	local basedir=${SCRATCH_MNT}/nesting
+
+	mkdir -p ${basedir}
+	_casefold_set_attr ${basedir}
+
+	mkdir ${basedir}/nd1
+	_casefold_set_attr ${basedir}/nd1
+	mkdir ${basedir}/nd1/nd2
+	_casefold_unset_attr ${basedir}/nd1/nd2
+	mkdir ${basedir}/nd1/nd2/nd3
+	_casefold_set_attr ${basedir}/nd1/nd2/nd3
+	mkdir ${basedir}/nd1/nd2/nd3/nd4
+	_casefold_unset_attr ${basedir}/nd1/nd2/nd3/nd4
+	mkdir ${basedir}/nd1/nd2/nd3/nd4/nd5
+	_casefold_set_attr ${basedir}/nd1/nd2/nd3/nd4/nd5
+
+	[ -d ${basedir}/ND1/ND2/nd3/ND4/nd5 ] || \
+		echo "Nest-dir Lookup failed."
+	[ -d ${basedir}/nd1/nd2/nd3/nd4/ND5 ] && \
+		echo "ND5: Nest-dir Lookup passed, it should fail."
+	[ -d ${basedir}/nd1/nd2/nd3/ND4/nd5 ] || \
+		echo "Nest-dir Lookup failed."
+	[ -d ${basedir}/nd1/nd2/ND3/nd4/ND5 ] && \
+		echo "ND3: Nest-dir Lookup passed, it should fail."
+}
+
+test_symlink_with_inexact_name()
+{
+	local basedir=${SCRATCH_MNT}/symlink
+
+	mkdir -p ${basedir}
+	_casefold_set_attr ${basedir}
+
+	mkdir ${basedir}/ind1
+	mkdir ${basedir}/ind2
+	_casefold_set_attr ${basedir}/ind1
+	touch ${basedir}/ind1/target
+
+	ln -s ${basedir}/ind1/TARGET ${basedir}/ind2/link
+	[ -L ${basedir}/ind2/link ] || echo "Not a symlink."
+	readlink -e ${basedir}/ind2/link | _filter_scratch
+}
+
+do_test_name_preserve()
+{
+	local basedir=${1}
+	local exact=${2}
+	local casefold=${3}
+
+	touch ${basedir}/${exact}
+	rm ${basedir}/${exact}
+
+	touch ${basedir}/${casefold}
+	_casefold_check_exact_name ${basedir} ${casefold} ||
+		echo "${casefold} was not created with exact name"
+}
+
+# Name-preserving tests
+# We create a file with a name, delete it and create again with an
+# equivalent name.  If the negative dentry wasn't invalidated, the
+# file might be created using $1 instead of $2.
+test_name_preserve()
+{
+	local basedir=${SCRATCH_MNT}/test_name_preserve
+
+	mkdir -p ${basedir}
+	_casefold_set_attr ${basedir}
+
+	do_test_name_preserve "${basedir}" "${pt_file1}" "${pt_file2}"
+	do_test_name_preserve "${basedir}" "${jp_file1}" "${jp_file2}"
+	do_test_name_preserve "${basedir}" "${ar_file1}" "${ar_file2}"
+	do_test_name_preserve "${basedir}" "${fr_file1}" "${fr_file2}"
+}
+
+do_test_dir_name_preserve()
+{
+	local basedir=${1}
+	local exact=${2}
+	local casefold=${3}
+
+	mkdir ${basedir}/${exact}
+	rmdir ${basedir}/${exact}
+
+	mkdir ${basedir}/${casefold}
+	_casefold_check_exact_name ${basedir} ${casefold} ||
+		echo "${casefold} was not created with exact name"
+}
+
+test_dir_name_preserve()
+{
+	local basedir=${SCRATCH_MNT}/"dir-test_name_preserve"
+
+	mkdir -p ${basedir}
+	_casefold_set_attr ${basedir}
+
+	do_test_dir_name_preserve "${basedir}" "${pt_file1}" "${pt_file2}"
+	do_test_dir_name_preserve "${basedir}" "${jp_file1}" "${jp_file2}"
+	do_test_dir_name_preserve "${basedir}" "${ar_file1}" "${ar_file2}"
+	do_test_dir_name_preserve "${basedir}" "${fr_file1}" "${fr_file2}"
+}
+
+test_name_reuse()
+{
+	local basedir=${SCRATCH_MNT}/reuse
+	local reuse1=fileX
+	local reuse2=FILEX
+
+	mkdir ${basedir}
+	_casefold_set_attr ${basedir}
+
+	touch ${basedir}/${reuse1}
+	rm -f ${basedir}/${reuse1} || echo "File lookup failed."
+	touch ${basedir}/${reuse2}
+	_casefold_check_exact_name "${basedir}" "${reuse2}" || \
+		echo "File created with wrong name"
+	_casefold_check_exact_name "${basedir}" "${reuse1}" && \
+		echo "File created with the old name"
+}
+
+test_create_with_same_name()
+{
+	local basedir=${SCRATCH_MNT}/same_name
+
+	mkdir ${basedir}
+	_casefold_set_attr ${basedir}
+
+	mkdir -p ${basedir}/same1/same1
+	touch ${basedir}/SAME1/sAME1/sAMe1
+	touch -c ${basedir}/SAME1/sAME1/same1 ||
+		echo "Would create a new file instead of using old one"
+}
+
+test_file_rename()
+{
+	local basedir=${SCRATCH_MNT}/rename
+
+	mkdir -p ${basedir}
+	_casefold_set_attr ${basedir}
+
+	# Move to an equivalent name should not work
+	mv ${basedir}/rename ${basedir}/rename 2>&1 | \
+		_filter_scratch
+
+	_casefold_check_exact_name ${basedir} "rename" || \
+		echo "Name shouldn't change."
+}
+
+# Test openfd with casefold.
+# 1. Delete a file after gettings its fd.
+# 2. Then create new dir with same name
+test_casefold_openfd()
+{
+	local basedir=${SCRATCH_MNT}/openfd
+	local ofd1="openfd"
+	local ofd2="OPENFD"
+
+	mkdir -p ${basedir}
+	_casefold_set_attr ${basedir}
+
+	exec 3<> ${basedir}/${ofd1}
+	rm -rf ${basedir}/${ofd1}
+	mkdir ${basedir}/${ofd2}
+	[ -d ${basedir}/${ofd2} ] || echo "Not a directory"
+	_casefold_check_exact_name ${basedir} "${ofd2}" ||
+		echo "openfd file was created using old name"
+	rm -rf ${basedir}/${ofd2}
+	exec 3>&-
+}
+
+# Test openfd with casefold.
+# 1. Delete a file after gettings its fd.
+# 2. Then create new file with same name
+# 3. Read from open-fd and write into new file.
+test_casefold_openfd2()
+{
+	local basedir=${SCRATCH_MNT}/openfd2
+	local ofd1="openfd"
+	local ofd2="OPENFD"
+
+	mkdir ${basedir}
+	_casefold_set_attr ${basedir}
+
+	date > ${basedir}/${ofd1}
+	exec 3<> ${basedir}/${ofd1}
+	rm -rf ${basedir}/${ofd1}
+	touch ${basedir}/${ofd1}
+	[ -f ${basedir}/${ofd2} ] || echo "Not a file"
+	read data <&3
+	echo $data >> ${basedir}/${ofd1}
+	exec 3>&-
+}
+
+test_hard_link_lookups()
+{
+	local basedir=${SCRATCH_MNT}/hard_link
+
+	mkdir ${basedir}
+	_casefold_set_attr ${basedir}
+
+	touch ${basedir}/h1
+	ln ${basedir}/H1 ${SCRATCH_MNT}/h1
+	cnt=`stat -c %h ${basedir}/h1`
+	[ $cnt -eq 1 ] && echo "Unable to create hardlink"
+
+	# Create hardlink for casefold dir file and inside regular dir.
+	touch ${SCRATCH_MNT}/h2
+	ln ${SCRATCH_MNT}/h2 ${basedir}/H2
+	cnt=`stat -c %h ${basedir}/h2`
+	[ $cnt -eq 1 ] && echo "Unable to create hardlink"
+}
+
+test_xattrs_lookups()
+{
+	local basedir=${SCRATCH_MNT}/xattrs
+
+	mkdir ${basedir}
+	_casefold_set_attr ${basedir}
+
+	mkdir -p ${basedir}/x
+
+	${SETFATTR_PROG} -n user.foo -v bar ${basedir}/x
+	${GETFATTR_PROG} --absolute-names -n user.foo \
+		${basedir}/x | _filter_scratch
+
+	touch ${basedir}/x/f1
+	${SETFATTR_PROG} -n user.foo -v bar ${basedir}/x/f1
+	${GETFATTR_PROG} --absolute-names -n user.foo \
+		${basedir}/x/f1 | _filter_scratch
+}
+
+test_lookup_large_directory()
+{
+	local basedir=${SCRATCH_MNT}/large
+
+	mkdir -p ${basedir}
+	_casefold_set_attr ${basedir}
+
+	touch $(seq -f "${basedir}/file%g" 0 2000)
+
+	# We really want to spawn a single process here, to speed up the
+	# test, but we don't want the output of 2k files, except for
+	# errors.
+	cat $(seq -f "${basedir}/FILE%g" 0 2000) || \
+		echo "Case on large dir failed"
+}
+
+test_strict_mode_invalid_filename()
+{
+	local basedir=${SCRATCH_MNT}/strict
+
+	mkdir -p ${basedir}
+	_casefold_set_attr ${basedir}
+
+	# These creation commands should fail, since we are on strict
+	# mode.
+	touch "${basedir}/${blob_file1}" 2>&1 | _filter_scratch
+	touch "${basedir}/${blob_file2}" 2>&1 | _filter_scratch
+}
+
+#############
+# Run tests #
+#############
+
+_scratch_mkfs_casefold >>$seqres.full 2>&1
+
+_scratch_mount
+
+_check_dmesg_for \
+	"\(${sdev}\): Using encoding defined by superblock: utf8" || \
+	_fail "Could not mount with encoding: utf8"
+
+test_casefold_flag_basic
+test_casefold_lookup
+test_bad_casefold_lookup
+test_create_and_remove
+test_casefold_flag_removal
+test_casefold_flag_inheritance
+test_nesting_sensitive_insensitive_tree_simple
+test_nesting_sensitive_insensitive_tree_complex
+test_symlink_with_inexact_name
+test_name_preserve
+test_dir_name_preserve
+test_name_reuse
+test_create_with_same_name
+test_file_rename
+test_casefold_openfd
+test_casefold_openfd2
+test_hard_link_lookups
+test_xattrs_lookups
+test_lookup_large_directory
+
+_scratch_unmount
+_check_scratch_fs
+
+# Test Strict Mode
+_scratch_mkfs_casefold_strict >>$seqres.full 2>&1
+_scratch_mount
+
+test_strict_mode_invalid_filename
+
+_scratch_unmount
+_check_scratch_fs
+
+status=0
+exit
diff --git a/tests/shared/012.out b/tests/shared/012.out
new file mode 100644
index 000000000000..2951be901f7c
--- /dev/null
+++ b/tests/shared/012.out
@@ -0,0 +1,16 @@
+QA output created by 012
+SCRATCH_MNT/basic           Extents, Casefold
+SCRATCH_MNT/basic           Extents
+SCRATCH_MNT/casefold_flag_removal Extents, Casefold
+SCRATCH_MNT/casefold_flag_removal Extents, Casefold
+SCRATCH_MNT/flag_inheritance/d1/d2/d3 Extents, Casefold
+SCRATCH_MNT/symlink/ind1/TARGET
+mv: cannot stat 'SCRATCH_MNT/rename/rename': No such file or directory
+# file: SCRATCH_MNT/xattrs/x
+user.foo="bar"
+
+# file: SCRATCH_MNT/xattrs/x/f1
+user.foo="bar"
+
+touch: setting times of 'SCRATCH_MNT/strict/corac'$'\314\247\303': Invalid argument
+touch: setting times of 'SCRATCH_MNT/strict/cora'$'\303\247\303': Invalid argument
diff --git a/tests/shared/group b/tests/shared/group
index b091d9111359..53b4a356695d 100644
--- a/tests/shared/group
+++ b/tests/shared/group
@@ -14,6 +14,7 @@
 009 auto stress dedupe
 010 auto stress dedupe
 011 auto quick
+012 auto quick casefold
 032 mkfs auto quick
 272 auto enospc rw
 289 auto quick
-- 
2.20.1

