Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9233E3925D
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Jun 2019 18:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730992AbfFGQm3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 7 Jun 2019 12:42:29 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44976 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730192AbfFGQm3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 7 Jun 2019 12:42:29 -0400
Received: by mail-pg1-f194.google.com with SMTP id n2so1433307pgp.11;
        Fri, 07 Jun 2019 09:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=JmG3HzoWX6A+IGX7rZ3+otzOQHqViN65YSiAgpzU30c=;
        b=u0KGFAgq1p9IwFd03EORxPFGSuhuhUbCUeJZXF2Yt4E/YPGHptCg93tYWuG80Otf7J
         izNO+8KEs9S+AKFvUx9w4N+wdLpcWtb4emt1k+FJKfLgA2tj3ziH9txws0DgpHltPQxv
         GXV+0Rh7KA+kisuZxqjhPb562//YDI6pkrFLIcaT2ERa94J/lGIqLPRGOZLBB0FnZ505
         WhFRgq6jDY+FfbfTNeyhSOPmCBMdbBA8cYVvitYEWHThicI6wd3mXc+mddLEOwqXAZE9
         dYNowoEOQ1Dvg+LHc3RbQZDyBfmS17HgIu0zX5G/ljJMbiNaQb5mYos9/Q5R4BKfzvRH
         rwkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=JmG3HzoWX6A+IGX7rZ3+otzOQHqViN65YSiAgpzU30c=;
        b=lqlKQOgby/+yrq9aCTEUIppWNiZQbuV7DmHG8hmJuE2REkdr/4ReN69cMiyLz42asD
         VHvlBP4KfuXsfsvHRET/Y4QTt3RBYDNGl1leHPvHmInoDT8f9e13Zc+HF2KiQoGJNSdN
         S2AVzXGWLgf3A2+zbpLpVNS+FNN/4rtkDsfi41LNuYPMVdzOV0YW/K7huLMyE8Ipq1jY
         jCwvsGD1CeOHc0+i0ZV1do+9v54JQgEV9y0+l2ruAESOkNKmN9oIIv1EsCSE/Dhdo/oR
         x1uy2tkZuEms9AGFW9TXnR9HWaeeUxprK+j8osemVBZA0C2fmdUFjgFkrio110Kf6/fH
         /lXw==
X-Gm-Message-State: APjAAAViJoXb9u1BvycCYGESTt7I9Bm+WxM1d+FEpMdzvNkp6sFLELp6
        f2dezZGDrGchGNtAS2KgfjwCVUZU
X-Google-Smtp-Source: APXvYqzKlw3uCLqzFxq2uafzucz8BkTnTGD6Kbrl8QTx5Scp+rn6paCQlYUB9kqv45vCSaSMcaNSig==
X-Received: by 2002:a63:5152:: with SMTP id r18mr3713684pgl.324.1559925748109;
        Fri, 07 Jun 2019 09:42:28 -0700 (PDT)
Received: from localhost ([47.254.35.144])
        by smtp.gmail.com with ESMTPSA id p64sm3104841pfp.72.2019.06.07.09.42.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 07 Jun 2019 09:42:27 -0700 (PDT)
Date:   Sat, 8 Jun 2019 00:42:23 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     tytso@mit.edu, fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
        "Lakshmipathi.G" <lakshmipathi.ganapathi@collabora.co.uk>
Subject: Re: [PATCH v2 2/2] ext4/036: Add tests for filename casefolding
 feature
Message-ID: <20190607164223.GV15846@desktop>
References: <20190606193138.25852-1-krisman@collabora.com>
 <20190606193138.25852-2-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190606193138.25852-2-krisman@collabora.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Jun 06, 2019 at 03:31:38PM -0400, Gabriel Krisman Bertazi wrote:
> From: "Lakshmipathi.G" <lakshmipathi.ganapathi@collabora.co.uk>
> 
> This new test implements verification for the per-directory
> case-insensitive feature, as supported in the reference implementation
> in Ext4.  Currently, this test only supports Ext4, but the plan is to
> run it in other filesystems, once they support the feature.
> 
> For now, let it live in ext4 and we move to shared/ or generic/ when
> other filesystems supporting this feature start to pop up.
> 
> Signed-off-by: Lakshmipathi.G <lakshmipathi.ganapathi@collabora.co.uk>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
>   [Rewrite to support feature design]
>   [Refactor to simplify implementation]
> ---
>  tests/ext4/036     | 469 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/ext4/036.out |   2 +
>  tests/ext4/group   |   1 +
>  3 files changed, 472 insertions(+)
>  create mode 100755 tests/ext4/036
>  create mode 100644 tests/ext4/036.out
> 
> diff --git a/tests/ext4/036 b/tests/ext4/036
> new file mode 100755
> index 000000000000..3dae4212853b
> --- /dev/null
> +++ b/tests/ext4/036
> @@ -0,0 +1,469 @@
> +#! /bin/bash
> +# FSQA Test No. 036
> +#
> +# Test the creation, mounting and basic functionality of file name
> +# casefolding on Ext4
> +#
> +#-----------------------------------------------------------------------
> +# Copyright (c) 2018 Collabora Ltd.  All Rights Reserved.
> +#
> +# This program is free software; you can redistribute it and/or
> +# modify it under the terms of the GNU General Public License as
> +# published by the Free Software Foundation.
> +#
> +# This program is distributed in the hope that it would be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program; if not, write the Free Software Foundation,
> +# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> +#
> +#-----------------------------------------------------------------------

Same here, use SPDX tags.

> +
> +seq=`basename $0`
> +seqres=$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +status=1 # failure is thea default
> +
> +. ./common/rc
> +. ./common/casefold
> +
> +_supported_os Linux
> +_require_scratch
> +_require_casefold_support
> +_require_check_dmesg
> +
> +sdev=$(_short_dev ${SCRATCH_DEV})
> +test_casefold=${SCRATCH_MNT}

This doesn't look necessary, just use $SCRATCH_MNT in the test?

> +
> +filename1="file.txt"
> +filename2="FILE.TXT"
> +
> +pt_file1=$(echo -e "coração")
> +pt_file2=$(echo -e "corac\xcc\xa7\xc3\xa3o" | tr a-z A-Z)
> +
> +fr_file2=$(echo -e "french_caf\xc3\xa9.txt")
> +fr_file1=$(echo -e "french_cafe\xcc\x81.txt")
> +
> +ar_file1=$(echo -e "arabic_\xdb\x92\xd9\x94.txt")
> +ar_file2=$(echo -e "arabic_\xdb\x93.txt" | tr a-z A-Z)
> +
> +jp_file1=$(echo -e "japanese_\xe3\x82\xb2.txt")
> +jp_file2=$(echo -e "japanese_\xe3\x82\xb1\xe3\x82\x99.txt")
> +
> +# '\xc3\x00' is an invalid sequence. Despite that, the sequences below
> +# could match, if we ignored the error.  But we don't want to be greedy
> +# at normalization, so at the first error we treat the entire sequence
> +# as an opaque blob.  Therefore, these two must NOT match.
> +blob_file1=$(echo -e "corac\xcc\xa7\xc3")
> +blob_file2=$(echo -e "coraç\xc3")
> +
> +# Test helpers
> +basic_create_lookup() {
> +    touch "${basedir}/${1}"

Please assign one of the function params to basedir and declare it as a
local variable.

> +    stat  "${basedir}/${2}" &> /dev/null || \
> +	_fail "Casefolded lookup of ${1} ${2} failed"

In fstests, we usually don't do _fail in tests, we just let test prints
error messages and the test harness will capture the outputs & compare
them with the golden image (.out file), so we know which part of the
test fails and test could continue to run. e.g.

> +    _casefold_check_exact_name "${basedir}" "${1}" || \
> +	_fail "Created file with wrong name."

	stat "$basedir/$2" | _filter_scratch
	_casefold_check_exact_name "$basedir" "$1" || \
		echo "Created \"$basedir/$2\" with wrong name"

To use _filter_scratch we need to source common/filter after sourcing
common/rc.

> +
> +}
> +
> +# CI search should fail.
> +bad_basic_create_lookup() {
> +    touch "${basedir}/${1}"
> +    stat  "${basedir}/${2}" &> /dev/null && \
> +	_fail "Lookup of ${1} using ${2} should have failed"
> +}
> +
> +# Testcases
> +test_casefold_lookup () {
                      ^^^ no space here.
> +    basedir=${test_casefold}/casefold_lookup
> +    mkdir -p ${basedir}
> +
> +    _set_casefold_attr ${basedir}

Same here, if _set_casefold_attr fails with some error messages to
stderr, the test harness would capture that, just put the expected
output to .out file if any.

> +
> +    basic_create_lookup "${filename1}" "${filename2}"
> +    basic_create_lookup "${pt_file1}" "${pt_file2}"
> +    basic_create_lookup "${fr_file1}" "${fr_file2}"
> +    basic_create_lookup "${ar_file1}" "${ar_file2}"
> +    basic_create_lookup "${jp_file1}" "${jp_file2}"
> +}
> +
> +test_bad_casefold_lookup () {
> +    bad_basic_create_lookup ${blob_file1} ${blob_file2}
> +}
> +
> +# remove and recreate
> +test_create_and_remove() {
> +    __create_and_remove() {

In fstests, functions and/or variables starting with "_" are reserved
for global names, do_create_and_remove should be fine. And move it out
of the outer function?

> +	basic_create_lookup ${1}
> +	rm -f  ${basedir}/"${1}"
> +	stat   ${basedir}/"${1}" &> /dev/null && \
> +	    _fail "File ${1} was not removed using exact name"
> +
> +	basic_create_lookup ${1}
> +	rm -f  ${basedir}/"${2}"
> +	stat   ${basedir}/"${1}" &> /dev/null && \
> +	    _fail "File ${1} was not removed using inexact name"
> +    }
> +
> +    basedir=${test_casefold}/create_and_remove
> +    mkdir -p ${basedir}
> +
> +    _set_casefold_attr ${basedir}
> +
> +    __create_and_remove "${pt_file1}" "${pt_file2}"
> +    __create_and_remove "${jp_file1}" "${jp_file2}"
> +    __create_and_remove "${ar_file1}" "${ar_file2}"
> +    __create_and_remove "${fr_file1}" "${fr_file2}"
> +
> +}
> +
> +test_casefold_flag_basic () {
> +    basedir=${test_casefold}/basic
> +    mkdir -p ${basedir}
> +
> +    _set_casefold_attr ${basedir}
> +    _is_casefolded_dir ${basedir} || _fail "Casefold attribute wasn't set"
> +
> +    _unset_casefold_attr ${basedir}
> +    _is_casefolded_dir ${basedir} && _fail "Casefold attribute is still set"
> +}
> +
> +test_casefold_flag_removal () {
> +    basedir=${test_casefold}/casefold_flag_removal
> +    mkdir -p ${basedir}
> +
> +    _set_casefold_attr ${basedir}
> +    touch ${basedir}/${filename1}
> +
> +    # Try to remove +F attribute on non empty directory
> +    _try_unset_casefold_attr ${basedir} && \
> +	_fail "Shouldn't be able to remove casefold attribute of non-empty directory"

So here we could just do "_unset_casefold_attr $basename" and log the
expected error message (maybe with some filters to make the output
deterministic) in .out file and we can get rid of the _try functions.

> +}
> +
> +# Test Inheritance of casefold flag
> +test_casefold_flag_inheritance () {
> +    dirpath1="d1/d2/d3"
> +    dirpath2="D1/D2/D3"
> +
> +    basedir=${test_casefold}/flag_inheritance
> +
> +    mkdir -p ${basedir}
> +    _set_casefold_attr ${basedir}
> +
> +    mkdir -p ${basedir}/${dirpath1}
> +
> +    _is_casefolded_dir ${basedir}/${dirpath1} || \
> +	_fail "Casefold attribute should be inherited"
> +    ls  ${basedir}/${dirpath2} &>/dev/null || \
> +	_fail "Dir Lookup failed."
> +    _casefold_check_exact_name "${basedir}" "${dirpath1}" || \
> +	_fail "Created directories wrong name."
> +
> +    touch ${basedir}/${dirpath2}/${filename1}
> +    ls  ${basedir}/${dirpath1}/${filename2} &>/dev/null || \
> +	_fail "Couldn't create file on casefolded parent."
> +}
> +
> +# Test nesting of sensitive directory inside insensitive directory.
> +test_nesting_sensitive_insensitive_tree_simple() {
> +    basedir=${test_casefold}/sd1
> +    mkdir -p ${basedir}
> +    _set_casefold_attr ${basedir}
> +
> +    mkdir -p ${basedir}/sd1
> +    _set_casefold_attr ${basedir}/sd1
> +
> +    mkdir ${basedir}/sd1/sd2
> +    _unset_casefold_attr ${basedir}/sd1/sd2
> +
> +    touch ${basedir}/sd1/sd2/${filename1}
> +    ls ${basedir}/sd1/sd2/${filename1} &>/dev/null || \
> +	_fail "Exact nested file lookup failed."
> +    ls ${basedir}/sd1/SD2/${filename1} &>/dev/null || \
> +	_fail "Nested file lookup failed."
> +    ls ${basedir}/sd1/SD2/${filename2} &>/dev/null && \
> +	_fail "Wrong file lookup passed, should have fail."
> +}
> +
> +test_nesting_sensitive_insensitive_tree_complex() {
> +    # Test nested-directories
> +    basedir=${test_casefold}/nesting
> +    mkdir -p ${basedir}
> +
> +    _set_casefold_attr ${basedir}
> +
> +    mkdir ${basedir}/nd1
> +    _set_casefold_attr ${basedir}/nd1
> +    mkdir ${basedir}/nd1/nd2
> +    _unset_casefold_attr ${basedir}/nd1/nd2
> +    mkdir ${basedir}/nd1/nd2/nd3
> +    _set_casefold_attr ${basedir}/nd1/nd2/nd3
> +    mkdir ${basedir}/nd1/nd2/nd3/nd4
> +    _unset_casefold_attr ${basedir}/nd1/nd2/nd3/nd4
> +    mkdir ${basedir}/nd1/nd2/nd3/nd4/nd5
> +    _set_casefold_attr ${basedir}/nd1/nd2/nd3/nd4/nd5
> +
> +    ls ${basedir}/ND1/ND2/nd3/ND4/nd5 &>/dev/null || \
> +	_fail "Nest-dir Lookup failed."
> +    ls ${basedir}/nd1/nd2/nd3/nd4/ND5 &>/dev/null && \
> +	_fail "ND5: Nest-dir Lookup passed, it should fail."
> +    ls ${basedir}/nd1/nd2/nd3/ND4/nd5 &>/dev/null || \
> +	_fail "Nest-dir Lookup failed."
> +    ls ${basedir}/nd1/nd2/ND3/nd4/ND5 &>/dev/null && \
> +	_fail "ND3: Nest-dir Lookup passed, it should fail."
> +}
> +
> +test_symlink_with_inexact_name () {
> +    basedir=${test_casefold}/symlink
> +    mkdir -p ${basedir}
> +
> +    _set_casefold_attr ${basedir}
> +
> +    mkdir ${basedir}/ind1
> +    mkdir ${basedir}/ind2
> +    _set_casefold_attr ${basedir}/ind1
> +    touch ${basedir}/ind1/target
> +    ln -s ${basedir}/ind1/TARGET ${basedir}/ind2/link
> +    [ -L ${basedir}/ind2/link ] || _fail "Not a symlink."
> +    readlink -e ${basedir}/ind2/link &>/dev/null || _fail "Symlink failed"
> +}
> +
> +
> +# Name-preserving tests
> +# We create a file with a name, delete it and create again with an
> +# equivalent name.  If the negative dentry wasn't invalidated, the
> +# file might be created using $1 instead of $2.
> +test_name_preserve () {
> +    __test_name_preserve () {
> +	touch ${basedir}/${1}
> +	rm ${basedir}/${1}
> +
> +	touch ${basedir}/${2}
> +	_casefold_check_exact_name ${basedir} ${2} ||
> +	    _fail "${2} was not created with exact name"
> +    }
> +    basedir=${test_casefold}/"test_name_preserve"
> +    mkdir -p ${basedir}
> +
> +    _set_casefold_attr ${basedir}
> +
> +    __test_name_preserve "${pt_file1}" "${pt_file2}"
> +    __test_name_preserve "${jp_file1}" "${jp_file2}"
> +    __test_name_preserve "${ar_file1}" "${ar_file2}"
> +    __test_name_preserve "${fr_file1}" "${fr_file2}"
> +}
> +
> +test_dir_name_preserve () {
> +
> +    __test_dir_name_preserve () {
> +	mkdir ${basedir}/${1}
> +	rmdir ${basedir}/${1}
> +
> +	mkdir ${basedir}/${2}
> +	_casefold_check_exact_name ${basedir} ${2} ||
> +	    _fail "${2} was not created with exact name"
> +    }
> +
> +    basedir=${test_casefold}/"dir-test_name_preserve"
> +    mkdir -p ${basedir}
> +
> +    _set_casefold_attr ${basedir}
> +
> +    __test_dir_name_preserve "${pt_file1}" "${pt_file2}"
> +    __test_dir_name_preserve "${jp_file1}" "${jp_file2}"
> +    __test_dir_name_preserve "${ar_file1}" "${ar_file2}"
> +    __test_dir_name_preserve "${fr_file1}" "${fr_file2}"
> +}
> +
> +# Name reuse for CI search
> +test_name_reuse () {
> +    basedir=${test_casefold}/reuse
> +
> +    mkdir ${basedir}
> +    _set_casefold_attr ${basedir}
> +
> +    reuse1=fileX
> +    reuse2=FILEX
> +
> +    touch ${basedir}/${reuse1}
> +    rm -f ${basedir}/${reuse1} || _fail "File lookup failed."
> +    touch ${basedir}/${reuse2}
> +    _casefold_check_exact_name "${basedir}" "${reuse2}" || \
> +	_fail "File created with wrong name"
> +    _casefold_check_exact_name "${basedir}" "${reuse1}" && \
> +	_fail "File created with the old name"
> +}
> +
> +# filepath same name
> +test_create_with_same_name () {
> +    basedir=${test_casefold}/same_name
> +    mkdir ${basedir}
> +
> +    _set_casefold_attr ${basedir}
> +
> +    mkdir -p ${basedir}/same1/same1
> +    touch ${basedir}/SAME1/sAME1/sAMe1
> +    touch -c ${basedir}/SAME1/sAME1/same1 ||
> +	_fail "Trying to create a new file instead of using old one"
> +}
> +
> +# file Rename
> +test_file_rename () {
> +    basedir=${test_casefold}/rename
> +    mkdir -p ${basedir}
> +    _set_casefold_attr ${basedir}
> +
> +    mv ${basedir}/rename ${basedir}/rename &>/dev/null && \
> +	_fail "mv to an equivalent name shouldn't work"
> +    _casefold_check_exact_name ${basedir} "rename"  || \
> +	_fail "Name shouldn't change."
> +}
> +
> +test_casefold_openfd () {
> +    # Test openfd with casefold.
> +    # 1. Delete a file after gettings its fd.
> +    # 2. Then create new dir with same name
> +    ofd1="openfd"
> +    ofd2="OPENFD"
> +
> +    basedir=${test_casefold}/openfd
> +    mkdir -p ${basedir}
> +    _set_casefold_attr ${basedir}
> +
> +    exec 3<> ${basedir}/${ofd1}
> +    rm -rf ${basedir}/${ofd1}
> +    mkdir ${basedir}/${ofd2}
> +    [ -d ${basedir}/${ofd2} ]   || _fail "Not a directory"
> +    _casefold_check_exact_name ${basedir} "${ofd2}" ||
> +	_fail "openfd file was created using old name"
> +    rm -rf ${basedir}/${ofd2}
> +    exec 3>&-
> +}
> +
> +test_casefold_openfd2 () {
> +    # Test openfd with casefold.
> +    # 1. Delete a file after gettings its fd.
> +    # 2. Then create new file with same name
> +    # 3. Read from open-fd and write into new file.
> +
> +    basedir=${test_casefold}/openfd2
> +    mkdir ${basedir}
> +    _set_casefold_attr ${basedir}
> +
> +    date > ${basedir}/${ofd1}
> +    exec 3<> ${basedir}/${ofd1}
> +    rm -rf ${basedir}/${ofd1}
> +    touch ${basedir}/${ofd1}
> +    [ -f ${basedir}/${ofd2} ] || _fail "Not a file"
> +    read data <&3
> +    echo $data >> ${basedir}/${ofd1}
> +    exec 3>&-
> +}
> +
> +test_hard_link_lookups () {
> +    # Create hardlink for casefold dir file and inside regular dir.
> +    basedir=${test_casefold}/hard_link
> +    mkdir ${basedir}
> +    _set_casefold_attr ${basedir}
> +
> +    touch ${basedir}/h1
> +    ln ${basedir}/H1 ${SCRATCH_MNT}/h1
> +    cnt=`stat -c %h ${basedir}/h1`
> +    [ $cnt -eq 1 ] && _fail "Unable to create hardlink"
> +
> +    # Create hardlink for casefold dir file and inside regular dir.
> +    touch ${SCRATCH_MNT}/h2
> +    ln ${SCRATCH_MNT}/h2 ${basedir}/H2
> +    cnt=`stat -c %h ${basedir}/h2`
> +    [ $cnt -eq 1 ] && _fail "Unable to create hardlink"
> +}
> +
> +test_xattrs_lookups () {
> +    basedir=${test_casefold}/xattrs
> +    mkdir ${basedir}
> +    _set_casefold_attr ${basedir}
> +
> +    mkdir -p ${basedir}/x
> +    setfattr -n user.foo -v bar ${basedir}/x
> +    getfattr -n user.foo ${basedir}/x &>/dev/null || \

Use $SETFATTR_PROG and $GETFATTR_PROG and _require_attrs in the
beginning.

> +	_fail "Casefold xattr lookup failed."
> +
> +    touch ${basedir}/x/f1
> +    setfattr -n user.foo -v bar ${basedir}/x/f1
> +    getfattr -n user.foo ${basedir}/x/f1 &>/dev/null || \
> +	_fail "Casefold xattr lookup failed."
> +}
> +
> +test_lookup_large_directory() {
> +    # Perform Casefold lookup on large dir
> +
> +    basedir=${test_casefold}/large
> +    mkdir ${basedir}
> +    _set_casefold_attr ${basedir}
> +
> +    touch $(seq -f "${basedir}/file%g" 0 2000)
> +    stat  $(seq -f "${basedir}/FILE%g" 0 2000) &>/dev/null || \
> +	_fail "Case on large dir failed"
> +}
> +
> +test_strict_mode_invalid_filename () {
> +    __strict_mode_invalid_filename () {
> +	touch  "${basedir}/${1}" &>/dev/null && \
> +	    _fail "Invalid UTF-8 sequence ${1} should fail at creation time."
> +    }
> +
> +    __strict_mode_invalid_filename ${blob1}
> +    __strict_mode_invalid_filename ${blob2}
> +}
> +
> +#############
> +# Run tests #
> +#############
> +
> +_scratch_mkfs_casefold 2>&1 1>/dev/null
> +
> +_scratch_mount
> +
> +_check_dmesg_for \
> +    "\(${sdev}\): Using encoding defined by superblock: utf8" || \
> +    _fail "Could not mount with encoding: utf8"
> +
> +test_casefold_flag_basic
> +test_casefold_lookup
> +test_bad_casefold_lookup
> +test_create_and_remove
> +test_casefold_flag_removal
> +test_casefold_flag_inheritance
> +test_nesting_sensitive_insensitive_tree_simple
> +test_nesting_sensitive_insensitive_tree_complex
> +test_symlink_with_inexact_name
> +test_name_preserve
> +test_dir_name_preserve
> +test_name_reuse
> +test_create_with_same_name
> +test_file_rename
> +test_casefold_openfd
> +test_casefold_openfd2
> +test_hard_link_lookups
> +test_xattrs_lookups
> +test_lookup_large_directory
> +
> +_scratch_unmount 2>&1

No need to do redirection, test harness captures both stdout and stderr.

> +_check_scratch_fs
> +
> +# Test Strict Mode
> +_scratch_mkfs_casefold_strict 2>&1 1>/dev/null

Better to redirect mkfs output to $seqres.full for debug purpose, e.g.

_scratch_mkfs_casefold_strict >>$seqres.full 2>&1

> +_scratch_mount 2>&1

No need to do redirection here either.

> +
> +test_strict_mode_invalid_filename
> +
> +_scratch_unmount 2>&1

Same here.

> +_check_scratch_fs

And if we do fsck after each test phase, we could replace
_require_scratch with _require_scratch_nocheck to let harness know
there's no need to do fsck again after test.

Thanks,
Eryu

> +
> +echo "Silence is golden"
> +status=0
> +exit
> diff --git a/tests/ext4/036.out b/tests/ext4/036.out
> new file mode 100644
> index 000000000000..ed460d98f87c
> --- /dev/null
> +++ b/tests/ext4/036.out
> @@ -0,0 +1,2 @@
> +QA output created by 036
> +Silence is golden
> diff --git a/tests/ext4/group b/tests/ext4/group
> index d27ec893333b..82639c13f8bb 100644
> --- a/tests/ext4/group
> +++ b/tests/ext4/group
> @@ -38,6 +38,7 @@
>  033 auto ioctl resize
>  034 auto quick quota
>  035 auto quick resize
> +036 auto quick casefold
>  271 auto rw quick
>  301 aio auto ioctl rw stress defrag
>  302 aio auto ioctl rw stress defrag
> -- 
> 2.20.1
> 
