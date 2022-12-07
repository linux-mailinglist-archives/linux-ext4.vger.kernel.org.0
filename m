Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69D856458F8
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Dec 2022 12:27:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbiLGL1j (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 7 Dec 2022 06:27:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbiLGL10 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 7 Dec 2022 06:27:26 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D7F1025
        for <linux-ext4@vger.kernel.org>; Wed,  7 Dec 2022 03:27:24 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 696221FD92;
        Wed,  7 Dec 2022 11:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1670412443; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=QPzrMfF6ir9fvyOMpM4KBO7i/oqDAZkqNSDTgXhpapQ=;
        b=c0sQR+WiNGyo1fQUgfFrFJ4pwXw5UAwvb9J1Wy554m1N8v3p3LCJWUsgAlGsUQMKUVSa0I
        kjRIhOWSHyua0Z8Lx7JTHKvnjCAuFSGCn8BLTU2qF5u2HLICL7dSmrMIQT3lOQxDdsza2c
        LkmkaZ33LZoIjKNR20dEHjrP3yRNXBU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1670412443;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=QPzrMfF6ir9fvyOMpM4KBO7i/oqDAZkqNSDTgXhpapQ=;
        b=//F1bhDZvJ73N95YcwJPx913ncvtr0WMOE13XLru76IF5JPupFJtSd/WB51oVNwE8RB4gn
        Rn2+VTKSuPmFm5Cg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 5D883136B4;
        Wed,  7 Dec 2022 11:27:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 0tQDFpt4kGMyLAAAGKfGzw
        (envelope-from <jack@suse.cz>); Wed, 07 Dec 2022 11:27:23 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id C8F4DA0725; Wed,  7 Dec 2022 12:27:22 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH v4 0/13] ext4: Stop using ext4_writepage() for writeout of ordered data
Date:   Wed,  7 Dec 2022 12:27:03 +0100
Message-Id: <20221207112259.8143-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1785; i=jack@suse.cz; h=from:subject:message-id; bh=C/jxgZJ4MhbnF31jyAm7QnJbCUVXR3O/H0bKknTZ0sQ=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjkHiCFKX8TNbUhQMsRg0eOMO83XEJg8PJUBMaKNPh bdVMZGuJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY5B4ggAKCRCcnaoHP2RA2RxnCA DIEazfo08BQGS6844GsO5SFTF+yBYQBARhtw7kJ47a3lf4ZMVTlmWIYvzUrMxxdW86bcm/eaCt3Y7G egi4bmQRPFfO5tTkXt9qCqscO77u5BahKZH//+OouTF71vA5nWy3hCYMxiYh7va85DxPK1W3UvIMSM gNi7pw8Ja1O08fslJHwv8fNAOYLc8HcU6nO+BaDS/SvCE+Izin5TV/RhkPcBC63ag0jSvlYRabbayr 1JmZ7QBbhVHu2eqNqEB3cYy/fhXYvj2KhMx0serrsTeXYgmNG48zqv3ifPEptu41fFcQZib2QhDFGg XS9icEAZnyKvI+FttF2hV+pd0TuGFg
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

Hello,

this patch series modifies ext4 so that we stop using ext4_writepage() for
writeout of ordered data during transaction commit (through
generic_writepages() from jbd2_journal_submit_inode_data_buffers()). Instead we
directly call ext4_writepages() from the
ext4_journal_submit_inode_data_buffers(). This is part of Christoph's effort
to get rid of the .writepage() callback in all filesystems.

I have also modified ext4_writepages() to use write_cache_pages() instead of
generic_writepages() so now we don't expose .writepage hook at all. We still
keep ext4_writepage() as a callback for write_cache_pages(). We should refactor
that path as well and get rid of ext4_writepage() completely but that is for a
separate cleanup. Also note that jbd2 still uses generic_writepages() in its
jbd2_journal_submit_inode_data_buffers() helper because it is still used from
OCFS2. Again, something to be dealt with in a separate patchset.

Changes since v3:
* Added export of buffer_migrate_page_norefs()
* Clarified commit message about page migration a bit

Changes since v2:
* Added Reviewed-by tags from Christoph
* Added WARN_ON to verify we're not trying to start transaction from
  transaction commit writeback
* Converted fastcommit path to use ext4_writepages() for data writeout
* Some minor tweaks suggested by Christoph

Changes since v1:
* Added Reviewed-by tags from Ritesh
* Added patch to get rid of generic_writepages() in ext4_writepages()
* Added patch to get rid of .writepage hook

								Honza
Previous versions:
Link: http://lore.kernel.org/r/20221130162435.2324-1-jack@suse.cz # v1
Link: http://lore.kernel.org/r/20221202163815.22928-1-jack@suse.cz # v2
Link: http://lore.kernel.org/r/20221205122604.25994-1-jack@suse.cz # v3
