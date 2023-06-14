Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8293C73093C
	for <lists+linux-ext4@lfdr.de>; Wed, 14 Jun 2023 22:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234964AbjFNUie (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 14 Jun 2023 16:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231747AbjFNUid (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 14 Jun 2023 16:38:33 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489E5268B
        for <linux-ext4@vger.kernel.org>; Wed, 14 Jun 2023 13:38:30 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-128-67.bstnma.fios.verizon.net [173.48.128.67])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 35EKbf1A018145
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jun 2023 16:37:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1686775065; bh=5gh9bjRefj/KDabv66hwJi8ENs36WVcGJRChLQjWbYA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=FI9jW17yMfvEyqLihy1lIpeYry/UisaL05d5WSeuBaSMfcVWLG/0PUBr4tsZfOh4V
         L3HixeeMCfheeUvacY4oPJs9jjNRVRDaWg6YcR5HFZL9B/PFa5bEXH90fEnlo3TFDs
         ahTUnOjfVEiHyCpVOIWBeAOsjKrNk93kkcYFY0gCxXt22B8FawdrShWGmt3vansu2+
         tYIyN0JoX5sWF+a7u6tgvZXbp88ni1Ri/lZwWIAgUNPbzvwW672chTXcbU3tlDKh8E
         ubgygM+Q7smgH8aztSq16dn/HxjnV6fQ2Qk5UAQPYCA428wzEtMYYykHJNE0hwf58n
         lpnguKu17sSmw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id E4AF515C00B0; Wed, 14 Jun 2023 16:37:40 -0400 (EDT)
Date:   Wed, 14 Jun 2023 16:37:40 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Zhang Yi <yi.zhang@huaweicloud.com>
Cc:     Zhihao Cheng <chengzhihao1@huawei.com>, linux-ext4@vger.kernel.org,
        adilger.kernel@dilger.ca, jack@suse.cz, yi.zhang@huawei.com,
        yukuai3@huawei.com
Subject: Re: [PATCH v3 4/6] jbd2: Fix wrongly judgement for buffer head
 removing while doing checkpoint
Message-ID: <20230614203740.GE51259@mit.edu>
References: <20230606135928.434610-1-yi.zhang@huaweicloud.com>
 <20230606135928.434610-5-yi.zhang@huaweicloud.com>
 <20230613043120.GB1584772@mit.edu>
 <20002902-39c5-914b-75b0-5a21b5cee25c@huawei.com>
 <20230613172749.GA18303@mit.edu>
 <20230614054222.GD51259@mit.edu>
 <1033cd3b-e41f-e4e0-c2ee-c4b23979208a@huaweicloud.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ag+CYUOMmOY8gPc+"
Content-Disposition: inline
In-Reply-To: <1033cd3b-e41f-e4e0-c2ee-c4b23979208a@huaweicloud.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--ag+CYUOMmOY8gPc+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 14, 2023 at 09:25:28PM +0800, Zhang Yi wrote:
> 
> Sorry about the regression, I found that this issue is not introduced
> by the first patch in this patch series ("jbd2: recheck chechpointing
> non-dirty buffer"), is d9eafe0afafa ("jbd2: factor out journal
> initialization from journal_get_superblock()") [1] on your dev branch.
> 
> The problem is the journal super block had been failed to write out
> due to IO fault, it's uptodate bit was cleared by
> end_buffer_write_syn() and didn't reset yet in jbd2_write_superblock().
> And it raced by jbd2_journal_revoke()->jbd2_journal_set_features()->
> jbd2_journal_check_used_features()->journal_get_superblock()->bh_read(),
> unfortunately, the read IO is also fail, so the error handling in
> journal_fail_superblock() clear the journal->j_sb_buffer, finally lead
> to above NULL pointer dereference issue.

Thanks for looking into this.  What I believe you are saying is that
the root cause is that earlier patch, but it is still something about
the patch "jbd2: recheck chechpointing non-dirty buffer" which is
changing the timing enough that we're hitting this buffer (because
without the "recheck checkpointing" patch, I'm not seeing the NULL
pointer dereference.

As far as the e2fsck bug that was causing it to hang in the ext4/adv
test scenario, the patch was a simple one, and I have also checked in
a test case which was a reliable reproducer of the problem.  (See
attached for the patches and more detail.)

It is really interesting that "recheck checkpointing" patch is making
enough of a difference that it is unmasking these bugs.  If you could
take a look at these changes and perhaps think about how this patch
series could be changing the nature of the corruption (specifically,
how symlink inodes referenced from inline directories could be
corupted with "rechecking checkpointing", thus unmasking the
e2fsprogs, I'd really appreciate it.

Thanks,

					- Ted


--ag+CYUOMmOY8gPc+
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-e2fsck-fix-handling-of-a-invalid-symlink-in-an-inlin.patch"

From 8798bbb81687103b0c0f56a42b096884c6032101 Mon Sep 17 00:00:00 2001
From: Theodore Ts'o <tytso@mit.edu>
Date: Wed, 14 Jun 2023 14:44:19 -0400
Subject: [PATCH 1/2] e2fsck: fix handling of a invalid symlink in an
 inline_data directory

If there is an inline directory that contains a directory entry to an
invalid symlink, and that invalid symlink is the portion of the inline
directory stored in an xattr portion of the inode, this can result in
a buffer overrun.

When check_dir_block() is handling the in-xattr portion of the inline
directory, it sets the buf pointer to the beginning of that part of
the inline directory.  This results in the scratch buffer passed to
e2fsck_process_bad_inode() to incorrect, resulting in a buffer overrun
if e2fsck_pass1_check_symlink() needs to read the symlink target (when
the symlink is too long to fit in the i_blocks[] space).

This commit fixes this by using the original cd->buf instead of buf,
since it can get modified when handling inline directories.

Fixes: 0ac4b3973f31 ("e2fsck: inspect inline dir data as two directory blocks")
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 e2fsck/pass2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/e2fsck/pass2.c b/e2fsck/pass2.c
index 47f9206f..42f3e5ef 100644
--- a/e2fsck/pass2.c
+++ b/e2fsck/pass2.c
@@ -1523,7 +1523,7 @@ skip_checksum:
 					     dirent->inode)) {
 			if (e2fsck_process_bad_inode(ctx, ino,
 						     dirent->inode,
-						     buf + fs->blocksize)) {
+						     cd->buf + fs->blocksize)) {
 				dirent->inode = 0;
 				dir_modified++;
 				goto next;
-- 
2.31.0


--ag+CYUOMmOY8gPc+
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0002-tests-add-test-for-handling-an-invalid-symlink-in-an.patch"

From 541ce8f2bb6f91834b5d5b7c98bd4de8998dccc5 Mon Sep 17 00:00:00 2001
From: Theodore Ts'o <tytso@mit.edu>
Date: Wed, 14 Jun 2023 15:15:48 -0400
Subject: [PATCH 2/2] tests: add test for handling an invalid symlink in an
 inline directory

Add a test for the commit "e2fsck: fix handling of a invalid symlink
in an inline_data directory"

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 tests/f_inlinedir_bad_symlink/expect.1 |  12 ++++++++++++
 tests/f_inlinedir_bad_symlink/expect.2 |   7 +++++++
 tests/f_inlinedir_bad_symlink/image.gz | Bin 0 -> 1797 bytes
 tests/f_inlinedir_bad_symlink/name     |   1 +
 4 files changed, 20 insertions(+)
 create mode 100644 tests/f_inlinedir_bad_symlink/expect.1
 create mode 100644 tests/f_inlinedir_bad_symlink/expect.2
 create mode 100644 tests/f_inlinedir_bad_symlink/image.gz
 create mode 100644 tests/f_inlinedir_bad_symlink/name

diff --git a/tests/f_inlinedir_bad_symlink/expect.1 b/tests/f_inlinedir_bad_symlink/expect.1
new file mode 100644
index 00000000..e1d0e879
--- /dev/null
+++ b/tests/f_inlinedir_bad_symlink/expect.1
@@ -0,0 +1,12 @@
+Pass 1: Checking inodes, blocks, and sizes
+Pass 2: Checking directory structure
+Symlink /a/7 (inode #19) is invalid.
+Clear? yes
+
+Pass 3: Checking directory connectivity
+Pass 4: Checking reference counts
+Pass 5: Checking group summary information
+
+test_filesys: ***** FILE SYSTEM WAS MODIFIED *****
+test_filesys: 19/112 files (0.0% non-contiguous), 16/200 blocks
+Exit status is 1
diff --git a/tests/f_inlinedir_bad_symlink/expect.2 b/tests/f_inlinedir_bad_symlink/expect.2
new file mode 100644
index 00000000..b881d657
--- /dev/null
+++ b/tests/f_inlinedir_bad_symlink/expect.2
@@ -0,0 +1,7 @@
+Pass 1: Checking inodes, blocks, and sizes
+Pass 2: Checking directory structure
+Pass 3: Checking directory connectivity
+Pass 4: Checking reference counts
+Pass 5: Checking group summary information
+test_filesys: 19/112 files (0.0% non-contiguous), 16/200 blocks
+Exit status is 0
diff --git a/tests/f_inlinedir_bad_symlink/image.gz b/tests/f_inlinedir_bad_symlink/image.gz
new file mode 100644
index 0000000000000000000000000000000000000000..c5bd71a3b5d3e685ce1ca34650e9325aabf2f498
GIT binary patch
literal 1797
zcmeHFZ!p^j7>>HF^p-;%>Xe*+jV3K){xsaU$rPp24pl16*2p3>RYJ_4h^f{o>QB#A
zS(9aDRvS4idKUJps<@VkrCUOXUoE<bG@>FwB){L-=YHt7ed+t{dG3AQ=e_5BQ8iXp
zBHNo8`z)!nFDYb%Mn=m_CLczuDKFQk(zgd<tXpGHm3diYU!Tv_*J3lzo%z05_PhA*
zNmb{u;3yK;%Q>q8bx@6`dL2Dw8{_BUfOO~Di1%}w*1TKdDmNHxO?s;$?EyVo0DxPd
z5+{-yB48bZL)RiLe3Jb-a((K$0u3GhAufIs9)XNcO~WO=fl5ioS-bV^@z2oivE#S+
zLCOO#_NnZX*+{0Wv=>u(<ECxd7Wu_g0($a1Kpoj3rkwtm->xpMEy-1_XA{)JG_0sD
zHHapQ#%ejtjYoy{w?D)sQA7nj_XV}5SWO-Z2i1$lGR9$K9!8HNQGouDbBJ=Wy>e?*
zd`KP+b6lR`qjt7#oaQ6xkGG9+W;vVBlgtz&5QyoJB`oGKXDqz^ndL4tN104Os290l
zw$P#rpPEV_jBnzyBa>&F$h>0!ZL!ZGj?Og;`l{YXlXb(ieY+B7WU(LoTw=ywMCDiS
zz{|^D%vtZ!Mx&WEv1o1c1ajWo-ZRS4!s8(*Y94H}=L175sDeTl9WRBhN7d{wL~ifx
z(r;PI;QDr(Z`z)_5v47EOVyj&uHyc?#vh5ePKmxuj_z!?!AG_fadCxx-JYTB2UeD{
zIScn#)K6)*^OtgRe>P$0@K9*w*~QTyboiB`03li-nbbVhfO9g(W&<u|he?%2sN<<p
zz}UY)tP=jPvG{1oLkfEdAi`jm??mjKmq*(a`ka}O9v;4<59VZIH40Wn990U_61BY1
zZ%)9@#LG~M<H-yi=S&8axDby2HB@(GOb1U_v%=wtGJ!+~2!CN7zXuP08^wht8%Acu
zdTLUY*WHGJkPLH}m~mAC^ph~oSz?HAFR#{3@E!mB>KL*YG7Z^%gw@u(CXH6CoPcZT
zBUAd6B*v@i{r!#erk6TWSl~pMKdp*v7CdKs9SsD?hZcplbgx*m_X^nPdaawf5Sd=e
zcbmRglB{mlYF+uB5kA4cJ@oFGD+tSG%M4`qOVEtr&)1;6p2at7RAWN0yH1}2E`Vy@
zJfM|aQq;3+^`aRGsOAi<KH0^BE4TD4`UK2{bi2dz3(bRk<pRcNOmR{JOp<=+uLLKL
zf9h!oQX&*h@3EB=VB@gjq@zoY%vDW%`1h8IaN&TRZhW9~MFiaG!58&Pfh8gc|7fbm
zg-4VPEXOOQLW3Gyo8qzjS+6!T%)L{dlr}nDJYUss;H+Nom2#K3MPtJ3;4vcw2?l&+
zY^#r#5#Sv*rKu&tP-5IdwYn8vUpDCA#X8HHI!@>zHH)NEbl;~q>@D`Dk9x<wOW=P=
Rp!}f0Nz*WBg(&|3@h^7vKm7mz

literal 0
HcmV?d00001

diff --git a/tests/f_inlinedir_bad_symlink/name b/tests/f_inlinedir_bad_symlink/name
new file mode 100644
index 00000000..f7f7f0d6
--- /dev/null
+++ b/tests/f_inlinedir_bad_symlink/name
@@ -0,0 +1 @@
+bad symlink in an inline directory
-- 
2.31.0


--ag+CYUOMmOY8gPc+--
