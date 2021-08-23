Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFB3A3F4DAE
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Aug 2021 17:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbhHWPmn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 23 Aug 2021 11:42:43 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:57930 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbhHWPmg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 23 Aug 2021 11:42:36 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 3BFC72200B;
        Mon, 23 Aug 2021 15:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629733312; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=reQXTzA5yj38UfKk59qOT3lLV0yKSiBzg4h8zSSwbcY=;
        b=k4AsslWmDW/Xki+oZ85aa2PanKHvB99e/ArZj7kOu3tWWvIG7JjcskbuoyJ4yE4GR0Xucl
        7nZw5O/DWU8l+M8jL9GT3DaBbaw83M/+Ami+QKiZaojnDWmLZvjH5Rooll0F+0sdBcZSB1
        A9IqDR00p8mcscCgb8+6BACGpSskS00=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629733312;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=reQXTzA5yj38UfKk59qOT3lLV0yKSiBzg4h8zSSwbcY=;
        b=FYnIEVqtv8B3DhoH4aONl4Wuyn7GDJu3xv3Xp6y1JQ8txCTpKEkrGZH9nU0QNJhk3YUiNG
        EEJThn8cx1JuACAw==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 28EA8A3BBE;
        Mon, 23 Aug 2021 15:41:52 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E10651F2CD3; Mon, 23 Aug 2021 17:41:51 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 6/8] tests: Expand test checking quota and orphan processing interaction
Date:   Mon, 23 Aug 2021 17:41:26 +0200
Message-Id: <20210823154128.16615-7-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210823154128.16615-1-jack@suse.cz>
References: <20210823154128.16615-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6562; h=from:subject; bh=DhTj3kEvV0Qyr475cC9Ibgq2SihqsjG3uqxgWWWwo9Y=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBhI8Glw7PlsFKjW/UJqIeOoGkF0qIKjvu0N4MkXnjz NKzdEzmJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYSPBpQAKCRCcnaoHP2RA2UYgCA C8b+P/C8lmgsSmAM7UazWQHZALJ2UjVXPP0oHc67QTZdv9G3wRgo7xnU6Hwh1ih1Z7ylxS27mHpjV8 NnI+4bfupzhaV50gjXFdAj8XrwQrCVBSA6yx1MxJLTyruSE6GW70/Wx4H1nlKBDKR/ueeZ8y7Uy23R 2dkL5PctecDYlD4PNguLlSKcj+pP75CMnoSsR+4foHDuScgEslhpxbc86rN7XoDDNRJipspG4XhXDk lEfcdzAMQBAOyUeSfr60y+NqvhKbJNI6V1Nbw+8qO1wmMlesV42nhrPAXRR0j114fgRQky/a6/+bDI oJ5MzUhMylo/0CphZXy25gDc2ZvXXs
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Expand f_orphquot test to also check handling of quotas for non-root
user and verify that quota limits are properly preserved over orphan
replay.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 tests/f_orphquot/expect    |   8 +++++++-
 tests/f_orphquot/image.bz2 | Bin 1327 -> 2083 bytes
 tests/f_orphquot/script    |   2 ++
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/tests/f_orphquot/expect b/tests/f_orphquot/expect
index 90a78130b6a9..f1f0b446c5d1 100644
--- a/tests/f_orphquot/expect
+++ b/tests/f_orphquot/expect
@@ -1,4 +1,4 @@
-Clearing orphaned inode 12 (uid=0, gid=0, mode=0100644, size=3842048)
+Clearing orphaned inode 12 (uid=1000, gid=100, mode=0100644, size=3145728)
 Pass 1: Checking inodes, blocks, and sizes
 Pass 2: Checking directory structure
 Pass 3: Checking directory connectivity
@@ -8,3 +8,9 @@ Pass 5: Checking group summary information
 test_filesystem: ***** FILE SYSTEM WAS MODIFIED *****
 test_filesystem: 11/512 files (9.1% non-contiguous), 1070/2048 blocks
 Exit status is 0
+   user id      blocks   quota    limit      inodes    quota    limit
+         0      20480        0        0           2        0        0
+      1000          0     5000     6000           0       50       60
+  group id      blocks   quota    limit      inodes    quota    limit
+         0      20480        0        0           2        0        0
+       100          0     6000     7000           0       60       70
diff --git a/tests/f_orphquot/image.bz2 b/tests/f_orphquot/image.bz2
index 44c831852b0740019705c1ffbafa3d37cc561da8..7ac17a0ffc88519616eff6cd18822897eee93cd4 100644
GIT binary patch
literal 2083
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
a|3pSH@Zn`&x2`Y8nd}k3z-=lKZT|&i{Dmw4

literal 1327
zcmV+~1<?9JT4*^jL0KkKSs|BC`v3sQfB*me|MuJ8ynp=vTV5~!@7a2^Ud_+_UmRWU
z)g`^x-rUdx{s27y6r)uTWhBxv8YYiMqY06t69AfR383_vFq&l07$azD7-RwgnkEQj
zG{nI)7||Y~<qa^#p#TFwXwyc3(-2_*$jE3kG{OuM6G5N`fB;~c1__X18VrV-VKQO>
zXg~na8Z^<MG{hJ{GBO$s4KRZQ#L#E~pa2*qfr4ZhMuQ=ym`s>}8U|8G00004z$O3y
z044%334j3500004!fB%+r=TVP002c2OoE=KN2!uz$l4&tVjiPRnKBvyqaX}`(?Osb
zX{LiiMuvbI00ThDrkI9-gsStIa}90{i-o$^7K0&Fnl9v$_;F03eab6_f5x#K3=KaF
zQ*~*u%QiQ&Qe^9>Ziq-jW<+WByf<$9k6!f8P~E+8+J^C$TbAECr+Q!unGTl)FSayf
zd4mzQ(W!iAD$TM%gJAb=^|Tg6pp0z^MJ<g}0nR#xfEF+a8WJ?P^3WmAz=&sl>Zp}M
z1J<xAZQ<8_9rMs+&a$xuAG#0_P*&t9f;V#vpc%6;U??k#S1Y+FE2QgnS1fYT8S7^g
zBp!o#Qp<KX%!Jwp1=?XYHWjG^AR1A)$fR<^1%W^%#fDbU!fTtuBT<wZ=s3dxrx@4a
zk~!Q$;LsBD0eyu70}PRIjTr+jwo(c*w+rNf)eYG>cvVyY18apMiIyk;CoH8RNGpg0
zAfO#HnNBxN;}K4G%$Qds2I7IBU_&6n&|q=LNaHxIL!4n-3NnK7D+rdz1poj7+YMn`
zDQF;2p#n0%jbu~}V+@Ki*fP<9LstkF7*(Lc2T20mVH<1=u&WFRLkfkVg>&pR)gZ9K
zx5!yx1%^2i6+i$0lBbAqGtI4FMl%5{A*d?8(UYiniqs~V`5gmccz_%3*oI0FhE^Y^
zf=$*6?1_B)*(yI?9!zK-mYBF+YEZ+4pineT4oo3ze#iM90hJqVVupqAU5iJSgu`LN
zV~q%9&HVncsrB4Kii9xstOGE?02!?5xFDl;FN`hog)Oup<k@R~9_G;T;0lO%Fv0&y
zl|!>9HHOqYC;XQXfubk_YG6Q#l1RKVbf!O&f?0|I>j>Z<WQ?IfEN_Vkrvp9I4rT$<
zupzhzFyIZdwr6(1%x6Px(0TU@z-Z1sWFey=$}(Vb{2%S8J;-#sl;Vc@>_eUk!0*UG
z0q`KG-U56NoMHGF<x>n$Rtk<~qL`^DECnE8gi$Q8>RDhNJ3$I7t;W?+<wI~*QQAn$
zec)_x9f);??cBD*B3uJ=f%Kc>fA|1#AW`;+cz1PgL<c_LbtWHD!<ju6U85cTN<b}_
z84bCkU_J7gz1GR+fS~vslYDw$r;uWwBy~%JpaW#gbCcFSa2J|9<4AUtR#$kyX%OE%
zpmk_)*niG9a2ovpUw8qEJRs@Ao^yeK`H2UhI&?Bif*SLrj~TFW7zgGw_DtDNq&vRA
z3zQUo!c35fgM3P%1qz6yl1WK+TzB?vz3T*i?DK!%Jg;9z2^K5Ah5)+ekO(xv+a-VW
zeZX$t9!Hq`dIkLV;EM91Z#HojfUyDc21ijMu;+l#GbyvuEQ<n}co1Fy^sg$0#uHPW
zav_IDum+0I?Evsf6ajH!RRt+h1xLvetpkQRC8Zn2Y7Ysm_7Nf28~IGx$G}qr4srwl
l006WK!?Gmje3DTDrUU@rg;??e)@;xGUC9*TLO_OHKkO*@K@b1{

diff --git a/tests/f_orphquot/script b/tests/f_orphquot/script
index acdf5670c500..e17bff0c1667 100644
--- a/tests/f_orphquot/script
+++ b/tests/f_orphquot/script
@@ -8,6 +8,8 @@ rm -rf $OUT
 $FSCK -f -y -N test_filesystem $TMPFILE > $OUT.new 2>&1
 status=$?
 echo Exit status is $status >> $OUT.new
+$DEBUGFS -R 'lq user' $TMPFILE >> $OUT.new 2>&1
+$DEBUGFS -R 'lq group' $TMPFILE >> $OUT.new 2>&1
 sed -f $cmd_dir/filter.sed $OUT.new >> $OUT
 rm -f $OUT.new
 
-- 
2.26.2

