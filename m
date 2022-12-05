Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E84C642877
	for <lists+linux-ext4@lfdr.de>; Mon,  5 Dec 2022 13:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbiLEM3f (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 5 Dec 2022 07:29:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbiLEM3c (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 5 Dec 2022 07:29:32 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6CAF17067
        for <linux-ext4@vger.kernel.org>; Mon,  5 Dec 2022 04:29:30 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 666D11FF26;
        Mon,  5 Dec 2022 12:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1670243369; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=nMt7wakyb5qBYxEf5vf6pAResQnWkbuxgneR3fJFPBc=;
        b=MjHjoTvw/vMxDbeEZup7sbmhfDkl32RyP1rC23azHWTc24x7XmAxJSQnqw0Gc+04t9von/
        neUrLNOr/gJKqGA8KespvUmINtFNKjgwxXPhOrUOIyIYhrgxds+uS+ktGFX2vecrE55twz
        DgJIW5gf5H3gA+KtcrIFIL4JB3or6lc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1670243369;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=nMt7wakyb5qBYxEf5vf6pAResQnWkbuxgneR3fJFPBc=;
        b=iXafV0wefJge+fivHL8DeCQD4cNmca2oVFPLOR62wnn0kYspiytq+BZUjogNKrTsRJLCKR
        wAit8VOTO0dyzSCw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 418671348F;
        Mon,  5 Dec 2022 12:29:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id mdrNDynkjWMHTgAAGKfGzw
        (envelope-from <jack@suse.cz>); Mon, 05 Dec 2022 12:29:29 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 4105AA0727; Mon,  5 Dec 2022 13:29:28 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH v3 0/12] ext4: Stop using ext4_writepage() for writeout of ordered data
Date:   Mon,  5 Dec 2022 13:29:14 +0100
Message-Id: <20221205122604.25994-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1588; i=jack@suse.cz; h=from:subject:message-id; bh=zUqXowMvSLTHKum7vudmHYkvyCpz4/LrqioaXZbefh8=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjjeQH8aarykzqHuAyPu1xnmVhCjd2Rk2Or2GDumpE FvqKYliJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY43kBwAKCRCcnaoHP2RA2aOEB/ wMHvfK2N5Sn8swPHbdKNLp/yxOjNVw+ZU6iNBe3oz/pEaB1zpUBJzn5dIROSf7d2k3dRjVdsKc9W4x HRvF+MJ8GemPteeBkpkoto36KBvHZElDugV/eoXVGPQtZjmbXncQfPLysNPDHnuSFPgWLCkO3Wnxcm xS9UCL0xZ2LgAXxo12sSRjd12ADahfI+c2o7FCAx0ZPvh/9PVYo2Lmogiz6cmMU3C6zjG4/RRZL9aW zRwV1vmwXwGv5oP+PqomhXWKjXdRHamO1gcNVTAO3MfSmfoA5bj3gUS7RWLXi67bS1z4sV72qLtO/f F+Veu0QAZMnASfY26R9gfP/Vdo19tJ
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
