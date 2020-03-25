Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA037193280
	for <lists+linux-ext4@lfdr.de>; Wed, 25 Mar 2020 22:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbgCYVTA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 25 Mar 2020 17:19:00 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:39610 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727351AbgCYVTA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 25 Mar 2020 17:19:00 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id AE03A292B0F
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     tytso@mit.edu
Cc:     linux-ext4@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: [PATCH e2fsprogs 11/11] tests: f_bad_fname: Test fixes of invalid filenames and duplicates
Date:   Wed, 25 Mar 2020 17:18:11 -0400
Message-Id: <20200325211812.2971787-12-krisman@collabora.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200325211812.2971787-1-krisman@collabora.com>
References: <20200325211812.2971787-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 tests/f_bad_fname/expect.1 |  22 ++++++++++++++++++++++
 tests/f_bad_fname/expect.2 |   7 +++++++
 tests/f_bad_fname/image.gz | Bin 0 -> 802 bytes
 tests/f_bad_fname/name     |   1 +
 4 files changed, 30 insertions(+)
 create mode 100644 tests/f_bad_fname/expect.1
 create mode 100644 tests/f_bad_fname/expect.2
 create mode 100644 tests/f_bad_fname/image.gz
 create mode 100644 tests/f_bad_fname/name

diff --git a/tests/f_bad_fname/expect.1 b/tests/f_bad_fname/expect.1
new file mode 100644
index 000000000000..1d860b2247a4
--- /dev/null
+++ b/tests/f_bad_fname/expect.1
@@ -0,0 +1,22 @@
+Pass 1: Checking inodes, blocks, and sizes
+Pass 2: Checking directory structure
+Entry 'AM-^?' in /ci_dir (12) has illegal characters in its name.
+Fix? yes
+
+Entry 'AM-~' in /ci_dir (12) has illegal characters in its name.
+Fix? yes
+
+Duplicate entry 'A.' found.
+	Marking /ci_dir (12) to be rebuilt.
+
+Pass 3: Checking directory connectivity
+Pass 3A: Optimizing directories
+Entry 'A.' in /ci_dir (12) has a non-unique filename.
+Rename to A.~0? yes
+
+Pass 4: Checking reference counts
+Pass 5: Checking group summary information
+
+test_filesys: ***** FILE SYSTEM WAS MODIFIED *****
+test_filesys: 14/16 files (0.0% non-contiguous), 22/100 blocks
+Exit status is 1
diff --git a/tests/f_bad_fname/expect.2 b/tests/f_bad_fname/expect.2
new file mode 100644
index 000000000000..13de1c0806b7
--- /dev/null
+++ b/tests/f_bad_fname/expect.2
@@ -0,0 +1,7 @@
+Pass 1: Checking inodes, blocks, and sizes
+Pass 2: Checking directory structure
+Pass 3: Checking directory connectivity
+Pass 4: Checking reference counts
+Pass 5: Checking group summary information
+test_filesys: 14/16 files (0.0% non-contiguous), 22/100 blocks
+Exit status is 0
diff --git a/tests/f_bad_fname/image.gz b/tests/f_bad_fname/image.gz
new file mode 100644
index 0000000000000000000000000000000000000000..a8b3fc6b8397a7859d9697c462f24f498bb57fd8
GIT binary patch
literal 802
zcmb2|=HU3ZwK|T0IWspgJ(c0@9p4PuP!Wa)#-G*9mUQmd6)h1gP)&N{wkF^Lhf?9g
zMNtKcnpXpOe4{cJM+7ff`jtKW--4vV=~{YsIv=@RXj&kBGDu*_q5yNH8;i;k=a=78
z@%4!p{B((@Y#;x**}v1?o!R+$Msd2?XQhT^yX=m-bnO%AUveTi<+L?Vc;L6)A5Olh
zkgUC!Xa6hu>if4lZ+<+wuKRbcPoc`uZ6eD**?bcdtk2o`_gzv|PMx0hpO>@$rmu^(
z?AyKU``I-=Pp&oC_H)|fqtg6-`@Wz0F1_p<&)<1R{~GSt@b*UM($5jzk<&|Eqb!S5
zC;dI25?e2O?evSo@-lf#pZaR%b#MCjIm7kh&2Lv9-_JR}c*edv`_`Z5uit04m}T9R
zvg*S}s~^PYF7Q0{{O`dNpFUM?$$I|tgvVE&{hDl_R{mvAe|KZ^|CzPI7iX&P%Zr_C
zZ@M!(>662efM5S2S5LLK+`4<&P40-^kkj^ie!o3`-2B-7*Z-%7h5kQqb@iJ6?SA`q
zEzOyqebrVf!FKA``uEYh>$GmalAq=J*SUCQeTLpw{<BN}E!=s<-emf(_Gdx=FT?;P
zy@8Ut>+2WHWLy0EcfE6{wREm~%<NmA*IwBd@H(K;H0a*{^XGG{ukTy`&U`}Su8{AQ
z@BceZp7Q<wb+ftkJKq&Dpn&P+Z;rhAk+dfKoOr+6AFEkXu17w<Ki@Zh-s(lSqDt<$
z_q}+p!+tI;b$j=wtnKr7?5{m$tlIMVebwjxKa=<Ve7|$+y+8WCt}>q26LNIByx0HF
zdH5@Ouk^p<-#3bF)m~g&Irr<c^Y&}Z{~y2aS`&EAK6>}r`pP?ZBEOZ}g`cy3`d{tq
z*BSM{UoQRmzSZQvY*fe5KXYH}*Z*qVr}y*p&-cgVKG&N_7JkaOdT;h8y<<UbLG{Z`
z3(CHJe*4V2-2Qg%U+dGK<aa&!b6u~#rZUZa`&H|C5pNk8Q9MX0=fSHl{Bc6hCNNB3
GWB>rT_?(Xb

literal 0
HcmV?d00001

diff --git a/tests/f_bad_fname/name b/tests/f_bad_fname/name
new file mode 100644
index 000000000000..675165a67c25
--- /dev/null
+++ b/tests/f_bad_fname/name
@@ -0,0 +1 @@
+Case-insensitive directory with broken file names
-- 
2.25.0

