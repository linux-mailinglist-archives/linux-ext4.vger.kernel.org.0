Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59A6D643BBD
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Dec 2022 04:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232500AbiLFDRv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 5 Dec 2022 22:17:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbiLFDRu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 5 Dec 2022 22:17:50 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A25C218A8
        for <linux-ext4@vger.kernel.org>; Mon,  5 Dec 2022 19:17:48 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2B63HQlj024202
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 5 Dec 2022 22:17:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1670296648; bh=p1r2m88M/QKxRRtpTpgy5FK3fYeYkJFhKXuPxwPZugY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=aRpJDRAuqxWMPU4dGvibIhN2/2z2ufbg1ZNl6qkOTu0UOUVE7q8F8ZOyCDQ2vm7XW
         H28PHOqdyaEPenkrvz2IpqytM70PW9yXPK2eDQVMfR3cCSzYxSJkNf2To9MxDdQwyA
         po3Rs64k2ageddjaK1CIW3yd7EBWHBG7anjSukPK+JuS5ibXUQXWGVE7P1fhpb8maM
         zmWiALPZyCjJ82ymscpgTKOEwbPXF7jTok8iQS6JUh4hAj3nToZo1QAMkSyvVzMmcD
         WiDlHaIS5y7Gq1vaeLNSddhVXWeUNz/sJ82ZKNXl7lxZlJc49KsfmoqZkx1sZCWS9T
         qXkloXX/UwVXw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 8884415C3489; Mon,  5 Dec 2022 22:17:26 -0500 (EST)
Date:   Mon, 5 Dec 2022 22:17:26 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org
Subject: Re: [PATCH v3 11/12] ext4: Stop providing .writepage hook
Message-ID: <Y460RpKTCDuPKWmN@mit.edu>
References: <20221205122604.25994-1-jack@suse.cz>
 <20221205122928.21959-11-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221205122928.21959-11-jack@suse.cz>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Dec 05, 2022 at 01:29:25PM +0100, Jan Kara wrote:
> Now we don't need .writepage hook for anything anymore. Reclaim is fine
> with relying on .writepages to clean pages and we often couldn't do much
> from the .writepage callback anyway. We only need to provide
> .migrate_folio callback for the ext4_journalled_aops - let's use
> buffer_migrate_page_norefs() there so that buffers cannot be modified
  ^^^^^^^^^^^^^^^^^^^^^^^^^^  this should be buffer_migrate_folio_norefs, no?
> under jdb2's hands.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Jan Kara <jack@suse.cz>

Could you clarify in the commit how critical it is to use the
_norefs() variant?  It's not entirely clear what you mean by "let's
use...".  I think what is meant is that we need to use ..._noref() or
we can get in trouble if while the page update is getting committed,
there is an attempted to migrate the folio containing the page.

buffer_migrate_folio_norefs() is currently not exported (although
buffer_migrate_folio is).  So if we need it for ext4, we're going to
have to EXPORT_SYMBOL buffer_migrate_folio_norefs.

Any objections from the mm folks?

				- Ted
