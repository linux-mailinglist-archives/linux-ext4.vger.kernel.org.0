Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0A7963DAC5
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Nov 2022 17:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbiK3QgT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 30 Nov 2022 11:36:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbiK3QgM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 30 Nov 2022 11:36:12 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 180E64AF00
        for <linux-ext4@vger.kernel.org>; Wed, 30 Nov 2022 08:36:10 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 771621F8D4;
        Wed, 30 Nov 2022 16:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669826169; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=UL25gCaDJrodqmJ1SYiSwXX6rH8spAMomtEA4Ay2/UQ=;
        b=e3M/ed5fle48FTgxanscadAGeeKPYGBCQTyD9q4GUBQhNmWgJxoNdIAw820TNY2TQr4npT
        furF+fCiHX2fKsxZf+3oWH+ii/N/m9ZUwYWwdQPyhKIxu7WW/bG2yIzl8MrUotwreT27Sz
        RAokOk8d58V2XGftyQrwjbE9STRAW0E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669826169;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=UL25gCaDJrodqmJ1SYiSwXX6rH8spAMomtEA4Ay2/UQ=;
        b=zAUwcZUDApByEkVuzRgbCKO5PT3UEplVvAlYSVnEOdzbXHO4jEhQ6FNU+K+vFRKTiVifRs
        RCdMyDhEYCUqwTCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 699E813A70;
        Wed, 30 Nov 2022 16:36:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id aUUiGXmGh2NYQgAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 30 Nov 2022 16:36:09 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id A39E2A0710; Wed, 30 Nov 2022 17:36:08 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 0/9] ext4: Stop using ext4_writepage() for writeout of ordered data
Date:   Wed, 30 Nov 2022 17:35:51 +0100
Message-Id: <20221130162435.2324-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=878; i=jack@suse.cz; h=from:subject:message-id; bh=b6tlEA0oFzJcFYq8+OHQIBKvDaJYnBZwj4zDOrqfQTA=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjh4ZjfGJupKd2XC4dTswqUIk4ZYpr6PH0sHgwjcdq HeAPBE2JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY4eGYwAKCRCcnaoHP2RA2cq2CA CoUtgJh0PcERVlIoGpCxpZWdHA73mjGSF7D1qswXOr6ISnJu322FveDwVlnZeU6F+ZOiGxrwvkb5Bs 0TYgeGZ9zHhnnUNHMHp6erKUGNWFQ7WN+d8bkRx9Tn92kY5fcQD6mnA9mIIu5NeP5JrGzVWCwROjk0 a5VpXyAwMs2N99wwQUh/+DZwkyUDFt/iPVYl44I9g7RmD0RW90/twirTKcl2/UthaxfJsul3cgSHgN O1IBnsuPXal70tQ8Jivc0aisIyO5kfrcELXpNsGgRyuUA8fesOKjWGSDNN29jlTKqkbLmKcjfbCVoZ jcEAQ1lq3T+tZZe6d8IVZF/ZcoWGD7
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

Note that we still keep ext4_writepage() function for writeout of journalled
data. That can be also dealt with but let's untangle things one by one.  Also
note that jbd2 still uses generic_writepages() in its
jbd2_journal_submit_inode_data_buffers() helper because it is still used from
OCFS2. Again, something to be dealt with in a separate patchset.

Patches pass for me tests on both 1k and 4k filesystems with dioreadlock and
without it.

								Honza
