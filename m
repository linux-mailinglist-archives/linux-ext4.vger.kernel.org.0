Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7AD6F930C
	for <lists+linux-ext4@lfdr.de>; Sat,  6 May 2023 18:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjEFQUc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 6 May 2023 12:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjEFQUb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 6 May 2023 12:20:31 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C03818FCA
        for <linux-ext4@vger.kernel.org>; Sat,  6 May 2023 09:20:29 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 346GKOvJ027507
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 6 May 2023 12:20:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1683390025; bh=J+ypT1hqCHoRbMnROpIBxyF1mJk4BPbQUGHgHOn3ha4=;
        h=From:To:Cc:Subject:Date;
        b=k+pzJm1q5PEKUvTzserjZsHq4z/JEJrHE7cb5IwDeUkN6R7xiIar0VCwfYkMrO5KE
         wgji4rIehXCukF+aHDAUNqz4I/HW6S5JiYbAO1zgi/nXSFN40iBTg4uVjHG9wfMguS
         Ux1Uk+Bo2Gf3tREGZg9c/VnkZa3VcgDWADp0rooftPiuhXojtR2TdhArNzee0Ul2GI
         EugFRpYt/bNK+2XF10FK5PrG0xSodkrNhh/GbFUCMsxIAgdRW2dhmawcYp4w1R3nwC
         DpfNgL/RszRC9ez7r7n8esr4e6czkebrl/SiY9i3zDhJ1HPJX6/2JtGNwJBSEVNC1o
         Xl6a0jikoP/Fg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 416E515C02E8; Sat,  6 May 2023 12:20:24 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        syzbot+394aa8a792cb99dbc837@syzkaller.appspotmail.com
Subject: [PATCH] ext4: improve error handling from ext4_dirhash()
Date:   Sat,  6 May 2023 12:20:20 -0400
Message-Id: <20230506162020.1088208-1-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The ext4_dirhash() will *almost* never fail, especially when the hash
tree feature was first introduced.  However, with the addition of
support of encrypted, casefolded file names, that function can most
certainly fail today.

So make sure the callers of ext4_dirhash() properly check for
failures, and reflect the errors back up to their callers.

Reported-by: syzbot+394aa8a792cb99dbc837@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?id=db56459ea4ac4a676ae4b4678f633e55da005a9b
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/hash.c  |  7 ++++++-
 fs/ext4/namei.c | 53 ++++++++++++++++++++++++++++++++++---------------
 2 files changed, 43 insertions(+), 17 deletions(-)

diff --git a/fs/ext4/hash.c b/fs/ext4/hash.c
index 147b5241dd94..e43b32ef9380 100644
--- a/fs/ext4/hash.c
+++ b/fs/ext4/hash.c
@@ -277,7 +277,12 @@ static int __ext4fs_dirhash(const struct inode *dir, const char *name, int len,
 	}
 	default:
 		hinfo->hash = 0;
-		return -1;
+		hinfo->minor_hash = 0;
+		ext4_warning(dir->i_sb,
+			     "invalid/unsupported hash tree version %u",
+			     hinfo->hash_version);
+		WARN_ON_ONCE(1);
+		return -EINVAL;
 	}
 	hash = hash & ~1;
 	if (hash == (EXT4_HTREE_EOF_32BIT << 1))
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index a5010b5b8a8c..45b579805c95 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -674,7 +674,7 @@ static struct stats dx_show_leaf(struct inode *dir,
 				len = de->name_len;
 				if (!IS_ENCRYPTED(dir)) {
 					/* Directory is not encrypted */
-					ext4fs_dirhash(dir, de->name,
+					(void) ext4fs_dirhash(dir, de->name,
 						de->name_len, &h);
 					printk("%*.s:(U)%x.%u ", len,
 					       name, h.hash,
@@ -709,8 +709,9 @@ static struct stats dx_show_leaf(struct inode *dir,
 					if (IS_CASEFOLDED(dir))
 						h.hash = EXT4_DIRENT_HASH(de);
 					else
-						ext4fs_dirhash(dir, de->name,
-						       de->name_len, &h);
+						(void) ext4fs_dirhash(dir,
+							de->name,
+							de->name_len, &h);
 					printk("%*.s:(E)%x.%u ", len, name,
 					       h.hash, (unsigned) ((char *) de
 								   - base));
@@ -720,7 +721,8 @@ static struct stats dx_show_leaf(struct inode *dir,
 #else
 				int len = de->name_len;
 				char *name = de->name;
-				ext4fs_dirhash(dir, de->name, de->name_len, &h);
+				(void) ext4fs_dirhash(dir, de->name,
+						      de->name_len, &h);
 				printk("%*.s:%x.%u ", len, name, h.hash,
 				       (unsigned) ((char *) de - base));
 #endif
@@ -849,8 +851,14 @@ dx_probe(struct ext4_filename *fname, struct inode *dir,
 	hinfo->seed = EXT4_SB(dir->i_sb)->s_hash_seed;
 	/* hash is already computed for encrypted casefolded directory */
 	if (fname && fname_name(fname) &&
-				!(IS_ENCRYPTED(dir) && IS_CASEFOLDED(dir)))
-		ext4fs_dirhash(dir, fname_name(fname), fname_len(fname), hinfo);
+	    !(IS_ENCRYPTED(dir) && IS_CASEFOLDED(dir))) {
+		int ret = ext4fs_dirhash(dir, fname_name(fname),
+					 fname_len(fname), hinfo);
+		if (ret < 0) {
+			ret_err = ERR_PTR(ret);
+			goto fail;
+		}
+	}
 	hash = hinfo->hash;
 
 	if (root->info.unused_flags & 1) {
@@ -1111,7 +1119,12 @@ static int htree_dirblock_to_tree(struct file *dir_file,
 				hinfo->minor_hash = 0;
 			}
 		} else {
-			ext4fs_dirhash(dir, de->name, de->name_len, hinfo);
+			err = ext4fs_dirhash(dir, de->name,
+					     de->name_len, hinfo);
+			if (err < 0) {
+				count = err;
+				goto errout;
+			}
 		}
 		if ((hinfo->hash < start_hash) ||
 		    ((hinfo->hash == start_hash) &&
@@ -1313,8 +1326,12 @@ static int dx_make_map(struct inode *dir, struct buffer_head *bh,
 		if (de->name_len && de->inode) {
 			if (ext4_hash_in_dirent(dir))
 				h.hash = EXT4_DIRENT_HASH(de);
-			else
-				ext4fs_dirhash(dir, de->name, de->name_len, &h);
+			else {
+				int err = ext4fs_dirhash(dir, de->name,
+						     de->name_len, &h);
+				if (err < 0)
+					return err;
+			}
 			map_tail--;
 			map_tail->hash = h.hash;
 			map_tail->offs = ((char *) de - base)>>2;
@@ -1452,10 +1469,9 @@ int ext4_fname_setup_ci_filename(struct inode *dir, const struct qstr *iname,
 	hinfo->hash_version = DX_HASH_SIPHASH;
 	hinfo->seed = NULL;
 	if (cf_name->name)
-		ext4fs_dirhash(dir, cf_name->name, cf_name->len, hinfo);
+		return ext4fs_dirhash(dir, cf_name->name, cf_name->len, hinfo);
 	else
-		ext4fs_dirhash(dir, iname->name, iname->len, hinfo);
-	return 0;
+		return ext4fs_dirhash(dir, iname->name, iname->len, hinfo);
 }
 #endif
 
@@ -2298,10 +2314,15 @@ static int make_indexed_dir(handle_t *handle, struct ext4_filename *fname,
 	fname->hinfo.seed = EXT4_SB(dir->i_sb)->s_hash_seed;
 
 	/* casefolded encrypted hashes are computed on fname setup */
-	if (!ext4_hash_in_dirent(dir))
-		ext4fs_dirhash(dir, fname_name(fname),
-				fname_len(fname), &fname->hinfo);
-
+	if (!ext4_hash_in_dirent(dir)) {
+		int err = ext4fs_dirhash(dir, fname_name(fname),
+					 fname_len(fname), &fname->hinfo);
+		if (err < 0) {
+			brelse(bh2);
+			brelse(bh);
+			return err;
+		}
+	}
 	memset(frames, 0, sizeof(frames));
 	frame = frames;
 	frame->entries = entries;
-- 
2.31.0

