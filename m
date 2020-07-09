Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11569219CAF
	for <lists+linux-ext4@lfdr.de>; Thu,  9 Jul 2020 11:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbgGIJ6B (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 9 Jul 2020 05:58:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:46604 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726315AbgGIJ6A (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 9 Jul 2020 05:58:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 07FD9AC50;
        Thu,  9 Jul 2020 09:57:58 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 394811E12C5; Thu,  9 Jul 2020 11:57:58 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <fstests@vger.kernel.org>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH] generic/530: Require metadata journaling
Date:   Thu,  9 Jul 2020 11:57:53 +0200
Message-Id: <20200709095753.3514-1-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Test generic/530 doesn't make sence without metadata journalling as in
that case, there's no way to recover shutdown fs besides fsck. ext4
can be configured without a journal and it supports shutdown ioctl even
in that mode which makes this test fail for that configuration. Add
requirement for metadata journalling to this test so that it's properly
skipped.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 tests/generic/530 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/generic/530 b/tests/generic/530
index cb874ace902b..153a045dca87 100755
--- a/tests/generic/530
+++ b/tests/generic/530
@@ -33,6 +33,7 @@ _supported_fs generic
 _supported_os Linux
 _require_scratch
 _require_scratch_shutdown
+_require_metadata_journaling
 _require_test_program "t_open_tmpfiles"
 
 rm -f $seqres.full
-- 
2.16.4

