Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80C476458F7
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Dec 2022 12:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbiLGL1h (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 7 Dec 2022 06:27:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbiLGL10 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 7 Dec 2022 06:27:26 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F9F11A06
        for <linux-ext4@vger.kernel.org>; Wed,  7 Dec 2022 03:27:25 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CB3741F37E;
        Wed,  7 Dec 2022 11:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1670412443; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vs7hmkx66Fp22yYnmDcVYVxpg8X0jWkoO4ST/ldwM1s=;
        b=z2LUD/TEYZERLm9bl4SmUZUXRNASBvlv/5ovqxAtroJdUXEZDyi6maHpqgK9cSkqx39hAM
        MndTjKGES/LdetPhI68zXuRMQESXcLivb4Afq39f+fYO4ogvzAz/BHZ9DGXhm4IDAeje1b
        69MSjLkWEwMSokLrgFyHOfmB6ktTBmY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1670412443;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vs7hmkx66Fp22yYnmDcVYVxpg8X0jWkoO4ST/ldwM1s=;
        b=o+63YQ4DCIFgHGz4DB4JDU6dMwiEPXCbDA+0El4kA7bWvPzh52NeDq6WCIcZ6YzkT1RftX
        s77bqd8iEaEgt9Aw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id BE41B1379D;
        Wed,  7 Dec 2022 11:27:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id mnhzLpt4kGNGLAAAGKfGzw
        (envelope-from <jack@suse.cz>); Wed, 07 Dec 2022 11:27:23 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 0F9C6A0736; Wed,  7 Dec 2022 12:27:23 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v4 10/13] ext4: Switch to using write_cache_pages() for data=journal writeout
Date:   Wed,  7 Dec 2022 12:27:13 +0100
Message-Id: <20221207112722.22220-10-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221207112259.8143-1-jack@suse.cz>
References: <20221207112259.8143-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1335; i=jack@suse.cz; h=from:subject; bh=23FIs73CR+dJuweXVsJE6NBdy/+rtnMaeWeeUjNcNEQ=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjkHiRoAynBFFpL2DjlyKvloiLtfeSQIv0y5PT8tMu bcDUS/GJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY5B4kQAKCRCcnaoHP2RA2aIiB/ 9pU+NPasMc0c+Yy6PKxpwJ3q+ryfZhGeUKMNfhFay8XW6Cj5NM38UDGkF/YDyHRvIg7Gj3p/3buff8 MyAcAHXfEYPslyMXdD+VktUQjrE9p0Nz/uxkzLAroEfpQGcNY2rbvogH7F/ORnS+OQmPIBKNVLnWWW z4j3+WfnNI3cCdWI0YSZ6P2qZhoPD1bpLziWKaQfjUMlrGCfX1ZRjygXn3RIMJU6k44kMHJd1u4NYX dOQeggHntS7J/C1A8+2LjeDRymX3Nwi/9vLf6BtD9ZpvJIezHT/Wax4VDl5Q30nkrpAvuYQR/+QgZQ QHmjiei+PfhiDoePuSkaaHT0/ygNo1
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Instead of using generic_writepages(), let's use write_cache_pages() for
writeout of journalled data. It will allow us to stop providing
.writepage callback. Our data=journal writeback path would benefit from
a larger cleanup and refactoring but that's for a separate cleanup
series.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/inode.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index b93a436bf5bc..f3b3792c1c96 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2705,6 +2705,12 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
 	return err;
 }
 
+static int ext4_writepage_cb(struct page *page, struct writeback_control *wbc,
+			     void *data)
+{
+	return ext4_writepage(page, wbc);
+}
+
 static int ext4_do_writepages(struct mpage_da_data *mpd)
 {
 	struct writeback_control *wbc = mpd->wbc;
@@ -2731,7 +2737,9 @@ static int ext4_do_writepages(struct mpage_da_data *mpd)
 		goto out_writepages;
 
 	if (ext4_should_journal_data(inode)) {
-		ret = generic_writepages(mapping, wbc);
+		blk_start_plug(&plug);
+		ret = write_cache_pages(mapping, wbc, ext4_writepage_cb, NULL);
+		blk_finish_plug(&plug);
 		goto out_writepages;
 	}
 
-- 
2.35.3

