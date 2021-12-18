Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1F6479889
	for <lists+linux-ext4@lfdr.de>; Sat, 18 Dec 2021 05:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbhLREFB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 17 Dec 2021 23:05:01 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:53610 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229885AbhLREFB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 17 Dec 2021 23:05:01 -0500
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1BI44vt6019473
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Dec 2021 23:04:57 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 0605015C00C8; Fri, 17 Dec 2021 23:04:57 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     Leah Rumancik <leah.rumancik@gmail.com>,
        "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH] ext4/050: support indirect as well as extent mapped journals
Date:   Fri, 17 Dec 2021 23:04:51 -0500
Message-Id: <20211218040451.631804-1-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Simplify the test and fix ext4/050 failures when running ext4 without
extents enabled (e.g., in ext3 emulation mode).

Instead of relying on parsing debugfs output's (which varies depending
on whether the journal inode is extent mapped or indirect block
mapped), use debugfs's "cat" command to get the contents of the
journal.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 tests/ext4/050 | 58 +++++---------------------------------------------
 1 file changed, 5 insertions(+), 53 deletions(-)

diff --git a/tests/ext4/050 b/tests/ext4/050
index 79961957..6f93b86d 100755
--- a/tests/ext4/050
+++ b/tests/ext4/050
@@ -22,55 +22,6 @@ _require_command "$DEBUGFS_PROG" debugfs
 checkpoint_journal=$here/src/checkpoint_journal
 _require_test_program "checkpoint_journal"
 
-# convert output from stat<journal_inode> to list of block numbers
-get_journal_extents() {
-	inode_info=$($DEBUGFS_PROG $SCRATCH_DEV -R "stat <8>" 2>> $seqres.full)
-	echo -e "\nJournal info:" >> $seqres.full
-	echo "$inode_info" >> $seqres.full
-
-	extents_line=$(echo "$inode_info" | awk '/EXTENTS:/{ print NR; exit }')
-	get_extents=$(echo "$inode_info" | sed -n "$(($extents_line + 1))"p)
-
-	# get just the physical block numbers
-	get_extents=$(echo "$get_extents" |  perl -pe 's|\(.*?\):||g' | sed -e 's/, /\n/g' | perl -pe 's|(\d+)-(\d+)|\1 \2|g')
-
-	echo "$get_extents"
-}
-
-# checks all extents are zero'd out except for the superblock
-# arg 1: extents (output of get_journal_extents())
-check_extents() {
-	echo -e "\nChecking extents:" >> $seqres.full
-	echo "$1" >> $seqres.full
-
-	super_block="true"
-	echo "$1" | while IFS= read line; do
-		start_block=$(echo $line | cut -f1 -d' ')
-		end_block=$(echo $line | cut -f2 -d' ' -s)
-
-		# if first block of journal, shouldn't be wiped
-		if [ "$super_block" == "true" ]; then
-			super_block="false"
-
-			#if super block only block in this extent, skip extent
-			if [ -z "$end_block" ]; then
-				continue;
-			fi
-			start_block=$(($start_block + 1))
-		fi
-
-		if [ ! -z "$end_block" ]; then
-			blocks=$(($end_block - $start_block + 1))
-		else
-			blocks=1
-		fi
-
-		check=$(od $SCRATCH_DEV --skip-bytes=$(($start_block * $blocksize)) --read-bytes=$(($blocks * $blocksize)) -An -v | sed -e 's/[0 \t\n\r]//g')
-
-		[ ! -z "$check" ] && echo "error" && break
-	done
-}
-
 testdir="${SCRATCH_MNT}/testdir"
 
 _scratch_mkfs_sized $((64 * 1024 * 1024)) >> $seqres.full 2>&1
@@ -93,11 +44,12 @@ sync --file-system $testdir/1
 # call ioctl to checkpoint and zero-fill journal blocks
 $checkpoint_journal $SCRATCH_MNT --erase=zeroout || _fail "ioctl returned error"
 
-extents=$(get_journal_extents)
-
 # check journal blocks zeroed out
-ret=$(check_extents "$extents")
-[ "$ret" = "error" ] && _fail "Journal was not zero-filled"
+$DEBUGFS_PROG $SCRATCH_DEV -R "cat <8>" 2> /dev/null | od >> $seqres.full
+check=$($DEBUGFS_PROG $SCRATCH_DEV -R "cat <8>" 2> /dev/null | \
+	    od --skip-bytes="$blocksize" -An -v | sed -e '/^[0 \t]*$/d')
+
+[ ! -z "$check" ] && _fail "Journal was not zeroed"
 
 _scratch_unmount >> $seqres.full 2>&1
 
-- 
2.31.0

