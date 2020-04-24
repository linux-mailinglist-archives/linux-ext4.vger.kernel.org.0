Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48E6A1B7102
	for <lists+linux-ext4@lfdr.de>; Fri, 24 Apr 2020 11:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbgDXJeN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 24 Apr 2020 05:34:13 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:58022 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726770AbgDXJeK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 24 Apr 2020 05:34:10 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R361e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01355;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0TwVfl8I_1587720847;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0TwVfl8I_1587720847)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 24 Apr 2020 17:34:07 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     fstests@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, joseph.qi@linux.alibaba.com,
        Jeffle Xu <jefflexu@linux.alibaba.com>
Subject: [PATCH RFC 2/2] xfstests: common/rc: add cluster size support for ext4
Date:   Fri, 24 Apr 2020 17:33:50 +0800
Message-Id: <1587720830-11955-3-git-send-email-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1587720830-11955-1-git-send-email-jefflexu@linux.alibaba.com>
References: <1587720830-11955-1-git-send-email-jefflexu@linux.alibaba.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Inserting and collapsing range on ext4 with 'bigalloc' feature will
fail due to the offset and size should be alligned with the cluster
size.

The previous patch has add support for cluster size in fsx. Detect and
pass the cluster size parameter to fsx if the underlying filesystem
is ext4 with bigalloc.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 common/rc | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/common/rc b/common/rc
index 2000bd9..71dde5f 100644
--- a/common/rc
+++ b/common/rc
@@ -3908,6 +3908,15 @@ run_fsx()
 {
 	echo fsx $@
 	local args=`echo $@ | sed -e "s/ BSIZE / $bsize /g" -e "s/ PSIZE / $psize /g"`
+
+	if [ "$FSTYP" == "ext4" ]; then
+		local cluster_size=$(tune2fs -l $TEST_DEV | grep 'Cluster size' | awk '{print $3}')
+		if [ -n $cluster_size ]; then
+			echo "cluster size: $cluster_size"
+			args="$args -u $cluster_size"
+		fi
+	fi
+
 	set -- $here/ltp/fsx $args $FSX_AVOID $TEST_DIR/junk
 	echo "$@" >>$seqres.full
 	rm -f $TEST_DIR/junk
-- 
1.8.3.1

