Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B97B640D9A
	for <lists+linux-ext4@lfdr.de>; Fri,  2 Dec 2022 19:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234064AbiLBSmI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 2 Dec 2022 13:42:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233612AbiLBSl2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 2 Dec 2022 13:41:28 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E322ECA2B
        for <linux-ext4@vger.kernel.org>; Fri,  2 Dec 2022 10:39:46 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E697121BFE;
        Fri,  2 Dec 2022 18:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1670006383; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Jxf9LTF/3YlfiMDoausCmPmiH2lwzWUXTFrC2+NnIHM=;
        b=nxAtAgcsRhKzGHpZy/YwIcOOkKw+VIUzRkBkev+mTC6WDJYiBgbYEHCkk4yPiSkOe4ldcc
        sNZC0Ti/jRrFnOgra3LFUBMRZzFAqSKddCfnPUjOUwzA+C384BUE02379QJVPQFTWY3ywu
        2rd3iEcmSh30niYwVAhQpvKJsSD4F20=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1670006383;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Jxf9LTF/3YlfiMDoausCmPmiH2lwzWUXTFrC2+NnIHM=;
        b=damwn1pET83lr8H+WbvP0dhisCx2bXUeu7zB1IAhcFUUcW7ijBujGNdX5o9GKRL9rSouir
        tlhVzG8/5JTVUQAw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id D15A913649;
        Fri,  2 Dec 2022 18:39:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id ZGJ2Mm9GimOlZAAAGKfGzw
        (envelope-from <jack@suse.cz>); Fri, 02 Dec 2022 18:39:43 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 49DFFA070B; Fri,  2 Dec 2022 19:39:43 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Ritesh Harjani <ritesh.list@gmail.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH v2 0/11] ext4: Stop using ext4_writepage() for writeout of ordered data
Date:   Fri,  2 Dec 2022 19:39:25 +0100
Message-Id: <20221202163815.22928-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1235; i=jack@suse.cz; h=from:subject:message-id; bh=qiNRJ+2e7WogrxmIyrdwiJ4WhlmfPG4jNydopJXKGTc=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjikZUho/8NjJBFwsU0f2mgWoROdHoVcUnMmLPzzy3 hRtIsu+JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY4pGVAAKCRCcnaoHP2RA2R9EB/ wP5VQ8gfwxMx8tGRsalZeoR5rBbT70cZSdTsUjGA6OyJNtJwrCL4NDf4ihoEJ71zzeXX/hlojmuqWv FtcriLAu2rFppy7OC0DuXoHYr2riwnALb0n0ALXGJhs4uejbCbKKKHy9R4A+M9bfnHqTmwDQKGy6qG EXkJbAMklDzWX5WR5uz7pS8MmQLdIsj8v5ZEPKerXKo/FZV8uL18+IHCy+yr7tD8NonFXgqfmOfeIv qKbgOkbnDWIiqILgnQGa6FpunY2JqkzI6sf+iNTVNcDjodmQBm81QYJST7brbeGrx+Vjz4bWLEDRVl lXKLuMXvTCvyzCBKiAQ+v3wGWHz12q
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
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

Changes since v1:
* Added Reviewed-by tags from Ritesh
* Added patch to get rid of generic_writepages() in ext4_writepages()
* Added patch to get rid of .writepage hook

								Honza
Previous versions:
Link: http://lore.kernel.org/r/20221130162435.2324-1-jack@suse.cz # v1
