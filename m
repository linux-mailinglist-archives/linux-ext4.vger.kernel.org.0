Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E11EE3F4DAC
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Aug 2021 17:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbhHWPmi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 23 Aug 2021 11:42:38 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:57910 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbhHWPmf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 23 Aug 2021 11:42:35 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 359F422007;
        Mon, 23 Aug 2021 15:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629733312; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BbjQihWLrY/gw45uV1+IXH0gOu9UuKBkN0Pr8+lnqk4=;
        b=AgRrBmXZG/8WkFb0PMhiTKgBD9KGq0ZvjRK9Q1y8SJPHYJpkXiuDkabC/Y3JKgEdBKMiv9
        vDeQsJYhH3cZza2lEsiby1x0ZZMSW0ZFyxyIH8VMcFkLPW9XciZB+WRR4O2cEKMAiApYQG
        lVPlGOdEpp+UzViPPsybRF/wvn103Bs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629733312;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BbjQihWLrY/gw45uV1+IXH0gOu9UuKBkN0Pr8+lnqk4=;
        b=iCfZsb1xjQdZhcIx9OxRTYhgslLg2sLs9oyWnfWLhWEf8rxJpUxfk6wszkqPK45o+4nUoq
        ZHbu7JKTWZjfiGCg==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 28912A3BBD;
        Mon, 23 Aug 2021 15:41:52 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id DBC081F2CD2; Mon, 23 Aug 2021 17:41:51 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 5/8] e2fsck: Do not trash user limits when processing orphan list
Date:   Mon, 23 Aug 2021 17:41:25 +0200
Message-Id: <20210823154128.16615-6-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210823154128.16615-1-jack@suse.cz>
References: <20210823154128.16615-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=770; h=from:subject; bh=qzGpt7+UOJv3hwzSLcLGr0hCRSh47K/myPGChyylU8U=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBhI8GlX5hq3rRf6HziKT8bgW4lwXuVz7w+FuGOUcPK Xw3NgfGJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYSPBpQAKCRCcnaoHP2RA2R2qCA DhX7BXpS8G05CmyapN9NiAu63JaSVW4o084uvfnud8EdFUMXbOkwGndcOty1Uk09HXfvVkeaZVTmkv pVfz8s4Vi/vjqCPOkxo7HiElNKlm/s/yCGP05ByfwhCqCXKKoaODsbMZJHz4bpUbfxo+qcBD1C0XuE tYgIzL35Jo0rJA65NyBao65L1jTDw4EZGykaYszfZjPayimYg3z2wl0Kv6qT+niYmOw+6w43O6b+6L vgIv8E0XTR0Pc0/JGhfydCSqYM+zoJXpcuURhap0hIo+j3x8FvRGu5ws5tM5Nw0dLmm/MqiDxfBSdA VYBJ83ewrnLu//5q0Kljfxo6T3qN4W
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

When e2fsck was loading quotas to process orphan list, it was loading
only quota usage. However subsequent quota writeout has effectively
overwritten quota limits, loosing them forever. Make sure quota limits
are preserved over orphan replay.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 e2fsck/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/e2fsck/super.c b/e2fsck/super.c
index 75b7b8ffa9b6..4ffafb211e50 100644
--- a/e2fsck/super.c
+++ b/e2fsck/super.c
@@ -282,7 +282,7 @@ static errcode_t e2fsck_read_all_quotas(e2fsck_t ctx)
 			continue;
 
 		retval = quota_read_all_dquots(ctx->qctx, qf_ino, qtype,
-					       QREAD_USAGE);
+					       QREAD_USAGE | QREAD_LIMITS);
 		if (retval)
 			break;
 	}
-- 
2.26.2

