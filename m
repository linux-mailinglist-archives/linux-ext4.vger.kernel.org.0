Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDABE66B6F1
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Jan 2023 06:46:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbjAPFp7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 16 Jan 2023 00:45:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231735AbjAPFp5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 16 Jan 2023 00:45:57 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2D959C8;
        Sun, 15 Jan 2023 21:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DyqbCFVVSRH9BdL+CtsL2Q0IUbjE2/UgdwZHHo8qQB0=; b=VpLfGMnSfQj8FrosrID5nRtle+
        nzIT4ANfYFRckuOCdbv2oJ2HnpBcXVwqkfI/P1K9FPFM70xt8YwOt0UfDlcVci11nIxWv9Wgt1evQ
        rdOf6sTwJiLeX0Z6uD3pIY9oEcYwVZtaMAmBSZxLqLcKgX2/Me0xLNWLmX2P6h4dKu4t7g8bRZXqy
        Le5zW6+zPyY5sN2iyBiTMjLuZ3FiUerwjh4u8H1XUfZc4940SNTBY26wmHKnJtdrvVhX+BN1TNLqQ
        RaEf9hS4DtPfCb3mW/ffI/L1Yax3IOQY5bbo8l723yeF4pU2FduhlWFnNj1DoIm6cOglPov/O6q+0
        BoQrNtNA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pHIJl-008SpC-8k; Mon, 16 Jan 2023 05:46:01 +0000
Date:   Mon, 16 Jan 2023 05:46:01 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC v6 04/10] iomap: Add iomap_get_folio helper
Message-ID: <Y8TkmbZfe3L/Yeky@casper.infradead.org>
References: <20230108213305.GO1971568@dread.disaster.area>
 <20230108194034.1444764-1-agruenba@redhat.com>
 <20230108194034.1444764-5-agruenba@redhat.com>
 <20230109124642.1663842-1-agruenba@redhat.com>
 <Y70l9ZZXpERjPqFT@infradead.org>
 <Y71pWJ0JHwGrJ/iv@casper.infradead.org>
 <Y8QxYjy+4Kjg05rB@magnolia>
 <Y8QyqlAkLyysv8Qd@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8QyqlAkLyysv8Qd@magnolia>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, Jan 15, 2023 at 09:06:50AM -0800, Darrick J. Wong wrote:
> On Sun, Jan 15, 2023 at 09:01:22AM -0800, Darrick J. Wong wrote:
> > On Tue, Jan 10, 2023 at 01:34:16PM +0000, Matthew Wilcox wrote:
> > > On Tue, Jan 10, 2023 at 12:46:45AM -0800, Christoph Hellwig wrote:
> > > > On Mon, Jan 09, 2023 at 01:46:42PM +0100, Andreas Gruenbacher wrote:
> > > > > We can handle that by adding a new IOMAP_NOCREATE iterator flag and
> > > > > checking for that in iomap_get_folio().  Your patch then turns into
> > > > > the below.
> > > > 
> > > > Exactly.  And as I already pointed out in reply to Dave's original
> > > > patch what we really should be doing is returning an ERR_PTR from
> > > > __filemap_get_folio instead of reverse-engineering the expected
> > > > error code.
> > > 
> > > Ouch, we have a nasty problem.
> > > 
> > > If somebody passes FGP_ENTRY, we can return a shadow entry.  And the
> > > encodings for shadow entries overlap with the encodings for ERR_PTR,
> > > meaning that some shadow entries will look like errors.  The way I
> > > solved this in the XArray code is by shifting the error values by
> > > two bits and encoding errors as XA_ERROR(-ENOMEM) (for example).
> > > 
> > > I don't _object_ to introducing XA_ERROR() / xa_err() into the VFS,
> > > but so far we haven't, and I'd like to make that decision intentionally.
> > 
> > Sorry, I'm not following this at all -- where in buffered-io.c does
> > anyone pass FGP_ENTRY?  Andreas' code doesn't seem to introduce it
> > either...?
> 
> Oh, never mind, I worked out that the conflict is between iomap not
> passing FGP_ENTRY and wanting a pointer or a negative errno; and someone
> who does FGP_ENTRY, in which case the xarray value can be confused for a
> negative errno.
> 
> OFC now I wonder, can we simply say that the return value is "The found
> folio or NULL if you set FGP_ENTRY; or the found folio or a negative
> errno if you don't" ?

Erm ... I would rather not!

Part of me remembers that x86-64 has the rather nice calling convention
of being able to return a struct containing two values in two registers:

: Integer return values up to 64 bits in size are stored in RAX while
: values up to 128 bit are stored in RAX and RDX.

so maybe we can return:

struct OptionFolio {
	int err;
	struct folio *folio;
};
