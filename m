Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34F053DB10A
	for <lists+linux-ext4@lfdr.de>; Fri, 30 Jul 2021 04:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234758AbhG3CNX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 29 Jul 2021 22:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbhG3CNX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 29 Jul 2021 22:13:23 -0400
Received: from hoggar.fisica.ufpr.br (hoggar.fisica.ufpr.br [IPv6:2801:82:80ff:7fff::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43487C061765
        for <linux-ext4@vger.kernel.org>; Thu, 29 Jul 2021 19:13:18 -0700 (PDT)
Received: by hoggar.fisica.ufpr.br (Postfix, from userid 577)
        id BF6C03630229; Thu, 29 Jul 2021 23:13:11 -0300 (-03)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=fisica.ufpr.br;
        s=201705; t=1627611191;
        bh=H9aNUMa2G39HqjMG+NPfEiuR1dx8CIKJxTMg+k52xX4=;
        h=Date:From:To:Subject:From;
        b=WBMrCN55P6BrZo3uUwxGtzHire7fFq1z0fYIVImkFu4uwqbo911Y0P454qRsNdGpC
         E1YMQ2CpVjA3iu/97lm1C1Uz26uKvI8mCi+GAe7LIGC/5ErNcpxK5rqIFAOLgmf8GT
         NdtyyC7yPUJQ+rvYFyl/kPb1LJQC8M+eKncelMO/1f/FugwatJI3bSKtK0Zqp8JwNx
         y6XVxWxNUcL2CBjdFnPQIo1o+wEp7SRcc7VQeQWTV7kLlm/HFPqDg68rL/YE370etH
         7arWK0eCRivQh0h+YYQ3qNhlEoAkxa5oow51QfrQdFbdwtxvxqC00fYq9QyEt/KsqH
         7iH4preaEEjhQ==
Date:   Thu, 29 Jul 2021 23:13:11 -0300
From:   Carlos Carvalho <carlos@fisica.ufpr.br>
To:     linux-ext4@vger.kernel.org
Subject: bug with large_dir in 5.12.17: patch from Denis
Message-ID: <YQNgN8Rh/MR58ZUz@fisica.ufpr.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Denis sent me his patch. He says his emails don't appear in the mailing list,
so I'm trying.

I don't know anything about this issue so I don't know if his fix is correct
but I'd be glad if it is.

----- Forwarded message from Denis <denis@voxelsoft.com> -----

Return-Path: <SRS0=FdEW=MW=voxelsoft.com=denis@fisica.ufpr.br>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	hoggar.fisica.ufpr.br
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Report: 
	* -1.0 BAYES_00 BODY: Bayes spam probability is 0 to 1%
	*      [score: 0.0000]
	*  1.0 HEADER_FROM_DIFFERENT_DOMAINS From and EnvelopeFrom 2nd level
	*      mail domains are different
X-Original-To: carlos@fisica.ufpr.br
Delivered-To: carlos@fisica.ufpr.br
Received: from mail.voxelsoft.com (voxelsoft.com [64.62.190.251])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	key-exchange X25519 server-signature ECDSA (P-384) server-digest
	SHA384)
	(No client certificate requested)
	by hoggar.fisica.ufpr.br (Postfix) with ESMTPS id E7CA8362FFC0
	for <carlos@fisica.ufpr.br>; Thu, 29 Jul 2021 22:20:06 -0300 (-03)
Received: by mail.voxelsoft.com (Postfix, from userid 65534)
	id 6E85E1B35F; Thu, 29 Jul 2021 21:20:02 -0400 (EDT)
Received: from system-name-here.lan (unknown [87.74.207.173])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	key-exchange ECDHE (P-256) server-signature RSA-PSS (1024 bits))
	(No client certificate requested)
	by mail.voxelsoft.com (Postfix) with ESMTPS id DAF0A1B30F
	for <carlos@fisica.ufpr.br>; Thu, 29 Jul 2021 21:20:00 -0400 (EDT)
Message-ID: <7d06358243c19dfe46e1d433a73cf3732672f021.camel@voxelsoft.com>
Subject: Fwd: Re: bug with large_dir in 5.12.17
From: Denis <denis@voxelsoft.com>
To: carlos@fisica.ufpr.br
Date: Fri, 30 Jul 2021 02:19:59 +0100
References: <7f781a3cd7114db0842dc3f291cd3f6cd826917f.camel@voxelsoft.com>
Content-Type: multipart/mixed; boundary="=-3LjA7skNvjayJnHkW34c"
User-Agent: Evolution 3.40.0-1
MIME-Version: 1.0
X-Bogosity: Unsure, tests=bogofilter, spamicity=0.500000, version=1.2.5
Status: RO
X-Status: A
Content-Length: 24607
Lines: 593

FYI

Message-ID: <7f781a3cd7114db0842dc3f291cd3f6cd826917f.camel@voxelsoft.com>
Subject: Re: bug with large_dir in 5.12.17
From: Denis <denis@voxelsoft.com>
To: Благодаренко Артём <artem.blagodarenko@gmail.com>
Cc: tytso@mit.edu
Date: Fri, 30 Jul 2021 02:15:12 +0100
In-Reply-To: <5FE9762B-6C6B-4A44-AC99-22192B76C060@gmail.com>
References: <YPl/boTCfc3rlJLU@fisica.ufpr.br>
  <5FE9762B-6C6B-4A44-AC99-22192B76C060@gmail.com>
Content-Type: multipart/mixed; boundary="=-MidjK6mTbr04vKC9iZEJ"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0

Hello,

I have sent the fix to Ted and Linus.

My emails to the list have been silently dropped and postmaster does
not respond.

See attached trails and link:
http://voxelsoft.com/2021/ext4_large_dir_corruption.html

Best,
Denis

On Thu, 2021-07-29 at 22:23 +0300, Благодаренко Артём wrote:
> Hello,
> 
> It looks like the fix b5776e7524afbd4569978ff790864755c438bba7 "ext4:
> fix potential htree index checksum corruption” introduced this
> regression.
> I reverted it and my test from previous message passed the dangerous
> level of 1570000 names count.
> Now test is still in progress. 2520000 names are already created.
> 
> I am searching the way to fix this.
> 
> Best regards,
> Artem Blagodarenko.
> 
> > On 22 Jul 2021, at 17:23, Carlos Carvalho <carlos@fisica.ufpr.br>
> > wrote:
> > 
> > There is a bug when enabling large_dir in 5.12.17. I got this during
> > a backup:
> > 
> > index full, reach max htree level :2
> > Large directory feature is not enabled on this filesystem
> > 
> > So I unmounted, ran tune2fs -O large_dir /dev/device and mounted
> > again. However
> > this error appeared:
> > 
> > dx_probe:864: inode #576594294: block 144245: comm rsync: directory
> > leaf block found instead of index block
> > 
> > I unmounted, ran fsck and it "salvaged" a bunch of directories.
> > However at the
> > next backup run the same errors appeared again.
> > 
> > This is with vanilla 5.2.17.
> 


Message-ID: <be3cb0e7566b2893bc311963a502853383899746.camel@voxelsoft.com>
Subject: Fwd: [PATCH RESEND] ext4: fix directory index node split corruption
From: Denis <denis@voxelsoft.com>
To: tytso@mit.edu
Date: Tue, 29 Jun 2021 20:32:01 +0100
References: <3112115f7c7b009755ce331631bd5ebf24bc6767.camel@voxelsoft.com>
Content-Type: multipart/mixed; boundary="=-2iokyD4xn0CorAJWsx+Y"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
X-Evolution-Identity: 1345390455.26215.0@denis-pc
X-Evolution-Fcc: folder://1305396255.3768.0%40denis-pc/INBOX/Sent
X-Evolution-Transport: 1345390455.26215.1@denis-pc
X-Evolution-Source-Folder: folder://1305396255.3768.0%40denis-pc/INBOX/Sent
X-Evolution-Source-Message: 1213
X-Evolution-Source-Flags: FORWARDED 
X-Evolution-Source: 

My emails to linux-ext4@vger.kernel.org seem to be received by vger but
end up in /dev/null, can't see it in the archive, and I haven't heard
from postmaster. Don't know if there's some approval or queueing
process that I'm supposed to jump through. Feel free to copy my
original email to the list on my behalf.

Denis

Message-ID: <3112115f7c7b009755ce331631bd5ebf24bc6767.camel@voxelsoft.com>
Subject: [PATCH RESEND] ext4: fix directory index node split corruption
From: Denis Lukianov <denis@voxelsoft.com>
To: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Date: Tue, 29 Jun 2021 17:00:20 +0100
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: base64

Following commit b5776e7, a trivial sequential write of empty files to
an empty ext4 file system (with large_dir enabled) fails after just
over 26 million files. Depending on luck, file creation will give error
EEXIST or EUCLEAN.

Commit b5776e7 fixed the no-restart condition so that
ext4_handle_dirty_dx_node is always called, but it also broke the
restart condition. This is because when restart=1, the original
implementation correctly skipped do_split() but b5776e7 clobbered the
"if(restart)goto journal_error;" logic.

This complementary change protects do_split() from restart condition,
making it safe from both current and future ordering of goto statements
in earlier sections of the code.

Tested on 5.11.20 with handy testing script:

#!/bin/python
i = 0
while i <= 32000000:
    print (i)
    with open('tmpmnt/%d' % i, 'wb') as fout:
        i += 1

Google-Bug-Id: 176345532
Fixes: b5776e7 ("ext4: fix potential htree index checksum corruption")
Signed-off-by: Denis Lukianov <denis@voxelsoft.com>

---
 fs/ext4/namei.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 9cc9e6c1d582..5052d1a6f6d8 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -2428,13 +2428,15 @@ static int ext4_dx_add_entry(handle_t *handle,
struct ext4_filename *fname,
                        goto journal_error;
                }
        }
-       de = do_split(handle, dir, &bh, frame, &fname->hinfo);
-       if (IS_ERR(de)) {
-               err = PTR_ERR(de);
+       if (!restart) {
+               de = do_split(handle, dir, &bh, frame, &fname->hinfo);
+               if (IS_ERR(de)) {
+                       err = PTR_ERR(de);
+                       goto cleanup;
+               }
+               err = add_dirent_to_buf(handle, fname, dir, inode, de,
bh);
                goto cleanup;
        }
-       err = add_dirent_to_buf(handle, fname, dir, inode, de, bh);
-       goto cleanup;
 
 journal_error:
        ext4_std_error(dir->i_sb, err); /* this is a no-op if err == 0
*/



Message-ID: <18781b816c37b55f191dfc9c866b88ff875b3667.camel@voxelsoft.com>
Subject: [PATCH] ext4: fix directory index node split corruption
From: Denis <denis@voxelsoft.com>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org, artem.blagodarenko@gmail.com
Date: Sat, 26 Jun 2021 18:50:36 +0100
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
X-Evolution-Identity: 1345390455.26215.0@denis-pc
X-Evolution-Fcc: folder://1305396255.3768.0%40denis-pc/INBOX/Sent
X-Evolution-Transport: 1345390455.26215.1@denis-pc
X-Evolution-Source: 
Content-Transfer-Encoding: base64

Following commit b5776e7, a trivial sequential write of empty files to
an empty ext4 file system (with large_dir enabled) fails after just
over 26 million files. Depending on luck, file creation will give error
EEXIST or EUCLEAN.

Commit b5776e7 fixed the no-restart condition so that
ext4_handle_dirty_dx_node is always called, but it also broke the
restart condition. This is because when restart=1, the original
implementation correctly skipped do_split() but b5776e7 clobbered the
"if(restart)goto journal_error;" logic.

This complementary change protects do_split() from restart condition,
making it safe from both current and future ordering of goto statements
in earlier sections of the code.

Tested on 5.11.20 with handy testing script:

#!/bin/python
i = 0
while i <= 32000000:
    print (i)
    with open('tmpmnt/%d' % i, 'wb') as fout:
        i += 1

Google-Bug-Id: 176345532
Fixes: b5776e7 ("ext4: fix potential htree index checksum corruption")
Fixes: e08ac99 ("ext4: add largedir feature")

---
 fs/ext4/namei.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 9cc9e6c1d582..5052d1a6f6d8 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -2428,13 +2428,15 @@ static int ext4_dx_add_entry(handle_t *handle,
struct ext4_filename *fname,
 			goto journal_error;
 		}
 	}
-	de = do_split(handle, dir, &bh, frame, &fname->hinfo);
-	if (IS_ERR(de)) {
-		err = PTR_ERR(de);
+	if (!restart) {
+		de = do_split(handle, dir, &bh, frame, &fname->hinfo);
+		if (IS_ERR(de)) {
+			err = PTR_ERR(de);
+			goto cleanup;
+		}
+		err = add_dirent_to_buf(handle, fname, dir, inode, de,
bh);
 		goto cleanup;
 	}
-	err = add_dirent_to_buf(handle, fname, dir, inode, de, bh);
-	goto cleanup;
 
 journal_error:
 	ext4_std_error(dir->i_sb, err); /* this is a no-op if err == 0
*/


Message-ID: <ad76727349f389fbcef84b4308cbf5bd4f6b39a7.camel@voxelsoft.com>
Subject: Fwd: [PATCH] ext4: fix directory index node split corruption
From: Denis <denis@voxelsoft.com>
To: postmaster@vger.kernel.org
Date: Mon, 28 Jun 2021 18:46:39 +0100
References: <18781b816c37b55f191dfc9c866b88ff875b3667.camel@voxelsoft.com>
Content-Type: multipart/mixed; boundary="=-rLPjsVEGrL0guC3uY+d1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
X-Evolution-Identity: 1345390455.26215.0@denis-pc
X-Evolution-Fcc: folder://1305396255.3768.0%40denis-pc/INBOX/Sent
X-Evolution-Transport: 1345390455.26215.1@denis-pc
X-Evolution-Source-Folder: folder://1305396255.3768.0%40denis-pc/INBOX/Sent
X-Evolution-Source-Message: 1208
X-Evolution-Source-Flags: FORWARDED 
X-Evolution-Source: 

Hello postmaster,

Please could you let me know if my only message to
linux-ext4@vger.kernel.org (atached) was lost, or is being held in some
sort of queue. Am I correct to expect it to appear in
https://www.spinics.net/lists/linux-ext4/maillist.html ?

Thanks,
Denis


Message-ID: <18781b816c37b55f191dfc9c866b88ff875b3667.camel@voxelsoft.com>
Subject: [PATCH] ext4: fix directory index node split corruption
From: Denis <denis@voxelsoft.com>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org, artem.blagodarenko@gmail.com
Date: Sat, 26 Jun 2021 18:50:36 +0100
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Following commit b5776e7, a trivial sequential write of empty files to
an empty ext4 file system (with large_dir enabled) fails after just
over 26 million files. Depending on luck, file creation will give error
EEXIST or EUCLEAN.

Commit b5776e7 fixed the no-restart condition so that
ext4_handle_dirty_dx_node is always called, but it also broke the
restart condition. This is because when restart=1, the original
implementation correctly skipped do_split() but b5776e7 clobbered the
"if(restart)goto journal_error;" logic.

This complementary change protects do_split() from restart condition,
making it safe from both current and future ordering of goto statements
in earlier sections of the code.

Tested on 5.11.20 with handy testing script:

#!/bin/python
i = 0
while i <= 32000000:
    print (i)
    with open('tmpmnt/%d' % i, 'wb') as fout:
        i += 1

Google-Bug-Id: 176345532
Fixes: b5776e7 ("ext4: fix potential htree index checksum corruption")
Fixes: e08ac99 ("ext4: add largedir feature")

---
 fs/ext4/namei.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 9cc9e6c1d582..5052d1a6f6d8 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -2428,13 +2428,15 @@ static int ext4_dx_add_entry(handle_t *handle,
struct ext4_filename *fname,
 			goto journal_error;
 		}
 	}
-	de = do_split(handle, dir, &bh, frame, &fname->hinfo);
-	if (IS_ERR(de)) {
-		err = PTR_ERR(de);
+	if (!restart) {
+		de = do_split(handle, dir, &bh, frame, &fname->hinfo);
+		if (IS_ERR(de)) {
+			err = PTR_ERR(de);
+			goto cleanup;
+		}
+		err = add_dirent_to_buf(handle, fname, dir, inode, de,
bh);
 		goto cleanup;
 	}
-	err = add_dirent_to_buf(handle, fname, dir, inode, de, bh);
-	goto cleanup;
 
 journal_error:
 	ext4_std_error(dir->i_sb, err); /* this is a no-op if err == 0
*/


Message-ID: <f0aa507ef8f90555124dfc8fcbaed4a7beafa3f9.camel@voxelsoft.com>
Subject: Fwd: [PATCH] ext4: fix directory index node split corruption
From: Denis <denis@voxelsoft.com>
To: torvalds@linux-foundation.org
Date: Sat, 26 Jun 2021 22:18:01 +0100
References: <18781b816c37b55f191dfc9c866b88ff875b3667.camel@voxelsoft.com>
Content-Type: multipart/mixed; boundary="=-jewEOkSP4iNK6NZ69SnQ"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
X-Evolution-Identity: 1345390455.26215.0@denis-pc
X-Evolution-Fcc: folder://1305396255.3768.0%40denis-pc/INBOX/Sent
X-Evolution-Transport: 1345390455.26215.1@denis-pc
X-Evolution-Source-Folder: folder://1305396255.3768.0%40denis-pc/INBOX/Sent
X-Evolution-Source-Message: 1208
X-Evolution-Source-Flags: FORWARDED 
X-Evolution-Source: 

Hi Linus,

Please be aware that there is a corruption issue in ext4 when large_dir
is enabled since v5.11.3 (b5776e7).

Bug will only manifest when directory indices grow htree levels, it
takes filing up a directory with tens of millions files to trigger. Why
was this not found earlier? As a guess, it is masked because most
large_dir users fall into following camps:
1) running pre-v5.11.3
2) already grew their large directories pre-v5.11, then upgraded
3) not growing large directories at all

For details see attached patch and linky for my analysis and testing
shortcuts.
http://voxelsoft.com/2021/ext4_large_dir_corruption.html

Thanks for your time,
Denis


Message-ID: <18781b816c37b55f191dfc9c866b88ff875b3667.camel@voxelsoft.com>
Subject: [PATCH] ext4: fix directory index node split corruption
From: Denis <denis@voxelsoft.com>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org, artem.blagodarenko@gmail.com
Date: Sat, 26 Jun 2021 18:50:36 +0100
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Following commit b5776e7, a trivial sequential write of empty files to
an empty ext4 file system (with large_dir enabled) fails after just
over 26 million files. Depending on luck, file creation will give error
EEXIST or EUCLEAN.

Commit b5776e7 fixed the no-restart condition so that
ext4_handle_dirty_dx_node is always called, but it also broke the
restart condition. This is because when restart=1, the original
implementation correctly skipped do_split() but b5776e7 clobbered the
"if(restart)goto journal_error;" logic.

This complementary change protects do_split() from restart condition,
making it safe from both current and future ordering of goto statements
in earlier sections of the code.

Tested on 5.11.20 with handy testing script:

#!/bin/python
i = 0
while i <= 32000000:
    print (i)
    with open('tmpmnt/%d' % i, 'wb') as fout:
        i += 1

Google-Bug-Id: 176345532
Fixes: b5776e7 ("ext4: fix potential htree index checksum corruption")
Fixes: e08ac99 ("ext4: add largedir feature")

---
 fs/ext4/namei.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 9cc9e6c1d582..5052d1a6f6d8 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -2428,13 +2428,15 @@ static int ext4_dx_add_entry(handle_t *handle,
struct ext4_filename *fname,
 			goto journal_error;
 		}
 	}
-	de = do_split(handle, dir, &bh, frame, &fname->hinfo);
-	if (IS_ERR(de)) {
-		err = PTR_ERR(de);
+	if (!restart) {
+		de = do_split(handle, dir, &bh, frame, &fname->hinfo);
+		if (IS_ERR(de)) {
+			err = PTR_ERR(de);
+			goto cleanup;
+		}
+		err = add_dirent_to_buf(handle, fname, dir, inode, de,
bh);
 		goto cleanup;
 	}
-	err = add_dirent_to_buf(handle, fname, dir, inode, de, bh);
-	goto cleanup;
 
 journal_error:
 	ext4_std_error(dir->i_sb, err); /* this is a no-op if err == 0
*/


Message-ID: <be3cb0e7566b2893bc311963a502853383899746.camel@voxelsoft.com>
Subject: Fwd: [PATCH RESEND] ext4: fix directory index node split corruption
From: Denis <denis@voxelsoft.com>
To: tytso@mit.edu
Date: Tue, 29 Jun 2021 20:32:01 +0100
References: <3112115f7c7b009755ce331631bd5ebf24bc6767.camel@voxelsoft.com>
Content-Type: multipart/mixed; boundary="=-2iokyD4xn0CorAJWsx+Y"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
X-Evolution-Identity: 1345390455.26215.0@denis-pc
X-Evolution-Fcc: folder://1305396255.3768.0%40denis-pc/INBOX/Sent
X-Evolution-Transport: 1345390455.26215.1@denis-pc
X-Evolution-Source-Folder: folder://1305396255.3768.0%40denis-pc/INBOX/Sent
X-Evolution-Source-Message: 1213
X-Evolution-Source-Flags: FORWARDED 
X-Evolution-Source: 

My emails to linux-ext4@vger.kernel.org seem to be received by vger but
end up in /dev/null, can't see it in the archive, and I haven't heard
from postmaster. Don't know if there's some approval or queueing
process that I'm supposed to jump through. Feel free to copy my
original email to the list on my behalf.

Denis

Message-ID: <3112115f7c7b009755ce331631bd5ebf24bc6767.camel@voxelsoft.com>
Subject: [PATCH RESEND] ext4: fix directory index node split corruption
From: Denis Lukianov <denis@voxelsoft.com>
To: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Date: Tue, 29 Jun 2021 17:00:20 +0100
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: base64

Following commit b5776e7, a trivial sequential write of empty files to
an empty ext4 file system (with large_dir enabled) fails after just
over 26 million files. Depending on luck, file creation will give error
EEXIST or EUCLEAN.

Commit b5776e7 fixed the no-restart condition so that
ext4_handle_dirty_dx_node is always called, but it also broke the
restart condition. This is because when restart=1, the original
implementation correctly skipped do_split() but b5776e7 clobbered the
"if(restart)goto journal_error;" logic.

This complementary change protects do_split() from restart condition,
making it safe from both current and future ordering of goto statements
in earlier sections of the code.

Tested on 5.11.20 with handy testing script:

#!/bin/python
i = 0
while i <= 32000000:
    print (i)
    with open('tmpmnt/%d' % i, 'wb') as fout:
        i += 1

Google-Bug-Id: 176345532
Fixes: b5776e7 ("ext4: fix potential htree index checksum corruption")
Signed-off-by: Denis Lukianov <denis@voxelsoft.com>

---
 fs/ext4/namei.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 9cc9e6c1d582..5052d1a6f6d8 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -2428,13 +2428,15 @@ static int ext4_dx_add_entry(handle_t *handle,
struct ext4_filename *fname,
                        goto journal_error;
                }
        }
-       de = do_split(handle, dir, &bh, frame, &fname->hinfo);
-       if (IS_ERR(de)) {
-               err = PTR_ERR(de);
+       if (!restart) {
+               de = do_split(handle, dir, &bh, frame, &fname->hinfo);
+               if (IS_ERR(de)) {
+                       err = PTR_ERR(de);
+                       goto cleanup;
+               }
+               err = add_dirent_to_buf(handle, fname, dir, inode, de,
bh);
                goto cleanup;
        }
-       err = add_dirent_to_buf(handle, fname, dir, inode, de, bh);
-       goto cleanup;
 
 journal_error:
        ext4_std_error(dir->i_sb, err); /* this is a no-op if err == 0
*/






----- End forwarded message -----
