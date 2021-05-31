Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A44A396A20
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Jun 2021 01:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbhEaXlX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 31 May 2021 19:41:23 -0400
Received: from smtp-out-so.shaw.ca ([64.59.136.138]:59600 "EHLO
        smtp-out-so.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232349AbhEaXlW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 31 May 2021 19:41:22 -0400
X-Greylist: delayed 488 seconds by postgrey-1.27 at vger.kernel.org; Mon, 31 May 2021 19:41:22 EDT
Received: from webber.adilger.int ([70.77.221.9])
        by shaw.ca with ESMTP
        id nrNblI2mO7YjPnrNcl30TL; Mon, 31 May 2021 17:31:33 -0600
X-Authority-Analysis: v=2.4 cv=fPVaYbWe c=1 sm=1 tr=0 ts=60b571d5
 a=2Y6h5+ypAxmHcsumz2f7Og==:117 a=2Y6h5+ypAxmHcsumz2f7Og==:17 a=ySfo2T4IAAAA:8
 a=MvuuwTCpAAAA:8 a=ULax61NCMTu6Xf7DQNcA:9 a=ZUkhVnNHqyo2at-WnAgH:22
 a=dVHiktpip_riXrfdqayU:22
From:   Andreas Dilger <adilger@whamcloud.com>
To:     tytso@mit.edu
Cc:     linux-ext4@vger.kernel.org, Andreas Dilger <adilger@whamcloud.com>,
        Artem Blagodarenko <artem.blagodarenko@hpe.com>
Subject: [PATCH] e2fsck: fix ".." more gracefully if possible
Date:   Mon, 31 May 2021 17:31:23 -0600
Message-Id: <20210531233123.16095-1-adilger@whamcloud.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfCFFTf2EqlDqG+hSennCzZXjIeuxHN7Y44JzjyzFooOZfkikOIQKtbe8iFmu/2rJbiawaSzL3J8HGb3JNVqIpAI96gq+8NvIYZ17D2RuyI0xZjkv3Epz
 Sw389UBf+6yCnry1/GOen5c6f3iWH+2uM1Bwd5E6ZuetaLfxQnBUTlaGBzBU2htA1udRIo6hEXjeeXZhVEJ+KWUkGCyq8QdF/HOWKGzGwwi/8CQJqpotSeGP
 Vt37muLlwXeJCzqTJyAFO/2MGPHRQsdSidDb7rBVqArrgsu/2gd0aF5bcijmvioF
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

If the "." entry is corrupted, it will be reset in check_dot().
It is possible that the ".." entry can be recovered from the
directory block instead of also resetting it immediately.  If
it appears that there is a valid ".." entry in the block, allow
that to be used, and let check_dotdot() verify the dirent itself.

When resetting the "." and ".." entries, use EXT2_FT_DIR as the
file type instead of EXT2_FT_UNKNOWN for the very common case of
filesystems with the "filetype" feature, to avoid later problems
that can be easily avoided.  This can't always be done, even if
filesystems without "filetype" are totally obsolete, because many
old test images do not have this feature enabled.

Fixup affected tests using the new "repair-test" script that
updates the expect.[12] files from $test.[12].log for the given
tests and re-runs the test to ensure it now passes.

Signed-off-by: Andreas dilger <adilger@whamcloud.com>
Reviewed-by: Artem Blagodarenko <artem.blagodarenko@hpe.com>
Lustre-bug-Id: https://jira.whamcloud.com/browse/LU-14710
Change-Id: Ia5e579bcf31a9d9ee260d5640de6dbdb60514823
Reviewed-on: https://review.whamcloud.com/43858
---
 e2fsck/pass2.c                        |  28 ++++++++++++++++++--------
 tests/f_baddotdir/expect.1            |   9 ++++++---
 tests/f_baddotdir/expect.2            |   2 +-
 tests/f_baddotdir/image.gz            | Bin 564 -> 592 bytes
 tests/f_dir_bad_csum/expect.1         |   2 --
 tests/f_rebuild_csum_rootdir/expect.1 |   2 --
 tests/f_resize_inode_meta_bg/expect.1 |   4 ----
 tests/f_uninit_dir/expect.1           |   2 --
 tests/scripts/repair-test             |   9 +++++++++
 9 files changed, 36 insertions(+), 22 deletions(-)
 create mode 100755 tests/scripts/repair-test

diff --git a/e2fsck/pass2.c b/e2fsck/pass2.c
index e504b30a..94f92c8b 100644
--- a/e2fsck/pass2.c
+++ b/e2fsck/pass2.c
@@ -405,6 +405,7 @@ static int check_dot(e2fsck_t ctx,
 	int		status = 0;
 	int		created = 0;
 	problem_t	problem = 0;
+	int		ftype = EXT2_FT_DIR;
 
 	if (!dirent->inode)
 		problem = PR_2_MISSING_DOT;
@@ -416,12 +417,14 @@ static int check_dot(e2fsck_t ctx,
 
 	(void) ext2fs_get_rec_len(ctx->fs, dirent, &rec_len);
 	if (problem) {
+		if (!ext2fs_has_feature_filetype(ctx->fs->super))
+			ftype = EXT2_FT_UNKNOWN;
 		if (fix_problem(ctx, problem, pctx)) {
 			if (rec_len < 12)
 				rec_len = dirent->rec_len = 12;
 			dirent->inode = ino;
 			ext2fs_dirent_set_name_len(dirent, 1);
-			ext2fs_dirent_set_file_type(dirent, EXT2_FT_UNKNOWN);
+			ext2fs_dirent_set_file_type(dirent, ftype);
 			dirent->name[0] = '.';
 			dirent->name[1] = '\0';
 			status = 1;
@@ -442,12 +445,18 @@ static int check_dot(e2fsck_t ctx,
 				nextdir = (struct ext2_dir_entry *)
 					((char *) dirent + 12);
 				dirent->rec_len = 12;
-				(void) ext2fs_set_rec_len(ctx->fs, new_len,
-							  nextdir);
-				nextdir->inode = 0;
-				ext2fs_dirent_set_name_len(nextdir, 0);
-				ext2fs_dirent_set_file_type(nextdir,
-							    EXT2_FT_UNKNOWN);
+				/* if the next entry looks like "..", leave it
+				 * and let check_dotdot() verify the dirent,
+				 * otherwise zap the following entry. */
+				if (strncmp(nextdir->name, "..", 3) != 0) {
+					(void)ext2fs_set_rec_len(ctx->fs,
+								 new_len,
+								 nextdir);
+					nextdir->inode = 0;
+					ext2fs_dirent_set_name_len(nextdir, 0);
+					ext2fs_dirent_set_file_type(nextdir,
+								    ftype);
+				}
 				status = 1;
 			}
 		}
@@ -466,6 +475,7 @@ static int check_dotdot(e2fsck_t ctx,
 {
 	problem_t	problem = 0;
 	unsigned int	rec_len;
+	int		ftype = EXT2_FT_DIR;
 
 	if (!dirent->inode)
 		problem = PR_2_MISSING_DOT_DOT;
@@ -478,6 +488,8 @@ static int check_dotdot(e2fsck_t ctx,
 
 	(void) ext2fs_get_rec_len(ctx->fs, dirent, &rec_len);
 	if (problem) {
+		if (!ext2fs_has_feature_filetype(ctx->fs->super))
+			ftype = EXT2_FT_UNKNOWN;
 		if (fix_problem(ctx, problem, pctx)) {
 			if (rec_len < 12)
 				dirent->rec_len = 12;
@@ -488,7 +500,7 @@ static int check_dotdot(e2fsck_t ctx,
 			 */
 			dirent->inode = EXT2_ROOT_INO;
 			ext2fs_dirent_set_name_len(dirent, 2);
-			ext2fs_dirent_set_file_type(dirent, EXT2_FT_UNKNOWN);
+			ext2fs_dirent_set_file_type(dirent, ftype);
 			dirent->name[0] = '.';
 			dirent->name[1] = '.';
 			dirent->name[2] = '\0';
diff --git a/tests/f_baddotdir/expect.1 b/tests/f_baddotdir/expect.1
index e24aa94f..a7ca4e49 100644
--- a/tests/f_baddotdir/expect.1
+++ b/tests/f_baddotdir/expect.1
@@ -29,6 +29,9 @@ Fix? yes
 Missing '..' in directory inode 16.
 Fix? yes
 
+Directory entry for '.' in ... (19) is big.
+Split? yes
+
 Pass 3: Checking directory connectivity
 '..' in /a (12) is <The NULL inode> (0), should be / (2).
 Fix? yes
@@ -47,13 +50,13 @@ Fix? yes
 
 Pass 4: Checking reference counts
 Pass 5: Checking group summary information
-Free blocks count wrong for group #0 (70, counted=71).
+Free blocks count wrong for group #0 (69, counted=70).
 Fix? yes
 
-Free blocks count wrong (70, counted=71).
+Free blocks count wrong (69, counted=70).
 Fix? yes
 
 
 test_filesys: ***** FILE SYSTEM WAS MODIFIED *****
-test_filesys: 18/32 files (0.0% non-contiguous), 29/100 blocks
+test_filesys: 19/32 files (0.0% non-contiguous), 30/100 blocks
 Exit status is 1
diff --git a/tests/f_baddotdir/expect.2 b/tests/f_baddotdir/expect.2
index 8b3523cb..0838aa33 100644
--- a/tests/f_baddotdir/expect.2
+++ b/tests/f_baddotdir/expect.2
@@ -3,5 +3,5 @@ Pass 2: Checking directory structure
 Pass 3: Checking directory connectivity
 Pass 4: Checking reference counts
 Pass 5: Checking group summary information
-test_filesys: 18/32 files (0.0% non-contiguous), 29/100 blocks
+test_filesys: 19/32 files (0.0% non-contiguous), 30/100 blocks
 Exit status is 0
diff --git a/tests/f_baddotdir/image.gz b/tests/f_baddotdir/image.gz
index 8ed90c5d6aaf0da309d34b91e615eac7682f585c..71df18f2198afd056e79e6b35b27400e334a80ba 100644
GIT binary patch
delta 540
zcmV+%0^|L(1keP3ABzYGCMU390t0DnVP|Ck?c6<UQ&AWP@ROuP+L+e9sPzpyb%})F
z=HTEUxOXsPTVov*3%-Eu2XOMk6x{tBegbh37YDa^PI6DV)Vl~?rM<r&Jnb1S{K<jm
z=E)(sAplLa8EYJCKGwrny;!Z&7i`Y{C3m)tcS2YX+uvJ%)9ao;?hoxEoK2lrb0_`Z
z3yZb{8e=k<+|KKt6QEfx1bYC@l;8W)=lERza{l=C;M4u|0p$1m#n3KYw_sEQ{`&nV
z{ux%?f7)TAbX__Z>BhQPoRKcYT8?!o)=I3^SZg7jjD~RePxIsb?|sb8mGjH@zbkdV
z{+RzU=H{w@%D-B3{^yvRt15q^=KS8MKg?B?f34>HdoedxRsM~d^B=wXayM5#87${t
zuQ`7^=H{w;{WojQU)Va{$yJqq%dHZCbEG|;X<K1%vTldLU^eTn$Eo+l!Rt5u{e!nJ
z$FtctUAtS%z-hf#%))8?q?n1*dR)xLY5laAk<)sAznGIhbXwt=?T7!Wd#e9`bY}ez
zG{l@O0R0c>e?b2O`XA8$fc^*cKcN2s{SWAW;H=2s|4)4XADSco{$~{Y{s)?7sp9>A
zG_o(y1k0uV@9KYOl>A(d!Cv|KAG_1%*?sNIhj)iZM~Aiv&M)Wx&`7JL`F|xi|AQu3
eo4)@8d;S-b@c}oI0uBtodGQPRlUDlxkO2VVPAWM7

delta 510
zcmV<a0RjHd1hfQyABzYGmU8AY0t0DnVP|Ck?c6_Z6G0RQ;ITI;f{BAefbgeCZ^^RK
zQBcqz`bgk5!K48ZDS$+B0M5WY=s5=`h|(Y$3OX}m??kJx4N?|i_WPt?GQ~<y9_fwW
zu55<@wAD_`G-fsCNlZVcbNPau#lPg)@!4(&TVd~eXMWv(tLMY9U4-RS#H?KOe?P3*
z5@?OtY_^ftKW9L@6u}-qJLUKObRVDdH|LLUkH0)hHz2>)UklyJb?!@mt3Q9@pK;y!
z(+%5|>#oK0Vy?%mm(NMljnj>oLCj{%&5)jqhH&do>&Nr&W2~E#>sQae+fBaySpRdZ
zn^RZ+PQ&$ozs9;bb@jI!uD?DRj&thj-)*@5!&o<`uKxXo>pwj{+s(;O2CMb&HC%r$
z*3GGV{SO>f0B~ix^O?32Mi=XD7>yRQ?pB<7Umv}FH#|Ig|7N<Febcr3<qVwG2jwiB
z)-TGLIIXAUY@F6F%NhAo(FupP9R3--Oa1?&SoA+-&=M=Q0Q5hg{{j6E=zl=}1NtA(
z|A77n^gp2gfn||D|DX8$KeR{w{?8=%{tvWGzvlgaGO;hv1{;<B@9BSNl|k<RgX-^p
z?9YGC?z~tHA5KnBPizzXzdZkkR@$u0|AXN9ACmzBLk|D|0Kl^P1-d^m3ILD+0M^YA
A(*OVf

diff --git a/tests/f_dir_bad_csum/expect.1 b/tests/f_dir_bad_csum/expect.1
index 2c684fe6..ae4b410e 100644
--- a/tests/f_dir_bad_csum/expect.1
+++ b/tests/f_dir_bad_csum/expect.1
@@ -24,11 +24,9 @@ Salvage? yes
 Missing '.' in directory inode 17.
 Fix? yes
 
-Setting filetype for entry '.' in ??? (17) to 2.
 Missing '..' in directory inode 17.
 Fix? yes
 
-Setting filetype for entry '..' in ??? (17) to 2.
 Entry 'file' in ??? (18) has invalid inode #: 4294967295.
 Clear? yes
 
diff --git a/tests/f_rebuild_csum_rootdir/expect.1 b/tests/f_rebuild_csum_rootdir/expect.1
index bab07e05..91e6027d 100644
--- a/tests/f_rebuild_csum_rootdir/expect.1
+++ b/tests/f_rebuild_csum_rootdir/expect.1
@@ -6,11 +6,9 @@ Salvage? yes
 Missing '.' in directory inode 2.
 Fix? yes
 
-Setting filetype for entry '.' in ??? (2) to 2.
 Missing '..' in directory inode 2.
 Fix? yes
 
-Setting filetype for entry '..' in ??? (2) to 2.
 Pass 3: Checking directory connectivity
 '..' in / (2) is <The NULL inode> (0), should be / (2).
 Fix? yes
diff --git a/tests/f_resize_inode_meta_bg/expect.1 b/tests/f_resize_inode_meta_bg/expect.1
index c733c18d..769f71ae 100644
--- a/tests/f_resize_inode_meta_bg/expect.1
+++ b/tests/f_resize_inode_meta_bg/expect.1
@@ -8,11 +8,9 @@ Pass 2: Checking directory structure
 First entry '' (inode=348) in directory inode 2 (???) should be '.'
 Fix? yes
 
-Setting filetype for entry '.' in ??? (2) to 2.
 Missing '..' in directory inode 2.
 Fix? yes
 
-Setting filetype for entry '..' in ??? (2) to 2.
 Directory inode 2, block #0, offset 860: directory corrupted
 Salvage? yes
 
@@ -25,11 +23,9 @@ Salvage? yes
 Missing '.' in directory inode 11.
 Fix? yes
 
-Setting filetype for entry '.' in ??? (11) to 2.
 Missing '..' in directory inode 11.
 Fix? yes
 
-Setting filetype for entry '..' in ??? (11) to 2.
 Directory inode 11, block #1, offset 0: directory corrupted
 Salvage? yes
 
diff --git a/tests/f_uninit_dir/expect.1 b/tests/f_uninit_dir/expect.1
index f0065f15..31870bda 100644
--- a/tests/f_uninit_dir/expect.1
+++ b/tests/f_uninit_dir/expect.1
@@ -10,11 +10,9 @@ Salvage? yes
 Missing '.' in directory inode 14.
 Fix? yes
 
-Setting filetype for entry '.' in ??? (14) to 2.
 Missing '..' in directory inode 14.
 Fix? yes
 
-Setting filetype for entry '..' in ??? (14) to 2.
 Pass 3: Checking directory connectivity
 '..' in /abc (14) is <The NULL inode> (0), should be / (2).
 Fix? yes
diff --git a/tests/scripts/repair-test b/tests/scripts/repair-test
new file mode 100755
index 00000000..c164e6e5
--- /dev/null
+++ b/tests/scripts/repair-test
@@ -0,0 +1,9 @@
+#!/bin/sh
+for T in "$*"; do
+	[ -f "$T.failed" -a -d "$T" ] ||
+		{ echo "usage: $0 <test_to_repair>"; exit 1; }
+
+	cp $T.1.log $T/expect.1
+	cp $T.2.log $T/expect.2
+	./test_one $T
+done
-- 
2.25.1

