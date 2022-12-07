Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13F936458FE
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Dec 2022 12:27:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbiLGL1x (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 7 Dec 2022 06:27:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbiLGL12 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 7 Dec 2022 06:27:28 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE3CB485
        for <linux-ext4@vger.kernel.org>; Wed,  7 Dec 2022 03:27:27 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D61F321CA8;
        Wed,  7 Dec 2022 11:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1670412443; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5QANUKVuRT8NWBgNyyusoguWy8/KXbVC7l0LNl2PJV0=;
        b=On4DKZrHnYAkleBsrfII4wyBdCgoUCXx3bnKrfvOITJB+Dela/QHErpq9N67SRkfsAH01N
        2rDanq2VH2Bkz9hdN13JZZMtku5goy/LPdtZwp57Fss+aXGKTQhVtQw2nemj2nv9QdPMrT
        HKrxAfLzHhI8166/BMInnsHpvzTOE08=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1670412443;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5QANUKVuRT8NWBgNyyusoguWy8/KXbVC7l0LNl2PJV0=;
        b=IXnmOae+UQoJ64qqJZfDC+fhZ4gApFd3UWZYzgIYiViYm6KPa8WxNns2iWl3stokJLcUW9
        6ncQN+iSBvKJL7Bg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id C9F7F1373B;
        Wed,  7 Dec 2022 11:27:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id vW9NMZt4kGNMLAAAGKfGzw
        (envelope-from <jack@suse.cz>); Wed, 07 Dec 2022 11:27:23 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 154A2A0739; Wed,  7 Dec 2022 12:27:23 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH v4 11/13] mm: Export buffer_migrate_folio_norefs()
Date:   Wed,  7 Dec 2022 12:27:14 +0100
Message-Id: <20221207112722.22220-11-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221207112259.8143-1-jack@suse.cz>
References: <20221207112259.8143-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=595; i=jack@suse.cz; h=from:subject; bh=c4DxOium70EyUaDzhldtIkg4QqnSvuPVVl74OaytVcQ=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjkHiR2cKn0kCv6C1MRoPMYcw2BXsjDABy9pBbep6m DewagrmJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY5B4kQAKCRCcnaoHP2RA2XgfB/ 9IanIVKkxfSPv+clJSW9XYefuZdGhm/1IgkHi6Nd/TxWRX9MoyAgtpZbKiGWvIXSlVj64glcDGSgmn IVviNDZlF/WryD8kpha8l1wihp8hBiagA+75WyuNsuyoRCoVZuU5dun78MUkm1wiO4Sx4NWpSZL8K9 PHKfYw4tKiPFl4K4W9QEeKWGHCDqF/X6PosLx8H9llLPBE7k35svt6hVQBHecT8irtom0eYIHpmhKl sGJSUoEaLMq0wgcfad5HVi9nMjIBjC+Xdth/391V0et+E+DUWx66E7Udkra0fz2tTCG/9EVt94scyE bcfhElPMml6QvOc2NUvQ4UKYz5Fjbk
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

Ext4 needs this function to allow safe migration for journalled data
pages.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 mm/migrate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/migrate.c b/mm/migrate.c
index dff333593a8a..5e4ca21da712 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -820,6 +820,7 @@ int buffer_migrate_folio_norefs(struct address_space *mapping,
 {
 	return __buffer_migrate_folio(mapping, dst, src, mode, true);
 }
+EXPORT_SYMBOL_GPL(buffer_migrate_folio_norefs);
 #endif
 
 int filemap_migrate_folio(struct address_space *mapping,
-- 
2.35.3

