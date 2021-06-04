Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3673839BF22
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Jun 2021 19:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbhFDR4M (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 4 Jun 2021 13:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbhFDR4M (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 4 Jun 2021 13:56:12 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB0C4C061766;
        Fri,  4 Jun 2021 10:54:25 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id z26so7994565pfj.5;
        Fri, 04 Jun 2021 10:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=S2cIZQp/b09lgGerU6aoNK6KVM5nBnpPTMkYyXcS9n8=;
        b=PmtMlvq2B59eFUaWqPHaRkhWY5N37bQTdAC/m/lr69kMYrKS/27wfLp1fEOS0cxdCP
         VvL+Dpa/jHZt95IbX2qP2nF6ARsFJM+HDfipHD3ddvsvGby95qEnJC21dzlfHultVIlT
         QVo6+yyiDU4aqqUliS33r93koqygCLzjHRRdEhmtQ4ThCPg1BaJ5Dk/dOLWVm3Jsvkys
         uhe4F664+raiOUB9KF0XWEK+UkJhbi2baKJIq4NVI+W4O0LjfdzG/CtmRjA93/D+Bs9U
         cje29eWcx1hQ/HhC9KyWzw7cr2vguU+lRUy98Qvhv5Ntk8mDnG5chL+tZ2Wv15oMDblj
         equQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S2cIZQp/b09lgGerU6aoNK6KVM5nBnpPTMkYyXcS9n8=;
        b=E6bCD3zKB6NQ20PiT85wHAnfnZpJwLLHqOovShGCzt8HfuxwpfaXgshjD9qPKlMIDD
         o1xlHeIBDym6ulfCrBvX6tPpnKgmIL4DKbzbQRXstP1cgTOR1RoWy23ULt+mwTgsLMYF
         p97ybrAKoB46TITKUmN6mWz8rn4CgETSU3aVbEqIAw6RRNgLlJo4E8FOpxQozfaiLtIF
         5ckVKFZhuihAN1zqS0Mdudlm5FmPG4mXnCLQco5ugB03s+ZiPUhbWH2UMw/b05clF6z2
         z6G6/QzKDhSK3cQ9jZanOTofpX4fz0CzuNok0KV4BeUn94Ty8vCRe7BYuXnvpuSBgqZm
         5ejg==
X-Gm-Message-State: AOAM532qJUeMXtuh1N4ZRkQN2kt44QmOvOkq/hfVmArz43j1f5PnLm1h
        Lm0kRQpeK4zINmyf09nE8bA=
X-Google-Smtp-Source: ABdhPJzmVFrtwTm8xMKNsqTKqEtwCTNOus0jaZpAjCJ0pIdUJWYWe5oGEUUNLm3Hnjx3Bh29kryJHg==
X-Received: by 2002:a62:1701:0:b029:2e9:a8ed:fcce with SMTP id 1-20020a6217010000b02902e9a8edfccemr5617316pfx.19.1622829264912;
        Fri, 04 Jun 2021 10:54:24 -0700 (PDT)
Received: from google.com ([2601:647:4701:18d0:de2f:6ca6:154e:b102])
        by smtp.gmail.com with ESMTPSA id o16sm2312508pfu.75.2021.06.04.10.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 10:54:24 -0700 (PDT)
Date:   Fri, 4 Jun 2021 10:54:22 -0700
From:   Leah Rumancik <leah.rumancik@gmail.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-ext4@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH v3] ext4/309: add test for ext4_dir_entry2 wipe
Message-ID: <YLpozucv4OW/e1E2@google.com>
References: <20210604001341.2700927-1-leah.rumancik@gmail.com>
 <20210604004437.GB26324@locust>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210604004437.GB26324@locust>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Jun 03, 2021 at 05:44:37PM -0700, Darrick J. Wong wrote:
> On Fri, Jun 04, 2021 at 12:13:41AM +0000, Leah Rumancik wrote:
> > From: Leah Rumancik <lrumancik@google.com>
> > 
> > Check wiping of dir entry data upon removing a file, converting to an
> > htree, and splitting htree nodes.
> > 
> > Tests commit 6c0912739699d8e4b6a87086401bf3ad3c59502d ("ext4: wipe
> > ext4_dir_entry2 upon file deletion").
> > 
> > Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
> > 
> > Changes in v2:
> > - fix formatting
> > - use _get_block_size instead of manually finding blocksize
> > - change scratch_dir to testdir to avoid confusion
> > 
> > Changes in v3:
> > - add _require_od_endian_flag function
> > - skip test 309 if od does not support endian flag
> > ---
> >  common/rc          |   9 +++
> >  tests/ext4/309     | 192 +++++++++++++++++++++++++++++++++++++++++++++
> >  tests/ext4/309.out |   5 ++
> >  tests/ext4/group   |   1 +
> >  4 files changed, 207 insertions(+)
> >  create mode 100755 tests/ext4/309
> >  create mode 100644 tests/ext4/309.out
> > 
> > diff --git a/common/rc b/common/rc
> > index 2cf550ec..8b8807d5 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -4513,6 +4513,15 @@ _getcap()
> >  	return ${PIPESTATUS[0]}
> >  }
> >  
> > +#od only supports --endian flag in versions 8.23 and later
> > +_require_od_endian_flag()
> > +{
> > +	version="$(od --version | grep -m 1 -o -E '[0-9.]+')"
> > +	[[ "${version%%.*}" -lt "8" ]] || \
> > +		[[ "${version%%.*}" -eq "8" && "${version##*.}" -lt "23" ]] && \
> > +		_notrun "od does not support endian flag"
> 
> Please don't do version checks to determine functionality -- linux
> distributors are free to patch in whatever new functionality they please
> without bumping version numbers <cough>RHELkernel<cough>.
> 
> od --endian=little < /dev/null > /dev/null 2>&1 || \
> 	_notrun "od does not support endian argument"

Ah that makes sense, thanks.

> 
> (At a glance the rest of the logic in the test looks good enough to
> handle regular directories, though I'm no longer well-versed in the
> weird directory variants <cough>luster<cough>.)
> 
> --D
> 
> > +}
> > +
> >  init_rc
> >  
> >  ################################################################################
> > diff --git a/tests/ext4/309 b/tests/ext4/309
> > new file mode 100755
> > index 00000000..e0497e1a
> > --- /dev/null
> > +++ b/tests/ext4/309
> > @@ -0,0 +1,192 @@
> > +#!/bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2021 Google, Inc. All Rights Reserved.
> > +#
> > +# FS QA Test No. 309
> > +#
> > +# Test wiping of ext4_dir_entry2 data upon file removal, conversion
> > +# to htree, and splitting of htree nodes
> > +#
> > +seq=`basename $0`
> > +seqres=$RESULT_DIR/$seq
> > +echo "QA output created by $seq"
> > +
> > +status=1       # failure is the default!
> > +
> > +# get standard environment, filters and checks
> > +. ./common/rc
> > +. ./common/filter
> > +
> > +# remove previous $seqres.full before test
> > +rm -f $seqres.full
> > +
> > +# real QA test starts here
> > +_supported_fs ext4
> > +
> > +_require_scratch
> > +_require_command "$DEBUGFS_PROG" debugfs
> > +_require_od_endian_flag
> > +
> > +testdir="${SCRATCH_MNT}/testdir"
> > +
> > +# get block number filename's dir ent
> > +# argument 1: filename
> > +get_block() {
> > +	echo $($DEBUGFS_PROG $SCRATCH_DEV -R "dirsearch /testdir $1" 2>> $seqres.full | grep -o -m 1 "phys [0-9]\+" | cut -c 6-)
> > +}
> > +
> > +# get offset of filename's dirent within the block
> > +# argument 1: filename
> > +get_offset() {
> > +	echo $($DEBUGFS_PROG $SCRATCH_DEV -R "dirsearch /testdir $1" 2>> $seqres.full | grep -o -m 1 "offset [0-9]\+" | cut -c 8-)
> > +}
> > +
> > +# get record length of dir ent at specified block and offset
> > +# argument 1: block
> > +# argument 2: offset
> > +get_reclen() {
> > +	echo $(od $SCRATCH_DEV --skip-bytes=$(($1 * $blocksize + $2 + 4)) --read-bytes=2  -d -An  --endian=little | tr -d ' \t\n\r')
> > +}
> > +
> > +# reads portion of dirent that should be zero'd out (starting at offset of name_len = 6)
> > +# and trims 0s and whitespace
> > +# argument 1: block num containing dir ent
> > +# argument 2: offset of dir ent within block
> > +# argument 3: rec len of dir ent
> > +read_dir_ent() {
> > +	echo $(od $SCRATCH_DEV --skip-bytes=$(($1 * $blocksize + $2 + 6)) --read-bytes=$(($3 - 6)) -d -An -v | sed -e 's/[0 \t\n\r]//g')
> > +}
> > +
> > +# forces node split on test directory
> > +# can be used to convert to htree and to split node on existing htree
> > +# looks for jump in directory size as indicator of node split
> > +induce_node_split() {
> > +	_scratch_mount >> $seqres.full 2>&1
> > +	dir_size="$(stat --printf="%s" $testdir)"
> > +	while [[ "$(stat --printf="%s" $testdir)" == "$dir_size" ]]; do
> > +		file_num=$(($file_num + 1))
> > +		touch $testdir/test"$(printf "%04d" $file_num)"
> > +	done
> > +	_scratch_unmount >> $seqres.full 2>&1
> > +}
> > +
> > +#
> > +# TEST 1: dir entry fields wiped upon file removal
> > +#
> > +
> > +test_file1="test0001"
> > +test_file2="test0002"
> > +test_file3="test0003"
> > +
> > +_scratch_mkfs_sized $((128 * 1024 * 1024)) >> $seqres.full 2>&1
> > +
> > +# create scratch dir for testing
> > +# create some files with no name a substr of another name so we can grep later
> > +_scratch_mount >> $seqres.full 2>&1
> > +blocksize="$(_get_block_size $SCRATCH_MNT)"
> > +mkdir $testdir
> > +file_num=1
> > +for file_num in {1..10}; do
> > +	touch $testdir/test"$(printf "%04d" $file_num)"
> > +done
> > +_scratch_unmount >> $seqres.full 2>&1
> > +
> > +# get block, offset, and rec_len of two test files
> > +block1=$(get_block $test_file1)
> > +offset1=$(get_offset $test_file1)
> > +rec_len1=$(get_reclen $block1 $offset1)
> > +
> > +block2=$(get_block $test_file2)
> > +offset2=$(get_offset $test_file2)
> > +rec_len2=$(get_reclen $block2 $offset2)
> > +
> > +_scratch_mount >> $seqres.full 2>&1
> > +rm $testdir/$test_file1
> > +_scratch_unmount >> $seqres.full 2>&1
> > +
> > +# read name_len field to end of dir entry
> > +check1=$(read_dir_ent $block1 $offset1 $rec_len1)
> > +check2=$(read_dir_ent $block2 $offset2 $rec_len2)
> > +
> > +# if check is empty, bytes read was all 0's, file data wiped
> > +# at this point, check1 should be empty, but check 2 should not be
> > +if [ -z "$check1" ] && [ ! -z "$check2" ]; then
> > +	echo "Test 1 part 1 passed."
> > +else
> > +	_fail "ERROR (test 1 part 1): metadata not wiped upon removing test file 1"
> > +fi
> > +
> > +_scratch_mount >> $seqres.full 2>&1
> > +rm $testdir/$test_file2
> > +_scratch_unmount >> $seqres.full 2>&1
> > +
> > +check2=$(read_dir_ent $block2 $offset2 $rec_len2)
> > +
> > +# at this point, both should be wiped
> > +[ -z "$check2" ] && echo "Test 1 part 2 passed." || _fail "ERROR (test 1 part 2): metadata not wiped upon removing test file 2"
> > +
> > +#
> > +# TEST 2: old dir entry fields wiped when directory converted to htree
> > +#
> > +
> > +# get original location
> > +block1=$(get_block $test_file3)
> > +offset1=$(get_offset $test_file3)
> > +rec_len1=$(get_reclen $block1 $offset1)
> > +
> > +# sanity check, ensures not an htree yet
> > +check_htree=$($DEBUGFS_PROG $SCRATCH_DEV -R "htree_dump /testdir" 2>&1)
> > +if [[ "$check_htree" != *"htree_dump: Not a hash-indexed directory"* ]]; then
> > +	_fail "ERROR (test 2): already an htree"
> > +fi
> > +
> > +# force conversion to htree
> > +induce_node_split
> > +
> > +# ensure it is now an htree
> > +check_htree=$($DEBUGFS_PROG $SCRATCH_DEV -R "htree_dump /testdir" 2>&1)
> > +if [[ "$check_htree" == *"htree_dump: Not a hash-indexed directory"* ]]; then
> > +	_fail "ERROR (test 2): directory was not converted to an htree after creation of many files"
> > +fi
> > +
> > +# check that old data was wiped
> > +# (this location is not immediately reused by ext4)
> > +check1=$(read_dir_ent $block1 $offset1 $rec_len1)
> > +
> > +# at this point, check1 should be empty meaning data was wiped
> > +[ -z "$check1" ] &&  echo "Test 2 passed." || _fail "ERROR (test 2): file metadata not wiped during conversion to htree"
> > +
> > +#
> > +# TEST 3: old dir entries wiped when moved to another block during split_node
> > +#
> > +
> > +# force splitting of a node
> > +induce_node_split
> > +# use debugfs to get names of two files from block 3
> > +hdump=$($DEBUGFS_PROG $SCRATCH_DEV -R "htree_dump /testdir" 2>> $seqres.full)
> > +
> > +# get line number of "Reading directory block 3"
> > +block3_line=$(echo "$hdump" | awk '/Reading directory block 3/{ print NR; exit }')
> > +
> > +[ -z "$block3_line" ] && echo "ERROR (test 3): could not find block number 3 after node split"
> > +
> > +test_file1=$(echo "$hdump" | sed -n "$(($block3_line + 1))"p | cut -d ' ' -f4)
> > +test_file2=$(echo "$hdump" | sed -n "$(($block3_line + 2))"p | cut -d ' ' -f4)
> > +
> > +# check these filenames don't exist in block 1 or 2
> > +# get block numbers of first two blocks
> > +block1=$(echo "$hdump" | grep -o -m 1 "Reading directory block 1, phys [0-9]\+" | cut -c 33-)
> > +block2=$(echo "$hdump" | grep -o -m 1 "Reading directory block 2, phys [0-9]\+" | cut -c 33-)
> > +
> > +# search all of both these blocks for these file names
> > +check1=$(od $SCRATCH_DEV --skip-bytes=$(($block1 * $blocksize)) --read-bytes=$blocksize -c -An -v | tr -d '\\ \t\n\r\v' | grep -e $test_file1 -e $test_file2)
> > +check2=$(od $SCRATCH_DEV --skip-bytes=$(($block2 * $blocksize)) --read-bytes=$blocksize -c -An -v | tr -d '\\ \t\n\r\v' | grep -e $test_file1 -e $test_file2)
> > +
> > +if [ -z "$check1" ] && [ -z "$check2" ]; then
> > +	echo "Test 3 passed."
> > +else
> > +	_fail "ERROR (test 3): file name not wiped during node split"
> > +fi
> > +
> > +status=0
> > +exit
> > diff --git a/tests/ext4/309.out b/tests/ext4/309.out
> > new file mode 100644
> > index 00000000..e5febaac
> > --- /dev/null
> > +++ b/tests/ext4/309.out
> > @@ -0,0 +1,5 @@
> > +QA output created by 309
> > +Test 1 part 1 passed.
> > +Test 1 part 2 passed.
> > +Test 2 passed.
> > +Test 3 passed.
> > diff --git a/tests/ext4/group b/tests/ext4/group
> > index ceda2ba6..e7ad3c24 100644
> > --- a/tests/ext4/group
> > +++ b/tests/ext4/group
> > @@ -59,3 +59,4 @@
> >  306 auto rw resize quick
> >  307 auto ioctl rw defrag
> >  308 auto ioctl rw prealloc quick defrag
> > +309 auto quick dir
> > -- 
> > 2.32.0.rc1.229.g3e70b5a671-goog
> > 
