Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2674D15417
	for <lists+linux-ext4@lfdr.de>; Mon,  6 May 2019 21:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbfEFTAC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 6 May 2019 15:00:02 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33082 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbfEFTAC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 6 May 2019 15:00:02 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 5E3722735FD
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     fstests@vger.kernel.org
Cc:     tytso@mit.edu, linux-ext4@vger.kernel.org,
        "Lakshmipathi.G" <lakshmipathi.ganapathi@collabora.co.uk>,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: [PATCH xfstests 2/2] ext4/035: Add tests for filename casefolding feature
Date:   Mon,  6 May 2019 14:59:41 -0400
Message-Id: <20190506185941.10570-2-krisman@collabora.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190506185941.10570-1-krisman@collabora.com>
References: <20190506185941.10570-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: "Lakshmipathi.G" <lakshmipathi.ganapathi@collabora.co.uk>

This new test implements verification for the per-directory
case-insensitive feature, as supported in the reference implementation
in Ext4.  Currently, this test only runs for Ext4, but it could be run
with minimal modifications on other filesystems, once they support the
feature.

Signed-off-by: Lakshmipathi.G <lakshmipathi.ganapathi@collabora.co.uk>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
  [Rewrite to support feature design]
  [Refactor to simplify implementation]
---
 tests/ext4/035     | 475 +++++++++++++++++++++++++++++++++++++++++++++
 tests/ext4/035.out |   2 +
 tests/ext4/group   |   1 +
 3 files changed, 478 insertions(+)
 create mode 100755 tests/ext4/035
 create mode 100644 tests/ext4/035.out

diff --git a/tests/ext4/035 b/tests/ext4/035
new file mode 100755
index 000000000000..120a76474973
--- /dev/null
+++ b/tests/ext4/035
@@ -0,0 +1,475 @@
+#! /bin/bash
+# FSQA Test No. 035
+#
+# Test the creation, mounting and basic functionality of file name
+# casefolding on Ext4
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2018 Collabora Ltd.  All Rights Reserved.
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it would be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write the Free Software Foundation,
+# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+#
+#-----------------------------------------------------------------------
+
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+status=1 # failure is thea default
+
+. ./common/rc
+. ./common/casefold
+
+_supported_fs ext4
+_supported_os Linux
+_require_scratch
+_require_check_dmesg
+
+sdev=$(_short_dev ${SCRATCH_DEV})
+test_casefold=${SCRATCH_MNT}
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
+# '\xc3\x00' is an invalid sequence. Despite that, the sequences below
+# could match, if we ignored the error.  But we don't want to be greedy
+# at normalization, so at the first error we treat the entire sequence
+# as an opaque blob.  Therefore, these two must NOT match.
+blob_file1=$(echo -e "corac\xcc\xa7\xc3")
+blob_file2=$(echo -e "coraç\xc3")
+
+# Test helpers
+basic_create_lookup() {
+    touch "${basedir}/${1}"
+    stat  "${basedir}/${2}" &> /dev/null || \
+	_fail "Casefolded lookup of ${1} ${2} failed"
+    _casefold_check_exact_name "${basedir}" "${1}" || \
+	_fail "Created file with wrong name."
+
+}
+
+# CI search should fail.
+bad_basic_create_lookup() {
+    touch "${basedir}/${1}"
+    stat  "${basedir}/${2}" &> /dev/null && \
+	_fail "Lookup of ${1} using ${2} should have failed"
+}
+
+# Testcases
+test_casefold_lookup () {
+    basedir=${test_casefold}/casefold_lookup
+    mkdir -p ${basedir}
+
+    _set_casefold_attr ${basedir}
+
+    basic_create_lookup "${filename1}" "${filename2}"
+    basic_create_lookup "${pt_file1}" "${pt_file2}"
+    basic_create_lookup "${fr_file1}" "${fr_file2}"
+    basic_create_lookup "${ar_file1}" "${ar_file2}"
+    basic_create_lookup "${jp_file1}" "${jp_file2}"
+}
+
+test_bad_casefold_lookup () {
+    bad_basic_create_lookup ${blob_file1} ${blob_file2}
+}
+
+# remove and recreate
+test_create_and_remove() {
+    __create_and_remove() {
+	basic_create_lookup ${1}
+	rm -f  ${basedir}/"${1}"
+	stat   ${basedir}/"${1}" &> /dev/null && \
+	    _fail "File ${1} was not removed using exact name"
+
+	basic_create_lookup ${1}
+	rm -f  ${basedir}/"${2}"
+	stat   ${basedir}/"${1}" &> /dev/null && \
+	    _fail "File ${1} was not removed using inexact name"
+    }
+
+    basedir=${test_casefold}/create_and_remove
+    mkdir -p ${basedir}
+
+    _set_casefold_attr ${basedir}
+
+    __create_and_remove "${pt_file1}" "${pt_file2}"
+    __create_and_remove "${jp_file1}" "${jp_file2}"
+    __create_and_remove "${ar_file1}" "${ar_file2}"
+    __create_and_remove "${fr_file1}" "${fr_file2}"
+
+}
+
+test_casefold_flag_basic () {
+    basedir=${test_casefold}/basic
+    mkdir -p ${basedir}
+
+    _set_casefold_attr ${basedir}
+    _is_casefolded_dir ${basedir} || _fail "Casefold attribute wasn't set"
+
+    _unset_casefold_attr ${basedir}
+    _is_casefolded_dir ${basedir} && _fail "Casefold attribute is still set"
+}
+
+test_casefold_flag_removal () {
+    basedir=${test_casefold}/casefold_flag_removal
+    mkdir -p ${basedir}
+
+    _set_casefold_attr ${basedir}
+    touch ${basedir}/${filename1}
+
+    # Try to remove +F attribute on non empty directory
+    _try_unset_casefold_attr ${basedir} && \
+	_fail "Shouldn't be able to remove casefold attribute of non-empty directory"
+}
+
+
+# Test Inheritance of casefold flag
+test_casefold_flag_inheritance () {
+    dirpath1="d1/d2/d3"
+    dirpath2="D1/D2/D3"
+
+    basedir=${test_casefold}/flag_inheritance
+
+    mkdir -p ${basedir}
+    _set_casefold_attr ${basedir}
+
+    mkdir -p ${basedir}/${dirpath1}
+
+    _is_casefolded_dir ${basedir}/${dirpath1} || \
+	_fail "Casefold attribute should be inherited"
+    ls  ${basedir}/${dirpath2} &>/dev/null || \
+	_fail "Dir Lookup failed."
+    _casefold_check_exact_name "${basedir}" "${dirpath1}" || \
+	_fail "Created directories wrong name."
+
+    touch ${basedir}/${dirpath2}/${filename1}
+    ls  ${basedir}/${dirpath1}/${filename2} &>/dev/null || \
+	_fail "Couldn't create file on casefolded parent."
+}
+
+# Test nesting of sensitive directory inside insensitive directory.
+test_nesting_sensitive_insensitive_tree_simple() {
+    basedir=${test_casefold}/sd1
+    mkdir -p ${basedir}
+    _set_casefold_attr ${basedir}
+
+    mkdir -p ${basedir}/sd1
+    _set_casefold_attr ${basedir}/sd1
+
+    mkdir ${basedir}/sd1/sd2
+    _unset_casefold_attr ${basedir}/sd1/sd2
+
+    touch ${basedir}/sd1/sd2/${filename1}
+    ls ${basedir}/sd1/sd2/${filename1} &>/dev/null || \
+	_fail "Exact nested file lookup failed."
+    ls ${basedir}/sd1/SD2/${filename1} &>/dev/null || \
+	_fail "Nested file lookup failed."
+    ls ${basedir}/sd1/SD2/${filename2} &>/dev/null && \
+	_fail "Wrong file lookup passed, should have fail."
+}
+
+test_nesting_sensitive_insensitive_tree_complex() {
+    # Test nested-directories
+    basedir=${test_casefold}/nesting
+    mkdir -p ${basedir}
+
+    _set_casefold_attr ${basedir}
+
+    mkdir ${basedir}/nd1
+    _set_casefold_attr ${basedir}/nd1
+    mkdir ${basedir}/nd1/nd2
+    _unset_casefold_attr ${basedir}/nd1/nd2
+    mkdir ${basedir}/nd1/nd2/nd3
+    _set_casefold_attr ${basedir}/nd1/nd2/nd3
+    mkdir ${basedir}/nd1/nd2/nd3/nd4
+    _unset_casefold_attr ${basedir}/nd1/nd2/nd3/nd4
+    mkdir ${basedir}/nd1/nd2/nd3/nd4/nd5
+    _set_casefold_attr ${basedir}/nd1/nd2/nd3/nd4/nd5
+
+    ls ${basedir}/ND1/ND2/nd3/ND4/nd5 &>/dev/null || \
+	_fail "Nest-dir Lookup failed."
+    ls ${basedir}/nd1/nd2/nd3/nd4/ND5 &>/dev/null && \
+	_fail "ND5: Nest-dir Lookup passed, it should fail."
+    ls ${basedir}/nd1/nd2/nd3/ND4/nd5 &>/dev/null || \
+	_fail "Nest-dir Lookup failed."
+    ls ${basedir}/nd1/nd2/ND3/nd4/ND5 &>/dev/null && \
+	_fail "ND3: Nest-dir Lookup passed, it should fail."
+}
+
+
+test_symlink_with_inexact_name () {
+    basedir=${test_casefold}/symlink
+    mkdir -p ${basedir}
+
+    _set_casefold_attr ${basedir}
+
+    mkdir ${basedir}/ind1
+    mkdir ${basedir}/ind2
+    _set_casefold_attr ${basedir}/ind1
+    touch ${basedir}/ind1/target
+    ln -s ${basedir}/ind1/TARGET ${basedir}/ind2/link
+    [ -L ${basedir}/ind2/link ] || _fail "Not a symlink."
+    readlink -e ${basedir}/ind2/link &>/dev/null || _fail "Symlink failed"
+}
+
+
+# Name-preserving tests
+# We create a file with a name, delete it and create again with an
+# equivalent name.  If the negative dentry wasn't invalidated, the
+# file might be created using $1 instead of $2.
+test_name_preserve () {
+    __test_name_preserve () {
+	touch ${basedir}/${1}
+	rm ${basedir}/${1}
+
+	touch ${basedir}/${2}
+	_casefold_check_exact_name ${basedir} ${2} ||
+	    _fail "${2} was not created with exact name"
+    }
+    basedir=${test_casefold}/"test_name_preserve"
+    mkdir -p ${basedir}
+
+    _set_casefold_attr ${basedir}
+
+    __test_name_preserve "${pt_file1}" "${pt_file2}"
+    __test_name_preserve "${jp_file1}" "${jp_file2}"
+    __test_name_preserve "${ar_file1}" "${ar_file2}"
+    __test_name_preserve "${fr_file1}" "${fr_file2}"
+}
+
+test_dir_name_preserve () {
+
+    __test_dir_name_preserve () {
+	mkdir ${basedir}/${1}
+	rmdir ${basedir}/${1}
+
+	mkdir ${basedir}/${2}
+	_casefold_check_exact_name ${basedir} ${2} ||
+	    _fail "${2} was not created with exact name"
+    }
+
+    basedir=${test_casefold}/"dir-test_name_preserve"
+    mkdir -p ${basedir}
+
+    _set_casefold_attr ${basedir}
+
+    __test_dir_name_preserve "${pt_file1}" "${pt_file2}"
+    __test_dir_name_preserve "${jp_file1}" "${jp_file2}"
+    __test_dir_name_preserve "${ar_file1}" "${ar_file2}"
+    __test_dir_name_preserve "${fr_file1}" "${fr_file2}"
+}
+
+# Name reuse for CI search
+test_name_reuse () {
+    basedir=${test_casefold}/reuse
+
+    mkdir ${basedir}
+    _set_casefold_attr ${basedir}
+
+    reuse1=fileX
+    reuse2=FILEX
+
+    touch ${basedir}/${reuse1}
+    rm -f ${basedir}/${reuse1} || _fail "File lookup failed."
+    touch ${basedir}/${reuse2}
+    _casefold_check_exact_name "${basedir}" "${reuse2}" || \
+	_fail "File created with wrong name"
+    _casefold_check_exact_name "${basedir}" "${reuse1}" && \
+	_fail "File created with the old name"
+}
+
+# filepath same name
+test_create_with_same_name () {
+    basedir=${test_casefold}/same_name
+    mkdir ${basedir}
+
+    _set_casefold_attr ${basedir}
+
+    mkdir -p ${basedir}/same1/same1
+    touch ${basedir}/SAME1/sAME1/sAMe1
+    touch -c ${basedir}/SAME1/sAME1/same1 ||
+	_fail "Trying to create a new file instead of using old one"
+}
+
+# file Rename
+test_file_rename () {
+    basedir=${test_casefold}/rename
+    mkdir -p ${basedir}
+    _set_casefold_attr ${basedir}
+
+    mv ${basedir}/rename ${basedir}/rename &>/dev/null && \
+	_fail "mv to an equivalent name shouldn't work"
+    _casefold_check_exact_name ${basedir} "rename"  || \
+	_fail "Name shouldn't change."
+}
+
+test_casefold_openfd () {
+    # Test openfd with casefold.
+    # 1. Delete a file after gettings its fd.
+    # 2. Then create new dir with same name
+    ofd1="openfd"
+    ofd2="OPENFD"
+
+    basedir=${test_casefold}/openfd
+    mkdir -p ${basedir}
+    _set_casefold_attr ${basedir}
+
+    exec 3<> ${basedir}/${ofd1}
+    rm -rf ${basedir}/${ofd1}
+    mkdir ${basedir}/${ofd2}
+    [ -d ${basedir}/${ofd2} ]   || _fail "Not a directory"
+    _casefold_check_exact_name ${basedir} "${ofd2}" ||
+	_fail "openfd file was created using old name"
+    rm -rf ${basedir}/${ofd2}
+    exec 3>&-
+}
+
+test_casefold_openfd2 () {
+    # Test openfd with casefold.
+    # 1. Delete a file after gettings its fd.
+    # 2. Then create new file with same name
+    # 3. Read from open-fd and write into new file.
+
+    basedir=${test_casefold}/openfd2
+    mkdir ${basedir}
+    _set_casefold_attr ${basedir}
+
+    date > ${basedir}/${ofd1}
+    exec 3<> ${basedir}/${ofd1}
+    rm -rf ${basedir}/${ofd1}
+    touch ${basedir}/${ofd1}
+    [ -f ${basedir}/${ofd2} ] || _fail "Not a file"
+    read data <&3
+    echo $data >> ${basedir}/${ofd1}
+    exec 3>&-
+}
+
+test_hard_link_lookups () {
+    # Create hardlink for casefold dir file and inside regular dir.
+    basedir=${test_casefold}/hard_link
+    mkdir ${basedir}
+    _set_casefold_attr ${basedir}
+
+    touch ${basedir}/h1
+    ln ${basedir}/H1 ${SCRATCH_MNT}/h1
+    cnt=`stat -c %h ${basedir}/h1`
+    [ $cnt -eq 1 ] && _fail "Unable to create hardlink"
+
+    # Create hardlink for casefold dir file and inside regular dir.
+    touch ${SCRATCH_MNT}/h2
+    ln ${SCRATCH_MNT}/h2 ${basedir}/H2
+    cnt=`stat -c %h ${basedir}/h2`
+    [ $cnt -eq 1 ] && _fail "Unable to create hardlink"
+}
+
+test_xattrs_lookups () {
+    basedir=${test_casefold}/xattrs
+    mkdir ${basedir}
+    _set_casefold_attr ${basedir}
+
+    mkdir -p ${basedir}/x
+    setfattr -n user.foo -v bar ${basedir}/x
+    getfattr -n user.foo ${basedir}/x &>/dev/null || \
+	_fail "Casefold xattr lookup failed."
+
+    touch ${basedir}/x/f1
+    setfattr -n user.foo -v bar ${basedir}/x/f1
+    getfattr -n user.foo ${basedir}/x/f1 &>/dev/null || \
+	_fail "Casefold xattr lookup failed."
+}
+
+test_lookup_large_directory() {
+    # Perform Casefold lookup on large dir
+
+    basedir=${test_casefold}/large
+    mkdir ${basedir}
+    _set_casefold_attr ${basedir}
+
+    touch $(seq -f "${basedir}/file%g" 0 2000)
+    stat  $(seq -f "${basedir}/FILE%g" 0 2000) &>/dev/null || \
+	_fail "Case on large dir failed"
+}
+
+test_strict_mode_invalid_filename () {
+    __strict_mode_invalid_filename () {
+	touch  "${basedir}/${1}" &>/dev/null && \
+	    _fail "Invalid UTF-8 sequence ${1} should fail at creation time."
+    }
+
+    __strict_mode_invalid_filename ${blob1}
+    __strict_mode_invalid_filename ${blob2}
+}
+
+#############
+# Run tests #
+#############
+
+_scratch_mkfs_ext4 "-O casefold" 2>&1 1>/dev/null
+
+_has_casefold_feature ${SCRATCH_DEV} || \
+    _fail "encoding flag wasn't configured for ${sdev}"
+
+_scratch_mount
+
+_check_dmesg_for \
+    "\(${sdev}\): Using encoding defined by superblock: utf8" || \
+    _fail "Could not mount with encoding: utf8"
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
+_scratch_unmount 2>&1
+_check_scratch_fs
+
+# Test Strict Mode
+_scratch_mkfs_ext4 \
+    "-O casefold -E encoding_flags=strict" 2>&1 1>/dev/null
+_scratch_mount 2>&1
+
+test_strict_mode_invalid_filename
+
+_scratch_unmount 2>&1
+_check_scratch_fs
+
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/ext4/035.out b/tests/ext4/035.out
new file mode 100644
index 000000000000..5c8f63c3e4f3
--- /dev/null
+++ b/tests/ext4/035.out
@@ -0,0 +1,2 @@
+QA output created by 035
+Silence is golden
diff --git a/tests/ext4/group b/tests/ext4/group
index eb744a121650..39ffa06ef036 100644
--- a/tests/ext4/group
+++ b/tests/ext4/group
@@ -37,6 +37,7 @@
 032 auto quick ioctl resize
 033 auto ioctl resize
 034 auto quick quota
+035 auto quick casefold
 271 auto rw quick
 301 aio auto ioctl rw stress defrag
 302 aio auto ioctl rw stress defrag
-- 
2.20.1

