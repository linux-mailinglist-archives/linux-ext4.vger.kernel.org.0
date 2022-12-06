Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C57F9644197
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Dec 2022 11:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbiLFKw3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 6 Dec 2022 05:52:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234417AbiLFKw2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 6 Dec 2022 05:52:28 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C8064CE
        for <linux-ext4@vger.kernel.org>; Tue,  6 Dec 2022 02:52:27 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2DD1F21C04;
        Tue,  6 Dec 2022 10:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1670323946; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5sN7XonIHkZPSXUeTVwCYriJf0V+92fbh96cz906ZH4=;
        b=uPsblBSeKAv+4PgDdzYGGUxaLa3iJiToTW1v5I7XvrGIricIScMgO0IfHI571XowaO1g2g
        fwwq80XRMZw5ECqXaDOmtfvwNkoAGo7LitzouOm54l2IN6rjkgMTg/0u4gVcUjHSWYT29b
        WUI76kJrGk1UUY2vLlrcMC5qbIO4AW4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1670323946;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5sN7XonIHkZPSXUeTVwCYriJf0V+92fbh96cz906ZH4=;
        b=lsYXJ/g7oh+PRG91le+UUGJ4ds/kwFFkMnhsdfvpBY6GUl95iiPlHQaI3MrH/oLnS33pSA
        GwjuUHIC9U3yniDQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 1F8EF132F3;
        Tue,  6 Dec 2022 10:52:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id +TivB+oej2O/NwAAGKfGzw
        (envelope-from <jack@suse.cz>); Tue, 06 Dec 2022 10:52:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 583C2A0725; Tue,  6 Dec 2022 11:52:25 +0100 (CET)
Date:   Tue, 6 Dec 2022 11:52:25 +0100
From:   Jan Kara <jack@suse.cz>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org
Subject: Re: [PATCH v3 11/12] ext4: Stop providing .writepage hook
Message-ID: <20221206105225.nr734teqlkueqdph@quack3>
References: <20221205122604.25994-1-jack@suse.cz>
 <20221205122928.21959-11-jack@suse.cz>
 <Y460RpKTCDuPKWmN@mit.edu>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ctkz3xut3vy6qate"
Content-Disposition: inline
In-Reply-To: <Y460RpKTCDuPKWmN@mit.edu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--ctkz3xut3vy6qate
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon 05-12-22 22:17:26, Theodore Ts'o wrote:
> On Mon, Dec 05, 2022 at 01:29:25PM +0100, Jan Kara wrote:
> > Now we don't need .writepage hook for anything anymore. Reclaim is fine
> > with relying on .writepages to clean pages and we often couldn't do much
> > from the .writepage callback anyway. We only need to provide
> > .migrate_folio callback for the ext4_journalled_aops - let's use
> > buffer_migrate_page_norefs() there so that buffers cannot be modified
>   ^^^^^^^^^^^^^^^^^^^^^^^^^^  this should be buffer_migrate_folio_norefs, no?
> > under jdb2's hands.
> > 
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > Signed-off-by: Jan Kara <jack@suse.cz>
> 
> Could you clarify in the commit how critical it is to use the
> _norefs() variant?  It's not entirely clear what you mean by "let's
> use...".  I think what is meant is that we need to use ..._noref() or
> we can get in trouble if while the page update is getting committed,
> there is an attempted to migrate the folio containing the page.

Exacly. For example when commit code does writeout of transaction buffers
in jbd2_journal_write_metadata_buffer(), we don't hold page lock or have
page writeback bit set or have buffer locked. So page migration code would
go and happily migrate the page elsewhere while the copy is running thus
corrupting data.

I've added this to the changelog.

> buffer_migrate_folio_norefs() is currently not exported (although
> buffer_migrate_folio is).  So if we need it for ext4, we're going to
> have to EXPORT_SYMBOL buffer_migrate_folio_norefs.
> 
> Any objections from the mm folks?

I don't expect any objection. The only reason we didn't export that
function when I've added it was that only blkdev code was using it and that
cannot be compiled as a module. Should I send a patch to 

I've added a patch to the series to export this function. It is attached.

I can also repost the whole series if these are the only changes that block
the inclusion.


								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

--ctkz3xut3vy6qate
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-mm-Export-buffer_migrate_folio_norefs.patch"

From 69eb9d34de54862f8653a3c2ca4f96891e69f64b Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Tue, 6 Dec 2022 11:42:29 +0100
Subject: [PATCH] mm: Export buffer_migrate_folio_norefs()

Ext4 needs this function to allow safe migration for journalled data
pages.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 mm/migrate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/migrate.c b/mm/migrate.c
index dff333593a8a..f00f5f6607b2 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -820,6 +820,7 @@ int buffer_migrate_folio_norefs(struct address_space *mapping,
 {
 	return __buffer_migrate_folio(mapping, dst, src, mode, true);
 }
+EXPORT_SYMBOL(buffer_migrate_folio_norefs);
 #endif
 
 int filemap_migrate_folio(struct address_space *mapping,
-- 
2.35.3


--ctkz3xut3vy6qate--
