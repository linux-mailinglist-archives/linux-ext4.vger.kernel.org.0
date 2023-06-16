Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCB837336A8
	for <lists+linux-ext4@lfdr.de>; Fri, 16 Jun 2023 18:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345876AbjFPQw1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 16 Jun 2023 12:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345778AbjFPQv3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 16 Jun 2023 12:51:29 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCED93C05
        for <linux-ext4@vger.kernel.org>; Fri, 16 Jun 2023 09:51:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C679721E07;
        Fri, 16 Jun 2023 16:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686934270; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zqo1BWdIMuWqLjLVLNkMlU4hmo4qb6IRcGcBPlYUVzk=;
        b=cS56+6AhMR36wBceHD4JIbwXqQw1WGF4Ojr0vWmz/8dtiaYm7uWZ6yIjzapdsMmUyrT3sm
        XwKzdHLpKmSgP8JuQahBQMbvKquddSpqslyr7shglbv/lJEXZZIvH8qMIRsSh0AeTXCkcf
        rWm4k260tEf2EM0Wv+ZsMz961ABmht0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686934270;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zqo1BWdIMuWqLjLVLNkMlU4hmo4qb6IRcGcBPlYUVzk=;
        b=C0pOJQOvV9Sap/bcBWqxnjYJOeYAEw7omtOcd0DFAjbWuc9c1uDzhAbaTZrLvxAaOdm87i
        vYp8BDnvA7jmpQAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B3C6B1330B;
        Fri, 16 Jun 2023 16:51:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WlXiK/6SjGRSIwAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 16 Jun 2023 16:51:10 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id A698CA076A; Fri, 16 Jun 2023 18:51:09 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 11/11] ext4: Replace read-only check for shutdown check in mmp code
Date:   Fri, 16 Jun 2023 18:50:57 +0200
Message-Id: <20230616165109.21695-11-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230616164553.1090-1-jack@suse.cz>
References: <20230616164553.1090-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1077; i=jack@suse.cz; h=from:subject; bh=3Rmi1/kB/VPpTRYcvKl9dnicjcpKuG2JKV/QRG3MXAU=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBkjJLw9n04JTv/OFqUH6x3RskByibQ2FLfA2s6GsYk bg6dGBKJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZIyS8AAKCRCcnaoHP2RA2QQrCA DRfG7HsLpK/JJBRNwkVqwrXkZOr2vflli4qgMOSbhYDCGSoC5YvhoXCP+7sZIer1QVbgak5u9ePnv3 bmIlIb8cvSmyFng7tZtW56LMrmo9+4KZxdKxfcaxIFmHQ946sVDwtWtIz4Z9acXUILgRDJIpWuA740 0eY6Wk7+HA6H1UEhEDnCrYremq9sfn6czPSSG/Pb3WC4/jESji6S9s5UY+XKaP1E899qJW1HJjnmwf 0l08qmI2hqWmwNej1sq6/q4JIs+iDWadQsVVcqlmwWSilWW37zR0ADY7lSV2h/jlemjwfDW4AxFnRS L0A48pgQLBe9Xmkdos/m+hgBn1we0A
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The multi-mount protection kthread checks for read-only filesystem and
aborts in that case. The remount code actually handles stopping of the
kthread on remount so the only purpose of the check is in case of
emergency remount read-only. Replace the check for read-only filesystem
with a check for shutdown filesystem as running MMP on such is risky
anyway and it makes ordering of things during remount simpler.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/mmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/mmp.c b/fs/ext4/mmp.c
index 0aaf38ffcb6e..bd946d0c71b7 100644
--- a/fs/ext4/mmp.c
+++ b/fs/ext4/mmp.c
@@ -162,7 +162,7 @@ static int kmmpd(void *data)
 	memcpy(mmp->mmp_nodename, init_utsname()->nodename,
 	       sizeof(mmp->mmp_nodename));
 
-	while (!kthread_should_stop() && !sb_rdonly(sb)) {
+	while (!kthread_should_stop() && !ext4_forced_shutdown(sb)) {
 		if (!ext4_has_feature_mmp(sb)) {
 			ext4_warning(sb, "kmmpd being stopped since MMP feature"
 				     " has been disabled.");
-- 
2.35.3

